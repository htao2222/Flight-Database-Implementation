    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Question Asked!</title>
</head>
<body>

<% 
try{
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	String username=request.getParameter("username");
	String question=request.getParameter("question");
	
	Statement stmt=con.createStatement();
	ResultSet latestQ=stmt.executeQuery("SELECT * FROM questions WHERE id>= ALL (SELECT id FROM questions)");
	latestQ.next();
	int id=latestQ.getInt("id")+1;
	
	PreparedStatement insertQ= con.prepareStatement("INSERT INTO questions VALUES (?,'',?)");
	insertQ.setString(1, question);
	insertQ.setInt(2,id);
	insertQ.executeUpdate();
	%>
	Question asked!
	<form action="customer.jsp" method="post">
	<input type="hidden" value=<%=username%> name="username">
	<input type="submit" value="Go back">
	</form>
	<% 
	db.closeConnection(con);
}catch(Exception e){
	out.println(e);
}


%>

</body>
</html>