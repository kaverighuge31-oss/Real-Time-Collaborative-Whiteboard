<%@ page import="java.sql.*" %>
<%@ page import="com.whiteboard.DBConnection" %>

<%
String email = (String) session.getAttribute("email");

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
"UPDATE users SET status='offline' WHERE email=?"
);

ps.setString(1,email);
ps.executeUpdate();

session.invalidate();

response.sendRedirect("login.html");
%>