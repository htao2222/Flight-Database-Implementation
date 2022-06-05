    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Results</title>
</head>
<body>

<% 
try{

	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	PreparedStatement stmt=con.prepareStatement("SELECT * FROM questions WHERE question LIKE ? OR answer LIKE ?");
	stmt.setString(1, "%"+request.getParameter("term")+"%");
	stmt.setString(2, "%"+request.getParameter("term")+"%");
	%>
	<table >
	<tr style="border-style:solid; border:1; border-color:black">
		<th style="border-style:solid; border:1; border-color:black">#</th>
		<th style="border-style:solid; border:1; border-color:black">Question</th>
		<th style="border-style:solid; border:1; border-color:black">Answer</th>
	</tr>
	<% 
	ResultSet qnaQuestions = stmt.executeQuery();
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
	
		<form action="customer.jsp" method="post">
	<input type="hidden" value=<%=request.getParameter("username")%> name="username">
	<input type="submit" value="Go back">
	</form>
	
	<% 
	db.closeConnection(con);
}catch(Exception e){
	out.print(e);
}
%>


</body>
</html>