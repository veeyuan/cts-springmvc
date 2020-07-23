package com.cts.model;


import org.springframework.web.multipart.MultipartFile;

public class AttachmentFile { 
	private MultipartFile attachmentFile;
	private String base64Image;
	private String format;
	private String fileName;
	private byte[] fileByteData;
	private String id;

	public AttachmentFile() {}
	
	/**
	 * @return the format
	 */
	public String getFormat() {
		return format;
	}
	/**
	 * @param format the format to set
	 */
	public void setFormat(String format) {
		this.format = format;
	}
	/**
	 * @return the fileName
	 */
	public String getFileName() {
		return fileName;
	}
	/**
	 * @param fileName the fileName to set
	 */
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	/**
	 * @return the attachmentFile
	 */
	public MultipartFile getAttachmentFile() {
		return attachmentFile;
	}
	/**
	 * @param attachmentFile the attachmentFile to set
	 */
	public void setAttachmentFile(MultipartFile attachmentFile) {
		this.attachmentFile = attachmentFile;
	}
	/**
	 * @return the base64Image
	 */
	public String getBase64Image() {
		return base64Image;
	}
	/**
	 * @param base64Image the base64Image to set
	 */
	public void setBase64Image(String base64Image) {
		this.base64Image = base64Image;
	}

	/**
	 * @return the fileByteData
	 */
	public byte[] getFileByteData() {
		return fileByteData;
	}

	/**
	 * @param fileByteData the fileByteData to set
	 */
	public void setFileByteData(byte[] fileByteData) {
		this.fileByteData = fileByteData;
	}

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	


}
