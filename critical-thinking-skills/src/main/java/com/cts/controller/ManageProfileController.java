package com.cts.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cts.dao.AgeGroupDao;
import com.cts.dao.CategoryDao;
import com.cts.dao.DisciplineDao;
import com.cts.dao.EthnicDao;
import com.cts.dao.FacultyDao;
import com.cts.dao.LanguageDao;
import com.cts.dao.NationalityDao;
import com.cts.dao.ProgrammingRstDao;
import com.cts.dao.ResultRangeDao;
import com.cts.dao.SurveyDao;
import com.cts.dao.UserDao;
import com.cts.model.AgeGroup;
import com.cts.model.Category;
import com.cts.model.Discipline;
import com.cts.model.Ethnic;
import com.cts.model.Faculty;
import com.cts.model.Language;
import com.cts.model.Nationality;
import com.cts.model.ProgrammingResults;
import com.cts.model.ResultRange;
import com.cts.model.SurveyForm;
import com.cts.model.User;

@Controller
public class ManageProfileController {
	@Autowired  
    UserDao userDao;
	@Autowired  
    DisciplineDao disciplineDao;
	@Autowired  
	CategoryDao categoryDao;
	@Autowired  
	LanguageDao languageDao;
	@Autowired  
	SurveyDao surveyDao;
	@Autowired
	AgeGroupDao ageGroupDao;
	@Autowired
	NationalityDao nationalityDao;
	@Autowired
	EthnicDao ethnicDao;
	@Autowired
	FacultyDao facultyDao;
	@Autowired
	ResultRangeDao resultRangeDao;
	@Autowired
	ProgrammingRstDao programmingRstDao;
	@RequestMapping("/manageProfile")  
	public ModelAndView  directToManageProfile(HttpServletRequest request) 
	{  
		ModelAndView model = new ModelAndView("manageProfile"); 
		String id = request.getSession().getAttribute("userid").toString();		
		User userDet = userDao.getUserDet(id);
		model.addObject("user",userDet);
		List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
		model.addObject("listDiscipline",listDiscipline);
		List<Category> listCategory =   categoryDao.getCategoryList();
		model.addObject("listCategory",listCategory);
		List<Language> listLanguage =   languageDao.getLanguageList();
		model.addObject("listLanguage",listLanguage);
		
		List<SurveyForm> listForm = surveyDao.getSurveyList(id, 1);
		model.addObject("listForm",listForm);
		request.setAttribute("formLst",listForm );

		return model;
	}
	
	@RequestMapping(value="/manageProfile",method = RequestMethod.POST)  
	public ModelAndView  directToManageProfile(HttpServletRequest request,@RequestParam("consentToTakeSurvey") String consentToTakeSurvey) 
	{  
		ModelAndView model = new ModelAndView("manageProfile"); 
		String id = request.getSession().getAttribute("userid").toString();		
		User userDet = userDao.getUserDet(id);
		model.addObject("user",userDet);
		if ("Y".equalsIgnoreCase(consentToTakeSurvey)) {
			userDao.grantConsentToSurvey(id);
			return new ModelAndView("redirect:/manageProfile.html"); 
		}
		List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
		model.addObject("listDiscipline",listDiscipline);
		List<Category> listCategory =   categoryDao.getCategoryList();
		model.addObject("listCategory",listCategory);
		List<Language> listLanguage =   languageDao.getLanguageList();
		model.addObject("listLanguage",listLanguage);
		
		List<SurveyForm> listForm = surveyDao.getSurveyList(id, 1);
		model.addObject("listForm",listForm);
		request.setAttribute("formLst",listForm );
		return model;
	}
	
	
	@RequestMapping("/fillSurvey")  
	public ModelAndView  fillSurvey(@RequestParam("formid") String formId,HttpServletRequest request) 
	{  
		ModelAndView model = new ModelAndView("fillPersonalDetails");	
		SurveyForm survey = new SurveyForm();
		survey.setId(formId);
		survey.setFormName(surveyDao.getFormName(formId));
		if (!surveyDao.getFormName(formId).equalsIgnoreCase("Personal Details")) {
			model = new ModelAndView("fillProgrammingRst"); 
			List<ProgrammingResults> listProgrammingRst = programmingRstDao.getProgrammingCourseList();
			model.addObject("listProgrammingRst",listProgrammingRst);
			model.addObject("form",survey);
			return model;
			
		}
		List<AgeGroup> listAgeGroup =   ageGroupDao.getAgeGroupList();
		model.addObject("listAgeGroup",listAgeGroup);
		List<Nationality> listNationality = nationalityDao.getNationList();
		model.addObject("listNationality",listNationality);
		List<Ethnic> listEthnic = ethnicDao.getEthnicList();
		model.addObject("listEthnic",listEthnic);
		List<Faculty> listFaculty = facultyDao.getFacultyDeptList();
		model.addObject("listFaculty",listFaculty);
		List<ResultRange> listRstRange = resultRangeDao.getRstRangeList();
		model.addObject("listRstRange",listRstRange);
		model.addObject("user",new User());
		
		model.addObject("form",survey);
		return model;
		
		
		
	}
	
	
	@RequestMapping("/processDISurvey")
	public ModelAndView  fillSurvey(@ModelAttribute("user")User user,@RequestParam("formid") String formid,BindingResult result ,HttpServletRequest request) 
	{ 
		ModelAndView model = new ModelAndView("redirect:/manageProfile.html"); 
		user.setId(request.getSession().getAttribute("userid").toString());
		try {
			surveyDao.submitDemoInfo(user,formid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	@RequestMapping("/processRstSurvey")
	public ModelAndView  fillRstSurvey(@ModelAttribute("form")SurveyForm form,BindingResult result ,HttpServletRequest request) 
	{ 
		ModelAndView model = new ModelAndView("redirect:/manageProfile.html"); 
		String userid = request.getSession().getAttribute("userid").toString();
		try {
			surveyDao.submitProgrammingRst(userid,form);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/processTestSpec")
	public ModelAndView  processTestSpec(@ModelAttribute("user")User user,BindingResult result ,HttpServletRequest request) 
	{ 
		ModelAndView model = new ModelAndView("redirect:/takeTest.html"); 
		String userid = request.getSession().getAttribute("userid").toString();
		user.setId(userid);
		try {
			userDao. updateTestSpec(user);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
}
