package com.cts.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.cts.dao.CategoryDao;
import com.cts.dao.DisciplineDao;
import com.cts.dao.LanguageDao;
import com.cts.dao.SubmissionListDao;
import com.cts.dao.UserDao;
import com.cts.model.Category;
import com.cts.model.Discipline;
import com.cts.model.Language;
import com.cts.model.Login;
import com.cts.model.User;

@Controller
public class LoginController {
	 @Autowired  
	    UserDao userDao;
	 @Autowired  
	    DisciplineDao disciplineDao;
	 @Autowired  
		CategoryDao categoryDao;
	@Autowired  
		LanguageDao languageDao;
	@Autowired  
	SubmissionListDao submissionListDao;
	
	 @RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
	  public ModelAndView loginProcess(@RequestParam("username") String username,@RequestParam("password") String pswd,@RequestParam("roleCd") String role,HttpServletRequest request) {
	    ModelAndView mav = null;
	    Login login = new Login (username,pswd,role);
	    List<User> userLst = userDao.validateUser(login);
	    if (!userLst.isEmpty()) {
	    	User user = userLst.get(0);
	    	if (("admin").equalsIgnoreCase(user.getRoleCd())) {
	    		mav = new ModelAndView("gradeRstWaitingList");
	    		request.getSession().setAttribute("userid", user.getId());
	    		request.getSession().setAttribute("username", user.getUsername());
	    		return new ModelAndView("redirect:/gradeRstWaitingList.html");
	    		
	    	}
	    	if (("TEST-TAKER").equalsIgnoreCase(user.getRoleCd())) {
	    		mav = new ModelAndView("takeTest");
	    		request.getSession().setAttribute("userid", user.getId());
	    		request.getSession().setAttribute("username", user.getUsername());
	    		return new ModelAndView("redirect:/takeTest.html");
			
	    	}
	    
	    } else {
	    	mav = new ModelAndView("redirect:/");
	    	mav.addObject("login","fail");
	    }

	    return mav;
	  }
	 
	 @RequestMapping("/logout")
	 public String logout(HttpSession session ) {
	     session.invalidate();
	     return "redirect:/";
	 } 
	 
	 
	 @RequestMapping(value = "/registerProcess", method = RequestMethod.POST)
	  public ModelAndView   registerProcess(@RequestParam("registerUserName") String username,@RequestParam("registerPswd") String pswd,
			  @RequestParam("emailaddr") String emailAddr,@RequestParam("fullname") String fullName,@RequestParam("matricNum") String matricNum, HttpServletRequest req,HttpServletResponse res, ModelAndView model) {
	     model = new ModelAndView("redirect:/");
		 User user = new User(username,pswd,"TEST-TAKER");
	    user.setFullname(fullName);
	    user.setEmail(emailAddr);
	    user.setMatricNum(matricNum);
	    try {
			userDao.createTestTaker(user);
		} catch (SQLException e) {
			model.addObject("register", "fail");
			e.printStackTrace();
			return model;
		}
	    model.addObject("register","success");
	    return model;
	  }
	 

	 

}
