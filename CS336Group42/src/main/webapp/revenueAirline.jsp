<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Airline Revenue</title>
</head>
<body>
    <% 
    try{
    	ApplicationDB db = new ApplicationDB();	
    	Connection con = db.getConnection();
    	
    	Statement stmt=con.createStatement();
    	ResultSet revenue = stmt.executeQuery("SELECT * FROM tickets WHERE airline='"+request.getParameter("airline")+"'");
    	ResultSet booking;
    	%><table>
    	<tr>
    	<th>
    	Ticket Price
    	</th>
    	<th>
    	Booking Fee
    	</th>
    	</tr>
    	<% 
    	while(revenue.next()){
    		%>
    		<tr>
    		<td>
    		<%=revenue.getInt("fare") %>
    		</td>
    		<td>
    		<%=revenue.getInt("bookingFee") %>
    		</td>
    		</tr>
    		<% 
    	}%>
    	</table>
    	<br>
    	Total spendings for airline <%=request.getParameter("airline") %>: 
    	<%revenue=stmt.executeQuery("SELECT SUM(fare) FROM tickets WHERE airline='"+request.getParameter("airline")+"'"); revenue.next();
    	booking =stmt.executeQuery("SELECT SUM(bookingFee) FROM tickets WHERE airline='"+request.getParameter("airline")+"'"); booking.next();%>
    	<%= revenue.getInt("SUM(fare)")+booking.getInt("SUM(bookingFee)")%>
    	<% 
    	
    	db.closeConnection(con);
    }catch(Exception e){
    	out.print(e);
    }
    %>
</body>
</html>
