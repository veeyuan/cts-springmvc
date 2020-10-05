package com.cts.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

import com.cts.dao.CategoryDao;
import com.cts.dao.DisciplineDao;
import com.cts.dao.LanguageDao;
import com.cts.dao.SubmissionListDao;
import com.cts.model.Category;
import com.cts.model.Discipline;
import com.cts.model.Language;
import com.cts.model.Question;
import com.cts.model.Submission;
import com.cts.model.User;

@Controller  
public class GradeResultController {
	@Autowired  
	SubmissionListDao submissionListDao;
	@Autowired  
    DisciplineDao disciplineDao;
	@Autowired  
	CategoryDao categoryDao;
	@Autowired  
	LanguageDao languageDao;

	@RequestMapping("/gradeRstWaitingList")  
	public ModelAndView  directToViewSubmission(HttpServletRequest request) throws IOException  
	{  
		ModelAndView model = new ModelAndView("gradeRstWaitingList"); 
		List<Submission> allSubmissionList =   submissionListDao.getSubmissionList(0,0);
		request.getSession().setAttribute("waitingtogradeNum", allSubmissionList.size());
		int totalRecords = allSubmissionList.size();
		int recordsPerPg = 5;
		int totalPages = totalRecords/recordsPerPg;
		if (totalRecords%recordsPerPg>0) {
			totalPages++;
		}
		List<Submission> submissionList =   submissionListDao.getSubmissionList(1,5);
		model.getModelMap().addAttribute("totalPages",Integer.toString(totalPages));
		model.getModelMap().addAttribute("currentPage",Integer.toString(1));
		model.addObject("listSubmission",submissionList);
		List<Language> listLanguage =   languageDao.getLanguageList();
		model.addObject("listLanguage",listLanguage);
		List<Category> listCategory =  categoryDao.getCategoryList();
		model.addObject("listCategory",listCategory);
		model.addObject("filterSubmission",new Submission());
	    return model;  
	}  
	
	@RequestMapping(value="/gradeRstWaitingList", method = RequestMethod.POST)  
	public ModelAndView filterSubmission(HttpServletRequest request,@RequestParam("submitDt") String strDate,@RequestParam("targetPage") String strTargetPage,@ModelAttribute("filterSubmission")Submission filterSubmission, 
		      BindingResult result) throws IOException  
	{  
		if(!strDate.isEmpty()) {
			try {
				java.util.Date utilDate = new SimpleDateFormat("yyyy/MM/dd").parse(strDate);
			    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());			
				filterSubmission.setSubmitDt(sqlDate);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
		}
		
		filterSubmission.setDisciplineCd("general");
		int numPerPg=5;  
		int startRow=1;
		int targetPage = Integer.parseInt(strTargetPage);
        if(targetPage==1){}    
        else{    
        	startRow=(targetPage-1)*numPerPg+1;    
        }    
        int endRow=startRow+numPerPg-1;
        ModelAndView model = new ModelAndView("gradeRstWaitingList"); 
		List<Submission> allSubmissionList =   submissionListDao.getSubmissionList(filterSubmission,0,0);
		int totalRecords = allSubmissionList.size();
		int recordsPerPg = 5;
		int totalPages = totalRecords/recordsPerPg;
		if (totalRecords%recordsPerPg>0) {
			totalPages++;
		}
		List<Submission> submissionList =   submissionListDao.getSubmissionList(filterSubmission,startRow,endRow);
		model.getModelMap().addAttribute("totalPages",Integer.toString(totalPages));
		model.getModelMap().addAttribute("currentPage",strTargetPage);
		model.getModelMap().addAttribute("filterSubmitDt",strDate);
		model.addObject("listSubmission",submissionList);
		List<Category> listCategory =  categoryDao.getCategoryList();
		model.addObject("listCategory",listCategory);
		List<Language> listLanguage =   languageDao.getLanguageList();
		model.addObject("listLanguage",listLanguage);
		
	    return model;  
	}  
	
	@RequestMapping("/gradeResults")
	public ModelAndView getSubmittedAnswers(@RequestParam("submissionID") String submissionID ,HttpServletRequest request) throws IOException{
			ModelAndView model = new ModelAndView("gradeResults"); 	
			Submission submission = submissionListDao.getSubmission(submissionID);
			model.addObject("submission",submission);
			request.setAttribute("submission",submission);
			
		
		return model;
	}
	
	@RequestMapping(value = "/submitGrades", method = RequestMethod.POST)
	public String submitGrade(HttpServletRequest request,@ModelAttribute("submission")Submission submission,BindingResult result ,ModelMap model) throws IOException, SQLException{
		  String id = request.getSession().getAttribute("userid").toString();

			try {
				submissionListDao.submitGrades(submission,id);
			}catch(SQLException e) {
				System.out.println("Failed to add >>>");
				model.addAttribute("success","N");
				e.printStackTrace();
				return "submitGrades";
			}
			
			
		
			return "redirect:/submitGrades.html";
	}
	
	@RequestMapping(value = "/submitGrades", method = RequestMethod.GET)
	public String submitGradesReload(ModelMap model) throws IOException {
		model.addAttribute("success","Y");
		return "submitGrades";
	}

}
