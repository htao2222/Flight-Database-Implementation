    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer submitted</title>
</head>
<body>
<% 

try{
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	String query="UPDATE questions SET answer=? WHERE id=?";
	PreparedStatement stmt = con.prepareStatement(query);
	int id=Integer.parseInt(request.getParameter("id"));
	String answer=request.getParameter("answer");
	%><% 
	
	stmt=con.prepareStatement(query);
	stmt.setString(1, answer);
	stmt.setInt(2,id);
	stmt.executeUpdate();
	%>Answer successful, please go back to the previous page.
	<form method="post" action="customerRep.jsp">
<input type="submit" value="Back">
</form>
	
	<% 
	db.closeConnection(con);
}catch(Exception e){
	
}
%>
</body>
</html>