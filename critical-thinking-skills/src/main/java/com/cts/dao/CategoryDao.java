package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.Category;

public class CategoryDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<Category> getCategoryList() {
	    String sqlStmt = "select * from tbl_category" ;
	    List<Category> list = getList(sqlStmt);
	    return list;
	  }
	
	public List<Category> getList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Category>() {
			public Category mapRow(ResultSet rs, int row) throws SQLException{
				Category category = new Category();
				category.setCode(rs.getString("category_cd"));	
				category.setName(rs.getString("category_dscp"));	
			    return category;
			}
		});
	}
}