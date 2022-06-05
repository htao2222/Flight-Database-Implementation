    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Confirm User Change</title>
</head>
<body>

<% 

try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	Statement stmt = con.createStatement();
	
	//stmt.executeUpdate("INSERT INTO USERS (username, password, level) VALUES ([var1],[var2],[var3])");
	
	String action = request.getParameter("command");
	String username = request.getParameter("username");
	String newUsername= request.getParameter("usernameNew");
	String password = request.getParameter("password");
	int level=0;
	if(request.getParameter("role").equals("rep"))
		level=1;
	
	String query = "SELECT * FROM users WHERE username=" + "'" + username + "'";
	ResultSet result = stmt.executeQuery(query);
	
	
	 
    if(action.equals("add")){
        if(result.next()){
            %>Invalid Username/Password<br>
			User already exists <%
        } else {
            //stmt.executeUpdate("INSERT INTO users VALUES ("+username+","+password+","+level+")");
            //"INSERT INTO users(username, password, level)"
	                //+ "VALUES (?, ?, ?)"
            String query2="INSERT INTO users(username, password, level)"
	                + "VALUES (?, ?, ?)";
			PreparedStatement insertUser = con.prepareStatement(query2);
			insertUser.setString(1,username);
			insertUser.setString(2,password);
			insertUser.setInt(3,level);
			insertUser.executeUpdate();
			%>Successfully added <%
        }        
        
    } else if (!result.next()){
        %>Invalid Username/Password<br>
		User does not exist <%
    } else if (action.equals("delete")){
       // stmt.executeUpdate("DELETE FROM users WHERE username="+username);
        String query2="DELETE FROM users WHERE username=?";
		PreparedStatement insertUser = con.prepareStatement(query2);
		insertUser.setString(1,username);
		insertUser.executeUpdate();
        %>Successfully deleted <%
    } else if (action.equals("edit")){
        result = stmt.executeQuery(query);
        if(stmt.executeQuery("SELECT * FROM users WHERE username=" + "'" + newUsername + "'").next()){
	        %>Invalid Username/Password<br>
			Changed Username already exists <%
    	} else {
            //stmt.executeUpdate("UPDATE users SET username="+newUsername+", password="+password+", level="+level+" WHERE username="+username);
            String query2="UPDATE users SET username=?, password=?, level=? WHERE username=?";
			PreparedStatement insertUser = con.prepareStatement(query2);
			insertUser.setString(1,newUsername);
			insertUser.setString(2,password);
			insertUser.setInt(3,level);
			insertUser.setString(4,username);
			insertUser.executeUpdate();
            %>Successfully edited <%
        }
        
    }
	//PreparedStatement updateStud=conn.prepareStatement("UPDATE Student SET fname=? WHERE lastname LIKE?"); 
	/*
	updateStud.setString(1,"John"); 
	updateStud.setString(2,"Doe"); 
	updateStud.executeUpdate(); 
*/
	
	
	
	db.closeConnection(con);

}catch(Exception e){
out.print(e);
}



%>
<form method="post" action="admin.jsp">
<input type="submit" value="Back">
</form>

</body>
</html>