package com.cts.model;

public class Login {

	
	private String username;
	private String password;
	private String roleCd;
	
	public Login(String username, String password, String roleCd) {
		this.username =  username ;
		this.password = password;
		this.roleCd = roleCd;
		
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRoleCd() {
		return roleCd;
	}
	public void setRoleCd(String roleCd) {
		this.roleCd = roleCd;
	}

}
