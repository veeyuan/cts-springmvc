package com.cts.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


import com.cts.model.Question;
import com.cts.model.SurveyForm;
import com.cts.model.User;


public class SurveyDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<SurveyForm> getSurveyList(String userid,int languageCd){
		List<SurveyForm> formList = new ArrayList<SurveyForm>() ;
	    ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_GET_SURVEY_SECTION_LIST(?,?)}");
			cs.setString(1, userid);
	        cs.setInt(2, languageCd);	 

	        resultSet = cs.executeQuery();
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	SurveyForm form = new SurveyForm();
		        	form.setId(resultSet.getString("id"));
		        	form.setFormName(resultSet.getString("section_name"));
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
        CallableStatement cs = connection.prepareCall("{call SP_SUBMIT_DEMO_INFO(?,?,?,?,?,?,?,?,?,?,?,?,?)}");       
        cs.setString(1,user.getId() );
        cs.setString(2, user.getOldMatricNum());
        cs.setString(3, user.getNewMatricNum());
    	cs.setInt(4, Integer.parseInt(user.getAgeGroupCd()));
    	cs.setInt(5, user.getYearOfStudy());
        cs.setString(6, user.getGender());
    	cs.setInt(7, Integer.parseInt(user.getEthnicCd()));
    	cs.setInt(8,Integer.parseInt(user.getNationalityCd()));
    	if (user.getFaculty()==null) {
    		cs.setString(9, null);
    	}else {
        	cs.setInt(9, Integer.parseInt(user.getFaculty().getCode()));
    	}
    	if (user.getDepartment()==null) {
    		cs.setString(10, null);
    	}else {
        	cs.setInt(10,Integer.parseInt(user.getDepartment().getCode()));
    	}
    	cs.setInt(11, Integer.parseInt(user.getGpa().getCode()));
    	cs.setInt(12,Integer.parseInt(user.getCgpa().getCode()));
    	cs.setString(13, formid);
    	cs.execute();
    	cs.close();
	}
	
	public String getFormName(String formId) {
		String sqlStmt = "select section_name from tbl_survey_section where id=?" ;
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
	
	public void submitProgrammingRst(String userid, SurveyForm form) throws SQLException {
		for (int i=0;i<form.getProgrammingRstList().size();i++) {
			Connection connection = jdbcTemplate.getDataSource().getConnection();
	        CallableStatement cs = connection.prepareCall("{call SP_SUBMIT_PROGRAMMING_RST(?,?,?,?)}");       
	        cs.setString(1,userid);
	        if (i==form.getProgrammingRstList().size()-1) {
	        	cs.setString(2,form.getId());
	        }else {
	        	cs.setString(2,null);
	        }
	        cs.setString(3,form.getProgrammingRstList().get(i).getCode());
	        cs.setString(4,form.getProgrammingRstList().get(i).getResult());
	    	cs.execute();
	    	cs.close();
		}
		
	}
	
}
