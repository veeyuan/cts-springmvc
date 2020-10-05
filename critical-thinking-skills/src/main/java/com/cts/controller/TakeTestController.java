package com.cts.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import com.cts.dao.TestDao;
import com.cts.dao.UserDao;
import com.cts.model.Answer;
import com.cts.model.Category;
import com.cts.model.Discipline;
import com.cts.model.Language;
import com.cts.model.Question;
import com.cts.model.Submission;
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
	
	@RequestMapping("/takeTest")
	public ModelAndView viewQuestionDet(HttpServletRequest request){
			ModelAndView model = new ModelAndView("takeTest"); 	
			String id = request.getSession().getAttribute("userid").toString();
			String username = request.getSession().getAttribute("username").toString();
    		User userDet = userDao.getUserDet(id);
    		model.addObject("user",userDet);
    		List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
    		model.addObject("listDiscipline",listDiscipline);
			List<Category> listCategory =   categoryDao.getCategoryList();
			model.addObject("listCategory",listCategory);
		
		
		return model;
	}
	
	@RequestMapping("/startTest")
	public ModelAndView getQuestions(HttpServletRequest request) throws IOException{
			ModelAndView model = new ModelAndView("startTest"); 	
			String id = request.getSession().getAttribute("userid").toString();
			String username = request.getSession().getAttribute("username").toString();
    		User userDet = userDao.getUserDet(id);
    		model.addObject("user",userDet);
    		List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
    		model.addObject("listDiscipline",listDiscipline);
			List<Category> listCategory =   categoryDao.getCategoryList();
			model.addObject("listCategory",listCategory);
			//in modal
			List<Question> listQuestion = testDao.getQuestions(userDet.getDisciplineCd(), userDet.getCategoryCd(), "ENG");
			Submission submission = new Submission();
			submission.setQuestionLst(listQuestion);
			model.addObject("submission",submission);
			request.setAttribute("questionLst",listQuestion );
			
		
		return model;
	}
	
	@RequestMapping(value = "/submitTest", method = RequestMethod.POST)
	public String submitAnswer(HttpServletRequest request,@ModelAttribute("submission")Submission submission,BindingResult result ,ModelMap model) throws IOException, SQLException{
			String id = request.getSession().getAttribute("userid").toString();
			submission.setUserId(id);
			long millis=System.currentTimeMillis();
			java.sql.Date date=new java.sql.Date(millis);
			submission.setSubmitDt(date);
			try {
			testDao.submitAnswer(submission);
			}catch(SQLException e) {
				System.out.println("Failed to add >>>");
				model.addAttribute("success","N");
				e.printStackTrace();
				return "submitTest";
			}
			return "redirect:/submitTest.html";
	}
	
	@RequestMapping(value = "/submitTest", method = RequestMethod.GET)
	public String submitTestReload(ModelMap model) throws IOException {
		model.addAttribute("success","Y");
		return "submitTest";
	}

}
