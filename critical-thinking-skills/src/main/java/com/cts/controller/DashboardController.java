package com.cts.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.cts.dao.ChartDao;
import com.cts.dao.ReportDao;
import com.cts.model.SubmissionByFaculty;

@Controller
public class DashboardController {
	
	@Autowired  
	ChartDao chartDao; 
	@Autowired  
	ReportDao reportDao;
	
	@RequestMapping("/dashboard") 
	public ModelAndView redirectToDashboard(HttpServletRequest request)  
    {  
		ModelAndView model = new ModelAndView("dashboard");
		List<List<Map<Object, Object>>> submissionStatusDataList = chartDao.getSubmissionMapList();
		List<List<Map<Object, Object>>> submissionByFacultyDataList = chartDao.getFacultySubmissionMapList();
		List<SubmissionByFaculty> listFacSubmission=chartDao.getFacultySubmissionSummary();
		model.addObject("dataPointsList",submissionStatusDataList);
		model.addObject("dataPointsList2",submissionByFacultyDataList);
		model.addObject("listFacSubmission",listFacSubmission);
		double totalCompletedSubmissionNum = chartDao.getCloseSubmission()+chartDao.getGradedSubmission();
		model.addObject("totalCompletedSubmissionNum",(int)totalCompletedSubmissionNum);
		model.addObject("reportName",reportDao.getReportName());
		model.addObject("totalSubmissionNum",(int)chartDao.getTotalSubmissionCount());
		model.addObject("openSubmissionNum",(int)chartDao.getOpenSubmission());
		model.addObject("closeSubmissionNum",(int)chartDao.getCloseSubmission());
		model.addObject("gradedSubmissionNum",(int)chartDao.getGradedSubmission());
		return model;
    }
	
	@RequestMapping(value = "/downloadData", method = RequestMethod.GET)
	public ModelAndView downloadData(HttpServletRequest request,HttpServletResponse response) throws Exception {
	 
	        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	        response.setContentLength(reportDao.generateFileByteData().length);
	        response.setHeader("Content-Disposition","attachment; filename=\"" + reportDao.getReportName() +"\"");
	        FileCopyUtils.copy(reportDao.generateFileByteData(), response.getOutputStream());
	 
	        return null;
	 
	    }
	


}
