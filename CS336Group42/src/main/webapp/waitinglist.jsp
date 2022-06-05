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
    <% 
    try{
    	ApplicationDB db = new ApplicationDB();	
    	Connection con = db.getConnection();
    	Statement stmt = con.createStatement();

        String username = request.getParameter("username");
        int fid = Integer.parseInt(request.getParameter("fid"));
        String classType = request.getParameter("class");
        
        ResultSet onList = stmt.executeQuery("SELECT * FROM waitinglist WHERE username='"+username+"' AND flightId = "+fid+" AND class = '"+classType+"'");
        
        if(!onList.next()){
        PreparedStatement putOnWait = con.prepareStatement("INSERT INTO waitinglist VALUES (?,?,?)");
        putOnWait.setString(1, username);
        putOnWait.setInt(2,fid);
        putOnWait.setString(3,classType);
        putOnWait.executeUpdate();
        %>Added to list.
        <% 
        }
        else{
        	%>You already are waiting for <%=classType %> class seats for flight # <%=fid %>.<% 
        }
    	db.closeConnection(con);
    }catch(Exception e){
    	out.print(e);
    }
    %>
</body>
</html>
