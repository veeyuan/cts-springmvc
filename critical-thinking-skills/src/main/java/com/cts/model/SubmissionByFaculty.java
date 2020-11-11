package com.cts.model;

public class SubmissionByFaculty {
	public SubmissionByFaculty(String facultyDscp,int amount) {
		if (facultyDscp == null) {
			facultyDscp="Others";
		}
		this.facultyDscp =  facultyDscp;
		this.amount = amount;
	}
	private String facultyDscp;
	private int amount;
	/**
	 * @return the facultyDscp
	 */
	public String getFacultyDscp() {
		return facultyDscp;
	}
	/**
	 * @param facultyDscp the facultyDscp to set
	 */
	public void setFacultyDscp(String facultyDscp) {
		this.facultyDscp = facultyDscp;
	}
	/**
	 * @return the amount
	 */
	public int getAmount() {
		return amount;
	}
	/**
	 * @param amount the amount to set
	 */
	public void setAmount(int amount) {
		this.amount = amount;
	}

}
