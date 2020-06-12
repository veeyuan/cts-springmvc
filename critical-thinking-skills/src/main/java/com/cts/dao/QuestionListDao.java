package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.Question;

public class QuestionListDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<Question> getQuestionList() {
	    String sqlStmt = "select * from tbl_question where del<>1" ;
	    List<Question> questionLst = getQuestion(sqlStmt);
	    return questionLst;
	  }
	
	public List<Question> getQuestion( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Question>() {
			public Question mapRow(ResultSet rs, int row) throws SQLException{
				Question question = new Question();
				question.setId(rs.getString("id"));	
				String dscp = rs.getString("question_dscp");
				dscp = dscp.substring(0, Math.min(dscp.length(), 20));
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
}
