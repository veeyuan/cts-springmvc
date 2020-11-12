package com.cts.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;
import com.cts.model.SubmissionByFaculty;


public class ChartDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	
	public List<List<Map<Object,Object>>> getSubmissionMapList(){
		List<List<Map<Object,Object>>> list = new ArrayList<List<Map<Object,Object>>>();
		List<Map<Object,Object>> dataPoints = new ArrayList<Map<Object,Object>>();
		Map<Object,Object> map = null;
		map = new HashMap<Object,Object>(); 
		map.put("label", "Open Submission"); 
		map.put("y", getOpenSubmission()/getTotalSubmissionCount()*100);
		dataPoints.add(map);
		map = new HashMap<Object,Object>(); 
		map.put("label", "Close Submission"); 
		map.put("y", getCloseSubmission()/getTotalSubmissionCount()*100);
		dataPoints.add(map);
		map = new HashMap<Object,Object>(); 
		map.put("label", "Graded Submission"); 
		map.put("y",getGradedSubmission() /getTotalSubmissionCount()*100);
		dataPoints.add(map);	
		list.add(dataPoints);
		return list;		
	}
	
	public List<List<Map<Object,Object>>> getFacultySubmissionMapList(){
	    String sqlStmt = "SELECT count(*) as amount,faculty.FACULTY_DSCP FROM tbl_submission submission INNER JOIN tbl_user_det userdet ON userdet.USER_ID = submission.USER_ID LEFT JOIN tbl_faculty faculty ON userdet.FACULTY_CD = faculty.FACULTY_CD WHERE submission.SUBMITTED_DT IS NOT NULL AND submission.JOIN_SURVEY='Y' GROUP BY faculty.FACULTY_CD" ;
		List<List<Map<Object,Object>>> list = new ArrayList<List<Map<Object,Object>>>();
		List<Map<Object,Object>> dataPoints = new ArrayList<Map<Object,Object>>();
		Map<Object,Object> map = null;
		ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			java.sql.Statement stmt = connection.createStatement();
			resultSet = stmt.executeQuery(sqlStmt);
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	if (resultSet.getInt("amount")>0) {
		        		map = new HashMap<Object,Object>(); 
		        		if (resultSet.getString("FACULTY_DSCP")==null) {
		        			map.put("label","Others" ); 
		        		}else {
		        			map.put("label",resultSet.getString("FACULTY_DSCP") ); 
		        		}	    		
			    		map.put("y",resultSet.getInt("amount")/(getCloseSubmission()+getGradedSubmission())*100 );
			    		dataPoints.add(map);
		        	}	        	
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
		list.add(dataPoints);
		return list;		
	}
	
	public List<SubmissionByFaculty> getFacultySubmissionSummary(){
	    String sqlStmt = "SELECT count(*) as amount,faculty.FACULTY_DSCP FROM tbl_submission submission INNER JOIN tbl_user_det userdet ON userdet.USER_ID = submission.USER_ID LEFT JOIN tbl_faculty faculty ON userdet.FACULTY_CD = faculty.FACULTY_CD WHERE submission.SUBMITTED_DT IS NOT NULL AND submission.JOIN_SURVEY='Y' GROUP BY faculty.FACULTY_CD order by faculty.FACULTY_DSCP ASC" ;
	    List<SubmissionByFaculty> list=new ArrayList<>();
		ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			java.sql.Statement stmt = connection.createStatement();
			resultSet = stmt.executeQuery(sqlStmt);
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	if (resultSet.getInt("amount")>0) {
		        		SubmissionByFaculty fac = new SubmissionByFaculty(resultSet.getString("FACULTY_DSCP"),resultSet.getInt("amount"));
		        		list.add(fac);
		        	} 
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
		     
		return list;
	}
	
	
	public double getTotalSubmissionCount() {
		String sqlStmt = "SELECT COUNT(*) FROM tbl_submission WHERE JOIN_SURVEY='Y'";
		int submissionCount=(Integer) jdbcTemplate.queryForObject(
				 sqlStmt, new Object[] {}, Integer.class);		
		return submissionCount;
	}
	
	public double getGradedSubmission() {
		String sqlStmt = "SELECT COUNT(ID) FROM tbl_submission WHERE READY_TO_RELEASE_RST='Y' AND JOIN_SURVEY='Y'";
		int submissionCount=(Integer) jdbcTemplate.queryForObject(
				 sqlStmt, new Object[] {}, Integer.class);		
		return submissionCount;
	}
	
	public double getOpenSubmission() {
		String sqlStmt = "SELECT COUNT(ID) FROM tbl_submission WHERE submitted_dt IS NULL AND JOIN_SURVEY='Y'";
		int submissionCount=(Integer) jdbcTemplate.queryForObject(
				 sqlStmt, new Object[] {}, Integer.class);		
		return submissionCount;
	}
	
	public double getCloseSubmission() {
		String sqlStmt = "SELECT COUNT(ID) FROM tbl_submission WHERE submitted_dt IS NOT NULL AND READY_TO_RELEASE_RST='N' AND JOIN_SURVEY='Y'";
		int submissionCount=(Integer) jdbcTemplate.queryForObject(
				 sqlStmt, new Object[] {}, Integer.class);	
		return submissionCount;
	}




}
