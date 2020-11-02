package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import com.cts.model.ResultRange;

public class ResultRangeDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<ResultRange> getRstRangeList() {
	    String sqlStmt = "select * from tbl_gpa_range order by range_cd" ;
	    List<ResultRange> list = getList(sqlStmt);
	    return list;
	  }
	
	public List<ResultRange> getList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<ResultRange>() {
			public ResultRange mapRow(ResultSet rs, int row) throws SQLException{
				ResultRange group = new ResultRange();
				group.setCode(rs.getString("range_cd"));	
				group.setName(rs.getString("range_dscp"));	
			    return group;
			}
		});
	}

}
