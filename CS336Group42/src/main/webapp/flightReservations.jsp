<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Flight Reservations</title>
</head>
<body>

<% try{

		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String action = request.getParameter("command");
		String username = request.getParameter("username");
		String flightID = request.getParameter("flightID");
		String passengerClass = request.getParameter("class");
		String seatNumber = request.getParameter("seatNumber");
		String fare = request.getParameter("fare");
		String date = request.getParameter("dateOfPurchase");
		
		String ticket = request.getParameter("ticket");
		String keys[] = ticket.split("/");
		
		ResultSet result = stmt.executeQuery("SELECT * FROM tickets WHERE flightId=" + "'" + flightID + "' AND class='" + passengerClass + "' AND seatNum='" + seatNumber +"'");
		
		 if (action.equals("addReservation")){
			if(result.next()){
                %>Can not add Reservation<br>
				Reservation already exists <%
			} else {
				String query2="INSERT INTO tickets(username, flightId, class, seatNum, fare, datePurchase)"
				 + "VALUES (?,?,?,?,?,?)";
				
				try{
               
					PreparedStatement insertAircraft = con.prepareStatement(query2);
					insertAircraft.setString(1,username);
					insertAircraft.setString(2,flightID);
					insertAircraft.setString(3,passengerClass);
					insertAircraft.setInt(4,Integer.parseInt(seatNumber));
					insertAircraft.setInt(5,Integer.parseInt(fare));
					insertAircraft.setString(6,date);
					
					insertAircraft.executeUpdate();
					%>Successfully added <%
				} catch(Exception e){
					out.print("Error: Invalid input");
				}
			}
			
		} else if (result.next()){
			%>Can not change this<br>
			A reservation already exists for these values<%
		} else if (action.equals("editReservation")){
			
			result = stmt.executeQuery("SELECT * FROM tickets WHERE flightId=" + "'" + keys[0] + "' AND class= '" +keys[1]+"' AND seatNum= '"+keys[2]+"'");
            if(!result.next()){
                %>Error<br>
				 Error<%
            } else {
            	String query2;
            	if(username != null && !username.isEmpty()){
					query2="UPDATE tickets SET username=? WHERE flightId=" + "'" + keys[0] + "' AND class= '" +keys[1]+"' AND seatNum= '"+keys[2]+"'";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setString(1,username);
					insertUser.executeUpdate();
				}
            	if(flightID != null && !flightID.isEmpty()){
					query2="UPDATE tickets SET flightId=? WHERE flightId=" + "'" + keys[0] + "' AND class= '" +keys[1]+"' AND seatNum= '"+keys[2]+"'";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setString(1,flightID);
					insertUser.executeUpdate();
				}
            	if(passengerClass != null && !passengerClass.isEmpty()){
					query2="UPDATE tickets SET class=? WHERE flightId=" + "'" + keys[0] + "' AND class= '" +keys[1]+"' AND seatNum= '"+keys[2]+"'";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setString(1,passengerClass);
					insertUser.executeUpdate();
				}
            	if(seatNumber != null && !seatNumber.isEmpty()){
					query2="UPDATE tickets SET seatNum=? WHERE flightId=" + "'" + keys[0] + "' AND class= '" +keys[1]+"' AND seatNum= '"+keys[2]+"'";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setInt(1,Integer.parseInt(seatNumber));
					insertUser.executeUpdate();
				}
            	if(fare != null && !fare.isEmpty()){
					query2="UPDATE tickets SET fare=? WHERE flightId=" + "'" + keys[0] + "' AND class= '" +keys[1]+"' AND seatNum= '"+keys[2]+"'";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setInt(1,Integer.parseInt(fare));
					insertUser.executeUpdate();
				}
            	if(date != null && !date.isEmpty()){
					query2="UPDATE tickets SET datePurchase=? WHERE flightId=" + "'" + keys[0] + "' AND class= '" +keys[1]+"' AND seatNum= '"+keys[2]+"'";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setString(1,date);;
					insertUser.executeUpdate();
				}
            	%>Successfully edited <%
            }
            
			
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