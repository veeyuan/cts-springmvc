package com.cts.model;

import java.sql.Date;
import java.util.List;

public class Submission {
	public Submission() {}
	private List<Question> questionLst;
	private List<Answer> answerLst;
	private List<GradedScores> scoresLst;
	private String userId;
	private Date submitDt;
	private int noReqManualGrading=0;
	private String submissionId;
	private String languageCd;
	private String disciplineCd;
	private String categoryCd;
	private String languageDscp;
	private String disciplineDscp;
	private String categoryDscp;
	private String testTakerName;
	
	private boolean hasTakenTest;
	private boolean isRstReady;
	private boolean joinSurvey;
	
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
	 * @return the scoresLst
	 */
	public List<GradedScores> getScoresLst() {
		return scoresLst;
	}
	/**
	 * @param scoresLst the scoresLst to set
	 */
	public void setScoresLst(List<GradedScores> scoresLst) {
		this.scoresLst = scoresLst;
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
	public int getCalculateNoReqManualGrading() {
		if (questionLst.size()>0) {
			for (int i=0; i<questionLst.size();i++) {
				if (!questionLst.get(i).isMcq()) {
					noReqManualGrading++;
				}
			}
		}
		return noReqManualGrading;
	}
	
	public int getNoReqManualGrading() {
		return noReqManualGrading;
	}
	/**
	 * @param noReqManualGrading the noReqManualGrading to set
	 */
	public void setNoReqManualGrading(int noReqManualGrading) {
		this.noReqManualGrading = noReqManualGrading;
	}
	/**
	 * @return the submissionId
	 */
	public String getSubmissionId() {
		return submissionId;
	}
	/**
	 * @param submissionId the submissionId to set
	 */
	public void setSubmissionId(String submissionId) {
		this.submissionId = submissionId;
	}
	/**
	 * @return the languageCd
	 */
	public String getLanguageCd() {
		return languageCd;
	}
	/**
	 * @param languageCd the languageCd to set
	 */
	public void setLanguageCd(String languageCd) {
		this.languageCd = languageCd;
	}
	/**
	 * @return the disciplineCd
	 */
	public String getDisciplineCd() {
		return disciplineCd;
	}
	/**
	 * @param disciplineCd the disciplineCd to set
	 */
	public void setDisciplineCd(String disciplineCd) {
		this.disciplineCd = disciplineCd;
	}
	/**
	 * @return the categoryCd
	 */
	public String getCategoryCd() {
		return categoryCd;
	}
	/**
	 * @param categoryCd the categoryCd to set
	 */
	public void setCategoryCd(String categoryCd) {
		this.categoryCd = categoryCd;
	}
	/**
	 * @return the testTakerName
	 */
	public String getTestTakerName() {
		return testTakerName;
	}
	/**
	 * @param testTakerName the testTakerName to set
	 */
	public void setTestTakerName(String testTakerName) {
		this.testTakerName = testTakerName;
	}
	/**
	 * @return the hasTakenTest
	 */
	public boolean isHasTakenTest() {
		return hasTakenTest;
	}
	/**
	 * @param hasTakenTest the hasTakenTest to set
	 */
	public void setHasTakenTest(boolean hasTakenTest) {
		this.hasTakenTest = hasTakenTest;
	}
	/**
	 * @return the isRstReady
	 */
	public boolean isRstReady() {
		return isRstReady;
	}
	/**
	 * @param isRstReady the isRstReady to set
	 */
	public void setRstReady(boolean isRstReady) {
		this.isRstReady = isRstReady;
	}
	/**
	 * @return the languageDscp
	 */
	public String getLanguageDscp() {
		return languageDscp;
	}
	/**
	 * @param languageDscp the languageDscp to set
	 */
	public void setLanguageDscp(String languageDscp) {
		this.languageDscp = languageDscp;
	}
	/**
	 * @return the disciplineDscp
	 */
	public String getDisciplineDscp() {
		return disciplineDscp;
	}
	/**
	 * @param disciplineDscp the disciplineDscp to set
	 */
	public void setDisciplineDscp(String disciplineDscp) {
		this.disciplineDscp = disciplineDscp;
	}
	/**
	 * @return the categoryDscp
	 */
	public String getCategoryDscp() {
		return categoryDscp;
	}
	/**
	 * @param categoryDscp the categoryDscp to set
	 */
	public void setCategoryDscp(String categoryDscp) {
		this.categoryDscp = categoryDscp;
	}
	/**
	 * @return the joinSurvey
	 */
	public boolean isJoinSurvey() {
		return joinSurvey;
	}
	/**
	 * @param joinSurvey the joinSurvey to set
	 */
	public void setJoinSurvey(boolean joinSurvey) {
		this.joinSurvey = joinSurvey;
	}

}
