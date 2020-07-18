package com.cts.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
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
public class ManageQuestionController {
	@Autowired  
    QuestionListDao questionListDao;
	@Autowired  
    DisciplineDao disciplineDao;
	@Autowired  
	CategoryDao categoryDao;
	@Autowired  
	LanguageDao languageDao;
	@Autowired  
    QuestionDao questionDao;
	
	@RequestMapping("/manageQuestion")  
	public ModelAndView  directToManageQuestion()  
	{  
		ModelAndView model = new ModelAndView("manageQuestion"); 
		List<Question> listQuestion =   questionListDao.getQuestionList();
		model.addObject("listQuestion",listQuestion);
		List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
		model.addObject("listDiscipline",listDiscipline);
		List<Category> listCategory =   categoryDao.getCategoryList();
		model.addObject("listCategory",listCategory);
		List<Language> listLanguage =   languageDao.getLanguageList();
		model.addObject("listLanguage",listLanguage);
	    return model;  
	}  
	
	@RequestMapping(value = "/deleteProcess", method = RequestMethod.POST)
	public String deleteQuestion( @RequestParam("delQuestionList") String[] delQuestionList, ModelMap model) throws IOException {
		int numberQuestions = delQuestionList.length;
		try {	
			questionDao.deleteQuestion(delQuestionList);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Failed to add >>>");
			model.addAttribute("success","N");
			model.addAttribute("numberQuestions",0);
			e.printStackTrace();
			return "deleteProcess";
		}
		model.addAttribute("success","Y");
		model.addAttribute("numberQuestions",Integer.toString(numberQuestions));
		return "deleteProcess";
	}
	
	@RequestMapping(value = "/viewQuestionDet", method = RequestMethod.POST)
	public ModelAndView viewQuestionDet( @RequestParam("questionID") String questionID) throws IOException, SQLException {
		ModelAndView model = new ModelAndView("viewQuestionDet"); 	
		Question question = questionDao.getQuestionDet(questionID);
		if (question !=null) {
			int numberOfOptions = 0;
			if (question.isMcq()) {
				if (question.getOption3()==null) {
					numberOfOptions=2;
				}else if (question.getOption4()==null) {
					numberOfOptions=3;
				}else if (question.getOption5()==null) {
					numberOfOptions=4;
				}else {
					numberOfOptions=5;
				}
				model.getModelMap().addAttribute("numberOfOptions",numberOfOptions);				
			}
			if (question.getBase64questionImage()==null) {
				System.out.println("no question attachment");
				model.getModelMap().addAttribute("hasQuestionAttachment","N");
			}else {
				model.getModelMap().addAttribute("hasQuestionAttachment","Y");
			}
			if (question.getBase64answerImage()==null) {
				System.out.println("no answer attachment");
				model.getModelMap().addAttribute("hasAnswerAttachment","N");
			}else {
				model.getModelMap().addAttribute("hasAnswerAttachment","Y");
			}
			model.addObject("question",question);
			model.getModelMap().addAttribute("success","Y");
			List<Discipline> listDiscipline =   disciplineDao.getDisciplineList();
			model.addObject("listDiscipline",listDiscipline);
			List<Category> listCategory =   categoryDao.getCategoryList();
			model.addObject("listCategory",listCategory);
			List<Language> listLanguage =   languageDao.getLanguageList();
			model.addObject("listLanguage",listLanguage);
		}else {
			model.getModelMap().addAttribute("success","N");
		}

		return model;
	}
	
	
	
	
}
