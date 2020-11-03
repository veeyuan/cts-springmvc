package com.cts.controller;


import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cts.dao.FacultyDao;
import com.cts.dao.OptionDao;
import com.cts.model.Department;
import com.cts.model.Faculty;
import com.cts.model.Option;
@Controller
public class ManageOptionController {
	@Autowired  
	OptionDao optionDao;
	@Autowired
	FacultyDao facultyDao;
	@RequestMapping("/manageOption") 
	public ModelAndView redirectToOptionGroup()  
    { 
		ModelAndView model = new ModelAndView("manageOption"); 		
		return model;		
    }
	
	@RequestMapping(value="/listOption",method =  RequestMethod.POST ) 
	public ModelAndView getOptionDetailPOST(@RequestParam(value="group",required = false) String group)  
    { 
		return getOptionDetail(group);
    }
	
	@RequestMapping(value="/listOption",method =  RequestMethod.GET ) 
	public ModelAndView getOptionDetailGET(HttpServletRequest request)  
    { 
		String group = request.getSession().getAttribute("varName").toString();
		return getOptionDetail(group);
    }
	
	public ModelAndView getOptionDetail( String group)  {		
		ModelAndView model = new ModelAndView("manageOptionDet");
		model.addObject("title",group);
		List<Option> listOption = null;
		if (StringUtils.containsIgnoreCase(group,"discipline")) {
			listOption = optionDao.getOptionAllList("discipline");
			model.addObject("varName","discipline");
		}else if (StringUtils.containsIgnoreCase(group,"category")) {
			listOption = optionDao.getOptionAllList("category");
			model.addObject("varName","category");
		}else if(StringUtils.containsIgnoreCase(group,"component")) {
			listOption = optionDao.getOptionAllList("component");
			model.addObject("varName","component");
		}else if(StringUtils.containsIgnoreCase(group,"faculty")) {
			listOption = optionDao.getOptionAllList("faculty");
			model.addObject("varName","faculty");
		}else if(StringUtils.containsIgnoreCase(group,"department")) {
			List<Department> listDepartment = optionDao.getAllDepartmentWithFacList();
			model.addObject("listOption",listDepartment);
			model.addObject("varName","department");
			List<Faculty> listFaculty = facultyDao.getFacultyList();
			model.addObject("listFaculty",listFaculty);
			return model;
		}else if(StringUtils.containsIgnoreCase(group,"programming")) {
			listOption = optionDao.getOptionAllList("course");
			model.addObject("varName","programming");
		}
		model.addObject("listOption",listOption);
		

		return model;
	}

	
	@RequestMapping(value = "/hideOptions", method = RequestMethod.POST)
	public ModelAndView  hideOptions( @RequestParam("hideGroupList") String[] hideOptionList,@RequestParam("varName") String varName,HttpServletRequest request) throws IOException {
		try {
			optionDao.showOptions(hideOptionList,varName);
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		 ModelAndView model =  new ModelAndView("redirect:/listOption.html");
		 request.getSession().setAttribute("varName",varName );
		return model;
		
	}
	
	@RequestMapping(value = "/addOption", method = RequestMethod.POST) 
	public ModelAndView redirectToAddOption(@RequestParam("varName") String varName,@RequestParam("optionDscp") String optionDscp,HttpServletRequest request)  
    { 
		try {
		optionDao.insertNewOption(varName,optionDscp);
		}catch(Exception e) {
			e.printStackTrace();
			return new ModelAndView("addOptionFail");
		}
		 ModelAndView model =  new ModelAndView("redirect:/listOption.html");
		 request.getSession().setAttribute("varName",varName );
		return model;
    }
	
	@RequestMapping(value = "/addDepartment", method = RequestMethod.POST) 
	public ModelAndView addDepartment(@RequestParam("deptDscp") String deptDscp,@RequestParam("facultyCd") String facultyCd,@RequestParam("varName") String varName,HttpServletRequest request)  
    { 
		try {
			optionDao.insertNewDepartment(deptDscp,facultyCd);
			}catch(Exception e) {
				e.printStackTrace();
				return new ModelAndView("addOptionFail");
			}
		 ModelAndView model =  new ModelAndView("redirect:/listOption.html");
		 request.getSession().setAttribute("varName",varName );
		return model;
    }
	
	@RequestMapping(value = "/addCourse", method = RequestMethod.POST) 
	public ModelAndView addProgrammingCourse(@RequestParam("courseCd") String courseCd,@RequestParam("courseNm") String courseNm,@RequestParam("varName") String varName,HttpServletRequest request)  
    { 
		
		try {
			optionDao.insertProgrammingCourse(courseCd,courseNm);
			}catch(Exception e) {
				e.printStackTrace();
				return new ModelAndView("addOptionFail");
			}
		 ModelAndView model =  new ModelAndView("redirect:/listOption.html");
		 request.getSession().setAttribute("varName",varName );
		return model;		
    }
}
