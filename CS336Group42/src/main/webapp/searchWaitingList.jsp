    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Waiting List</title>
</head>
<body>

    <% try{

		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement(); 
		
		String flightID = request.getParameter("flightID");
		ResultSet result = stmt.executeQuery("SELECT * FROM waitinglist WHERE flightId ='" + flightID +"'");
		%><table>
		<tr style="border-style:solid; border:1; border-color:black">
		<th style="border-style:solid; border:1; border-color:black">Waiting List:</th>
		</tr><%
		while(result.next()){%>
            <tr style="border-style:solid; border:1; border-color:black">
				<td style="border-style:solid; border:1; border-color:black"><%= result.getString("username")%></td>
			</tr>
        <% } %>
        </table><%
		
		
		
		
			db.closeConnection(con);  
		
	}catch(Exception e){
		out.print(e);
		} %>

  <form method="post" action="customerRep.jsp">
<input type="submit" value="Back">
</form>

</body>
</html>