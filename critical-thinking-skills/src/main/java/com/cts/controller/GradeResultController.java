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

import com.cts.dao.CategoryDao;
import com.cts.dao.DisciplineDao;
import com.cts.dao.SubmissionListDao;
import com.cts.model.Category;
import com.cts.model.Discipline;
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
		List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
		model.addObject("listDiscipline",listDiscipline);
		List<Category> listCategory =  categoryDao.getCategoryList();
		model.addObject("listCategory",listCategory);
		
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
			model.addAttribute("success","Y");
			model.addAttribute("submissionid",submission.getSubmissionId());
			
		
		return "submitGrades";
	}
	
	

}
