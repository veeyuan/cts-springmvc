package com.cts.controller;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;
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
import com.cts.dao.QuestionDao;
import com.cts.dao.QuestionListDao;
import com.cts.model.Category;
import com.cts.model.Discipline;
import com.cts.model.Language;
import com.cts.model.Question;  
@Controller  
public class AddQuestionController {
	
	
	@Autowired  
    QuestionDao questionDao;
	@Autowired  
    DisciplineDao disciplineDao;
	@Autowired  
	CategoryDao categoryDao;
	@Autowired  
	LanguageDao languageDao;
	
	@RequestMapping("/addQuestion")  
    public ModelAndView redirectToAddQuestion()  
    {  
		ModelAndView model = new ModelAndView("addQuestion","question",new Question()); 
		List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
		model.addObject("listDiscipline",listDiscipline);
		List<Category> listCategory =   categoryDao.getCategoryList();
		model.addObject("listCategory",listCategory);
		List<Language> listLanguage =   languageDao.getLanguageList();
		model.addObject("listLanguage",listLanguage);
	    return model;
    }  
	
	@RequestMapping(value = "/addProcess", method = RequestMethod.POST)
	public String addQuestion(@RequestParam("radio-all-mcq") String strMCQ, @ModelAttribute("question")Question question, 
		      BindingResult result, ModelMap model) {
		try {
			System.out.println("question >>>"+question.getQuestionDscp());
			System.out.println("discipline >>>"+question.getDisciplineCd());
			System.out.println("category >>>"+question.getCategoryCd());
			System.out.println("language >>>"+question.getLanguageCd());
			if ("Yes".equalsIgnoreCase(strMCQ)) {
				question.setMcq(true);
			}else {
				question.setMcq(false);
			}
			System.out.println("isMCQ >>>"+question.isMcq());
			System.out.println("opt1 >>>"+question.getOption1());
			System.out.println("opt2 >>>"+question.getOption2());
			System.out.println("opt3 >>>"+question.getOption3());
			System.out.println("opt4 >>>"+question.getOption4());
			System.out.println("opt5 >>>"+question.getOption5());
			System.out.println("mcqAns >>>"+question.getMcqAns());
			System.out.println("sampleAns >>>"+question.getSampleAns());
			System.out.println("analysis >>>"+question.getAnalysisScore());
			System.out.println("logic >>>"+question.getLogicScore());
			System.out.println("judgement >>>"+question.getJudgementScore());
			System.out.println("probsolve >>>"+question.getProbSolveScore());
			System.out.println("creative >>>"+question.getCreativeScore());
			questionDao.addQuestion(question);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Failed to add >>>");
			e.printStackTrace();
		}
		return "addQuestion";
	}
}