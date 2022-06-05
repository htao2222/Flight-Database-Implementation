<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Report</title>
</head>
<body>
    <% 
    try{
    	ApplicationDB db = new ApplicationDB();	
    	Connection con = db.getConnection();
    	Statement stmt= con.createStatement();
    	Statement stmt2 = con.createStatement();
    	
        ResultSet revenue=stmt.executeQuery("SELECT * FROM tickets WHERE username<>'' AND EXTRACT(YEAR_MONTH FROM datePurchase)="+request.getParameter("year-month"));
    	%>
    	<%=request.getParameter("year-month").substring(0,4)+"-"+request.getParameter("year-month").substring(4) %> Sales Report
    	<table>
    	<tr style="border-style:solid; border:1; border-color:black">
    	<th style="border-style:solid; border:1; border-color:black">
    	FlightID
    	</th>
    	<th style="border-style:solid; border:1; border-color:black">
    	Customer
    	</th>
    	<th style="border-style:solid; border:1; border-color:black">
    	Class
    	</th>
    	<th style="border-style:solid; border:1; border-color:black">
    	Seat #
    	</th>
 		<th style="border-style:solid; border:1; border-color:black">
 		Ticket Fare
 		</th>
 		<th style="border-style:solid; border:1; border-color:black">
 		Booking Fee
 		</th>
    	</tr>
    	<% while(revenue.next()){ %>
    	<tr style="border-style:solid; border:1; border-color:black">
    	<td style="border-style:solid; border:1; border-color:black">
    	<%=revenue.getInt("flightId") %>
    	</td>
    	<td style="border-style:solid; border:1; border-color:black">
    	<%=revenue.getString("username") %>
    	</td>
    	<td style="border-style:solid; border:1; border-color:black">
    	<%=revenue.getString("class") %>
    	</td>
    	<td style="border-style:solid; border:1; border-color:black">
    	<%=revenue.getInt("seatNum") %>
    	</td>
    	<td style="border-style:solid; border:1; border-color:black">
    	<%=revenue.getInt("fare") %>
    	</td>
    	<td style="border-style:solid; border:1; border-color:black">
    	<%=revenue.getInt("bookingFee")%>
    	</td>
    	</tr>
    	<%} %>
    	</table>
    	<br>
    	Total earnings: 
    	<%revenue=stmt.executeQuery("SELECT SUM(fare) FROM tickets WHERE EXTRACT(YEAR_MONTH FROM datePurchase)='"+request.getParameter("year-month")+"'"); revenue.next();
    	ResultSet booking=stmt2.executeQuery("SELECT SUM(bookingFee) FROM tickets WHERE EXTRACT(YEAR_MONTH FROM datePurchase)='"+request.getParameter("year-month")+"'"); booking.next();%>
    	<%=revenue.getInt("SUM(fare)")+booking.getInt("SUM(bookingFee)") %>
    	<% 
    	db.closeConnection(con);
    }catch(Exception e){
    	out.print(e);
    }
    %>
</body>
</html>
