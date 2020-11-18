package com.cts.dao;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.Question;


public class QuestionListDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	
	
		
	
	public List<Question> filterQuestionList(Question questionType,int startRow, int numberPerPg) throws IOException  {		
		List<Question> questionList = new ArrayList<Question>() ;
		ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_FILTER_QUESTION(?,?,?,?,?,?,?,?)}");
	        cs.setString(1, questionType.getQuestionDscp());
	        cs.setString(2, null);
	        cs.setString(3, null);
	        cs.setString(4, checkIsAll(questionType.getLanguageCd()));
	        if (numberPerPg!=0 && startRow!=0) {
	        	startRow--;
	        }
	        cs.setInt(5, startRow);
	        cs.setInt(6, numberPerPg);
	        cs.setString(7, checkIsAll(questionType.getHotsComponentCd()));
	        cs.setString(8, questionType.getStrIsSelectedToAsk());
	       
	        resultSet =  cs.executeQuery();
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	Question question = new Question();
		        	question.setId(resultSet.getString("id"));
		        	question.setDisciplineCd(resultSet.getString("DISCIPLINE_CD"));
		        	question.setCategoryCd(resultSet.getString("CATEGORY_CD"));
		        	question.setLanguageDscp(resultSet.getString("LANGUAGE_DSCP"));
		        	question.setHotsComponentCd(resultSet.getString("HOTS_COMPONENT"));
		        	question.setHotsDSCP(resultSet.getString("COMPONENT_NAME"));		        	
		        	question.setStrIsSelectedToAsk(resultSet.getString("SELECTED_TO_ASK"));
		        	if ("Y".equalsIgnoreCase(resultSet.getString("SELECTED_TO_ASK"))) {
		        		question.setSelectedToAsk(true);
		        	}else {
		        		question.setSelectedToAsk(false);
		        	}
		        	String dscp = resultSet.getString("question_dscp");
					dscp = dscp.substring(0, Math.min(dscp.length(), 100));
					question.setQuestionDscp(dscp);
					String mcq = resultSet.getString("mcq"); 
					if ("Y".equalsIgnoreCase(mcq)) {
						question.setMcq(true);
					}else {
						question.setMcq(false);
					}
		        	questionList.add(question);
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
        
      

        		return questionList;
	}
	
	public String checkIsAll(String val) {
		if ("All".equalsIgnoreCase(val)) {
			return null;
		}
		return val;
	}
	
}
