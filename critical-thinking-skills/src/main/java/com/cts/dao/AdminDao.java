package com.cts.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.Admin;
import com.cts.model.Login;
import com.cts.model.Option;

public class AdminDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	
	public List<Admin> getAdminList(){		
		String sqlStmt = "select * from tbl_user where role_cd='ADMIN' or role_cd='SUPERADMIN' order by user_name";
		List<Admin> list = getAllList(sqlStmt);
	    return list;
	}
	
	public List<Admin> getAllList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Admin>() {
			public Admin mapRow(ResultSet rs, int row) throws SQLException{
				Admin admin = new Admin();
				admin.setId(rs.getString("id"));
				admin.setUsername(rs.getString("user_name"));
				admin.setRoleCd(rs.getString("role_cd"));
				if (rs.getInt("del")==0) {
					admin.setHidden(false);
				}else {
					admin.setHidden(true);
				}
			    return admin;
			}
		});
	}
	
	public List<Option> getRoleOption(){
		String sqlStmt = "select * from tbl_user_role where role_cd LIKE '%ADMIN%'";
		List<Option> list = getRoleList(sqlStmt);
	    return list;
	}
	
	public List<Option> getRoleList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Option>() {
			public Option mapRow(ResultSet rs, int row) throws SQLException{
				Option option = new Option();
				option.setCode(rs.getString("role_cd"));
				option.setName(rs.getString("role_dscp"));
			    return option;
			}
		});
	}
	
	public void setAdminAccessibility(String[] unhideList) throws SQLException {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		Statement stmt = connection.createStatement();	
		String hideAllQuery ="update tbl_user set del=1 where role_cd IN ('ADMIN','SUPERADMIN')";
		stmt.executeUpdate(hideAllQuery);
		String conditionQuery =  "";
		for (int i=0;i<unhideList.length;i++) {
			if(i==unhideList.length-1) {
				conditionQuery+="'"+unhideList[i].toString()+"'";
			}else {
				conditionQuery+="'"+unhideList[i].toString()+"' or id = ";
			}			
		}
		String uhidequery = "update tbl_user set del=0 where id = "+conditionQuery;
		
		stmt.executeUpdate(uhidequery);
	}
	
	public void insertNewAdmin(Login login) {
		String sql="INSERT INTO tbl_user (user_name,login_pswd,role_cd) VALUES (?,?,?)";
		jdbcTemplate.update(sql,login.getUsername(),login.getPassword(),login.getRoleCd());
	}

}
