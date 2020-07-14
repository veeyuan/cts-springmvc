package com.cts.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

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

	public void addQuestion(Question question) throws SQLException {
		 Connection connection = jdbcTemplate.getDataSource().getConnection();
         CallableStatement cs = connection.prepareCall("{call SP_CREATE_QUESTION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        
         cs.setString(1, question.getQuestionDscp());
         /*cs.setString(2, question.getDisciplineCd());
     	 cs.setString(3, question.getCategoryCd());
     	 cs.setString(4, question.getLanguageCd());
     	 if (question.isMcq()) {
         	 cs.setString(5,"Y");
     	 }else {
         	 cs.setString(5,"N");
     	 }
     	 cs.setString(6, question.getOption1());
     	 cs.setString(7, question.getOption2());
     	 cs.setString(8, question.getOption3());
     	 cs.setString(9, question.getOption4());
     	 cs.setString(10, question.getOption5());
     	 cs.setString(11, question.getSampleAns());
     	 cs.setInt(12, question.getAnalysisScore());
     	 cs.setInt(13, question.getLogicScore());
     	 cs.setInt(14, question.getJudgementScore());
     	 cs.setInt(15, question.getProbSolveScore());
     	 cs.setInt(16, question.getCreativeScore());
     	 */
     	 
    	 cs.setString(2, "general");
    	 cs.setString(3, "College");
    	 cs.setString(4, "ENG");
    	 cs.setString(5,"Y");
    	 cs.setString(6, "aaa");
    	 cs.setString(7, "aaa");
    	 cs.setString(8, "aaa");
    	 cs.setString(9, "aaa");
    	 cs.setString(10, "aaa");
    	 cs.setString(11, "aaa");
    	 cs.setInt(12, 3);
    	 cs.setInt(13, 3);
    	 cs.setInt(14, 0);
    	 cs.setInt(15, 2);
    	 cs.setInt(16, 1);
     	 cs.execute();



		
	}
}
