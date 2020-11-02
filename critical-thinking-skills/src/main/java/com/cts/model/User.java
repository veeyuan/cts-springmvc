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
	private String nationalityCd;
	private String gender;
	private boolean completeSurvey;
	private boolean consentGrantedToSurvey;
	
	private String newMatricNum;
	private String oldMatricNum;
	private int yearOfStudy;
	private Faculty faculty;
	private Department department;
	private ResultRange gpa;
	private ResultRange cgpa;
	private String ethnicCd;

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

	/**
	 * @return the consentGrantedToSurvey
	 */
	public boolean isConsentGrantedToSurvey() {
		return consentGrantedToSurvey;
	}

	/**
	 * @param consentGrantedToSurvey the consentGrantedToSurvey to set
	 */
	public void setConsentGrantedToSurvey(boolean consentGrantedToSurvey) {
		this.consentGrantedToSurvey = consentGrantedToSurvey;
	}

	/**
	 * @return the newMatricNum
	 */
	public String getNewMatricNum() {
		return newMatricNum;
	}

	/**
	 * @param newMatricNum the newMatricNum to set
	 */
	public void setNewMatricNum(String newMatricNum) {
		this.newMatricNum = newMatricNum;
	}

	/**
	 * @return the oldMatricNum
	 */
	public String getOldMatricNum() {
		return oldMatricNum;
	}

	/**
	 * @param oldMatricNum the oldMatricNum to set
	 */
	public void setOldMatricNum(String oldMatricNum) {
		this.oldMatricNum = oldMatricNum;
	}

	/**
	 * @return the yearOfStudy
	 */
	public int getYearOfStudy() {
		return yearOfStudy;
	}

	/**
	 * @param yearOfStudy the yearOfStudy to set
	 */
	public void setYearOfStudy(int yearOfStudy) {
		this.yearOfStudy = yearOfStudy;
	}

	/**
	 * @return the faculty
	 */
	public Faculty getFaculty() {
		return faculty;
	}

	/**
	 * @param faculty the faculty to set
	 */
	public void setFaculty(Faculty faculty) {
		this.faculty = faculty;
	}

	/**
	 * @return the department
	 */
	public Department getDepartment() {
		return department;
	}

	/**
	 * @param department the department to set
	 */
	public void setDepartment(Department department) {
		this.department = department;
	}

	/**
	 * @return the gpa
	 */
	public ResultRange getGpa() {
		return gpa;
	}

	/**
	 * @param gpa the gpa to set
	 */
	public void setGpa(ResultRange gpa) {
		this.gpa = gpa;
	}

	/**
	 * @return the cgpa
	 */
	public ResultRange getCgpa() {
		return cgpa;
	}

	/**
	 * @param cgpa the cgpa to set
	 */
	public void setCgpa(ResultRange cgpa) {
		this.cgpa = cgpa;
	}

	/**
	 * @return the ethnicCd
	 */
	public String getEthnicCd() {
		return ethnicCd;
	}

	/**
	 * @param ethnicCd the ethnicCd to set
	 */
	public void setEthnicCd(String ethnicCd) {
		this.ethnicCd = ethnicCd;
	}

	
	
	

}
