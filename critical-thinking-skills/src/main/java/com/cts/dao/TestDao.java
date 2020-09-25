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
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.Answer;
import com.cts.model.AttachmentFile;
import com.cts.model.Question;
import com.cts.model.Submission;

import oracle.jdbc.OracleTypes;

public class TestDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	
	public List<Question> getQuestions(String disciplineCd, String categoryCd, String languageCd) throws IOException  {
		List<Question> questionLst = new ArrayList<Question>();
		ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_RETRIEVE_TEST_QUESTIONS(?,?,?,?)}");
	        cs.setString(1, categoryCd);
	        cs.setString(2, disciplineCd);
	        cs.setString(3, languageCd);
	        cs.registerOutParameter(4, OracleTypes.CURSOR); 
	        cs.execute();
	        resultSet = (ResultSet) cs.getObject(4);
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	Question question = new Question();
		        	question.setId(resultSet.getString("id"));
		        	question.setQuestionDscp(resultSet.getString("QUESTION_DSCP"));
		        	if (resultSet.getBlob("question_filedata")!=null) {
		        		AttachmentFile questionFileObj = new AttachmentFile();
		        		questionFileObj.setFileName(resultSet.getString("question_filename"));
		        		questionFileObj.setFormat(resultSet.getString("question_fileformat"));
		        		questionFileObj.setBase64Image(getBase64Image(resultSet.getBlob("question_filedata")));
		        		questionFileObj.setId(resultSet.getString("question_fileid"));
		        		question.setQuestionAttachment(questionFileObj);	
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
		        	}
		        
		        	questionLst.add(question);
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
        
      

        		return questionLst;
	}
	
	public void submitAnswer(Submission submission) throws SQLException, IOException {
		String submissionId = createSubmission(submission);
		insertAnswers(submissionId,submission.getAnswerLst());
	}
	
	public String createSubmission(Submission submission) throws SQLException {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
        CallableStatement cs = connection.prepareCall("{call SP_CREATE_SUBMISSION(?,?,?,?)}");       
        String submissionId = getSysGuid();
        cs.setString(1,submissionId );
        cs.setString(2, submission.getUserId());
    	cs.setDate(3, submission.getSubmitDt());
    	cs.setInt(4, submission.getCalculateNoReqManualGrading());
    	cs.execute();
    	cs.close();
    	return submissionId;
	}
	
	public void insertAnswers(String submissionId,List<Answer> answerLst ) throws SQLException, IOException {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		for (int i=0;i<answerLst.size();i++) {		
			Answer answer = answerLst.get(i);
	        CallableStatement cs = connection.prepareCall("{call SP_SUBMIT_ANSWER(?,?,?,?,?,?)}"); 
	        cs.setString(1,submissionId );
	        cs.setString(2,answer.getQuestionId());
	    	cs.setString(3, answer.getStrAnswer());
	    	if (answer.getOriFile()!=null) {
	    		AttachmentFile fileObj = new AttachmentFile();
	    		fileObj.setAttachmentFile(answer.getOriFile());
	    		fileObj.setFileName(answer.getOriFile().getOriginalFilename());
	    		fileObj.setFormat(answer.getOriFile().getContentType());
	    		 cs.setBlob(4,new ByteArrayInputStream(fileObj.getAttachmentFile().getBytes()));    
	         	 cs.setString(5,fileObj.getFileName());
	         	 cs.setString(6,fileObj.getFormat());    		
	    	}else {
	     		 cs.setBlob(4,(Blob)null);
	     		 cs.setString(5,null);
	        	 cs.setString(6,null);
	     	 }
	    	cs.execute();
	    	cs.close();

		}
	}
	
	public String getSysGuid() {
		 String sqlStmt ="SELECT SYS_GUID() FROM DUAL";
		 String id=(String) jdbcTemplate.queryForObject(
				 sqlStmt, new Object[] {}, String.class);
		 return id;		 
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
