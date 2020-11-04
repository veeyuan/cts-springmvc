package com.cts.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cts.dao.UserDao;

@Controller
public class ChangePasswordController {
	
	@Autowired  
	UserDao userDao;
	
	@RequestMapping("/changePassword") 
	public ModelAndView requestChangePassword()  
    {
		ModelAndView model = new ModelAndView("changePassword"); 
		return model;
    }
	
	@RequestMapping(value="/changePassword", method = RequestMethod.POST) 
	public ModelAndView processChangePassword(@RequestParam("oldpswd") String oldpswd,@RequestParam("newpswd") String newpswd,HttpServletRequest request)  
    {
		String userid = request.getSession().getAttribute("userid").toString();
		boolean isChanged = userDao.changePassword(userid,oldpswd,newpswd);
		ModelAndView model = new ModelAndView("changePasswordProcess");
		if (isChanged) {
			model.addObject("success","Y");
		}else {
			model.addObject("success","N");
		}
		return model;
    }

}
