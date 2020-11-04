package com.cts.dao;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;

import com.cts.model.Answer;
import com.cts.model.AttachmentFile;
import com.cts.model.GradedScores;
import com.cts.model.Question;
import com.cts.model.Submission;



public class SubmissionListDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	public List<Submission> getSubmissionList(int startRow, int endRow) {
	    List<Submission> submissionLst = new ArrayList<Submission>() ;
	    ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_FILTER_SUBMISSION(?,?,?,?,?,?,?)}");
			cs.setString(1, null);
	        cs.setString(2, null);
	        cs.setString(3, null);
	        cs.setString(4, null);
	        cs.setDate(5, null);
	        cs.setInt(6, startRow);
	        cs.setInt(7, endRow);
	       
	        resultSet =  cs.executeQuery();
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	Submission submission = new Submission();
		        	submission.setSubmissionId(resultSet.getString("id"));
		        	submission.setNoReqManualGrading(resultSet.getInt("NUM_REQUIRE_MANUAL_GRADE"));
		        	submission.setSubmitDt(resultSet.getDate("SUBMITTED_DT"));
		        	submission.setDisciplineCd(resultSet.getString("DISCIPLINE_CD"));
		        	submission.setCategoryCd(resultSet.getString("CATEGORY_CD"));
		        	submission.setLanguageCd(resultSet.getString("LANGUAGE_CD"));
		        	submission.setDisciplineDscp(resultSet.getString("DISCIPLINE_DSCP"));
		        	submission.setCategoryDscp(resultSet.getString("CATEGORY_DSCP"));
		        	submission.setLanguageDscp(resultSet.getString("LANGUAGE_DSCP"));
		        	submission.setTestTakerName(resultSet.getString("FULLNAME"));
		        	submissionLst.add(submission);
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
	    return submissionLst;
	  }
	
	public List<Submission> getSubmissionList(Submission filterSubmission,int startRow, int endRow) {

	    List<Submission> submissionLst = new ArrayList<Submission>() ;
	    ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_FILTER_SUBMISSION(?,?,?,?,?,?,?)}");
			cs.setString(1, checkIsAll(filterSubmission.getTestTakerName()));
	        cs.setString(2, null);
	        cs.setString(3, checkIsAll(filterSubmission.getCategoryCd()));
	        cs.setString(4, checkIsAll(filterSubmission.getLanguageCd()));
	        if (filterSubmission.getSubmitDt()==null) {
	        	 cs.setDate(5, null);
	        }else {
		        cs.setDate(5, filterSubmission.getSubmitDt());
	        }
	        cs.setInt(6, startRow);
	        cs.setInt(7, endRow);
	        cs.execute();
	        resultSet =  cs.executeQuery();
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	Submission submission = new Submission();
		        	submission.setSubmissionId(resultSet.getString("id"));
		        	submission.setNoReqManualGrading(resultSet.getInt("NUM_REQUIRE_MANUAL_GRADE"));
		        	submission.setSubmitDt(resultSet.getDate("SUBMITTED_DT"));
		        	submission.setDisciplineCd(resultSet.getString("DISCIPLINE_CD"));
		        	submission.setCategoryCd(resultSet.getString("CATEGORY_CD"));
		        	submission.setLanguageCd(resultSet.getString("LANGUAGE_CD"));
		        	submission.setDisciplineDscp(resultSet.getString("DISCIPLINE_DSCP"));
		        	submission.setCategoryDscp(resultSet.getString("CATEGORY_DSCP"));
		        	submission.setLanguageDscp(resultSet.getString("LANGUAGE_DSCP"));
		        	submission.setTestTakerName(resultSet.getString("FULLNAME"));
		        	submissionLst.add(submission);
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
	    return submissionLst;
	  }
	
	
	public Submission getSubmission(String submissionId) throws IOException {
		Submission submission = new Submission();
		submission.setSubmissionId(submissionId);
		List<Question> questionLst = new ArrayList<Question>() ;
		List<Answer> ansLst = new ArrayList<Answer>() ;
		ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_GET_ANSWERS_FOR_GRADING(?)}");
			cs.setString(1, submissionId);
	        
	        resultSet = cs.executeQuery();
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	Question question = new Question();	        	
		        	question.setQuestionDscp(resultSet.getString("QUESTION_DSCP"));
		        	question.setSampleAns(resultSet.getString("SAMPLE_ANSWER"));
		        	if (resultSet.getBlob("question_filedata")!=null) {
		        		AttachmentFile questionFileObj = new AttachmentFile();
		        		questionFileObj.setFileName(resultSet.getString("question_filename"));
		        		questionFileObj.setFormat(resultSet.getString("question_fileformat"));
		        		questionFileObj.setBase64Image(getBase64Image(resultSet.getBlob("question_filedata")));
		        		questionFileObj.setId(resultSet.getString("question_fileid"));
		        		question.setQuestionAttachment(questionFileObj);	
		        	}
		        	if(resultSet.getBlob("sample_answer_filedata")!=null) {
	        			AttachmentFile sampleAnsFileObj = new AttachmentFile();
	        			sampleAnsFileObj.setFileName(resultSet.getString("sample_answer_filename"));
	        			sampleAnsFileObj.setFormat(resultSet.getString("sample_answer_fileformat"));
	        			sampleAnsFileObj.setBase64Image(getBase64Image(resultSet.getBlob("sample_answer_filedata")));
	        			sampleAnsFileObj.setId(resultSet.getString("sample_answer_fileid"));
		        		question.setSampleAnsAttachment(sampleAnsFileObj);		        		
	        		}	
		        	question.setAnalysisScore(Integer.parseInt(resultSet.getString("ANALYSIS_EVALUATION")));
		        	question.setLogicScore(Integer.parseInt(resultSet.getString("LOGIC_REASONING")));
		        	question.setJudgementScore(Integer.parseInt(resultSet.getString("JUDGEMENT")));
		        	question.setProbSolveScore(Integer.parseInt(resultSet.getString("PROBLEM_SOLVING")));
		        	question.setCreativeScore(Integer.parseInt(resultSet.getString("CREATIVE")));
		        	Answer answer = new Answer();
		        	answer.setSubmittedAnsId(resultSet.getString("submitted_ans_id"));
		        	if (resultSet.getBlob("answer_filedata")!=null) {
		        		AttachmentFile answerFileObj = new AttachmentFile();
		        		answerFileObj.setFileName(resultSet.getString("answer_filename"));
		        		answerFileObj.setFormat(resultSet.getString("answer_fileformat"));
		        		answerFileObj.setBase64Image(getBase64Image(resultSet.getBlob("answer_filedata")));
		        		answerFileObj.setId(resultSet.getString("answer_fileid"));
		        		answer.setAttachment(answerFileObj);
		        	}
		        	answer.setStrAnswer(resultSet.getString("answer"));	
		        	questionLst.add(question);
		        	ansLst.add(answer);
		        }
	        }    
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				resultSet.close();
				submission.setQuestionLst(questionLst);
				submission.setAnswerLst(ansLst);

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return submission;
	}
	
	
	public String checkIsAll(String val) {
		if ("All".equalsIgnoreCase(val)) {
			return null;
		}
		return val;
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
	
	public void submitGrades(Submission submission, String userId) throws SQLException {
		insertGrades(submission,userId);
		analyseResults(submission.getSubmissionId());
	}
	
	public void insertGrades(Submission submission, String userId) throws SQLException {
		List<Answer> answerLst = submission.getAnswerLst();
		List<GradedScores> scoresLst = submission.getScoresLst();
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		for (int i=0;i<answerLst.size();i++) {		
			Answer answer = answerLst.get(i);
			GradedScores scores = scoresLst.get(i);
	        CallableStatement cs = connection.prepareCall("{call SP_SUBMIT_GRADES(?,?,?,?,?,?,?)}"); 
	        cs.setString(1,answer.getSubmittedAnsId() );
	        cs.setString(2,userId);
	    	cs.setInt(3,scores.getAnalysisScore());
	    	cs.setInt(4,scores.getLogicScore());
	    	cs.setInt(5,scores.getJudgementScore());
	    	cs.setInt(6,scores.getProbSolveScore());
	    	cs.setInt(7,scores.getCreativeScore());
	    	cs.execute();
	    	cs.close();

		}
	}
	
	public void analyseResults(String submissionId) throws SQLException {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
        CallableStatement cs = connection.prepareCall("{call SP_ANALYSE_RESULTS(?)}"); 
        cs.setString(1,submissionId);
        cs.execute();
    	cs.close();
	}
	
	public boolean hasTakenTest(String userId) {
		String sqlStmt = "select count(id) from tbl_submission where USER_ID=?" ;
		int num = (Integer) jdbcTemplate.queryForObject(
				sqlStmt, new Object[] { userId }, Integer.class);
		if (num>0) {
			return true;
		}
		return false;
	}
	
	public boolean isResultReady(String userId) {
		String sqlStmt = "select READY_TO_RELEASE_RST from tbl_submission where USER_ID=?" ;
		String isRstReady = (String) jdbcTemplate.queryForObject(
				sqlStmt, new Object[] { userId }, String.class);
		if ("Y".equalsIgnoreCase(isRstReady)) {
			return true;
		}
		return false;
	}
	
	public Submission getScoresAnalysis(Submission submission) throws ParseException {
		ResultSet resultSet = null;
		Connection connection;
		List<GradedScores> scoreLst=new ArrayList<GradedScores>();
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_RETRIEVE_RESULTS(?)}");
	        cs.setString(1, submission.getSubmissionId());        
	        resultSet = cs.executeQuery();
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	GradedScores scores = new GradedScores();
		        	scores.setAnalysisScore(Integer.parseInt(resultSet.getString("PERCENTAGE_ANALYSIS_EVALUATION")));
		        	scores.setLogicScore(Integer.parseInt(resultSet.getString("PERCENTAGE_LOGIC_REASONING")));
		        	scores.setJudgementScore(Integer.parseInt(resultSet.getString("PERCENTAGE_JUDGEMENT")));
		        	scores.setProbSolveScore(Integer.parseInt(resultSet.getString("PERCENTAGE_PROBLEM_SOLVING")));
		        	scores.setCreativeScore(Integer.parseInt(resultSet.getString("PERCENTAGE_CREATIVE")));
		        	scoreLst.add(scores);
		        	submission.setScoresLst(scoreLst);
		        	submission.setSubmitDt(resultSet.getDate("SUBMITTED_DT"));
		        	submission.setCategoryCd(resultSet.getString("CATEGORY_CD"));
		        	submission.setDisciplineCd(resultSet.getString("DISCIPLINE_CD"));
		        	submission.setLanguageCd(resultSet.getString("LANGUAGE_CD"));
		        	submission.setTestTakerName(resultSet.getString("FULLNAME"));
		        	if (resultSet.getString("JOIN_SURVEY").equalsIgnoreCase("Y")) {
		        		submission.setJoinSurvey(true);
		        	}else {
		        		submission.setJoinSurvey(false);		        		
		        	}
		        	
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
        
		return submission;
	}
	
	public List<List<Map<Object,Object>>> getScoresAnalysisMap(Submission submission ) throws ParseException{
		List<List<Map<Object,Object>>> list = new ArrayList<List<Map<Object,Object>>>();
		List<Map<Object,Object>> dataPoints = new ArrayList<Map<Object,Object>>();
		Map<Object,Object> map = null;
		map = new HashMap<Object,Object>(); 
		map.put("label", "Analysis & Evaluation"); 
		map.put("y", submission.getScoresLst().get(0).getAnalysisScore());
		dataPoints.add(map);
		map = new HashMap<Object,Object>(); 
		map.put("label", "Logic & Reasoning"); 
		map.put("y", submission.getScoresLst().get(0).getLogicScore());
		dataPoints.add(map);
		map = new HashMap<Object,Object>(); 
		map.put("label", "Judgement"); 
		map.put("y",submission.getScoresLst().get(0).getJudgementScore());
		dataPoints.add(map);
		map = new HashMap<Object,Object>(); 
		map.put("label", "Problem Solving"); 
		map.put("y",submission.getScoresLst().get(0).getProbSolveScore());
		dataPoints.add(map);
		map = new HashMap<Object,Object>(); 
		map.put("label", "Creative Thinking"); 
		map.put("y",submission.getScoresLst().get(0).getCreativeScore());
		dataPoints.add(map);
		list.add(dataPoints);
		return list;		
	}
	
	public List<Submission> getSubmittedSubmissionList(String userId){
		ResultSet resultSet = null;
		Connection connection;
		List<Submission> submittedSubmissionList =new ArrayList<Submission>();
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_RETRIEVE_GRADED_SUBMISSION(?)}");
	        cs.setString(1, userId);	       
	        
	        resultSet = cs.executeQuery();
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	Submission submission = new Submission();		    
		        	submission.setSubmissionId(resultSet.getString("ID"));
		        	submission.setSubmitDt(resultSet.getDate("SUBMITTED_DT"));
		        	if ("Y".equalsIgnoreCase(resultSet.getString("IS_GRADED"))) {
		        		submission.setRstReady(true);
		        	}else {
		        		submission.setRstReady(false);
		        	}
		        	submittedSubmissionList.add(submission);
		        	
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
		return submittedSubmissionList;
	}
}
