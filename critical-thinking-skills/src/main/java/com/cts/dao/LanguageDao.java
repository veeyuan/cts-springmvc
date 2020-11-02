package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.Language;

public class LanguageDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<Language> getLanguageList() {
	    String sqlStmt = "select * from tbl_language where del=0" ;
	    List<Language> list = getList(sqlStmt);
	    return list;
	  }
	
	public List<Language> getList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Language>() {
			public Language mapRow(ResultSet rs, int row) throws SQLException{
				Language language = new Language();
				language.setCode(rs.getString("language_cd"));	
				language.setName(rs.getString("language_dscp"));	
			    return language;
			}
		});
	}
}