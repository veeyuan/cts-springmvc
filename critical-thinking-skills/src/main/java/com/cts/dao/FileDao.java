package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.AttachmentFile;


public class FileDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public AttachmentFile getFilefromDB(String id) {
	    String sqlStmt = "select * from tbl_attachment where id='"+id+"'" ;
	    List <AttachmentFile> list = getFile(sqlStmt);
	    AttachmentFile file = list.get(0);
	    return file;
	  }
	
	public List<AttachmentFile> getFile( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<AttachmentFile>() {
			public AttachmentFile mapRow(ResultSet resultSet, int row) throws SQLException{
				AttachmentFile attachementFileObj = new AttachmentFile();
				attachementFileObj.setFileName(resultSet.getString("filename"));
				attachementFileObj.setFileByteData(resultSet.getBytes("filedata"));
			    return attachementFileObj;
			}
		});
	}
}
