package com.cts.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import com.cts.model.Login;
import com.cts.model.User;


public class UserDao {

	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	  
	public List<User> validateUser(Login login) {
		String sqlStmt = "select * from tbl_user where del=0 and user_name='" + login.getUsername() + "' and login_pswd='" + login.getPassword() 
	    + "' and role_cd";
		if (login.getRoleCd().equalsIgnoreCase("ADMIN")){
			sqlStmt+=" IN ('ADMIN','SUPERADMIN')";
		}else {
			sqlStmt+=" = 'TEST-TAKER'";
		}
	    
	    List<User> userLst = getUser(sqlStmt,login);
	    return userLst;
	  }
	
	public List<User> getUser( String sqlStmt,final Login login){
		return jdbcTemplate.query(sqlStmt, new RowMapper<User>() {
			public User mapRow(ResultSet rs, int row) throws SQLException{
				User user = new User(login.getUsername(),login.getPassword(),login.getRoleCd());
			    user.setId(rs.getString("id"));		
			    user.setUsername(rs.getString("user_name"));		
			    user.setRoleCd(rs.getString("role_cd"));
			    return user;
			}
		});
	}
	
	public User getUserDet(String userid) {		
		 String sql = "SELECT * FROM tbl_user_det WHERE USER_ID = ?";
		 User user = new User();
		 try {
			Connection connection = jdbcTemplate.getDataSource().getConnection();
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,userid);		
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				user.setId(userid);
				user.setDisciplineCd(rs.getString("DISCIPLINE_CD"));
				user.setCategoryCd(rs.getString("CATEGORY_CD"));
				user.setLanguageCd(rs.getString("LANGUAGE_CD"));
				if ("Y".equalsIgnoreCase(rs.getString("READY_TO_TEST"))) {
					user.setReadyToTakeTest(true);
				}else {
					user.setReadyToTakeTest(false);
				}
				if ("Y".equalsIgnoreCase(rs.getString("COMPLETE_SURVEY"))) {
					user.setCompleteSurvey(true);
				}else {
					user.setCompleteSurvey(false);
				}
				if ("Y".equalsIgnoreCase(rs.getString("CONSENT_SURVEY"))) {
					user.setConsentGrantedToSurvey(true);
				}else {
					user.setConsentGrantedToSurvey(false);
				}
				
			}
			rs.close();
			ps.close();
					} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		 String sql2 = "SELECT * FROM tbl_user WHERE ID = ?";
		 try {
				Connection connection = jdbcTemplate.getDataSource().getConnection();
				PreparedStatement ps = connection.prepareStatement(sql2);
				ps.setString(1,userid);		
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					user.setUsername(rs.getString("user_name"));
				}
				rs.close();
				ps.close();
						} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 return user;


	}
	
	public void createTestTaker(User user) throws SQLException {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
        CallableStatement cs = connection.prepareCall("{call SP_CREATE_TESTTAKER(?,?,?,?,?)}");
       
        cs.setString(1, user.getUsername());
        cs.setString(2,user.getPassword());
        cs.setString(3, user.getRoleCd());
        cs.setString(4,user.getEmail());
        cs.setString(5, user.getFullname());
        cs.execute();
    	 cs.close();
	}
	
	public void updateTestSpec(User user) throws SQLException {		
    	 String sql = "UPDATE TBL_USER_DET SET DISCIPLINE_CD = ?,CATEGORY_CD = ?,LANGUAGE_CD = ?,READY_TO_TEST = 'Y' WHERE USER_ID = ?";
 		jdbcTemplate.update(sql, user.getDisciplineCd(),user.getCategoryCd(),user.getLanguageCd(),user.getId());
	}
	
	public void grantConsentToSurvey(String userid) {
		String sql = "UPDATE tbl_user_det SET CONSENT_SURVEY='Y' WHERE USER_ID=?";
		jdbcTemplate.update(sql,userid);
	}
	
	public boolean hasStartedTest(String userid) {
		String sqlStmt = "SELECT COUNT(ID) FROM TBL_SUBMISSION WHERE USER_ID ='"+userid+"' and SUBMITTED_DT IS NULL";
		int submissionCount=(Integer) jdbcTemplate.queryForObject(
				 sqlStmt, new Object[] {}, Integer.class);
		if (submissionCount>0) {
			return true;
		}
		return false;
	}
	
	public String getLastTakeTestDate(String userid) {
		String sqlStmt ="SELECT COUNT(SUBMITTED_DT) FROM TBL_SUBMISSION WHERE USER_ID = '"+userid+"' AND SUBMITTED_DT IS NOT NULL";
		String sqlStmt2 ="SELECT MAX(SUBMITTED_DT) FROM TBL_SUBMISSION WHERE USER_ID = '"+userid+"' AND SUBMITTED_DT IS NOT NULL";

		int numOfRecord=(int) jdbcTemplate.queryForObject(
				 sqlStmt, new Object[] {}, Integer.class);

		if (numOfRecord==0) {
			return "noRecords";
		}
		Date lastTakeTestDt=(Date) jdbcTemplate.queryForObject(
				 sqlStmt2, new Object[] {}, Date.class);
		
		return lastTakeTestDt.toString();
	}
	
	public boolean changePassword(String userid,String oldpswd, String newpswd) {
		String sqlStmt = "SELECT COUNT(ID) FROM TBL_USER WHERE ID=? AND login_pswd=?";
		int numOfRecord=(int) jdbcTemplate.queryForObject(
				 sqlStmt, new Object[] {userid,oldpswd}, Integer.class);
		if (numOfRecord==1) {
			try {
			String sql = "UPDATE TBL_USER SET login_pswd=? WHERE ID=?";
			jdbcTemplate.update(sql,newpswd,userid);
			}catch (Exception e) {
				return false;
			}finally {
				return true;
			}
		}
		return false;
	}
}
