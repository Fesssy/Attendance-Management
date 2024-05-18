<%-- 
    Document   : markingattendance
    Created on : 03-Oct-2022, 7:44:37 pm
    Author     : alien
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
        if(session.getAttribute("uid")==null){
            %><script>window.location.href="login.html";</script><%
        }%>
        <script>
            window.onload = function(){
                document.getElementById("date").value = "<%= date %>";
                if("<%= now %>" !== "<%= date %>"){
                    document.getElementById("date").value = "<%= request.getParameter("date") %>";
                }
            };
        </script>
    </head>
    <%!
        Connection con;
        Statement stmt, stmt2;
        ResultSet rs, rs2;
        String query;
        //HttpSession session;
        String uid;
        String name;
        String now = java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE);
        String date = now;
        
    %>
    <%
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/attendance", "root", "abc");
        stmt = con.createStatement();
        stmt2 = con.createStatement();
        //session = request.getSession(false);
        
    %>
    <%
        query = "select name, uid from students;";
        rs = stmt.executeQuery(query);
        try{
            date = request.getParameter("date");
            if(date == null){
                date=java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE);
            }
        }catch(Exception e){
            date = java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE);
        }
    %>
    <body>
        <h1>Attendance</h1>
        <table>
            <tr><!-- 1st row -->
                <td> <!-- Form for selecting date -->
                    <form id="chsub" action="showingattendance.jsp" method="post">
                    <label for="date">Date: </label>
                    <input type="date" name="date" id="date"/>
                    <input type="submit" value="Change Date"/>
                    </form>
                </td>
            </tr>
            
            <!-- Iteration to create n rows -->
            <%
                out.print("<tr><td><span id='curdate'></span></td></tr>");
                try{
                while(rs.next()){
                
                    name = rs.getString("name");
                    uid = rs.getString("uid");
                    try{
                    query = "select * from " + uid + " where date=\""+date+"\";";
                    rs2 = stmt2.executeQuery(query);
                    rs2.next();
                    out.print("<tr><th>"+name+" : "+uid+"</th></tr>");
                    out.print("<tr><td><b>Subject</b></td><td></td></tr>");
                    out.print("<tr><td>Python</td><td>" + rs2.getString("sbsd401") + "</td></tr>");
                    out.print("<tr><td>Java</td><td>" + rs2.getString("sbsd402") + "</td></tr>");
                    out.print("<tr><td>C++</td><td>" + rs2.getString("sbsd403") + "</td></tr>");
                    out.print("<tr><td>Maths</td><td>" + rs2.getString("sbsd404") + "</td></tr>");
                    }
                    catch(Exception e){}
            
                }
                }catch(Exception e){
                    out.print(e);
                }
            %>

        </table>
        <center>
            <button onclick="window.location.href='index.jsp'"> Dashboard </button>
        </center>
    </body>
</html>
