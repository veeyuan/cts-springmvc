package com.cts.controller;
import org.springframework.stereotype.Controller;  
import org.springframework.web.bind.annotation.RequestMapping;  
@Controller  
public class MenuController {  
	
	@RequestMapping("/addQuestion")  
    public String redirectToAddQuestion()  
    {  
		System.out.println(">>>>>>>>>>>>>>Menu Controller");
        return "addQuestion";  
    }     
	
	@RequestMapping("/manageQuestion")  
	public String redirectToManageQuestion()  
	{  
	    return "manageQuestion";  
	}  
	
	@RequestMapping("/gradeRstWaitingList")  
	public String redirectToGradeRstWaitingList()  
	{  
	    return "gradeRstWaitingList";  
	}  
}  