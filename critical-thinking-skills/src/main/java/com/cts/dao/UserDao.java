package com.cts.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import com.cts.model.Login;
import com.cts.model.User;


public class UserDao {

	JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
		this.jdbcTemplate = jdbcTemplate;  
	} 
	  
	public List<User> validateUser(Login login) {
	    String sqlStmt = "select * from tbl_user where user_name='" + login.getUsername() + "' and login_pswd='" + login.getPassword() 
	    + "' and role_cd='" + login.getRoleCd()   + "'";
	    List<User> userLst = getUser(sqlStmt,login);
	    return userLst;
	  }
	
	public List<User> getUser( String sqlStmt,final Login login){
		return jdbcTemplate.query(sqlStmt, new RowMapper<User>() {
			public User mapRow(ResultSet rs, int row) throws SQLException{
				User user = new User(login.getUsername(),login.getPassword(),login.getRoleCd());
			    user.setId(rs.getString("id"));		    
			    user.setRoleCd(rs.getString("role_cd"));
			    return user;
			}
		});
	}
	
}
