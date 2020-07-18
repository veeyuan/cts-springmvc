package com.cts.dao;


import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.Base64;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;

import com.cts.model.Question;

import oracle.jdbc.OracleTypes;

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
     	 cs.close();
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
		stmt.executeQuery(query);
	}
	
	public Question getQuestionDet(String questionID) throws IOException  {
		Question question = new Question();
		ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_DISPLAY_QUESTION_DET(?,?)}");
	        cs.setString(1, questionID);
	        cs.registerOutParameter(2, OracleTypes.CURSOR); 
	        cs.execute();
	        resultSet = (ResultSet) cs.getObject(2);
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	question.setId(resultSet.getString("id"));
		        	question.setDisciplineCd(resultSet.getString("DISCIPLINE_CD"));
		        	question.setCategoryCd(resultSet.getString("CATEGORY_CD"));
		        	question.setLanguageCd(resultSet.getString("LANGUAGE_CD"));
		        	question.setQuestionDscp(resultSet.getString("QUESTION_DSCP"));
		        	if (resultSet.getBlob("QUESTION_ATTACHMENT")!=null) {
		        		question.setBase64questionImage(getBase64Image(resultSet.getBlob("QUESTION_ATTACHMENT")));		        		
		        	}		        	
		        	if ("Y".equalsIgnoreCase(resultSet.getString("MCQ"))) {
		            	question.setMcq(true);
		        	}else {
		        		question.setMcq(false);
		        	}
		        	if (question.isMcq()) {
		            	question.setOption1(resultSet.getString("option1"));
		            	question.setOption2(resultSet.getString("option2"));
		            	question.setOption3(resultSet.getString("option3"));
		            	question.setOption4(resultSet.getString("option4"));                	
		            	question.setOption5(resultSet.getString("option5"));
		        	}else {
		        		if(resultSet.getBlob("SAMPLE_ANSWER_ATTACHMENT")!=null) {
			        		question.setBase64answerImage(getBase64Image(resultSet.getBlob("SAMPLE_ANSWER_ATTACHMENT")));		        		
		        		}		        		
		        	}
		        	question.setSampleAns(resultSet.getString("SAMPLE_ANSWER"));
		        	question.setAnalysisScore(Integer.parseInt(resultSet.getString("ANALYSIS_EVALUATION")));
		        	question.setLogicScore(Integer.parseInt(resultSet.getString("LOGIC_REASONING")));
		        	question.setJudgementScore(Integer.parseInt(resultSet.getString("JUDGEMENT")));
		        	question.setProbSolveScore(Integer.parseInt(resultSet.getString("PROBLEM_SOLVING")));
		        	question.setCreativeScore(Integer.parseInt(resultSet.getString("CREATIVE")));
		        	
		        }
	        }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				resultSet.close();

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
        
      

        		return question;
	}
	
	public String getBase64Image(Blob blob) throws SQLException, IOException {
		InputStream inputStream = blob.getBinaryStream();
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[4096];
        int bytesRead = -1;
         
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);                  
        }
         
        byte[] imageBytes = outputStream.toByteArray();
        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
         
         
        inputStream.close();
        outputStream.close();
	    return base64Image;
	}
}
