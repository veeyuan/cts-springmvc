package com.cts.controller;
import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.RequestMapping;  
@Controller  
public class AddQuestionController {
	@RequestMapping("/add")  
    public String helloWorld(Model m) {  
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Add Question Controller");
        return "add";   
    }  
}