package com.cts.dao;


import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;

import com.cts.model.Question;

public class QuestionDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 

	public void addQuestion(Question question) throws SQLException, IOException {
		 Connection connection = jdbcTemplate.getDataSource().getConnection();
         CallableStatement cs = connection.prepareCall("{call SP_CREATE_QUESTION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        
         cs.setString(1, question.getQuestionDscp());
         cs.setString(2, question.getDisciplineCd());
     	 cs.setString(3, question.getCategoryCd());
     	 cs.setString(4, question.getLanguageCd());
     	 if (question.isMcq()) {
         	 cs.setString(5,"Y");
         	 cs.setString(6, question.getOption1());
        	 cs.setString(7, question.getOption2());
        	 cs.setString(8, question.getOption3());
        	 cs.setString(9, question.getOption4());
        	 cs.setString(10, question.getOption5());
        	 cs.setString(11, question.getMcqAns());
     	 }else {
         	 cs.setString(5,"N");
         	 cs.setString(6, null);
	       	 cs.setString(7, null);
	       	 cs.setString(8, null);
	       	 cs.setString(9, null);
	       	 cs.setString(10,null);
         	 cs.setString(11, question.getSampleAns());
     	 }
     	 
     	 
     	 cs.setInt(12, question.getAnalysisScore());
     	 cs.setInt(13, question.getLogicScore());
     	 cs.setInt(14, question.getJudgementScore());
     	 cs.setInt(15, question.getProbSolveScore());
     	 cs.setInt(16, question.getCreativeScore());
     	 cs.setBlob(17,new ByteArrayInputStream(question.getQuestionAttachment().getBytes()));
     	 cs.setBlob(18,new ByteArrayInputStream(question.getSampleAnsAttachment().getBytes()));     	 
     	 cs.execute();
	}
	
	public void deleteQuestion(String[] delQuestionList) throws SQLException {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		Statement stmt = connection.createStatement();
		String query = "update tbl_question set del=1 where id = ";
		for (int i=0;i<delQuestionList.length;i++) {
			if(i==delQuestionList.length-1) {
				query+="'"+delQuestionList[i].toString()+"'";
			}else {
				query+="'"+delQuestionList[i].toString()+"' or id = ";
			}
			
		}
		System.out.println("Query >>> "+query);
		stmt.executeQuery(query);
	}
}
