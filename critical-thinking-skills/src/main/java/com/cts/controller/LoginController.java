package com.cts.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cts.dao.UserDao;
import com.cts.model.Login;
import com.cts.model.User;
@Controller
public class LoginController {
	 @Autowired  
	    UserDao userDao;
	
	 @RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
	  public ModelAndView loginProcess(@RequestParam("username") String username,@RequestParam("password") String pswd,@RequestParam("roleCd") String role) {
	    ModelAndView mav = null;
	    Login login = new Login (username,pswd,role);
	    List<User> userLst = userDao.validateUser(login);
	    if (!userLst.isEmpty()) {
	    	User user = userLst.get(0);
	    	if (("admin").equalsIgnoreCase(user.getRoleCd())) {
	    		mav = new ModelAndView("gradeRstWaitingList");
	    	}
	    
	    } else {
	    	 System.out.println("Invalid username and pswd");
			/*
			 * mav = new ModelAndView("login"); mav.addObject("message",
			 * "Username or Password is wrong!!");
			 */
	    }

	    return mav;
	  }

}
