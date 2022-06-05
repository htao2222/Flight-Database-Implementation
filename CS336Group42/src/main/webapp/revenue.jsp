<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Revenue</title>
</head>
<body>
    <% 
    try{
    	ApplicationDB db = new ApplicationDB();	
    	Connection con = db.getConnection();
    	
    	Statement stmt=con.createStatement();
    	ResultSet revenue;
    	
    	if(request.getParameter("operation").equals("customer")){
    	
    	revenue=stmt.executeQuery("SELECT username,SUM(fare+bookingFee) fees FROM tickets WHERE username IS NOT NULL GROUP BY username ORDER BY username ASC");
    	%>
    	<table>
    		<tr>
    			<th>
    			Username
    			</th>
    			<th>
    			Fees
    			</th>
    		</tr>
    		<% while(revenue.next()){%>
    		<tr>
    			<td>
    			<%=revenue.getString("username") %>
    			</td>
    			<td>
    			<%=revenue.getInt("fees") %>
    			</td>
    		</tr>
    	</table>
    	<%}
    	}
    	else if(request.getParameter("operation").equals("airline")){
        	
        	revenue=stmt.executeQuery("SELECT f.airline airline,SUM(t.fare+t.bookingFee) fees FROM tickets t,flights f WHERE f.flightId=t.flightId AND username IS NOT NULL GROUP BY airline ORDER BY airline ASC");
        	%>
        	<table>
        		<tr>
        			<th>
        			Airline
        			</th>
        			<th>
        			Fees
        			</th>
        		</tr>
        		<% while(revenue.next()){%>
        		<tr>
        			<td>
        			<%=revenue.getString("airline") %>
        			</td>
        			<td>
        			<%=revenue.getInt("fees") %>
        			</td>
        		</tr>
        	</table>
        	<%}
        	}
    	else if(request.getParameter("operation").equals("flight")){
        	
        	revenue=stmt.executeQuery("SELECT flightId fid,SUM(fare+bookingFee) fees FROM tickets WHERE username<>'' GROUP BY fid ORDER BY fid ASC");
        	%>
        	<table>
        		<tr>
        			<th>
        			FlightID
        			</th>
        			<th>
        			Fees
        			</th>
        		</tr>
        		<% while(revenue.next()){%>
        		<tr>
        			<td>
        			<%=revenue.getString("fid") %>
        			</td>
        			<td>
        			<%=revenue.getInt("fees") %>
        			</td>
        		</tr>
        	</table>
        	<%}
        	}

    	
    	
    	db.closeConnection(con);
    }catch(Exception e){
    	out.print(e);
    }
    %>
</body>
</html>
