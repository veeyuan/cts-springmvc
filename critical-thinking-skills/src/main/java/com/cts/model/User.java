package com.cts.model;

public class User extends Login{
	
	
	private String id;
	private String fullname;
	private String email;
	private String disciplineCd;
	private String categoryCd;
	private String languageCd;
	private boolean readyToTakeTest;
	
	private String ageGroupCd;
	private String employmentStatusCd;
	private String nationalityCd;
	private String highestEduLevelCd;
	private String gender;
	private boolean completeSurvey;
		
	public User(String username, String password, String roleCd) {
		super(username, password, roleCd);
		// TODO Auto-generated constructor stub
	}
	
	public User() {}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	 * @return the readyToTakeTest
	 */
	public boolean isReadyToTakeTest() {
		return readyToTakeTest;
	}

	/**
	 * @param readyToTakeTest the readyToTakeTest to set
	 */
	public void setReadyToTakeTest(boolean readyToTakeTest) {
		this.readyToTakeTest = readyToTakeTest;
	}

	/**
	 * @return the ageGroupCd
	 */
	public String getAgeGroupCd() {
		return ageGroupCd;
	}

	/**
	 * @param ageGroupCd the ageGroupCd to set
	 */
	public void setAgeGroupCd(String ageGroupCd) {
		this.ageGroupCd = ageGroupCd;
	}

	/**
	 * @return the employmentStatusCd
	 */
	public String getEmploymentStatusCd() {
		return employmentStatusCd;
	}

	/**
	 * @param employmentStatusCd the employmentStatusCd to set
	 */
	public void setEmploymentStatusCd(String employmentStatusCd) {
		this.employmentStatusCd = employmentStatusCd;
	}

	/**
	 * @return the nationalityCd
	 */
	public String getNationalityCd() {
		return nationalityCd;
	}

	/**
	 * @param nationalityCd the nationalityCd to set
	 */
	public void setNationalityCd(String nationalityCd) {
		this.nationalityCd = nationalityCd;
	}

	/**
	 * @return the highestEduLevelCd
	 */
	public String getHighestEduLevelCd() {
		return highestEduLevelCd;
	}

	/**
	 * @param highestEduLevelCd the highestEduLevelCd to set
	 */
	public void setHighestEduLevelCd(String highestEduLevelCd) {
		this.highestEduLevelCd = highestEduLevelCd;
	}

	/**
	 * @return the gender
	 */
	public String getGender() {
		return gender;
	}

	/**
	 * @param gender the gender to set
	 */
	public void setGender(String gender) {
		this.gender = gender;
	}

	/**
	 * @return the completeSurvey
	 */
	public boolean isCompleteSurvey() {
		return completeSurvey;
	}

	/**
	 * @param completeSurvey the completeSurvey to set
	 */
	public void setCompleteSurvey(boolean completeSurvey) {
		this.completeSurvey = completeSurvey;
	}
	
	

}
