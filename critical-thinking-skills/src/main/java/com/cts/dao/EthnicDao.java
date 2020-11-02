package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.Ethnic;

public class EthnicDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<Ethnic> getEthnicList() {
	    String sqlStmt = "select * from tbl_ethnic where del=0 order by ethnic_cd" ;
	    List<Ethnic> list = getList(sqlStmt);
	    return list;
	  }
	
	public List<Ethnic> getList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Ethnic>() {
			public Ethnic mapRow(ResultSet rs, int row) throws SQLException{
				Ethnic group = new Ethnic();
				group.setCode(rs.getString("ethnic_cd"));	
				group.setName(rs.getString("ethnic_dscp"));	
			    return group;
			}
		});
	}
}
