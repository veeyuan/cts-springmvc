package com.cts.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cts.dao.AgeGroupDao;
import com.cts.dao.CategoryDao;
import com.cts.dao.DisciplineDao;
import com.cts.dao.EducationLevelDao;
import com.cts.dao.EmploymentStatusDao;
import com.cts.dao.LanguageDao;
import com.cts.dao.NationalityDao;
import com.cts.dao.SurveyDao;
import com.cts.dao.UserDao;
import com.cts.model.AgeGroup;
import com.cts.model.Category;
import com.cts.model.Discipline;
import com.cts.model.EducationLevel;
import com.cts.model.EmploymentStatus;
import com.cts.model.Language;
import com.cts.model.Nationality;
import com.cts.model.Question;
import com.cts.model.Submission;
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
	EducationLevelDao educationLevelDao;
	@Autowired
	EmploymentStatusDao employmentStatusDao;
	@Autowired
	NationalityDao nationalityDao;
	
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
		
		List<SurveyForm> listForm = surveyDao.getSurveyList(id, "ENG");
		model.addObject("listForm",listForm);
		request.setAttribute("formLst",listForm );
		return model;
	}
	@RequestMapping("/fillSurvey")  
	public ModelAndView  fillSurvey(@RequestParam("formid") String formId,HttpServletRequest request) 
	{  
		ModelAndView model = new ModelAndView("fillSurvey"); 
		String id = request.getSession().getAttribute("userid").toString();		
		List<Question> questionLst = surveyDao.getSurveyQuestion(formId);
		if (questionLst.size()==0) {
			model = new ModelAndView("fillPersonalDetails"); 
			
			List<AgeGroup> listAgeGroup =   ageGroupDao.getAgeGroupList();
			model.addObject("listAgeGroup",listAgeGroup);
			List<EducationLevel> listEduLevel  = educationLevelDao.getEduLevelList();
			model.addObject("listEduLevel",listEduLevel);
			List<EmploymentStatus> listEmpStatus = employmentStatusDao.getEmploymentStatusList();
			model.addObject("listEmpStatus",listEmpStatus);
			List<Nationality> listNationality = nationalityDao.getNationList();
			model.addObject("listNationality",listNationality);
			model.addObject("user",new User());
			SurveyForm survey = new SurveyForm();
			survey.setId(formId);
			survey.setFormName(surveyDao.getFormName(formId));
			model.addObject("form",survey);
			return model;
		}
		SurveyForm survey = new SurveyForm();
		survey.setId(formId);
		survey.setFormName(surveyDao.getFormName(formId));
		survey.setRatingScaleImgDir(surveyDao.getRatingScaleImgDir(formId));
		survey.setQuetionLst(questionLst);
		model.addObject("survey",survey);
		request.setAttribute("questionLstSize",Integer.toString(questionLst.size()) );
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
	
	
	@RequestMapping("/processSurvey")
	public ModelAndView  fillSurvey(@ModelAttribute("survey")SurveyForm survey,BindingResult result ,HttpServletRequest request) 
	{ 
		ModelAndView model = new ModelAndView("redirect:/manageProfile.html"); 
		String userid = request.getSession().getAttribute("userid").toString();
		try {
			surveyDao.submitSurvey(survey,userid);
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
