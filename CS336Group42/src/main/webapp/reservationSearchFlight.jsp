    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reservation Search</title>
</head>
<body>
<% 
try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	Statement stmt = con.createStatement();
	String query="SELECT * FROM tickets WHERE username IS NOT NULL AND flightId="+request.getParameter("chosenFlight");
	ResultSet tickets = stmt.executeQuery(query);
	%>
	<table>
		<tr style="border-style:solid; border:1; border-color:black">
			<th style="border-style:solid; border:1; border-color:black">Flight ID</th>
			<th style="border-style:solid; border:1; border-color:black">Username</th>
			<th style="border-style:solid; border:1; border-color:black">Class</th>
			<th style="border-style:solid; border:1; border-color:black">Seat Number</th>
			<th style="border-style:solid; border:1; border-color:black">Ticket Price</th>
			<th style="border-style:solid; border:1; border-color:black">Purchase Date</th>
		</tr>
		<% 
		while(tickets.next()){
			%>
			<tr style="border-style:solid; border:1; border-color:black">
				<td style="border-style:solid; border:1; border-color:black"><%=tickets.getInt("flightId")%></td>
				<td style="border-style:solid; border:1; border-color:black"><%=tickets.getString("username")%></td>
				<td style="border-style:solid; border:1; border-color:black"><%=tickets.getString("class")%></td>
				<td style="border-style:solid; border:1; border-color:black"><%=tickets.getInt("seatNum")%></td>
				<td style="border-style:solid; border:1; border-color:black"><%=tickets.getInt("fare")%></td>
				<td style="border-style:solid; border:1; border-color:black"><%=tickets.getDate("datePurchase")%></td>
			</tr>
			
			<% 
		}
		%>
	</table>
	
	
	<% 
	db.closeConnection(con);
}catch(Exception e){
	out.print(e);
}
%>
</body>
</html>