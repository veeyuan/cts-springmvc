package com.cts.dao;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.jdbc.core.JdbcTemplate;

public class ReportDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	
	public String getReportName() {
		String pattern = "yyyyMMdd";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		String date = simpleDateFormat.format(new Date());
		return "cts-survey-data-"+date+".xlsx";
	}
	
	public byte[] generateFileByteData() {
		ResultSet resultSet = null;
		Connection connection;
		byte[] bytes = null;
		try {
			connection = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = connection.prepareCall("{call SP_GENERATE_REPORT()}");	       
	        resultSet =  cs.executeQuery();
	        XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet("Data");
 
            writeHeaderLine(sheet);
 
            writeDataLines(resultSet, workbook, sheet);
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            try {
				workbook.write(bos);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            workbook.close();
            bos.close();
            bytes = bos.toByteArray();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				resultSet.close();

			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return bytes;
	}
	
	private void writeHeaderLine(XSSFSheet sheet) {
		 
        XSSFRow headerRow = sheet.createRow(0);
 
        Cell headerCell = headerRow.createCell(0);
        headerCell.setCellValue("Old Matric Number");
 
        headerCell = headerRow.createCell(1);
        headerCell.setCellValue("New Matric Number");
 
        headerCell = headerRow.createCell(2);
        headerCell.setCellValue("Age Group");
 
        headerCell = headerRow.createCell(3);
        headerCell.setCellValue("Year of Study");
 
        headerCell = headerRow.createCell(4);
        headerCell.setCellValue("Gender");
        
        headerCell = headerRow.createCell(5);
        headerCell.setCellValue("Ethnic");
        
        headerCell = headerRow.createCell(6);
        headerCell.setCellValue("Nationality");
        
        headerCell = headerRow.createCell(7);
        headerCell.setCellValue("Faculty");
        
        headerCell = headerRow.createCell(8);
        headerCell.setCellValue("Department");
        
        headerCell = headerRow.createCell(9);
        headerCell.setCellValue("GPA");
        
        headerCell = headerRow.createCell(10);
        headerCell.setCellValue("CGPA");
        
        headerCell = headerRow.createCell(11);
        headerCell.setCellValue("WIX1002");
        
        headerCell = headerRow.createCell(12);
        headerCell.setCellValue("WIA1002");
        
        headerCell = headerRow.createCell(13);
        headerCell.setCellValue("Analysis & Evaluation");
        
        headerCell = headerRow.createCell(14);
        headerCell.setCellValue("Logic & Reasoning");
        
        headerCell = headerRow.createCell(15);
        headerCell.setCellValue("Judgement");
        
        headerCell = headerRow.createCell(16);
        headerCell.setCellValue("Problem Solving");
        
        headerCell = headerRow.createCell(17);
        headerCell.setCellValue("Creative Thinking");
    }
 
    private void writeDataLines(ResultSet result, XSSFWorkbook workbook,
            XSSFSheet sheet) throws SQLException {
        int rowCount = 1;
 
        while (result.next()) {
           
            XSSFRow row = sheet.createRow(rowCount++);
 
            int columnCount = 0;
            Cell cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("old_matric"));
 
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("new_matric"));
 
            cell = row.createCell(columnCount++);         
            cell.setCellValue(result.getString("age_range_dscp"));
 
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("year_of_study"));
 
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("gender"));
            
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("ethnic_dscp"));
 
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("nationality_dscp"));
 
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("faculty_dscp"));
 
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("department_dscp"));
            
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("gpa"));
 
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("cgpa"));
 
            cell = row.createCell(columnCount++);         
            cell.setCellValue(result.getString("WIX1002"));
 
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("WIA1002"));
 
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getInt("percentage_analysis_evaluation"));
            
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getInt("percentage_logic_reasoning"));
 
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getInt("percentage_judgement"));
 
            cell = row.createCell(columnCount++);         
            cell.setCellValue(result.getInt("percentage_problem_solving"));
 
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getInt("percentage_creative"));
 
        }
    }
}
