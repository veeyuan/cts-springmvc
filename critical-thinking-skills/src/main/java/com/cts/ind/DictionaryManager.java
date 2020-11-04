package com.cts.ind;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.JdbcTemplate;




public class DictionaryManager {
	JdbcTemplate jdbcTemplate;    
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	
	

    public String getTerm(String wordCd,int languageCd) throws SQLException {
        String rstString="";

    	try{  
    		Class.forName("com.mysql.jdbc.Driver");  
    		Connection connection=DriverManager.getConnection( "jdbc:mysql://localhost:3306/cts?useTimezone=true&serverTimezone=UTC&useSSL=false","root","sysadmin");  
    		//Connection connection = jdbcTemplate.getDataSource().getConnection();
    		String query="select dscp from tbl_dictionary where word_cd=? and language_cd=? and del=0";
    		PreparedStatement ps = connection.prepareStatement(query);
    		ps.setString(1, wordCd);
    		ps.setInt(2,languageCd); //only english
    		ResultSet rs=ps.executeQuery();  
    		while(rs.next())  {
        		rstString = rs.getString("dscp");
    		}
    		connection.close();  
    		}catch(Exception e){ System.out.println(e);}  
    		
		
        return rstString;

    }
}
