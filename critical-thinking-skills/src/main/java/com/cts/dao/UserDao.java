package com.cts.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
			    user.setUsername(rs.getString("user_name"));		
			    user.setRoleCd(rs.getString("role_cd"));
			    return user;
			}
		});
	}
	
	public User getUserDet(String userid) {		
		 String sql = "SELECT * FROM tbl_user_det WHERE USER_ID = ?";
		 User user = new User();
		 try {
			Connection connection = jdbcTemplate.getDataSource().getConnection();
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,userid);		
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				user.setId(userid);
				user.setDisciplineCd(rs.getString("DISCIPLINE_CD"));
				user.setCategoryCd(rs.getString("CATEGORY_CD"));
			}
			rs.close();
			ps.close();
					} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		 String sql2 = "SELECT * FROM tbl_user WHERE ID = ?";
		 try {
				Connection connection = jdbcTemplate.getDataSource().getConnection();
				PreparedStatement ps = connection.prepareStatement(sql2);
				ps.setString(1,userid);		
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					user.setUsername(rs.getString("user_name"));
				}
				rs.close();
				ps.close();
						} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 return user;


	}
	
	public void createTestTaker(User user) throws SQLException {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
        CallableStatement cs = connection.prepareCall("{call SP_CREATE_TESTTAKER(?,?,?,?,?)}");
       
        cs.setString(1, user.getUsername());
        cs.setString(2,user.getPassword());
        cs.setString(3, user.getRoleCd());
        cs.setString(4,user.getEmail());
        cs.setString(5, user.getFullname());
        cs.execute();
    	 cs.close();
	}
	
}
