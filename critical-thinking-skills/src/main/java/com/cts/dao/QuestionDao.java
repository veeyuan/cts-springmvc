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
import java.util.Base64;

import org.springframework.jdbc.core.JdbcTemplate;

import com.cts.model.AttachmentFile;
import com.cts.model.Question;
import oracle.jdbc.OracleTypes;

public class QuestionDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 

	public void addQuestion(Question question) throws SQLException, IOException {
		 Connection connection = jdbcTemplate.getDataSource().getConnection();
         CallableStatement cs = connection.prepareCall("{call SP_CREATE_QUESTION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        
         cs.setString(1, question.getQuestionDscp());
         cs.setString(2, question.getDisciplineCd());
     	 cs.setString(3, question.getCategoryCd());
     	 cs.setString(4, question.getLanguageCd());
     	 if (question.isMcq()) {
         	 cs.setString(5,"Y");
         	 cs.setString(6, question.getOption1());
        	 cs.setString(7, question.getOption2());
        	 cs.setString(8, question.getOption3());
        	 cs.setString(9, question.getOption4());
        	 cs.setString(10, question.getOption5());
        	 cs.setString(11, question.getMcqAns());
     	 }else {
         	 cs.setString(5,"N");
         	 cs.setString(6, null);
	       	 cs.setString(7, null);
	       	 cs.setString(8, null);
	       	 cs.setString(9, null);
	       	 cs.setString(10,null);
         	 cs.setString(11, question.getSampleAns());
     	 }
 
     	 cs.setInt(12, question.getAnalysisScore());
     	 cs.setInt(13, question.getLogicScore());
     	 cs.setInt(14, question.getJudgementScore());
     	 cs.setInt(15, question.getProbSolveScore());
     	 cs.setInt(16, question.getCreativeScore());

     	 if (question.getQuestionAttachment()!=null) {
     		 AttachmentFile questionFile = question.getQuestionAttachment();
         	 cs.setBlob(17,new ByteArrayInputStream(questionFile.getAttachmentFile().getBytes()));
         	 cs.setString(19,questionFile.getFileName());
        	 cs.setString(21,questionFile.getFormat());
     	 }else {
     		 cs.setBlob(17,(Blob)null);
     		 cs.setString(19,null);
     		 cs.setString(21, null);
     	 }
     	 if (question.getSampleAnsAttachment()!=null) {
     		 AttachmentFile answerFile = question.getSampleAnsAttachment();
         	 cs.setBlob(18,new ByteArrayInputStream(answerFile.getAttachmentFile().getBytes()));    
         	 cs.setString(20,answerFile.getFileName());
         	 cs.setString(22,answerFile.getFormat());
     	 }else {
     		 cs.setBlob(18,(Blob)null);
     		 cs.setString(20,null);
        	 cs.setString(22,null);
     	 }
     	 cs.setString(23,question.getHotsComponentCd());
     	 cs.setString(24,question.getStrIsSelectedToAsk());
     	 cs.execute();
     	 cs.close();
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
		stmt.executeQuery(query);
	}
	
	public Question getQuestionDet(String questionID) throws IOException  {
		Question question = new Question();
		ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_DISPLAY_QUESTION_DET(?,?)}");
	        cs.setString(1, questionID);
	        cs.registerOutParameter(2, OracleTypes.CURSOR); 
	        cs.execute();
	        resultSet = (ResultSet) cs.getObject(2);
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
		            	question.setOption1(resultSet.getString("option1"));
		            	question.setOption2(resultSet.getString("option2"));
		            	question.setOption3(resultSet.getString("option3"));
		            	question.setOption4(resultSet.getString("option4"));                	
		            	question.setOption5(resultSet.getString("option5"));
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
	
	public void modifyQuestion( Question question) throws SQLException, IOException {
		 Connection connection = jdbcTemplate.getDataSource().getConnection();
         CallableStatement cs = connection.prepareCall("{call SP_MODIFY_QUESTION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        
         cs.setString(1, question.getQuestionDscp());
         cs.setString(2, question.getDisciplineCd());
     	 cs.setString(3, question.getCategoryCd());
     	 cs.setString(4, question.getLanguageCd());
     	 if (question.isMcq()) {
         	 cs.setString(5,"Y");
         	 cs.setString(6, question.getOption1());
        	 cs.setString(7, question.getOption2());
        	 cs.setString(8, question.getOption3());
        	 cs.setString(9, question.getOption4());
        	 cs.setString(10, question.getOption5());
        	 cs.setString(11, question.getMcqAns());
     	 }else {
         	 cs.setString(5,"N");
         	 cs.setString(6, null);
	       	 cs.setString(7, null);
	       	 cs.setString(8, null);
	       	 cs.setString(9, null);
	       	 cs.setString(10,null);
         	 cs.setString(11, question.getSampleAns());
     	 }
 
     	 cs.setInt(12, question.getAnalysisScore());
     	 cs.setInt(13, question.getLogicScore());
     	 cs.setInt(14, question.getJudgementScore());
     	 cs.setInt(15, question.getProbSolveScore());
     	 cs.setInt(16, question.getCreativeScore());

     	 if (question.getQuestionAttachment()!=null) { //has either alternative or ori file
        	 if (question.getQuestionAttachment().getId() == null ) {	//has alternative file
        		 AttachmentFile questionFile = question.getQuestionAttachment();
             	 cs.setBlob(17,new ByteArrayInputStream(questionFile.getAttachmentFile().getBytes()));
             	 cs.setString(19,questionFile.getFileName());
            	 cs.setString(21,questionFile.getFormat());
            	 cs.setString(24,null);
            	  

        	 }else {												//has ori file
         		 
            	 cs.setString(24,question.getQuestionAttachment().getId());
            	 cs.setBlob(17,(Blob)null);
         		 cs.setString(19,null);
         		 cs.setString(21, null);
        	 }
     	 }else {
     		 cs.setBlob(17,(Blob)null);
     		 cs.setString(19,null);
     		 cs.setString(21,null);
        	 cs.setString(24,null);
     	 }
     	 
     	 if (question.getSampleAnsAttachment()!=null) {
     		 
         	if (question.getSampleAnsAttachment().getId()==null) {
         		 AttachmentFile answerFile = question.getSampleAnsAttachment();
	         	 cs.setBlob(18,new ByteArrayInputStream(answerFile.getAttachmentFile().getBytes()));    
	         	 cs.setString(20,answerFile.getFileName());
	         	 cs.setString(22,answerFile.getFormat());
	           	 cs.setString(25,null);          	 
	       	 }else {
	       		cs.setString(25,question.getSampleAnsAttachment().getId());
	           	 cs.setBlob(18,(Blob)null);
	    		 cs.setString(20,null);
	    		 cs.setString(22,null);
	       	 }
     	 }else {
     		 cs.setBlob(18,(Blob)null);
     		 cs.setString(20,null);
        	 cs.setString(22,null);
           	 cs.setString(25,null);
     	 }
     	 
     	 cs.setString(23,question.getId());
     	 cs.setString(26,question.getHotsComponentCd());
     	 cs.setString(27,question.getStrIsSelectedToAsk());
     	 cs.execute();
     	 cs.close();
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
