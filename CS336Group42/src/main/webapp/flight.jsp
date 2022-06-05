<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.text.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Flight</title>
</head>
<body>

    <% try{

		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		//DateFormat dateFormat = new SimpleDateFormat("hh:mm:ss");
		
		String flight = request.getParameter("flightID");
		
		String newFlight = request.getParameter("flightIDnew");
		String aircraftData = request.getParameter("aircraftData");
		String arrivalAirport = request.getParameter("arrivalAirport");
		String departingAirport = request.getParameter("departingAirport");
		//out.println("Got here");
		String arrivalTime = request.getParameter("arrivalTime");
		String departureTime = request.getParameter("departureTime");
		//out.println("Got here");
		String typeFlight = request.getParameter("typeFlight");
		String econRate = request.getParameter("econRate");
		String businessRate = request.getParameter("businessRate");
		String firstRate = request.getParameter("firstRate");
		String duration = request.getParameter("duration");
		String airline = request.getParameter("airline");
		String arrivalDate = request.getParameter("arrivalDate");
		String departureDate = request.getParameter("departureDate");
		
		//out.println(typeFlight);
		
		String action = request.getParameter("command");
		
		ResultSet result = stmt.executeQuery("SELECT * FROM flights WHERE flightId=" + "'" + flight + "'");
		
		if(flight.isEmpty()){
			%>Empty text field<br>
			No Flight ID <%
		} else if (action.equals("addFlights")){
            if(result.next()){
                %>Can not add Flight<br>
				Flight already exists <%
            } else {
                //String query2="INSERT INTO flights(flightId, aircraftData, arrivalAirport, departingAirport, arrivalTime, departureTime, typeFlight, econRate, businessRate, firstRate, duration, airline)"
	               // + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
                String query2 = "INSERT INTO flights VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement insertAircraft = con.prepareStatement(query2);
				insertAircraft.setInt(1,Integer.parseInt(flight));
				insertAircraft.setString(2,aircraftData);
				insertAircraft.setString(3,arrivalAirport);
				insertAircraft.setString(4,departingAirport);
				insertAircraft.setTime(5,Time.valueOf(arrivalTime));
				insertAircraft.setTime(6,Time.valueOf(departureTime));
				insertAircraft.setString(7,typeFlight);
				insertAircraft.setInt(8,Integer.parseInt(econRate));
				insertAircraft.setInt(9,Integer.parseInt(businessRate));
				insertAircraft.setInt(10,Integer.parseInt(firstRate));
				insertAircraft.setInt(11, Integer.parseInt(duration));
				insertAircraft.setString(12, airline);
				insertAircraft.setString(13,arrivalDate); //arrivalDate
				insertAircraft.setString(14,departureDate); //departureDate
				insertAircraft.executeUpdate();
				
				ResultSet seats = stmt.executeQuery("SELECT econSeats,businessSeats,firstSeats FROM aircraftData a WHERE a.aircraftData='"+aircraftData+"'");
				seats.next();
				int econSeats = seats.getInt("econSeats");
				int businessSeats = seats.getInt("businessSeats");
				int firstSeats = seats.getInt("firstSeats");
				
				String ticketQuery = "INSERT INTO tickets VALUES (?,?,?,?,?,?,?,?)";
				PreparedStatement tickets;
				for(int i=0; i<econSeats; i++){
					tickets = con.prepareStatement(ticketQuery);
					tickets.setString(1, null);
					tickets.setInt(2,Integer.parseInt(flight));
					tickets.setString(3,"economy");
					tickets.setInt(4,i+1);
					tickets.setInt(5,Integer.parseInt(econRate));
					tickets.setString(6,null);
					tickets.setInt(7,(int)(Integer.parseInt(econRate)*1.5));
					tickets.setInt(8,(int)(Integer.parseInt(econRate)*0.5));
					tickets.executeUpdate();
				}
				for(int i=0; i<businessSeats; i++){
					tickets = con.prepareStatement(ticketQuery);
					tickets.setString(1, null);
					tickets.setInt(2,Integer.parseInt(flight));
					tickets.setString(3,"business");
					tickets.setInt(4,i+1);
					tickets.setInt(5,Integer.parseInt(businessRate));
					tickets.setString(6,null);
					tickets.setInt(7,(int)(Integer.parseInt(businessRate)*1.5));
					tickets.setInt(8,(int)(Integer.parseInt(businessRate)*0.5));
					tickets.executeUpdate();
				}
				for(int i=0; i<firstSeats; i++){
					tickets = con.prepareStatement(ticketQuery);
					tickets.setString(1, null);
					tickets.setInt(2,Integer.parseInt(flight));
					tickets.setString(3,"first");
					tickets.setInt(4,i+1);
					tickets.setInt(5,Integer.parseInt(firstRate));
					tickets.setString(6,null);
					tickets.setInt(7,(int)(Integer.parseInt(firstRate)*1.5));
					tickets.setInt(8,(int)(Integer.parseInt(firstRate)*0.5));
					tickets.executeUpdate();
				}
				
				
				
				%>Successfully added <%
            }
        } else if(!result.next()){
        	%>Can not edit/delete flight<br>
			Flight does not exist  <%
        } else if (action.equals("editFlights")){
            result = stmt.executeQuery("SELECT * FROM flights WHERE flightId=" + "'" + newFlight + "'");
            if(result.next()){
                %>Can not edit name<br>
				 New name is in use<%
            } else {
            	
            	String ticketQuery = "SELECT * FROM tickets WHERE flightId='" + flight +"'";
            	
				String query2;
				if(econRate != null && !econRate.isEmpty()){
					query2="UPDATE flights SET econRate=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setInt(1,Integer.parseInt(econRate));
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
					//ResultSet seats = stmt.executeQuery(ticketQuery + " AND class='economy'");
					stmt.executeUpdate("UPDATE tickets SET fare='" + econRate +"' WHERE flightId='"+flight+"' AND class='economy'");
				}
				if(businessRate != null && !businessRate.isEmpty()){
					query2="UPDATE flights SET businessRate=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setInt(1,Integer.parseInt(businessRate));
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
					//ResultSet seats = stmt.executeQuery(ticketQuery + " AND class='business'");
					stmt.executeUpdate("UPDATE tickets SET fare='" + businessRate +"' WHERE flightId='"+flight+"' AND class='business'");
				}
				if(firstRate != null && !firstRate.isEmpty()){
					query2="UPDATE flights SET firstRate=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setInt(1,Integer.parseInt(firstRate));
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
					//ResultSet seats = stmt.executeQuery(ticketQuery + " AND class='first'");
					stmt.executeUpdate("UPDATE tickets SET fare='" + firstRate +"' WHERE flightId='"+flight+"' AND class='first'");
				}
				if(newFlight != null && !newFlight.isEmpty()){
					query2="UPDATE flights SET flightId=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setString(1,newFlight);
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
				}
                if(aircraftData != null && !aircraftData.isEmpty()){
					query2="UPDATE flights SET aircraftData=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setString(1,aircraftData);
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
				}
				if(arrivalTime != null && !arrivalTime.isEmpty()){
					query2="UPDATE flights SET arrivalTime=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					//out.println("Got here");
					insertUser.setTime(1,Time.valueOf(arrivalTime));
					//out.println("Got here");
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
				}
				if(arrivalAirport != null && !arrivalAirport.isEmpty()){
					query2="UPDATE flights SET arrivalAirport=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setString(1,arrivalAirport);
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
				}
				if(departingAirport != null && !departingAirport.isEmpty()){
					query2="UPDATE flights SET departingAirport=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setString(1,departingAirport);
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
				}
				if(departureTime != null && !departureTime.isEmpty()){
					query2="UPDATE flights SET departureTime=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setTime(1,Time.valueOf(departureTime));
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
				}
				if(typeFlight != null && !typeFlight.isEmpty()){
					query2="UPDATE flights SET typeFlight=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setString(1,typeFlight);
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
				}
				
				if(duration != null && !duration.isEmpty()){
					query2="UPDATE flights SET duration=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setInt(1,Integer.parseInt(duration));
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
				}
				if(airline != null && !airline.isEmpty()){
					query2="UPDATE flights SET airline=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setString(1,airline);
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
				}
				if(arrivalDate != null && !arrivalDate.isEmpty()){
					query2="UPDATE flights SET arrivalDate=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setString(1,arrivalDate);
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
				}
				if(departureDate != null && !departureDate.isEmpty()){
					query2="UPDATE flights SET departureDate=? WHERE flightId=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setString(1,departureDate);
					insertUser.setString(2,flight);
					insertUser.executeUpdate();
				}
				
				
				
	            %>Successfully edited <%
            }
        } else if (action.equals("deleteFlights")){
            String query2="DELETE FROM flights WHERE flightId=?";
			PreparedStatement deleteAircraft = con.prepareStatement(query2);
			deleteAircraft.setString(1,flight);
			deleteAircraft.executeUpdate();
			stmt.executeUpdate("DELETE FROM tickets WHERE flightId='"+flight+"'");
	        %>Successfully deleted <%
        }
	
		db.closeConnection(con);
	}catch(Exception e){
		out.print(e);
	}%>


<form method="post" action="customerRep.jsp">
<input type="submit" value="Back">
</form>

</body>
</html>