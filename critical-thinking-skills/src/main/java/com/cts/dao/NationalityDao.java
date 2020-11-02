package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.Nationality;

public class NationalityDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<Nationality> getNationList() {
	    String sqlStmt = "select * from tbl_nationality where del=0" ;
	    List<Nationality> list = getList(sqlStmt);
	    return list;
	  }
	
	public List<Nationality> getList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Nationality>() {
			public Nationality mapRow(ResultSet rs, int row) throws SQLException{
				Nationality group = new Nationality();
				group.setCode(rs.getString("nationality_cd"));	
				group.setName(rs.getString("nationality_dscp"));	
			    return group;
			}
		});
	}
}
