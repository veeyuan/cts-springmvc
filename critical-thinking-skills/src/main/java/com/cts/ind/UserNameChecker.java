package com.cts.ind;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class UserNameChecker {
	Connection conn;                                         // The database connection object.

    public String getUsernameList() throws SQLException, ClassNotFoundException {
    	String query="SELECT user_name from tbl_user where role_cd = 'TEST-TAKER'" ;
    	Class.forName("com.mysql.jdbc.Driver");  
		Connection conn=DriverManager.getConnection( "jdbc:mysql://103.233.3.93:3306/cts_db?useTimezone=true&serverTimezone=UTC&useSSL=false","cts_admin","T72!wsb2");  
		
        String rstString="";
        Statement stmt = conn.createStatement();
        ResultSet rset = stmt.executeQuery(query);
        while (rset.next()) {
        	if (rstString=="") {
        		rstString=rset.getString("user_name");
        	}else {
        		rstString+=","+rset.getString("user_name");
        	}
        	
	    }
	    rset.close();
        stmt.close();
        conn.close();
        return rstString;
    }
    
    
    
    public String getEmailList() throws SQLException, ClassNotFoundException {
    	String query="SELECT EMAIL from tbl_user_det" ;
    	Class.forName("com.mysql.jdbc.Driver");  
		Connection conn=DriverManager.getConnection( "jdbc:mysql://103.233.3.93:3306/cts_db?useTimezone=true&serverTimezone=UTC&useSSL=false","cts_admin","T72!wsb2");  
		
        String rstString="";
        Statement stmt = conn.createStatement();
        ResultSet rset = stmt.executeQuery(query);
        while (rset.next()) {
        	if (rstString=="") {
        		rstString=rset.getString("EMAIL");
        	}else {
        		rstString+=","+rset.getString("EMAIL");
        	}
        	
	    }
	    rset.close();
        stmt.close();
        conn.close();
        return rstString;
    }
}
