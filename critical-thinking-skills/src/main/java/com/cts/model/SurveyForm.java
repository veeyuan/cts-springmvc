package com.cts.model;

import java.util.List;

public class SurveyForm {

	private String id;
	private String formName;
	private boolean isCompleted;
	private List<Question> quetionLst;
	private List<Answer> answerLst;
	private String ratingScaleImgDir;
	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return the formName
	 */
	public String getFormName() {
		return formName;
	}
	/**
	 * @param formName the formName to set
	 */
	public void setFormName(String formName) {
		this.formName = formName;
	}
	/**
	 * @return the isCompleted
	 */
	public boolean isCompleted() {
		return isCompleted;
	}
	/**
	 * @param isCompleted the isCompleted to set
	 */
	public void setCompleted(boolean isCompleted) {
		this.isCompleted = isCompleted;
	}
	/**
	 * @return the quetionLst
	 */
	public List<Question> getQuetionLst() {
		return quetionLst;
	}
	/**
	 * @param quetionLst the quetionLst to set
	 */
	public void setQuetionLst(List<Question> quetionLst) {
		this.quetionLst = quetionLst;
	}
	/**
	 * @return the answerLst
	 */
	public List<Answer> getAnswerLst() {
		return answerLst;
	}
	/**
	 * @param answerLst the answerLst to set
	 */
	public void setAnswerLst(List<Answer> answerLst) {
		this.answerLst = answerLst;
	}
	/**
	 * @return the ratingScaleImgDir
	 */
	public String getRatingScaleImgDir() {
		return ratingScaleImgDir;
	}
	/**
	 * @param ratingScaleImgDir the ratingScaleImgDir to set
	 */
	public void setRatingScaleImgDir(String ratingScaleImgDir) {
		this.ratingScaleImgDir = ratingScaleImgDir;
	}
	
}
