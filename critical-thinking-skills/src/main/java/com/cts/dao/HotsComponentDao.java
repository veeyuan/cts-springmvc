package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.HotsComponent;

public class HotsComponentDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<HotsComponent> getHotsComponentList() {
	    String sqlStmt = "select * from tbl_hots_components where del=0 order by component_cd" ;
	    List<HotsComponent> list = getList(sqlStmt);
	    return list;
	  }
	
	public List<HotsComponent> getList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<HotsComponent>() {
			public HotsComponent mapRow(ResultSet rs, int row) throws SQLException{
				HotsComponent group = new HotsComponent();
				group.setCode(rs.getString("component_cd"));	
				group.setName(rs.getString("component_name"));	
			    return group;
			}
		});
	}
}
