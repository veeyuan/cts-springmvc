package com.cts.controller;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cts.dao.CategoryDao;
import com.cts.dao.DisciplineDao;
import com.cts.dao.LanguageDao;
import com.cts.dao.QuestionDao;
import com.cts.dao.QuestionListDao;
import com.cts.model.Category;
import com.cts.model.Discipline;
import com.cts.model.Language;
import com.cts.model.Question;  
@Controller  
public class AddQuestionController {
	
	
	@Autowired  
    QuestionDao questionDao;
	@Autowired  
    DisciplineDao disciplineDao;
	@Autowired  
	CategoryDao categoryDao;
	@Autowired  
	LanguageDao languageDao;
	
	@RequestMapping("/addQuestion")  
    public ModelAndView redirectToAddQuestion()  
    {  
		ModelAndView model = new ModelAndView("addQuestion","question",new Question()); 
		List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
		model.addObject("listDiscipline",listDiscipline);
		List<Category> listCategory =   categoryDao.getCategoryList();
		model.addObject("listCategory",listCategory);
		List<Language> listLanguage =   languageDao.getLanguageList();
		model.addObject("listLanguage",listLanguage);
	    return model;
    } 
	
	
    static String saveDirectory = "uploadedFiles"; 
	@RequestMapping(value = "/addProcess", method = RequestMethod.POST)
	public String addQuestion(@RequestParam("questionAttachment") CommonsMultipartFile questionAttachment,@RequestParam("sampleAnsAttachment") CommonsMultipartFile sampleAnsAttachment,@RequestParam("radio-all-mcq") String strMCQ, @ModelAttribute("question")Question question, 
		      BindingResult result, ModelMap model) throws IOException {
		try {
			
			if ("Yes".equalsIgnoreCase(strMCQ)) {
				question.setMcq(true);
			}else {
				question.setMcq(false);
			}
			
			
			if (!questionAttachment.isEmpty()) {
				question.setQuestionAttachment(questionAttachment);
			}
			if (!sampleAnsAttachment.isEmpty()) {
				question.setQuestionAttachment(sampleAnsAttachment);
			}
			
			questionDao.addQuestion(question);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Failed to add >>>");
			model.addAttribute("success","N");
			e.printStackTrace();
			return "addProcess";
		}
		model.addAttribute("success","Y");
		
		return "addProcess";
	}
}