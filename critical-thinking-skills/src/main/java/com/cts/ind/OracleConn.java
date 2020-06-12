package com.cts.ind;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class OracleConn {
	public Connection getConn() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		Connection connection = null;
		try {
			connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcldb","user1","sysadmin");
		} catch (SQLException e) {
			System.out.println("Connection failed...");
			e.printStackTrace();
			return null;
		} 
		if (connection!=null) {
			return connection;
		}else {
			System.out.println("Connection failed...");
		}
		return connection;
	
	}

}
