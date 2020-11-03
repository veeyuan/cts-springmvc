package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.Department;
import com.cts.model.Faculty;

public class FacultyDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	
	public List<Faculty> getFacultyDeptList(){
		List<Faculty> facultyList = getFacultyList();
		for (int i=0;i<facultyList.size();i++) {
			 String sqlStmt = "select * from tbl_department where del=0 and faculty_cd='"+facultyList.get(i).getCode()+"' order by department_cd" ;
			 List<Department> departmentList= getDeptList(sqlStmt);
			 facultyList.get(i).setDepartmentList(departmentList);
		}
		return facultyList;
	}
	public List<Faculty> getFacultyList() {
	    String sqlStmt = "select * from tbl_faculty where del=0 order by faculty_cd" ;
	    List<Faculty> list = getList(sqlStmt);
	    return list;
	  }
	
	public List<Faculty> getList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Faculty>() {
			public Faculty mapRow(ResultSet rs, int row) throws SQLException{
				Faculty group = new Faculty();
				group.setCode(rs.getString("faculty_cd"));	
				group.setName(rs.getString("faculty_dscp"));	
			    return group;
			}
		});
	}
	
	public List<Department> getDeptList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Department>() {
			public Department mapRow(ResultSet rs, int row) throws SQLException{
				Department group = new Department();
				group.setCode(rs.getString("department_cd"));	
				group.setName(rs.getString("department_dscp"));	
			    return group;
			}
		});
	}
}
