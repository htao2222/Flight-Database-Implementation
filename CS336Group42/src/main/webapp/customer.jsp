    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Page</title>
</head>
<body>

<form method="post" action="WelcomePage.jsp">
<input type="submit" value="Logout">
</form>
<% 

try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	String username = request.getParameter("username");
	Statement stmt = con.createStatement();
	%>
	Purchase Tickets <br>
	<form method="post" action="tickets.jsp">
	FlightID: <input type="number" min="1" name="fid"><br>
	Class: <select name="class">
	<option value="economy">Economy</option>
	<option value="business">Business</option>
	<option value="first">First</option>
	</select>
	<br>Today's Date (YYYY-MM-DD): <input type="text" name="date" maxlength=10>
	<input type="hidden" value="<%=username%>" name="username">
	<input type="submit" value="submit">
	</form>
	
	
	<form method="post" action="flightSearch.jsp">
       <br>
	Search for Flights
	<br>
		Arrival Airport: <input type="text" name="arrivingAirport" minlength=5 maxlength=50>
	   <br>
	   Departing Airport: <input type="text" name="departingAirport" minlength=5 maxlength=50>
	   <br>
	   <select name="typeFlight">
	    <option value="One-Way Specific">One-Way Specific Date</option>
	    <option value="Round-Trip Specific">Round-Trip Specific Date</option>
	    <option value="One-Way Flexible">One-Way Flexible</option>
	    <option value="Round-Trip Flexible">Round-Trip Flexible</option>
	    </select> 
	    <select name="sorting">
	    <option value="unsorted">Unsorted</option>
	    <option value="price">Sort by Price</option>
	    <option value="takeOffTime">Sort by Take-Off Time</option>
	    <option value="landingTime">Sort by Landing Time</option>
	    <option value="flightDuration">Sort by Flight Duration</option>
	    <option value="airline">Sort by Airline</option>
	    </select> 
	    <select name="SeatType">
	    <option value="econ">Economy</option>
	    <option value="first">First Class</option>
	    <option value="business">Business Class</option>
	    </select>
	    <br>
	    Max Price: <input type="text" name="maxPrice" minlength=5 maxlength=50>
	    <br>
	    TakeOff Time Frame(hh:mm:ss): <input type="text" name="takeOffMin" minlength=5 maxlength=50> - <input type="text" name="takeOffMax" minlength=5 maxlength=50>
	    <br>
	    Landing Time Frame(hh:mm:ss): <input type="text" name="landingMin" minlength=5 maxlength=50> - <input type="text" name="landingMax" minlength=5 maxlength=50>
	    <br>
	    Airline: 
	    <%ResultSet result = stmt.executeQuery("SELECT * FROM flights"); %>
	   <select  name="airline" >
           <option value="unselected"> Unselected</option>
	   		<%while(result.next()){ %>
	    		<option value="<%=result.getString("airline")%>"> <%=result.getString("airline") %></option>
	    	<%} %>
	    </select> 
	   <input type="submit" value="Submit" />
	  </form>
	
	
	Ask a question
	<br>
	<form action="askQNA.jsp" method="post">
	<textarea rows="5" cols="50" name="question">Ask away!</textarea>
	<input type="submit" value="submit">
	<input type="hidden" value=<%=username%> name="username">
	</form>
	<br>
	
	Search questions and answers
	
	<form action="searchQNA.jsp" method="post">
	Keyword:<input type="text" name="term">
	<input type="hidden" value="<%=username%>" name="username">
	<input type="submit" value="submit">
	</form>
	
	
	<br>
	<!-- Show support tickets -->Browse all questions
	<table >
		<tr style="border-style:solid; border:1; border-color:black">
			<th style="border-style:solid; border:1; border-color:black">#</th>
			<th style="border-style:solid; border:1; border-color:black">Question</th>
			<th style="border-style:solid; border:1; border-color:black">Answer</th>
		</tr>
		<% 
		String qnaQuery="SELECT * FROM questions";
		ResultSet qnaQuestions = stmt.executeQuery(qnaQuery);
		while(qnaQuestions.next()){
			%>
			<tr style="border-style:solid; border:1; border-color:black">
			<td style="border-style:solid; border:1; border-color:black"><%= qnaQuestions.getInt("id")%></td>
			<td style="border-style:solid; border:1; border-color:black"><%= qnaQuestions.getString("question")%></td>
			<td style="border-style:solid; border:1; border-color:black"><%= qnaQuestions.getString("answer") %> </td>
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