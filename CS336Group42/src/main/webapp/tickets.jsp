    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Purchase Tickets</title>
</head>
<body>
<%
try{
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	
	String username = request.getParameter("username");
	int fid = Integer.parseInt(request.getParameter("fid"));
	String classType = request.getParameter("class");
	String date = request.getParameter("date");
	
	ResultSet goldenTicket = stmt.executeQuery("SELECT * FROM tickets WHERE flightId="+fid+" AND class='"+classType+"' AND username IS NULL ORDER BY seatNum ASC");
	
	if(!goldenTicket.next()){
		//waiting list
		%>
		We are out of tickets of the wanted class for the desired flight. <br> If you want, you may join the waiting list.<br>
		<form action="waitinglist.jsp" method="post">
		<input type="hidden" name="username" value="<%=username%>">
		<input type="hidden" name="fid" value="<%=fid%>">
		<input type="hidden" name="class" value="<%=classType%>">
		<input type="submit" value="Join the waiting list">
		</form>
		<% 
	}
	else{
		int seatNum = goldenTicket.getInt("seatNum");
		int fare = goldenTicket.getInt("fare");
		int booking = goldenTicket.getInt("bookingFee");
		int cancel = goldenTicket.getInt("cancelFee");
		PreparedStatement buyTicket = con.prepareStatement("DELETE FROM tickets WHERE flightId="+fid+" AND class='"+classType+"' AND seatNum="+seatNum);
		out.println("HERE");
		buyTicket.executeUpdate();
		buyTicket = con.prepareStatement("INSERT INTO tickets VALUES (?,?,?,?,?,?,?,?)");
		buyTicket.setString(1,username);
		buyTicket.setInt(2,fid);
		buyTicket.setString(3,classType);
		buyTicket.setInt(4,seatNum);
		buyTicket.setInt(5,fare);
		buyTicket.setString(6,date);
		buyTicket.setInt(7,booking);
		buyTicket.setInt(8,cancel);
		buyTicket.executeUpdate();
		%>
		You have purchased a ticket! Congratulations!
		<% 
	}
	
	db.closeConnection(con);
}catch(Exception e){
	out.print(e);
}
%>
</body>
</html>