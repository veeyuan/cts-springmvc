package com.cts.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cts.model.Department;
import com.cts.model.Option;

public class OptionDao {
	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	
	public String getTableName(String varName) {
		String tableName = "tbl_";
		
		if (varName.equalsIgnoreCase("component")) {
			tableName+="hots_components";			
		}else if(varName.equalsIgnoreCase("course")) {
			tableName+="programming_course";
		}else {
			tableName+=varName;
		}
		return tableName;
	}
	
	public List<Option> getOptionAllList(String varName){
		String tableName = getTableName(varName);
		String varCode = varName+"_cd";
		String sqlStmt = "select * from "+tableName+" order by "+varCode ;
		List<Option> list = getAllList(sqlStmt,varName);

	    return list;
	}
	
	public List<Option> getAllList( String sqlStmt,String varName){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Option>() {
			public Option mapRow(ResultSet rs, int row) throws SQLException{
				Option option = new Option();
				String varCode = varName+"_cd";				
				String varDscp = varName;
				if (varName == "component") {
					varDscp += "_name";
				}else {
					varDscp += "_dscp";
				}
				option.setCode(rs.getString(varCode));	
				
				option.setName(rs.getString(varDscp));	
				if (rs.getInt("del")==0) {
					option.setHidden(false);
				}else {
					option.setHidden(true);
				}
			    return option;
			}
		});
	}
	
	public void showOptions(String[] hideOptionList,String varName) throws SQLException {
		hideAllOptions(varName);
		String tableName = getTableName(varName);
		String varCode = varName+"_cd";	
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		Statement stmt = connection.createStatement();		
		String conditionQuery =  "";
		for (int i=0;i<hideOptionList.length;i++) {
			if(i==hideOptionList.length-1) {
				conditionQuery+="'"+hideOptionList[i].toString()+"'";
			}else {
				conditionQuery+="'"+hideOptionList[i].toString()+"' or "+varCode+" = ";
			}			
		}
		String hidequery = "update "+tableName+" set del=0 where "+varCode+" = "+conditionQuery;
		
		stmt.executeUpdate(hidequery);
		

	}
	
	public void hideAllOptions(String varName) throws SQLException {
		String tableName = getTableName(varName);
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		Statement stmt = connection.createStatement();	
		String unhideAllQuery ="update "+tableName+" set del=1 where del>=0";
		stmt.executeUpdate(unhideAllQuery);
	}
	
	public void insertNewOption(String varName,String dscp) {
		String tableName = getTableName(varName);
		String varDscp = varName+"_dscp";	
		if (varName.equalsIgnoreCase("component")) {
			varDscp = varName+"_name";	
		}
		 String sql = "INSERT INTO "+tableName+" ("+varDscp+") VALUES (?)";
	 		jdbcTemplate.update(sql,dscp );
	}
	
	public void insertNewDepartment(String deptDscp, String facCd) {
		 String sql = "INSERT INTO TBL_DEPARTMENT (department_dscp,faculty_cd) VALUES (?,?)";
	 		jdbcTemplate.update(sql,deptDscp,facCd );
	}
	
	public List<Department> getAllDepartmentWithFacList(){		
		String sqlStmt = "select department.*,fac.faculty_dscp from tbl_department department left join tbl_faculty fac on fac.faculty_cd = department.faculty_cd order by fac.faculty_dscp,department.department_cd";
		List<Department> list  = getAllList(sqlStmt);
	    return list;
	}
	public List<Department> getAllList( String sqlStmt){
		return jdbcTemplate.query(sqlStmt, new RowMapper<Department>() {
			public Department mapRow(ResultSet rs, int row) throws SQLException{
				Department department = new Department();
				department.setCode(rs.getString("department_cd"));
				department.setName(rs.getString("department_dscp"));
				department.setFacultyDscp(rs.getString("faculty_dscp"));	
				if (rs.getInt("del")==0) {
					department.setHidden(false);
				}else {
					department.setHidden(true);
				}
			    return department;
			}
		});
	}
	
	public void insertProgrammingCourse(String courseCd, String courseNm) {
		 String sql = "INSERT INTO tbl_programming_course (course_cd,course_dscp) VALUES (?,?)";
	 		jdbcTemplate.update(sql,courseCd,courseNm );
	}

}
