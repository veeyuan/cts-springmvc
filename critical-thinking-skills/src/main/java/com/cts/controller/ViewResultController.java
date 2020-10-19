package com.cts.controller;

import java.text.ParseException;
import java.util.ArrayList;
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
import com.cts.dao.SubmissionListDao;
import com.cts.model.Category;
import com.cts.model.Discipline;
import com.cts.model.Language;
import com.cts.model.Question;
import com.cts.model.Submission;

@Controller  
public class ViewResultController {
	@Autowired  
	SubmissionListDao submissionListDao;
	@Autowired  
    DisciplineDao disciplineDao;
	@Autowired  
	CategoryDao categoryDao;
	@Autowired  
	LanguageDao languageDao;
	
	@RequestMapping("/viewResultList") 
	public ModelAndView redirectToViewResultList(HttpServletRequest request)  
    {  
		ModelAndView model = new ModelAndView("viewResultList"); 
		String userid = request.getSession().getAttribute("userid").toString();	
		List<Submission> submittedSubmissionList =new ArrayList<Submission>();
		if(submissionListDao.hasTakenTest(userid)) {
			submittedSubmissionList = submissionListDao.getSubmittedSubmissionList(userid);
			model.addObject("submissionList", submittedSubmissionList);
			return model;
		}else {
			model = new ModelAndView("viewResult"); 
			Submission submission = new Submission();
			submission.setHasTakenTest(false);
			model.addObject("submission", submission);
			return model;
		}
    } 
	
	@RequestMapping(value="/viewResult",method = RequestMethod.POST)  
    public ModelAndView redirectToViewResult(@RequestParam("submissionId") String submissionId, HttpServletRequest request)  
    {  
		ModelAndView model = new ModelAndView("viewResult");
		Submission submission = new Submission();
		submission.setHasTakenTest(true);
		submission.setSubmissionId(submissionId);
		try {
			submission = submissionListDao.getScoresAnalysis(submission);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
		model.addObject("listDiscipline",listDiscipline);
		List<Category> listCategory =   categoryDao.getCategoryList();
		model.addObject("listCategory",listCategory);
		List<Language> listLanguage =   languageDao.getLanguageList();
		model.addObject("listLanguage",listLanguage);
		
		model.addObject("submission", submission);
		
	    return model;
    } 

}
