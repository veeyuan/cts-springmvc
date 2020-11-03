package com.cts.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cts.dao.CategoryDao;
import com.cts.dao.DisciplineDao;
import com.cts.dao.HotsComponentDao;
import com.cts.dao.LanguageDao;
import com.cts.dao.TestDao;
import com.cts.dao.UserDao;
import com.cts.model.Answer;
import com.cts.model.Category;
import com.cts.model.Discipline;
import com.cts.model.HotsComponent;
import com.cts.model.Language;
import com.cts.model.Question;
import com.cts.model.Section;
import com.cts.model.User;
@Controller
public class TakeTestController {
	
	@Autowired  
    DisciplineDao disciplineDao;
	@Autowired  
	CategoryDao categoryDao;
	@Autowired  
	LanguageDao languageDao;
	@Autowired  
    UserDao userDao;
	@Autowired  
    TestDao testDao;
	@Autowired  
	HotsComponentDao hotsComponentDao;
	
	@RequestMapping("/takeTest")
	public ModelAndView viewQuestionDet(HttpServletRequest request) throws IOException, SQLException{
			ModelAndView model = new ModelAndView("takeTest"); 	
			String id = request.getSession().getAttribute("userid").toString();
    		User userDet = userDao.getUserDet(id);
    		model.addObject("user",userDet);
    		if (userDet.isReadyToTakeTest()) {  
    			if (userDao.hasStartedTest(id)) {
    				model = new ModelAndView("testSection"); 	
    				List<HotsComponent> listHotsComponent =   hotsComponentDao.getHotsComponentList();
    				List<Section> listSection = testDao.getSections(userDet,listHotsComponent);
    				model.addObject("listSection",listSection);
    				if (isAllComplete(listSection) && testDao.getSubmissionId(id)!=null ) {
    					testDao.closeSubmission(testDao.getSubmissionId(id));
    				}
    				return model;
    			}else {
    				model.addObject("lastTestDate",userDao.getLastTakeTestDate(id));
    				List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
            		model.addObject("listDiscipline",listDiscipline);
        			List<Category> listCategory =   categoryDao.getCategoryList();
        			model.addObject("listCategory",listCategory);
        			List<Language> listLanguage =   languageDao.getLanguageList();
        			model.addObject("listLanguage",listLanguage);
    			}
    			
    			
    			return model;
        		
    		}
    		
    		model.addObject("lastTestDate",userDao.getLastTakeTestDate(id));
		return model;
	}
	
	public boolean isAllComplete(List<Section> listSection) {
		for (int i=0;i<listSection.size();i++){
			   if (!listSection.get(i).isCompleted()){				   
				   return false;			   
			   }
		 }		
		return true;
	}
	
	@RequestMapping(value="/takeTest",method = RequestMethod.POST)
	public ModelAndView getSection(HttpServletRequest request) throws IOException{
		String id = request.getSession().getAttribute("userid").toString();
		User user = userDao.getUserDet(id);
		testDao.startTest(user);
		
		return new ModelAndView("redirect:/takeTest.html"); 	
	}
	
	@RequestMapping("/answerQuestion")
	public ModelAndView getQuestion( @RequestParam("hotsCd") String hotsCd,HttpServletRequest request) throws IOException{
		
		ModelAndView model = new ModelAndView("answerQuestion"); 	
		String userid = request.getSession().getAttribute("userid").toString();
		User user = userDao.getUserDet(userid);
		
		List<Question> questionList = testDao.getQuestions(user,hotsCd);
		for (int i=0;i<questionList.size();i++) {
			Question question = questionList.get(i);
			if (!question.isSubmitted()) {
				model.addObject("question",question);
				model.addObject("totalquestionNum",questionList.size());
				model.addObject("currentQuestionNum",i+1);
				model.addObject("answer",new Answer());
				return model;
			}
		}
		
		return new ModelAndView("redirect:/takeTest.html"); 	
	}
	
	@RequestMapping(value = "/answerQuestion{hotsCd}", method = RequestMethod.GET)
	public ModelAndView getQuestionRedirect(@PathVariable("hotsCd") String hotsCd,HttpServletRequest request) throws IOException{		
		return getQuestion(hotsCd,request); 	
	}
	
	@RequestMapping(value="/submitAnswer",method = RequestMethod.POST)
	public RedirectView submitAnswer(@RequestParam("hotsCd") String hotsCd,@ModelAttribute("answer")Answer answer,BindingResult result ,HttpServletRequest request) throws IOException{
		String userid = request.getSession().getAttribute("userid").toString();
		String submissionId = testDao.getSubmissionId(userid);
		try {
			testDao.insertAnswer(submissionId, answer);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		RedirectView rv = new RedirectView();
        rv.setContextRelative(true);
        String url="/answerQuestion"+hotsCd+".html";
        rv.setUrl(url);
        return rv;	
	}
	
}
