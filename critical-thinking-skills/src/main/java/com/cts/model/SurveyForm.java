package com.cts.model;

import java.util.List;

public class SurveyForm {

	private String id;
	private String formName;
	private boolean isCompleted;
	private List<ProgrammingResults> programmingRstList;
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
	 * @return the programmingRstList
	 */
	public List<ProgrammingResults> getProgrammingRstList() {
		return programmingRstList;
	}
	/**
	 * @param programmingRstList the programmingRstList to set
	 */
	public void setProgrammingRstList(List<ProgrammingResults> programmingRstList) {
		this.programmingRstList = programmingRstList;
	}
	
}
