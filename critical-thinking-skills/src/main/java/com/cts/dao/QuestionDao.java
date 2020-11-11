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
import java.util.ArrayList;
import java.util.Base64;
import java.util.UUID;

import org.springframework.jdbc.core.JdbcTemplate;

import com.cts.model.AttachmentFile;
import com.cts.model.Question;

public class QuestionDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 

	public void addQuestion(Question question) throws SQLException, IOException {
		 Connection connection = jdbcTemplate.getDataSource().getConnection();
         CallableStatement cs = connection.prepareCall("{call SP_CREATE_QUESTION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
         UUID questionid = UUID.randomUUID();
         cs.setString(1, question.getQuestionDscp());
         cs.setString(2, question.getDisciplineCd());
     	 cs.setString(3, question.getCategoryCd());
     	 cs.setString(4, question.getLanguageCd());
     	 if (question.isMcq()) {
         	 cs.setString(5,"Y");
        	 cs.setString(6, question.getMcqAns());
     	 }else {
         	 cs.setString(5,"N");
         	 cs.setString(6, question.getSampleAns());
     	 }
 
     	 cs.setInt(7, question.getAnalysisScore());
     	 cs.setInt(8, question.getLogicScore());
     	 cs.setInt(9, question.getJudgementScore());
     	 cs.setInt(10, question.getProbSolveScore());
     	 cs.setInt(11, question.getCreativeScore());

     	 if (question.getQuestionAttachment()!=null) {
     		 AttachmentFile questionFile = question.getQuestionAttachment();
         	 cs.setBlob(12,new ByteArrayInputStream(questionFile.getAttachmentFile().getBytes()));
         	 cs.setString(14,questionFile.getFileName());
        	 cs.setString(16,questionFile.getFormat());
     	 }else {
     		 cs.setBlob(12,(Blob)null);
     		 cs.setString(14,null);
     		 cs.setString(16, null);
     	 }
     	 if (question.getSampleAnsAttachment()!=null) {
     		 AttachmentFile answerFile = question.getSampleAnsAttachment();
         	 cs.setBlob(13,new ByteArrayInputStream(answerFile.getAttachmentFile().getBytes()));    
         	 cs.setString(15,answerFile.getFileName());
         	 cs.setString(17,answerFile.getFormat());
     	 }else {
     		 cs.setBlob(13,(Blob)null);
     		 cs.setString(15,null);
        	 cs.setString(17,null);
     	 }
     	 cs.setString(18,question.getHotsComponentCd());
     	 cs.setString(19,question.getStrIsSelectedToAsk());
     	 cs.setInt(20,question.getTimeLimitMin());
     	 cs.setString(21,questionid.toString());
     	 cs.execute();
     	 cs.close();
     	insertOption(question.getOptionArr(),questionid.toString());
     	 
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
		stmt.executeUpdate(query);
	}
	
	public Question getQuestionDet(String questionID) throws IOException  {
		Question question = new Question();
		ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_DISPLAY_QUESTION_DET(?)}");
	        cs.setString(1, questionID);      
	        resultSet =  cs.executeQuery();
	        if (resultSet!=null) {
		        while (resultSet.next()) {
		        	question.setId(resultSet.getString("id"));
		        	question.setDisciplineCd(resultSet.getString("DISCIPLINE_CD"));
		        	question.setCategoryCd(resultSet.getString("CATEGORY_CD"));
		        	question.setLanguageCd(resultSet.getString("LANGUAGE_CD"));
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
		        		question.setOptionArrSize(resultSet.getInt("total_option"));
		        		question.setOptionArr(getQuestionOptions(question.getId(),question.getOptionArrSize()));
		        	}else {
		        		if(resultSet.getBlob("answer_filedata")!=null) {
		        			AttachmentFile answerFileObj = new AttachmentFile();
		        			answerFileObj.setFileName(resultSet.getString("answer_filename"));
		        			answerFileObj.setFormat(resultSet.getString("answer_fileformat"));
		        			answerFileObj.setBase64Image(getBase64Image(resultSet.getBlob("answer_filedata")));
		        			answerFileObj.setId(resultSet.getString("answer_fileid"));
			        		question.setSampleAnsAttachment(answerFileObj);		        		
		        		}		        		
		        	}
		        	question.setSampleAns(resultSet.getString("SAMPLE_ANSWER"));
		        	question.setAnalysisScore(Integer.parseInt(resultSet.getString("ANALYSIS_EVALUATION")));
		        	question.setLogicScore(Integer.parseInt(resultSet.getString("LOGIC_REASONING")));
		        	question.setJudgementScore(Integer.parseInt(resultSet.getString("JUDGEMENT")));
		        	question.setProbSolveScore(Integer.parseInt(resultSet.getString("PROBLEM_SOLVING")));
		        	question.setCreativeScore(Integer.parseInt(resultSet.getString("CREATIVE")));
		        	question.setHotsComponentCd(resultSet.getString("HOTS_COMPONENT"));
		        	question.setStrIsSelectedToAsk(resultSet.getString("SELECTED_TO_ASK"));
		        	question.setTimeLimitMin(Integer.parseInt(resultSet.getString("TIME_LIMIT_MINUTE")));
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
	
	public ArrayList<String> getQuestionOptions (String questionId,int totalOption) {
		ArrayList<String> options = new ArrayList<>();
		for (int i=1;i<=totalOption;i++) {
			String sqlStmt = "SELECT option_dscp from tbl_question_option where option_no ='"+i+"' and question_id = '"+questionId+"'";
			String dscp=(String) jdbcTemplate.queryForObject(
					 sqlStmt, new Object[] {}, String.class);
			options.add(dscp);			
		}
		
		return options;
	}
	
	public void modifyQuestion( Question question) throws SQLException, IOException {
		 Connection connection = jdbcTemplate.getDataSource().getConnection();
         CallableStatement cs = connection.prepareCall("{call SP_MODIFY_QUESTION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        
         cs.setString(1, question.getQuestionDscp());
         cs.setString(2, question.getDisciplineCd());
     	 cs.setString(3, question.getCategoryCd());
     	 cs.setString(4, question.getLanguageCd());
     	 if (question.isMcq()) {
         	 cs.setString(5,"Y");   	 
        	 cs.setString(6, question.getMcqAns());
     	 }else {
         	 cs.setString(5,"N");
         	 cs.setString(6, question.getSampleAns());
     	 }
 
     	 cs.setInt(7, question.getAnalysisScore());
     	 cs.setInt(8, question.getLogicScore());
     	 cs.setInt(9, question.getJudgementScore());
     	 cs.setInt(10, question.getProbSolveScore());
     	 cs.setInt(11, question.getCreativeScore());

     	 if (question.getQuestionAttachment()!=null) { //has either alternative or ori file
        	 if (question.getQuestionAttachment().getId() == null ) {	//has alternative file
        		 AttachmentFile questionFile = question.getQuestionAttachment();
             	 cs.setBlob(12,new ByteArrayInputStream(questionFile.getAttachmentFile().getBytes()));
             	 cs.setString(14,questionFile.getFileName());
            	 cs.setString(16,questionFile.getFormat());
            	 cs.setString(19,null);
            	  

        	 }else {												//has ori file
         		 
            	 cs.setString(19,question.getQuestionAttachment().getId());
            	 cs.setBlob(12,(Blob)null);
         		 cs.setString(14,null);
         		 cs.setString(16, null);
        	 }
     	 }else {
     		 cs.setBlob(12,(Blob)null);
     		 cs.setString(14,null);
     		 cs.setString(16,null);
        	 cs.setString(19,null);
     	 }
     	 
     	 if (question.getSampleAnsAttachment()!=null) {
     		 
         	if (question.getSampleAnsAttachment().getId()==null) {
         		 AttachmentFile answerFile = question.getSampleAnsAttachment();
	         	 cs.setBlob(13,new ByteArrayInputStream(answerFile.getAttachmentFile().getBytes()));    
	         	 cs.setString(15,answerFile.getFileName());
	         	 cs.setString(17,answerFile.getFormat());
	           	 cs.setString(20,null);          	 
	       	 }else {
	       		cs.setString(20,question.getSampleAnsAttachment().getId());
	           	 cs.setBlob(13,(Blob)null);
	    		 cs.setString(15,null);
	    		 cs.setString(17,null);
	       	 }
     	 }else {
     		 cs.setBlob(13,(Blob)null);
     		 cs.setString(15,null);
        	 cs.setString(17,null);
           	 cs.setString(20,null);
     	 }
     	 
     	 cs.setString(18,question.getId());
     	 cs.setString(21,question.getHotsComponentCd());
     	 cs.setString(22,question.getStrIsSelectedToAsk());
     	 cs.setInt(23, question.getTimeLimitMin());
     	 cs.execute();
     	 cs.close();
	}
	
	public void insertOption(ArrayList<String> arr,String questionId) throws SQLException {		
		for (int i=1;i<=arr.size();i++) {
		   	 String sql = "INSERT INTO TBL_QUESTION_OPTION (question_id,option_no,option_dscp) VALUES (?,?,?)";
		     jdbcTemplate.update(sql, questionId,i,arr.get(i-1));
		}
	}
	
	public int deleteOption(String questionId) {
		String deleteSql = "DELETE 	FROM TBL_QUESTION_OPTION WHERE QUESTION_ID = ?";
	     int row = jdbcTemplate.update(deleteSql, questionId);
	     return row;
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
