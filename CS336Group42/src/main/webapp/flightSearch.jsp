    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Flight Search</title>
</head>
<body>

<% 

try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	
	String arrivalAirport = request.getParameter("arrivingAirport");
	String departingAirport = request.getParameter("departingAirport");
	String typeFlight = request.getParameter("typeFlight");
	String sorting = request.getParameter("sorting");
	String maxPrice = request.getParameter("maxPrice");
	String takeOffMin = request.getParameter("takeOffMin");
	String takeOffMax = request.getParameter("takeOffMax");
	String landingMin = request.getParameter("landingMin");
	String landingMax = request.getParameter("landingMax");
	String airline = request.getParameter("airline");
	
	String query = "SELECT * FROM flights WHERE departingAirport=" + "'" + departingAirport + "'" + " AND arrivalAirport=" + "'" + arrivalAirport +"'" + " AND typeFlight=" + "'" + typeFlight + "'";
	
	//out.print("HERE");
	
	//ResultSet result = stmt.executeQuery(query);
	if(maxPrice != null && !maxPrice.isEmpty()){
		query += " AND econRate < " + Integer.parseInt(maxPrice);
	}
	if(takeOffMin != null && !takeOffMin.isEmpty()){
		query += " AND departureTime > '" + takeOffMin + "'";
	}
	if(takeOffMax != null && !takeOffMax.isEmpty()){
		query += " AND departureTime < '" + takeOffMax + "'";
	}
	if(landingMin != null && !landingMin.isEmpty()){
		query += " AND arrivalTime > '" + landingMin + "'";
	}
	if(landingMax != null && !landingMax.isEmpty()){
		query += " AND arrivalTime < '" + landingMax + "'";
	}
	if(!airline.equals("unselected")){
        query += " AND airline = '" + airline + "'";
    }
	
	if(sorting.equals("price")){
		query += " ORDER BY econrate ASC";
		//result = stmt.executeQuery("SELECT * FROM flights WHERE departingAirport=" + "'" + departingAirport + "'" + " AND arrivalAirport=" + "'" + arrivalAirport +"'" + " AND typeFlight=" + "'" + typeFlight + "'" + " ORDER BY econrate ASC");
	} else if (sorting.equals("takeOffTime")){
		query += " ORDER BY departureTime ASC";
		//result = stmt.executeQuery("SELECT * FROM flights WHERE departingAirport=" + "'" + departingAirport + "'" + " AND arrivalAirport=" + "'" + arrivalAirport +"'" + " AND typeFlight=" + "'" + typeFlight + "'" + " ORDER BY departureTime ASC");
	} else if (sorting.equals("landingTime")){
		query += " ORDER BY arrivalTime ASC";
		//result = stmt.executeQuery("SELECT * FROM flights WHERE departingAirport=" + "'" + departingAirport + "'" + " AND arrivalAirport=" + "'" + arrivalAirport +"'" + " AND typeFlight=" + "'" + typeFlight + "'" + " ORDER BY arrivalTime ASC");
	} else if (sorting.equals("flightDuration")){
		query += " ORDER BY duration ASC";
		//result = stmt.executeQuery("SELECT * FROM flights WHERE departingAirport=" + "'" + departingAirport + "'" + " AND arrivalAirport=" + "'" + arrivalAirport +"'" + " AND typeFlight=" + "'" + typeFlight + "'" + " ORDER BY duration ASC");
	} else if (sorting.equals("airline")){
        query += "ORDER BY airline ASC";
    }
	 ResultSet result = stmt.executeQuery(query);
	
	%>
	<table>
		<tr style="border-style:solid; border:1; border-color:black">
			<th style="border-style:solid; border:1; border-color:black">Flight ID</th>
			<th style="border-style:solid; border:1; border-color:black">Aircraft</th>
			<th style="border-style:solid; border:1; border-color:black">Arrival Airport </th>
			<th style="border-style:solid; border:1; border-color:black">Departing Airport </th>
			<th style="border-style:solid; border:1; border-color:black">Arrival Time </th>
			<th style="border-style:solid; border:1; border-color:black">Departure Time</th>
			<th style="border-style:solid; border:1; border-color:black">Type of Flight </th>
			<th style="border-style:solid; border:1; border-color:black">Economic Rate </th>
			<th style="border-style:solid; border:1; border-color:black">Business Rate </th>
			<th style="border-style:solid; border:1; border-color:black">First Class Rate</th>
			<th style="border-style:solid; border:1; border-color:black">Duration </th>
			<th style="border-style:solid; border:1; border-color:black">Airline </th>
		</tr>
	<%
	while(result.next()){
		//out.println("Got here");
        %>
        
			<br>
			
				<tr style="border-style:solid; border:1; border-color:black">
				<td style="border-style:solid; border:1; border-color:black"><%= result.getString("flightId")%></td>
				<td style="border-style:solid; border:1; border-color:black"><%= result.getString("aircraftData")%></td>
				<td style="border-style:solid; border:1; border-color:black"><%= result.getString("arrivalAirport") %> </td>
				<td style="border-style:solid; border:1; border-color:black"><%= result.getString("departingAirport") %> </td>
				<td style="border-style:solid; border:1; border-color:black"><%= result.getTime("arrivalTime") %> </td>
				<td style="border-style:solid; border:1; border-color:black"><%= result.getTime("departureTime") %> </td>
				<td style="border-style:solid; border:1; border-color:black"><%= result.getString("typeFlight") %> </td>
				<td style="border-style:solid; border:1; border-color:black"><%= result.getInt("econRate") %> </td>
				<td style="border-style:solid; border:1; border-color:black"><%= result.getInt("businessRate") %> </td>
				<td style="border-style:solid; border:1; border-color:black"><%= result.getInt("firstRate") %> </td>
				<td style="border-style:solid; border:1; border-color:black"><%= result.getInt("duration") %> </td>
				<td style="border-style:solid; border:1; border-color:black"><%= result.getString("airline") %> </td>
				</tr>
			
		<%
    }
	
	%>
	
	</table> 
	<%
	db.closeConnection(con);
}catch(Exception e){
	out.print(e);
}%>

<form method="post" action="customer.jsp">
<input type="submit" value="Back">
</form>

</body>
</html>