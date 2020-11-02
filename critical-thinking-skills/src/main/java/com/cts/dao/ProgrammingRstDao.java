package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.ProgrammingResults;

public class ProgrammingRstDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<ProgrammingResults> getProgrammingCourseList() {
	    String sqlStmt = "select * from tbl_programming_course where del=0" ;
	    List<ProgrammingResults> list = getList(sqlStmt);
	    return list;
	  }
	
	public List<ProgrammingResults> getList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<ProgrammingResults>() {
			public ProgrammingResults mapRow(ResultSet rs, int row) throws SQLException{
				ProgrammingResults group = new ProgrammingResults();
				group.setCode(rs.getString("course_cd"));	
				group.setName(rs.getString("course_dscp"));	
			    return group;
			}
		});
	}

}
