<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign In Page</title>
</head>
<body>
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			//String str = "SELECT * FROM " + entity;
			//Run the query against the database.
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			if(username.length() <5 ||password.length() <5 ||username.length() >50 ||password.length() >50){
				%>Invalid Username/Password length<br>
				Username and Password should be between 5-50 characters in length <%						
				
			}
			
			else if (entity.equals("login")){				
				String login = "SELECT * FROM users WHERE username=" + "'" + username + "'" +" AND password=" +"'" +password+"'";
				
				ResultSet result = stmt.executeQuery(login);
				
				if (!result.next()){
					%>Login Failed<%
				}
				else {
                    %>Hello
	<%= username %>!<%
            		if(result.getInt("level")== 2){
            			%><br>You are an Admin!
            			
            			<form method="post" action="admin.jsp"> 
            			<!-- <input type="hidden" name="username" value=<%//request.getParameter("username");%>> -->
            			<input type="submit" value="Admin Powers">
            			</form>
            			
            			<%
            		}
            		else if(result.getInt("level")==1){
            			%><br> You are a Customer Rep!
                    	
                    	<form method="post" action="customerRep.jsp"> 
            			<!-- <input type="hidden" name="username" value=<%//request.getParameter("username");%>> -->
            			<input type="submit" value="Rep Powers">
            			</form><%
                    }
            		else{
            			%> 
            			<form method="post" action="customer.jsp">
            			<input type="hidden" name="username" value=<%=username%>>
            			<input type="submit" value="Use the website">
            			</form>
            			<% 
            		}//end customer
                }
			}
			else if (entity.equals("register")){				
				String register = "SELECT * FROM users WHERE username=" + "'" + username + "'";
				ResultSet result = stmt.executeQuery(register);
				//System.out.println(result.toString());
				if(result.next()){
					%>Username already in use!<%
				}
				else{					
					String query="INSERT INTO users(username, password, level)"
			                + "VALUES (?, ?, ?)";
					PreparedStatement insertUser = con.prepareStatement(query);
					insertUser.setString(1,username);
					insertUser.setString(2,password);
					insertUser.setInt(3,0);
					insertUser.executeUpdate();
					%>Welcome
					<%= username %>!<br> Log back in to start using the site.<%
				}
				
			}
			//ResultSet result = stmt.executeQuery();
		%>
	<% 
			//close the connection.
			db.closeConnection(con);
			%>


	<%} catch (Exception e) {
			out.print(e);
		}%>
<form method="post" action="WelcomePage.jsp">
<input type="submit" value="Logout">
</form>

</body>
</html>