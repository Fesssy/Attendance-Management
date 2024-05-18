<%-- 
    Document   : index
    Created on : 02-Oct-2022, 7:20:36 pm
    Author     : alien
--%>

<%@page import="java.sql.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        <%
        if(session.getAttribute("uid")==null){
            %><script>window.location.href="login.html";</script><%
        }%>
    </head>
    
    <%!
        Connection con;
        Statement stmt;
        ResultSet rs;
        String query;
        HttpSession session;
        String uid;
        String name;
    %>
    <%
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/attendance", "root", "abc");
        stmt = con.createStatement();
        session = request.getSession(false);
        query = "select * from students where uid=\"" + session.getAttribute("uid") +"\"";
        rs = stmt.executeQuery(query);
        while (rs.next()) {
                name = rs.getString("name");
                session.setAttribute("name", name);
            }
    %>
    <body>
    <center>
        <h1>Dashboard</h1>
        <h2>Welcome, <%=name%></h2>
        <ul>
            <li><a href="markingattendance.jsp">Take attendance</a></li>
            <li><a href="showingattendance.jsp">Show attendance</a></li>
        </ul>
        <br>
        <center>
            <form method="post" action="logout"><input type="submit" value="Log Out" /></form>
        </center>
    </center>
    </body>
</html>
