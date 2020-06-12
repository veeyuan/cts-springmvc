package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.Discipline;

public class DisciplineDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<Discipline> getDisciplineList() {
	    String sqlStmt = "select * from tbl_discipline" ;
	    List<Discipline> list = getList(sqlStmt);
	    return list;
	  }
	
	public List<Discipline> getList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Discipline>() {
			public Discipline mapRow(ResultSet rs, int row) throws SQLException{
				Discipline discipline = new Discipline();
				discipline.setCode(rs.getString("discipline_cd"));	
				discipline.setName(rs.getString("discipline_name"));	
			    return discipline;
			}
		});
	}
}
