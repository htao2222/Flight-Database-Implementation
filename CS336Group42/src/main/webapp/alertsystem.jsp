<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Alert System</title>
</head>
<body>
    <% 
    try{
    	ApplicationDB db = new ApplicationDB();	
    	Connection con = db.getConnection();
    	Statement stmt = con.createStatement();

		String username = request.getParameter("username");
		String flightID = request.getParameter("flightid");
		ResultSet openseats = stmt.executeQuery("");
		
		if(openseats.next()){
			PreparedStatement planeseat = con.prepareStatement("INSERT INTO openseats VALUES (?,?)");
			planeseat.setString(0,username);
			planeseat.setString(1,flightID);
		}else{
			%> Sorry. There are no seats available yet for Flight <%= flightID %>.<%
		}

    	db.closeConnection(con);
    }catch(Exception e){
    	out.print(e);
    }
    %>
</body>
</html>