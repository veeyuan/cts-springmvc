package com.cts.controller;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@RequestMapping("/viewResult")  
    public ModelAndView redirectToViewResult(HttpServletRequest request)  
    {  
		ModelAndView model = new ModelAndView("viewResult"); 
		String userid = request.getSession().getAttribute("userid").toString();	
		Submission submission = new Submission();
		if(submissionListDao.hasTakenTest(userid)) {
			submission.setHasTakenTest(true);
			if (submissionListDao.isResultReady(userid)) {
				submission.setRstReady(true);
				submission.setUserId(userid);
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
			}else {
				submission.setRstReady(false);
			}
		}else {
			submission.setHasTakenTest(false);
		}
		
		model.addObject("submission", submission);
		
	    return model;
    } 

}
