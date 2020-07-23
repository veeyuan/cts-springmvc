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

import oracle.jdbc.OracleTypes;

public class QuestionListDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<Question> getQuestionList() {
	    String sqlStmt = "select * from tbl_question where del<>1 ORDER BY question_dscp ASC";
	   // String sqlStmt = "select * from tbl_question where del<>1 AND rownum between 1 and "+numPerPg+" ORDER BY question_dscp ASC";

	    List<Question> questionLst = getQuestion(sqlStmt);
	    return questionLst;
	  }
	
	public List<Question> getQuestion( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Question>() {
			public Question mapRow(ResultSet rs, int row) throws SQLException{
				Question question = new Question();
				question.setId(rs.getString("id"));	
				String dscp = rs.getString("question_dscp");
				dscp = dscp.substring(0, Math.min(dscp.length(), 100));
				question.setQuestionDscp(dscp);
				question.setDisciplineCd(rs.getString("discipline_cd"));
				question.setCategoryCd(rs.getString("category_cd"));
				question.setLanguageCd(rs.getString("language_cd"));
				String mcq = rs.getString("mcq"); 
				if ("Y".equalsIgnoreCase(mcq)) {
					question.setMcq(true);
				}else {
					question.setMcq(false);
				}
			    return question;
			}
		});
	}
		
	
	public List<Question> filterQuestionList(Question questionType) throws IOException  {		
		List<Question> questionList = new ArrayList() ;
		ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_FILTER_QUESTION(?,?,?,?,?)}");
	        cs.setString(1, questionType.getQuestionDscp());
	        cs.setString(2, checkIsAll(questionType.getDisciplineCd()));
	        cs.setString(3, checkIsAll(questionType.getCategoryCd()));
	        cs.setString(4, checkIsAll(questionType.getLanguageCd()));
	       // cs.setInt(5, startRow);
	       // cs.setInt(6, endRow);
	        cs.registerOutParameter(5, OracleTypes.CURSOR); 
	        cs.execute();
	        resultSet = (ResultSet) cs.getObject(5);
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	Question question = new Question();
		        	question.setId(resultSet.getString("id"));
		        	question.setDisciplineCd(resultSet.getString("DISCIPLINE_CD"));
		        	question.setCategoryCd(resultSet.getString("CATEGORY_CD"));
		        	question.setLanguageCd(resultSet.getString("LANGUAGE_CD"));
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
