<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Aircraft</title>
</head>
<body>
    
	
	<% try{

		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String aircraft = request.getParameter("aircraftName");
		String action = request.getParameter("command");
		String newAircraft= request.getParameter("aircraftNew");
		String econSeats = request.getParameter("econSeats");
		String businessSeats = request.getParameter("businessSeats");
		String firstSeats = request.getParameter("firstClass");
		ResultSet result = stmt.executeQuery("SELECT * FROM aircraftData WHERE aircraftData=" + "'" + aircraft + "'");
		
		if(action.equals("addAircrafts")){
            if(result.next()){
                %>Can not add aircraft<br>
				Aircraft already exists <%
            } else {
                String query2="INSERT INTO aircraftData(aircraftData, econSeats, businessSeats, firstClass)"
	                + "VALUES (?,?,?,?)";
				PreparedStatement insertAircraft = con.prepareStatement(query2);
				try{
					insertAircraft.setString(1,aircraft);
					insertAircraft.setInt(2,Integer.parseInt(econSeats));
					insertAircraft.setInt(3,Integer.parseInt(businessSeats));
					insertAircraft.setInt(4,Integer.parseInt(firstSeats));
					insertAircraft.executeUpdate();
					%>Successfully added<%
				} catch(Exception e){
					%>Error: Could not add <%
				}
				
            }
        } else if(!result.next()){
        	%>Can not edit/delete aircraft<br>
			Aircraft does not exist  <%
        } else if (action.equals("editAircrafts")){
			if(newAircraft != null){
				result = stmt.executeQuery("SELECT * FROM aircraftData WHERE aircraftData=" + "'" + newAircraft + "'");
				if(result.next()){
	                %>Can not edit name<br>
					 New name is in use<%
	            } else {
	                String query2="UPDATE aircraftData SET aircraftData=? WHERE aircraftData=?";
					PreparedStatement insertUser = con.prepareStatement(query2);
					insertUser.setString(1,newAircraft);
					insertUser.setString(2,aircraft);
					insertUser.executeUpdate();
	            }
			}
			if(econSeats != null){
				String query2="UPDATE aircraftData SET econSeats=? WHERE aircraftData=?";
				PreparedStatement insertUser = con.prepareStatement(query2);
				insertUser.setString(1,econSeats);
				insertUser.setString(2,aircraft);
				insertUser.executeUpdate();
			}
			if(businessSeats != null){
				String query2="UPDATE aircraftData SET businessSeats=? WHERE aircraftData=?";
				PreparedStatement insertUser = con.prepareStatement(query2);
				insertUser.setString(1,businessSeats);
				insertUser.setString(2,aircraft);
				insertUser.executeUpdate();
			}
			if(firstSeats != null){
				String query2="UPDATE aircraftData SET firstClass=? WHERE aircraftData=?";
				PreparedStatement insertUser = con.prepareStatement(query2);
				insertUser.setString(1,firstSeats);
				insertUser.setString(2,aircraft);
				insertUser.executeUpdate();
			}
            
            %>Successfully edited <%
        } else if (action.equals("deleteAircrafts")){
            String query2="DELETE FROM aircraftData WHERE aircraftData=?";
			PreparedStatement deleteAircraft = con.prepareStatement(query2);
			deleteAircraft.setString(1,aircraft);
			deleteAircraft.executeUpdate();
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