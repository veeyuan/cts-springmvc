package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.EmploymentStatus;

public class EmploymentStatusDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<EmploymentStatus> getEmploymentStatusList() {
	    String sqlStmt = "select * from tbl_employment_status" ;
	    List<EmploymentStatus> list = getList(sqlStmt);
	    return list;
	  }
	
	public List<EmploymentStatus> getList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<EmploymentStatus>() {
			public EmploymentStatus mapRow(ResultSet rs, int row) throws SQLException{
				EmploymentStatus group = new EmploymentStatus();
				group.setCode(rs.getString("emp_status_cd"));	
				group.setName(rs.getString("emp_status_dscp"));	
			    return group;
			}
		});
	}
}
