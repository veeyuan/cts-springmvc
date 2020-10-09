package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.AgeGroup;

public class AgeGroupDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<AgeGroup> getAgeGroupList() {
	    String sqlStmt = "select * from tbl_age_group order by AGE_GROUP_CD" ;
	    List<AgeGroup> list = getList(sqlStmt);
	    return list;
	  }
	
	public List<AgeGroup> getList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<AgeGroup>() {
			public AgeGroup mapRow(ResultSet rs, int row) throws SQLException{
				AgeGroup group = new AgeGroup();
				group.setCode(rs.getString("age_group_cd"));	
				group.setName(rs.getString("age_range_dscp"));	
			    return group;
			}
		});
	}
}
