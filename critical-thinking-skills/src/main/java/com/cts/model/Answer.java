package com.cts.model;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class Answer {
	public Answer() {}
	private String strAnswer;
	private String questionId;
	private AttachmentFile attachment;
	private CommonsMultipartFile oriFile;
	/**
	 * @return the strAnswer
	 */
	public String getStrAnswer() {
		return strAnswer;
	}
	/**
	 * @param strAnswer the strAnswer to set
	 */
	public void setStrAnswer(String strAnswer) {
		this.strAnswer = strAnswer;
	}
	/**
	 * @return the questionId
	 */
	public String getQuestionId() {
		return questionId;
	}
	/**
	 * @param questionId the questionId to set
	 */
	public void setQuestionId(String questionId) {
		this.questionId = questionId;
	}
	/**
	 * @return the attachment
	 */
	public AttachmentFile getAttachment() {
		return attachment;
	}
	/**
	 * @param attachment the attachment to set
	 */
	public void setAttachment(AttachmentFile attachment) {
		this.attachment = attachment;
	}
	/**
	 * @return the oriFile
	 */
	public CommonsMultipartFile getOriFile() {
		return oriFile;
	}
	/**
	 * @param oriFile the oriFile to set
	 */
	public void setOriFile(CommonsMultipartFile oriFile) {
		this.oriFile = oriFile;
	}


}
