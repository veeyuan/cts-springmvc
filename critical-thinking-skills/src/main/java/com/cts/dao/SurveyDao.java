package com.cts.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.Answer;
import com.cts.model.Category;
import com.cts.model.Question;
import com.cts.model.Submission;
import com.cts.model.SurveyForm;
import com.cts.model.User;

import oracle.jdbc.OracleTypes;

public class SurveyDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<SurveyForm> getSurveyList(String userid,String languageCd){
		List<SurveyForm> formList = new ArrayList() ;
	    ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_GET_SURVEYFORM_LIST(?,?,?)}");
			cs.setString(1, userid);
	        cs.setString(2, languageCd);	       
	        cs.registerOutParameter(3, OracleTypes.CURSOR); 
	        cs.execute();
	        resultSet = (ResultSet) cs.getObject(3);
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	SurveyForm form = new SurveyForm();
		        	form.setId(resultSet.getString("id"));
		        	form.setFormName(resultSet.getString("form_name"));
		        	if ("Y".equalsIgnoreCase(resultSet.getString("is_complete"))){
		        		form.setCompleted(true);
		        	}else {
		        		form.setCompleted(false);
		        	}
		        	formList.add(form);
		        }
	        }    
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				resultSet.close();

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return formList;
	}
	
	public List<Question> getSurveyQuestion(String formId) {
	    String sqlStmt = "select * from tbl_survey_question where form_id='"+formId+"'" ;
	    List<Question> list = getList(sqlStmt);
	    return list;
	  }
	
	public List<Question> getList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Question>() {
			public Question mapRow(ResultSet rs, int row) throws SQLException{
				Question question = new Question();
				question.setId(rs.getString("id"));
				question.setQuestionDscp(rs.getString("question_dscp"));				
			    return question;
			}
		});
	}
	
	public void submitDemoInfo(User user,String formid) throws SQLException {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
        CallableStatement cs = connection.prepareCall("{call SP_SUBMIT_DEMO_INFO(?,?,?,?,?,?,?)}");       
        cs.setString(1,user.getId() );
        cs.setString(2, user.getGender());
    	cs.setString(3, user.getAgeGroupCd());
    	cs.setString(4, user.getEmploymentStatusCd());
    	cs.setString(5, user.getHighestEduLevelCd());
    	cs.setString(6,user.getNationalityCd());
    	cs.setString(7, formid);
    	cs.execute();
    	cs.close();
	}
	
	public String getFormName(String formId) {
		String sqlStmt = "select FORM_NAME from tbl_survey_form where id=?" ;
		String name = (String) jdbcTemplate.queryForObject(
				sqlStmt, new Object[] { formId }, String.class);
		return name;
	}
	
	public String getRatingScaleImgDir(String formId) {
		String sqlStmt = "select rating_scale_img_dir from tbl_survey_form where id=?" ;
		String dir = (String) jdbcTemplate.queryForObject(
				sqlStmt, new Object[] { formId }, String.class);
		return dir;
	}
	
	public void submitSurvey(SurveyForm survey,String userid) throws SQLException {
		String submissionid = createSubmission(survey.getId(),userid);
		submitSurveyAnswer(survey,submissionid,userid);
	}
	
	public String createSubmission(String formid, String userid) throws SQLException {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
        CallableStatement cs = connection.prepareCall("{call SP_CREATE_SURVEY_SUBMISSION(?,?,?)}");       
        String submissionId = getSysGuid();
        cs.setString(1,submissionId );
        cs.setString(2, userid );
        cs.setString(3, formid);
        cs.execute();
    	cs.close();
    	return submissionId;
	}
	
	public String getSysGuid() {
		 String sqlStmt ="SELECT SYS_GUID() FROM DUAL";
		 String id=(String) jdbcTemplate.queryForObject(
				 sqlStmt, new Object[] {}, String.class);
		 return id;		 
	}
	
	public void submitSurveyAnswer(SurveyForm survey,String submissionId,String userId) throws SQLException {
		List<Question> questionLst = survey.getQuetionLst();
		List<Answer> answerLst = survey.getAnswerLst();
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		for (int i=0;i<questionLst.size();i++) {
			 CallableStatement cs = connection.prepareCall("{call SP_SUBMIT_SURVEY_ANSWERS(?,?,?,?)}");       		    
		        cs.setString(1,submissionId );
		        cs.setString(2, questionLst.get(i).getId());
		        cs.setString(3, answerLst.get(i).getStrAnswer());
		        cs.setString(4, userId);
		        cs.execute();
		    	cs.close();
		}
       
	}
	
}
