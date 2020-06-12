package com.cts.ind;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;



public class DictionaryManager {
	Connection conn;                                         // The database connection object.

    public String getTerm(String wordCd,String language) throws SQLException {
    	   
    	String query="SELECT dscp from tbl_lang_dic where word_cd = '"+wordCd+"' and lang='"+language+"'" ;
    	OracleConn oracleConn=new OracleConn();
        conn = oracleConn.getConn();
        String rstString="";
        Statement stmt = conn.createStatement();
        ResultSet rset = stmt.executeQuery(query);
        while (rset.next())
           // System.out.println(rset.getString(1));
        rstString+=rset.getString(1);
        rset.close();
        stmt.close();
        conn.close();
        return rstString;
    }
}
