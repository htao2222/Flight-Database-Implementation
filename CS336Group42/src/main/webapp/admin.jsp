    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Powers</title>
</head>
<body>

<% try{

	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt=con.createStatement();
	%>
		
	Add/Edit/Delete User<br>
	
	<form method="post" action="changeUsers.jsp">
   
   Add: <input type="radio" name="command" value="add" checked/>
   <br>
   Edit: <input type="radio" name="command" value="edit"/>
   <br>
   Delete: <input type="radio" name="command" value="delete"/>
   <br>
	Username: <input type="text" name="username" minlength=5 maxlength=50>
	<br>
	New Username [If Editing User]: <input type="text" name="usernameNew" minlength=5 maxlength=50>
	<br>
	New Password [If Adding/Editing User]: <input type="text" name="password" minlength=5 maxlength=50>
	<br>
	User: <input type="radio" name="role" value="user" checked/>
	<br>
	Customer Rep: <input type="radio" name="role" value="rep" checked/>
	<input type="submit" value="Submit" />
	</form>
	
	<br>
	Top spender:
	<% 
	String topSpendQuery ="SELECT username,SUM(fare) FROM tickets WHERE username IS NOT NULL GROUP BY username ORDER BY SUM(fare) DESC";
	ResultSet topSpender=stmt.executeQuery(topSpendQuery);
	if(topSpender.next()){
	%><%= topSpender.getString("username") %> (<%=topSpender.getInt("SUM(fare)") %>)
	<%}else{%>None<%} %> 
	
	<br>
	Most active flights:
	<% 
	String activeFlightsQuery = "SELECT flightId, count(*) FROM tickets t WHERE username IS NOT NULL GROUP BY flightId ORDER BY count(*) DESC";
	ResultSet activeFlights=stmt.executeQuery(activeFlightsQuery);
	
	if(activeFlights.next()){
	int numTickets = activeFlights.getInt("count(*)");
	%>
	<%= activeFlights.getInt("flightId") %>
	<% 
	while(activeFlights.next()){
		if(numTickets!=activeFlights.getInt("count(*)"))
			break;
		else{
			%>, <%=activeFlights.getInt("flightId") %><% 
		}
	}
	}
	else{
		%>None<% 
	}
	%>
	<br>
	<br>
	Search Reservations
	<br>by Flight Number:
	<% 
	ResultSet flights = stmt.executeQuery("SELECT flightId FROM tickets WHERE username IS NOT NULL GROUP BY flightId ORDER BY flightId ASC");
	%> 
	<form action="reservationSearchFlight.jsp" method="post">
	<select name="chosenFlight">
		<% 
		while(flights.next()){
			%><option value="<%=flights.getInt("flightId")%>"><%=flights.getInt("flightId")%></option><% 
		}
		%>
	</select>
	<input type="submit" value="submit">
	</form>
	
	<br>by username:
	<%ResultSet usernames = stmt.executeQuery("SELECT username FROM users WHERE level=0 AND username IS NOT NULL ORDER BY username ASC"); %>
	<form action="reservationSearchUser.jsp" method="post">
	<select name="chosenUser">
		<% 
		while(usernames.next()){
			%><option value="<%=usernames.getString("username")%>"><%=usernames.getString("username")%></option><% 
		}
		%>
	</select>
	<input type="submit" value="submit">
	</form>
	<br>
	Get Revenue Summary (booking fee is 150% ticket cost)
	<form action="revenue.jsp" method="post">
	Airline: <input type="radio" name="operation" value="airline" checked>
	Flight: <input type="radio" name="operation" value="flight">
	Customer: <input type="radio" name="operation" value="customer">
	<input type="submit" value="submit">
	</form>
	
	
	
	<br>
	<%ResultSet months=stmt.executeQuery("SELECT EXTRACT( YEAR_MONTH FROM datePurchase) month FROM tickets WHERE username IS NOT NULL GROUP BY EXTRACT(YEAR_MONTH FROM datePurchase)"); %>
	Sales Report for:
	<% if(months.next()){ %> 
	
	<form action="salesReport.jsp" method="post">
	<select name="year-month">
	
	<% do{%>
	<option value="<%=months.getString("month")%>"><%=months.getString("month").substring(0,4)+"-"+months.getString("month").substring(4) %></option>
	<%}while(months.next());%>
	</select>
	<input type="submit" value="submit">
	</form>
	<% }
	else {
	%>No tickets have been sold.<% 
	}%>
	<% 
	db.closeConnection(con);
}catch(Exception e){
	out.print(e);
}%>

<form method="post" action="WelcomePage.jsp">
<input type="submit" value="Logout">
</form>

</body>
</html>