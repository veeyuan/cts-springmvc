package com.cts.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cts.dao.CategoryDao;
import com.cts.dao.DisciplineDao;
import com.cts.dao.LanguageDao;
import com.cts.dao.UserDao;
import com.cts.model.Category;
import com.cts.model.Discipline;
import com.cts.model.Language;
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

}
