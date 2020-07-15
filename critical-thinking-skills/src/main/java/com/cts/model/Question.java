package com.cts.model;

public class Question {
	
	public Question() {	}
	
	private String id;
	private String disciplineCd;
	private String categoryCd;
	private String questionDscp;
	private boolean mcq;
	private String option1;
	private String option2;
	private String option3;
	private String option4;
	private String option5;
	private String mcqAns;
	private String sampleAns;
	private int del;
	private String languageCd;
	private int analysisScore;
	private int logicScore;
	private int judgementScore;
	private int probSolveScore;
	private int creativeScore;

	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDisciplineCd() {
		return disciplineCd;
	}
	public void setDisciplineCd(String disciplineCd) {
		this.disciplineCd = disciplineCd;
	}
	public String getCategoryCd() {
		return categoryCd;
	}
	public void setCategoryCd(String categoryCd) {
		this.categoryCd = categoryCd;
	}
	public String getQuestionDscp() {
		return questionDscp;
	}
	public void setQuestionDscp(String questionDscp) {
		this.questionDscp = questionDscp;
	}
	public boolean isMcq() {
		return mcq;
	}
	public void setMcq(boolean mcq) {
		this.mcq = mcq;
	}
	public String getOption1() {
		return option1;
	}
	public void setOption1(String option1) {
		this.option1 = option1;
	}
	public String getOption2() {
		return option2;
	}
	public void setOption2(String option2) {
		this.option2 = option2;
	}
	public String getOption3() {
		return option3;
	}
	public void setOption3(String option3) {
		this.option3 = option3;
	}
	public String getOption4() {
		return option4;
	}
	public void setOption4(String option4) {
		this.option4 = option4;
	}
	public String getOption5() {
		return option5;
	}
	public void setOption5(String option5) {
		this.option5 = option5;
	}
	public String getSampleAns() {
		return sampleAns;
	}
	public void setSampleAns(String sampleAns) {
		this.sampleAns = sampleAns;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	public String getLanguageCd() {
		return languageCd;
	}
	public void setLanguageCd(String languageCd) {
		this.languageCd = languageCd;
	}
	/**
	 * @return the analysisScore
	 */
	public int getAnalysisScore() {
		return analysisScore;
	}
	/**
	 * @param analysisScore the analysisScore to set
	 */
	public void setAnalysisScore(int analysisScore) {
		this.analysisScore = analysisScore;
	}
	/**
	 * @return the logicScore
	 */
	public int getLogicScore() {
		return logicScore;
	}
	/**
	 * @param logicScore the logicScore to set
	 */
	public void setLogicScore(int logicScore) {
		this.logicScore = logicScore;
	}
	/**
	 * @return the judgementScore
	 */
	public int getJudgementScore() {
		return judgementScore;
	}
	/**
	 * @param judgementScore the judgementScore to set
	 */
	public void setJudgementScore(int judgementScore) {
		this.judgementScore = judgementScore;
	}
	/**
	 * @return the probSolveScore
	 */
	public int getProbSolveScore() {
		return probSolveScore;
	}
	/**
	 * @param probSolveScore the probSolveScore to set
	 */
	public void setProbSolveScore(int probSolveScore) {
		this.probSolveScore = probSolveScore;
	}
	/**
	 * @return the creativeScore
	 */
	public int getCreativeScore() {
		return creativeScore;
	}
	/**
	 * @param creativeScore the creativeScore to set
	 */
	public void setCreativeScore(int creativeScore) {
		this.creativeScore = creativeScore;
	}
	public String getMcqAns() {
		return mcqAns;
	}
	public void setMcqAns(String mcqAns) {
		this.mcqAns = mcqAns;
	}

}
