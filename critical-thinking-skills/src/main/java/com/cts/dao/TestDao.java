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

import com.cts.model.Answer;
import com.cts.model.AttachmentFile;
import com.cts.model.HotsComponent;
import com.cts.model.Question;
import com.cts.model.Section;
import com.cts.model.User;


public class TestDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	
	public List<Question> getQuestions(User user,String hotsCd) throws IOException  {
		List<Question> questionLst = new ArrayList<Question>();
		ResultSet resultSet = null;
		Connection connection;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_RETRIEVE_TEST_QUESTIONS(?,?,?,?,?)}");
	        cs.setString(1, user.getCategoryCd());
	        cs.setString(2, user.getDisciplineCd());
	        cs.setString(3, user.getLanguageCd());
	        cs.setString(4, hotsCd);
	        cs.setString(5, user.getId());
	
	        resultSet =  cs.executeQuery();
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
		        		question.setOptionArrSize(resultSet.getInt("total_option"));
		        		question.setOptionArr(getQuestionOptions(question.getId(),question.getOptionArrSize()));		        	
		        		}
		        	
		        	if ("Y".equalsIgnoreCase(resultSet.getString("IS_SUBMITTED"))) {
		            	question.setSubmitted(true);
		        	}else {
		        		question.setSubmitted(false);
		        	}
		        	question.setHotsDSCP(resultSet.getString("COMPONENT_NAME"));
		        	question.setTimeLimitMin(Integer.parseInt(resultSet.getString("TIME_LIMIT_MINUTE")));
		        	question.setHotsComponentCd(resultSet.getString("HOTS_COMPONENT"));
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
	
	
	public void insertAnswer(String submissionId,Answer answer) throws SQLException, IOException {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement cs = connection.prepareCall("{call SP_SUBMIT_ANSWER(?,?,?,?,?,?)}"); 
        cs.setString(1,submissionId );
        cs.setString(2,answer.getQuestionId());
    	cs.setString(3, answer.getStrAnswer());
    	if (answer.getOriFile()!=null && answer.getOriFile().getOriginalFilename()!="") {
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
	
	
	public List<Section> getSections(User user,List<HotsComponent> listHotsComponents) throws IOException{
		List<Section> sectionList = new ArrayList<Section>();
		for (int i=0;i<listHotsComponents.size();i++) {
			Section section = new Section(listHotsComponents.get(i));
			List<Question> listQuestion = getQuestions(user,listHotsComponents.get(i).getCode());

			section.setCompleted(true);
			for (int j=0;j<listQuestion.size();j++) {
				
				if (!listQuestion.get(j).isSubmitted()) {
					section.setCompleted(false);
					break;
				}else {
				}
			}
			section.setQuestionList(listQuestion);
			if (section.getQuestionList().size()>0) {
				sectionList.add(section);
			}
			
			
			
		}
		
		return sectionList;
		
	}
	public String getSubmissionId(String userid) {
		String sqlStmt = "SELECT ID FROM tbl_submission WHERE USER_ID ='"+userid+"' and SUBMITTED_DT IS NULL";
		String submissionIid =(String) jdbcTemplate.queryForObject(
				 sqlStmt, new Object[] {}, String.class);
		
		return submissionIid;
	}
	public void closeSubmission(String  submissionId) throws SQLException {		
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement cs = connection.prepareCall("{call SP_CLOSE_SUBMISSION(?)}"); 
        cs.setString(1,submissionId );
    	cs.execute();
    	cs.close();
	}
	

	public void startTest(User user) {
		String sql = "INSERT INTO  tbl_submission (USER_ID,DISCIPLINE_CD,CATEGORY_CD,LANGUAGE_CD) VALUES (?,?,?,?)";
		if (!user.isJoinSurvey()) {
			sql = "INSERT INTO  tbl_submission (USER_ID,DISCIPLINE_CD,CATEGORY_CD,LANGUAGE_CD,join_survey) VALUES (?,?,?,?,'N')";
		}		
		jdbcTemplate.update(sql,user.getId(),user.getDisciplineCd(),user.getCategoryCd(),user.getLanguageCd());
	}
	
	
}
