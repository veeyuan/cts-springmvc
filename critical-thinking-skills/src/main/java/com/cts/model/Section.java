package com.cts.model;

import java.util.List;

public class Section {
	private HotsComponent hots;
	private List<Question> questionList;
	private boolean isCompleted;
	/**
	 * @return the hots
	 */
	public Section(HotsComponent hots) {
		this.hots = hots;
	}
	public HotsComponent getHots() {
		return hots;
	}
	/**
	 * @param hots the hots to set
	 */
	public void setHots(HotsComponent hots) {
		this.hots = hots;
	}
	/**
	 * @return the questionList
	 */
	public List<Question> getQuestionList() {
		return questionList;
	}
	/**
	 * @param questionList the questionList to set
	 */
	public void setQuestionList(List<Question> questionList) {
		this.questionList = questionList;
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

}
