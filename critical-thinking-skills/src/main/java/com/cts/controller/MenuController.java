package com.cts.controller;
import org.springframework.stereotype.Controller;  
import org.springframework.web.bind.annotation.RequestMapping;  
@Controller  
public class MenuController {  
	
	    
	
	
	@RequestMapping("/gradeRstWaitingList")  
	public String redirectToGradeRstWaitingList()  
	{  
	    return "gradeRstWaitingList";  
	} 
	
	
}  