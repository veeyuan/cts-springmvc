package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.EducationLevel;

public class EducationLevelDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<EducationLevel> getEduLevelList() {
	    String sqlStmt = "select * from tbl_education_level" ;
	    List<EducationLevel> list = getList(sqlStmt);
	    return list;
	  }
	
	public List<EducationLevel> getList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<EducationLevel>() {
			public EducationLevel mapRow(ResultSet rs, int row) throws SQLException{
				EducationLevel group = new EducationLevel();
				group.setCode(rs.getString("edu_level_cd"));	
				group.setName(rs.getString("edu_level_dscp"));	
			    return group;
			}
		});
	}
}
