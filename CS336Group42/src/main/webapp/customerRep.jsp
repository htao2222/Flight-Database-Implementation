    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Rep</title>

<script type="text/javascript">
function hideReservations(){
	document.getElementById('ticket').style.display='none';
}
function showReservations(){
	document.getElementById('ticket').style.display='block';
}
</script>

</head>
<body>

<form method="post" action="WelcomePage.jsp">
<input type="submit" value="Logout">
</form>

    <% try{

		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		
		%>Finding waiting list for flight ID:
	<form method="post" action="searchWaitingList.jsp">
		<input type="text" name="flightID" minlength=5 maxlength=50>
		<br>
		<input type="submit" value="Submit" />
	</form>
	
	List flights for airport:<br>
	<form method="post" action="flightList.jsp">
		<%ResultSet result2 = stmt.executeQuery("SELECT * FROM airportData"); %>
	   <select  name="airport" >
	   		<%while(result2.next()){ %>
	    		<option value="<%=result2.getString("airportData")%>"> <%=result2.getString("airportData") %></option>
	    	<%} %>
	    </select> 
		<br>
		<input type="submit" value="Submit" />
	</form>
		
		Add/Edit Flight Reservations<br>
		<form method = "post" action = "flightReservations.jsp">
		Add: <input type="radio" name="command" value="addReservation" checked onclick="hideReservations();"/>
	   <br>
	   Edit: <input type="radio" name="command" value="editReservation" onclick="showReservations();"/>
	   <br>
	   <%ResultSet result = stmt.executeQuery("SELECT * FROM tickets"); %>
	   <div id = "ticket" style="display:none">
	   		Ticket to edit:
		   <select  name="ticket" >
		   		<%while(result.next()){ %>
		    		<option value="<%=result.getString("flightId") + "/" + result.getString("class") + "/" + result.getString("seatNum")%>">
		    		FlightID: <%=result.getString("flightId") %>,  Class: <%=result.getString("class") %>,   Seat Number: <%=result.getString("seatNum") %></option>
		    	<%} %>
		    </select> 
	    </div>
	   Username: <input type="text" name="username" minlength=5 maxlength=50>
	   <br>
	   Flight ID: <input type="text" name="flightID" minlength=5 maxlength=50>
	   <br>
	   Class: 
	    <select name="class">
	    <option value="economy">Economy</option>
	    <option value="first">First Class</option>
	    <option value="business">Business Class</option>
	    </select>
	   <br>
	   Seat Number: <input type="text" name="seatNumber" minlength=5 maxlength=50>
	   <br>
	   Fare: <input type="text" name="fare" minlength=5 maxlength=50>
	   <br>
	   Date of Purchase(yyyy-mm-dd): <input type="text" name="dateOfPurchase" minlength=5 maxlength=50>
	   <br>
		<input type="submit" value="Submit" />
		</form>
		
		
		
		Add/Edit/Delete Aircrafts<br>

		<form method="post" action="aircraft.jsp">
		Add: <input type="radio" name="command" value="addAircrafts" checked/>
	   <br>
	   Edit: <input type="radio" name="command" value="editAircrafts"/>
	   <br>
	   Delete: <input type="radio" name="command" value="deleteAircrafts"/>
	   <br>
	   Aircraft: <input type="text" name="aircraftName" minlength=5 maxlength=50>
	   <br>
		New Aircraft [If Editing Aircraft]: <input type="text" name="aircraftNew" minlength=5 maxlength=50>
		<br>
		Economic Seats: <input type="text" name="econSeats" minlength=5 maxlength=50>
		<br>
		Business Seats: <input type="text" name="businessSeats" minlength=5 maxlength=50>
		<br>
		First Class Seats: <input type="text" name="firstClass" minlength=5 maxlength=50>
	<br>
	<input type="submit" value="Submit" />
	</form>
	
	<form method="post" action="airport.jsp">
	   
	   Add/Edit/Delete Airports<br>
	   
	   Add: <input type="radio" name="command" value="addAirport" checked/>
	   <br>
	   Edit: <input type="radio" name="command" value="editAirport"/>
	   <br>
	   Delete: <input type="radio" name="command" value="deleteAirport"/>
	   <br>
	   Airport: <input type="text" name="airportName" minlength=3 maxlength=3>
	   <br>
		New Airport [If Editing Airport]: <input type="text" name="airportNew" minlength=3 maxlength=3>
	<br>
	<input type="submit" value="Submit" />
	</form>
	
		<form method="post" action="flight.jsp">
		Add/Edit/Delete Flights<br>
		Add: <input type="radio" name="command" value="addFlights" checked/>
	   <br>
	   Edit: <input type="radio" name="command" value="editFlights"/>
	   <br>
	   Delete: <input type="radio" name="command" value="deleteFlights"/>
	   <br>
	   Flight ID(integer): <input type="text" name="flightID" minlength=5 maxlength=50>
	<br>
	New Flight ID (Editing): <input type="text" name="flightIDnew" minlength=5 maxlength=50>
	<br>
	New Aircraft: <input type="text" name="aircraftData" minlength=5 maxlength=50>
	<br>	
	New Arrival Airport (3 characters): <input type="text" name="arrivalAirport" minlength=3 maxlength=3>
	<br>
	New Departing Airport (3 characters): <input type="text" name="departingAirport" minlength=3 maxlength=3>
	<br>
	New Arrival Time(hh:mm:ss): <input type="text" name="arrivalTime" minlength=5 maxlength=50>
	<br>
	New Departure Time(hh:mm:ss): <input type="text" name="departureTime" minlength=5 maxlength=50>
	<br>
	New Arrival Date(YYYY-MM-DD): <input type="text" name="arrivalDate" minlength=5 maxlength=50>
	<br>
	New Departure Date(YYYY-MM-DD): <input type="text" name="departureDate" minlength=5 maxlength=50>
	<br>
	New Flight Type: 

	<select name="typeFlight">
    <option value="One-Way Specific">One-Way Specific Date</option>
    <option value="Round-Trip Specific">Round-Trip Specific Date</option>
    <option value="One-Way Flexible">One-Way Flexible</option>
    <option value="Round-Trip Flexible">Round-Trip Flexible</option>
    </select> 
	<br>
	New Economic Rate: <input type="text" name="econRate" minlength=5 maxlength=50>
	<br>
	New Business Rate: <input type="text" name="businessRate" minlength=5 maxlength=50>
	<br>
	New First Rate: <input type="text" name="firstRate" minlength=5 maxlength=50>
	<br>
	New Duration: <input type="text" name="duration" minlength=5 maxlength=50>
	<br>
	New Airline ID(2 characters): <input type="text" name="airline" maxlength=2>
	<br>
	<input type="submit" value="Submit" />
	</form>
		<br>
		Respond to Questions
		<%ResultSet latestQ=stmt.executeQuery("SELECT * FROM questions WHERE id>= ALL (SELECT id FROM questions)");
		latestQ.next();
		int id=latestQ.getInt("id"); %>
		<form action="answerQNA.jsp" method="post">
		Question ID: <input type="number" min="1" max="<%=id%>"name="id" value=1> <br>
		Answer: <textarea name="answer" rows="5" cols="50">Answer here!</textarea>
		<input type="submit" value="submit answer">
		</form>
		
		<%
		String qnaQuery = "SELECT * FROM questions";
		ResultSet qnaQuestions = stmt.executeQuery(qnaQuery);
		%>
		
		<table style="width:100%">
		<tr style="border-style: solid; border: 1; border-color: black">
			<th style="border-style: solid; border: 1; border-color: black">#</th>
			<th style="border-style: solid; border: 1; border-color: black">Question</th>
			<th style="border-style: solid; border: 1; border-color: black">Answer</th>
		</tr>
		
		<% int count=0;
		while(qnaQuestions.next()){%>
			<tr style="border-style: solid; border: 1; border-color: black">
				<td style="border-style: solid; border: 1; border-color: black">
				<%= qnaQuestions.getInt("id")%>
				</td>
				<td style="border-style: solid; border: 1; border-color: black">
				<%=qnaQuestions.getString("question") %>
				</td>
				<td style="border-style: solid; border: 1; border-color: black">
				<%=qnaQuestions.getString("answer") %>
				</td>
			</tr>
			<% 
		}
		%>
		</table>
		
	<% 	db.closeConnection(con);  
	/*
	
	*/
	}catch(Exception e){
		out.print(e);
		} %>


</body>
</html>