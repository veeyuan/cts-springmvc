package com.cts.model;

public class User extends Login{
	

	
	public User(String username, String password, String roleCd) {
		super(username, password, roleCd);
		// TODO Auto-generated constructor stub
	}
	private String id;
	private String fullname;
	private String email;
	private String disciplineCd;
	private String categoryCd;
	
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
	
	

}
