package com.cts.model;

import java.sql.Date;
import java.util.List;

public class Submission {
	public Submission() {}
	private List<Question> questionLst;
	private List<Answer> answerLst;
	private String userId;
	private Date submitDt;
	private int noReqManualGrading=0;
	/**
	 * @return the questionLst
	 */
	public List<Question> getQuestionLst() {
		return questionLst;
	}
	/**
	 * @param questionLst the questionLst to set
	 */
	public void setQuestionLst(List<Question> questionLst) {
		this.questionLst = questionLst;
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
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return the submitDt
	 */
	public Date getSubmitDt() {
		return submitDt;
	}
	/**
	 * @param submitDt the submitDt to set
	 */
	public void setSubmitDt(Date submitDt) {
		this.submitDt = submitDt;
	}
	/**
	 * @return the noReqManualGrading
	 */
	public int getNoReqManualGrading() {
		if (questionLst.size()>0) {
			for (int i=0; i<questionLst.size();i++) {
				if (!questionLst.get(i).isMcq()) {
					noReqManualGrading++;
				}
			}
		}
		return noReqManualGrading;
	}
	/**
	 * @param noReqManualGrading the noReqManualGrading to set
	 */
	public void setNoReqManualGrading(int noReqManualGrading) {
		this.noReqManualGrading = noReqManualGrading;
	}

}
