<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Airport</title>
</head>
<body>
	
    <% try{

		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String airport = request.getParameter("airportName");
		String action = request.getParameter("command");
		String newAirport= request.getParameter("airportNew");
		
		ResultSet result = stmt.executeQuery("SELECT * FROM airportData WHERE airportData=" + "'" + airport + "'");
		
		if(action.equals("addAirport")){
            if(result.next()){
                %>Can not add airport<br>
				Airport already exists <%
            } else {
                String query2="INSERT INTO airportData(airportData)"
	                + "VALUES (?)";
				PreparedStatement insertAircraft = con.prepareStatement(query2);
				insertAircraft.setString(1,airport);
				insertAircraft.executeUpdate();
				%>Successfully added <%
            }
        } else if(!result.next()){
			%>Can not edit/delete airport<br>
			Airport does not exist  <%
        	
        } else if (action.equals("editAirport")){
            result = stmt.executeQuery("SELECT * FROM airportData WHERE airportData=" + "'" + newAirport + "'");
            if(result.next()){
                %>Can not edit name<br>
				 New name is in use<%
            } else {
                String query2="UPDATE airportData SET airportData=? WHERE airportData=?";
				PreparedStatement insertUser = con.prepareStatement(query2);
				insertUser.setString(1,newAirport);
				insertUser.setString(2,airport);
				insertUser.executeUpdate();
	            %>Successfully edited <%
            }
        } else if (action.equals("deleteAirport")){
            String query2="DELETE FROM airportData WHERE airportData=?";
			PreparedStatement deleteAircraft = con.prepareStatement(query2);
			deleteAircraft.setString(1,airport);
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