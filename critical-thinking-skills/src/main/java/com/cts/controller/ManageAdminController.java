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

import com.cts.dao.AdminDao;
import com.cts.model.Admin;
import com.cts.model.Option;
import com.cts.model.Login;

@Controller
public class ManageAdminController {
	@Autowired  
	AdminDao adminDao;
	@RequestMapping("/manageAdmin") 
	public ModelAndView redirectToManageAdmin()  
    { 
		ModelAndView model = new ModelAndView("manageAdmin"); 		
		List<Admin> adminList = adminDao.getAdminList();
		model.addObject("listAdmin",adminList);
		List<Option> roleList = adminDao.getRoleOption();
		model.addObject("listRole",roleList);
		model.addObject("newAdmin",new Login());
		return model;		
    }
	
	@RequestMapping(value = "/setAdminAccessibility", method = RequestMethod.POST)
	public ModelAndView  hideOptions( @RequestParam("hideGroupList") String[] unhideOptionList,HttpServletRequest request) throws IOException {
		try {
			adminDao.setAdminAccessibility(unhideOptionList);
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		 ModelAndView model =  new ModelAndView("redirect:/manageAdmin.html");
		return model;
		
	}
	
	@RequestMapping(value = "/addAdmin", method = RequestMethod.POST) 
	public ModelAndView addAdmin(@ModelAttribute("newAdmin")Login login,BindingResult result, ModelMap model)  
    { 
		try {
			adminDao.insertNewAdmin(login);
		}catch(Exception e) {
			e.printStackTrace();
			return new ModelAndView("addAdminFail");
		}
		 ModelAndView mav =  new ModelAndView("redirect:/manageAdmin.html");
		return mav;
    }

}
