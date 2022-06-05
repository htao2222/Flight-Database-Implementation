<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Flight Revenue</title>
</head>
<body>
    <% 
    try{
    	ApplicationDB db = new ApplicationDB();	
    	Connection con = db.getConnection();
    	
    	//code go here
    	Statement stmt=con.createStatement();
    	ResultSet revenue = stmt.executeQuery("SELECT * FROM tickets WHERE flightId='"+request.getParameter("flight")+"'");
    	%><table>
    	<tr>
    	<th>
    	Ticket Price
    	</th>
    	</tr>
    	<% 
    	while(revenue.next()){
    		%>
    		<tr>
    		<td>
    		<%=revenue.getInt("fare") %>
    		</td>
    		</tr>
    		<% 
    	}%>
    	</table>
    	<br>
    	Total earnings for flight <%=request.getParameter("flight") %>: 
    	<%revenue=stmt.executeQuery("SELECT SUM(fare) FROM tickets WHERE flightId='"+request.getParameter("flight")+"'"); revenue.next();%>
    	<%= revenue.getInt("SUM(fare)")%>
    	<% 
    	db.closeConnection(con);
    }catch(Exception e){
    	out.print(e);
    }
    %>
</body>
</html>
