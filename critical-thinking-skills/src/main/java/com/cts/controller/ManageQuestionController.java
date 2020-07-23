package com.cts.controller;


import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.cts.dao.CategoryDao;
import com.cts.dao.DisciplineDao;
import com.cts.dao.FileDao;
import com.cts.dao.LanguageDao;
import com.cts.dao.QuestionDao;
import com.cts.dao.QuestionListDao;
import com.cts.model.AttachmentFile;
import com.cts.model.Category;
import com.cts.model.Discipline;
import com.cts.model.Language;
import com.cts.model.Question;

@Controller
public class ManageQuestionController {
	@Autowired  
    QuestionListDao questionListDao;
	@Autowired  
    DisciplineDao disciplineDao;
	@Autowired  
	CategoryDao categoryDao;
	@Autowired  
	LanguageDao languageDao;
	@Autowired  
    QuestionDao questionDao;
	@Autowired  
	FileDao fileDao;
	
	@RequestMapping("/manageQuestion")  
	public ModelAndView  directToManageQuestion()  
	{  
		ModelAndView model = new ModelAndView("manageQuestion"); 
		List<Question> listQuestion =   questionListDao.getQuestionList();
		model.addObject("listQuestion",listQuestion);
		List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
		model.addObject("listDiscipline",listDiscipline);
		List<Category> listCategory =   categoryDao.getCategoryList();
		model.addObject("listCategory",listCategory);
		List<Language> listLanguage =   languageDao.getLanguageList();
		model.addObject("listLanguage",listLanguage);
		model.addObject("question",new Question());
	    return model;  
	}  
	
	@RequestMapping(value="/manageQuestion", method = RequestMethod.POST)  
	public ModelAndView  filterQuestion(@ModelAttribute("question")Question question, 
		      BindingResult result) throws IOException  
	{  
		/*int numPerPg=5;  
		int startRow=1;		
        if(pageid==1){}    
        else{    
        	startRow=(pageid-1)*numPerPg+1;    
        }    
        int endRow=startRow+numPerPg-1;*/
		ModelAndView model = new ModelAndView("manageQuestion"); 
		List<Question> listQuestion =   questionListDao.filterQuestionList(question);
		model.addObject("listQuestion",listQuestion);
		List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
		model.addObject("listDiscipline",listDiscipline);
		List<Category> listCategory =   categoryDao.getCategoryList();
		model.addObject("listCategory",listCategory);
		List<Language> listLanguage =   languageDao.getLanguageList();
		model.addObject("listLanguage",listLanguage);
		model.addObject("question",new Question());
	    return model;  
	}  
	
	
	@RequestMapping(value = "/deleteProcess", method = RequestMethod.POST)
	public String deleteQuestion( @RequestParam("delQuestionList") String[] delQuestionList, ModelMap model) throws IOException {
		int numberQuestions = delQuestionList.length;
		try {	
			questionDao.deleteQuestion(delQuestionList);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Failed to add >>>");
			model.addAttribute("success","N");
			model.addAttribute("numberQuestions",0);
			e.printStackTrace();
			return "deleteProcess";
		}
		model.addAttribute("success","Y");
		model.addAttribute("numberQuestions",Integer.toString(numberQuestions));
		return "deleteProcess";
	}
	
	@RequestMapping(value = "/viewQuestionDet", method = RequestMethod.POST)
	public ModelAndView viewQuestionDet( @RequestParam("questionID") String questionID) throws IOException, SQLException {
		ModelAndView model = new ModelAndView("viewQuestionDet"); 	
		Question question = questionDao.getQuestionDet(questionID);

		if (question !=null) {
			int numberOfOptions = 0;
			if (question.isMcq()) {
				if (question.getOption3()==null) {
					numberOfOptions=2;
				}else if (question.getOption4()==null) {
					numberOfOptions=3;
				}else if (question.getOption5()==null) {
					numberOfOptions=4;
				}else {
					numberOfOptions=5;
				}
				model.getModelMap().addAttribute("numberOfOptions",numberOfOptions);				
			}
			if (question.getQuestionAttachment()==null) {
				model.getModelMap().addAttribute("hasQuestionAttachment","N");
			}else {
				model.getModelMap().addAttribute("hasQuestionAttachment","Y");
				if (containsIgnoreCase(question.getQuestionAttachment().getFormat(),"image")) {
					model.getModelMap().addAttribute("isQuesAttachmentIMG","Y");
				}else {
					model.getModelMap().addAttribute("isQuesAttachmentIMG","N");

				}
			}
			if (question.getSampleAnsAttachment()==null) {
				model.getModelMap().addAttribute("hasAnswerAttachment","N");
			}else {
				model.getModelMap().addAttribute("hasAnswerAttachment","Y");
				if (containsIgnoreCase(question.getSampleAnsAttachment().getFormat(),"image")) {
					model.getModelMap().addAttribute("isAnsAttachmentIMG","Y");
				}else {
					model.getModelMap().addAttribute("isAnsAttachmentIMG","N");
				}

			}
			model.addObject("question",question);
		//	model.getModelMap().addAttribute("success","Y");
			List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
			model.addObject("listDiscipline",listDiscipline);
			List<Category> listCategory =   categoryDao.getCategoryList();
			model.addObject("listCategory",listCategory);
			List<Language> listLanguage =   languageDao.getLanguageList();
			model.addObject("listLanguage",listLanguage);
		}else {
		//	model.getModelMap().addAttribute("success","N");
		}

		return model;
	}
	@RequestMapping(value = "/downloadAttachment", method = RequestMethod.GET)
	public ModelAndView download(HttpServletRequest request,HttpServletResponse response) throws Exception {
	        String id = ServletRequestUtils.getRequiredStringParameter(request, "id");
	        AttachmentFile file = fileDao.getFilefromDB(id);
	 
	        response.setContentType(file.getFormat());
	        response.setContentLength(file.getFileByteData().length);
	        response.setHeader("Content-Disposition","attachment; filename=\"" + file.getFileName() +"\"");
	 
	        FileCopyUtils.copy(file.getFileByteData(), response.getOutputStream());
	 
	        return null;
	 
	    }
	
	@RequestMapping(value = "/modifyQuestion", method = RequestMethod.POST)
	public ModelAndView modifyQuestion( @RequestParam("questionID") String questionID) throws IOException, SQLException {
		ModelAndView model = new ModelAndView("modifyQuestion"); 	
		Question question = questionDao.getQuestionDet(questionID);
		if (question !=null) {
			List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
			model.addObject("listDiscipline",listDiscipline);
			List<Category> listCategory =   categoryDao.getCategoryList();
			model.addObject("listCategory",listCategory);
			List<Language> listLanguage =   languageDao.getLanguageList();
			model.addObject("listLanguage",listLanguage);
			int numberOfOptions = 0;
			if (question.isMcq()) {
				model.getModelMap().addAttribute("isMcq","Y");
				if (question.getOption3()==null) {
					numberOfOptions=2;
				}else if (question.getOption4()==null) {
					numberOfOptions=3;
				}else if (question.getOption5()==null) {
					numberOfOptions=4;
				}else {
					numberOfOptions=5;
				}
				model.getModelMap().addAttribute("numberOfOptions",numberOfOptions);				
			}else {
				model.getModelMap().addAttribute("isMcq","N");
			}
			if (question.getQuestionAttachment()==null) {
				model.getModelMap().addAttribute("hasQuestionAttachment","N");
			}else {
				model.getModelMap().addAttribute("hasQuestionAttachment","Y");
				
			}
			if (question.getSampleAnsAttachment()==null) {
				model.getModelMap().addAttribute("hasAnswerAttachment","N");
			}else {
				model.getModelMap().addAttribute("hasAnswerAttachment","Y");
				

			}
			model.addObject("question",question);
		//	model.getModelMap().addAttribute("success","Y");
			
		}else {
		//	model.getModelMap().addAttribute("success","N");
		}
		return model;
	}
	
	@RequestMapping(value = "/modifyProcess", method = RequestMethod.POST)
	public String modifyQuestion(@RequestParam("questionID") String questionId ,
			@RequestParam("questionAttachment") CommonsMultipartFile questionAttachment,
			@RequestParam("sampleAnsAttachment") CommonsMultipartFile sampleAnsAttachment,
			@RequestParam("quesAttachmentID") String quesAttachmentID ,
			@RequestParam("ansAttachmentID") String ansAttachmentID ,
			@RequestParam("radio-all-mcq") String strMCQ, 
			@ModelAttribute("question")Question question, 
		      BindingResult result, ModelMap model) throws IOException {
		try {
			question.setId(questionId);
			
			if ("Yes".equalsIgnoreCase(strMCQ)) {
				question.setMcq(true);
			}else {
				question.setMcq(false);
			}

			if (!questionAttachment.isEmpty()) { //new alternative file
				AttachmentFile questionFileObj = new AttachmentFile();
				questionFileObj.setAttachmentFile(questionAttachment);
				questionFileObj.setFileName(questionAttachment.getOriginalFilename());
				questionFileObj.setFormat(questionAttachment.getContentType());
				question.setQuestionAttachment(questionFileObj);
			}else {								//no alternative file
				if (quesAttachmentID != null && quesAttachmentID.length() != 0) {   //has ori file
					AttachmentFile questionFileObj = new AttachmentFile();
					questionFileObj.setId(quesAttachmentID);
					question.setQuestionAttachment(questionFileObj);
				}
			}
			if (!sampleAnsAttachment.isEmpty()) {
				AttachmentFile answerFileObj = new AttachmentFile();
				answerFileObj.setAttachmentFile(sampleAnsAttachment);
				answerFileObj.setFileName(sampleAnsAttachment.getOriginalFilename());
				answerFileObj.setFormat(sampleAnsAttachment.getContentType());
				question.setSampleAnsAttachment(answerFileObj);
			}else {
				if (ansAttachmentID!= null && ansAttachmentID.length() != 0) {
					AttachmentFile answerFileObj = new AttachmentFile();
					answerFileObj.setId(ansAttachmentID);
					question.setQuestionAttachment(answerFileObj);
				}
			}
			
			questionDao.modifyQuestion(question);
		} catch (SQLException e) {
			System.out.println("Failed to modiffy >>>");
			model.addAttribute("success","N");
			e.printStackTrace();
			return "modifyProcess";
		}
		model.addAttribute("success","Y");
		
		return "modifyProcess";
	}
	public static boolean containsIgnoreCase(String src, String what) {
	    final int length = what.length();
	    if (length == 0)
	        return true; // Empty string is contained

	    final char firstLo = Character.toLowerCase(what.charAt(0));
	    final char firstUp = Character.toUpperCase(what.charAt(0));

	    for (int i = src.length() - length; i >= 0; i--) {
	        // Quick check before calling the more expensive regionMatches() method:
	        final char ch = src.charAt(i);
	        if (ch != firstLo && ch != firstUp)
	            continue;

	        if (src.regionMatches(true, i, what, 0, length))
	            return true;
	    }

	    return false;
	}
}
