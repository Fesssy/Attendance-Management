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
                const date = new Date();
                document.getElementById("curdate").innerHTML = date.toDateString();
                
                if("<%=sub%>" !== "sbsd401"){
                    document.getElementById("subject").value="<%=request.getParameter("subject")%>";
                }
            };
        </script>
        <script>
            var query="";
            function pr_func(roll){
                var query_tmp = "update " + roll + " set " + document.getElementById("subject").value + "=\"P\" where date=curdate();";
                query = query + query_tmp;
            }
            function ab_func(roll){
                var query_tmp = "update " + roll + " set " + document.getElementById("subject").value + "=\"A\" where date=curdate();";
                query = query + query_tmp;
            }
            function exe(){
                document.getElementById("query").value=query;
                document.getElementById("enter").submit();
            }
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
        String sub = "sbsd401";
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
            sub = request.getParameter("subject");
            if(sub == null){
                sub="sbsd401";
            }
        }catch(Exception e){
            sub = "sbsd401";
        }
    %>
    <body>
        <h1>Taking Attendance</h1>
        <h2>Today's Date: <span id="curdate">Date</span></h2>
        <h3>Subject Code: <span><%= sub %></span></h3>
        <table>
            <tr><!-- 1st row -->
                <td> <!-- Form for selecting subjects -->
                    <form id="chsub" action="markingattendance.jsp" method="post">
                    <label for="subject">Subject: </label>
                    <select id="subject" name="subject">
                        <option value="sbsd401" selected>Python</option>
                        <option value="sbsd402">Java</option>
                        <option value="sbsd403">C++</option>
                        <option value="sbsd404">Math</option>
                    </select>
                    <input type="submit" value="Change Subject"/>
                    </form>
                </td>
            </tr>
            <tr><!-- 2nd row - header -->
                <th>Name</th><th>UID</th><th></th><th></th>
            </tr>
            <!-- Iteration to create n rows -->
            <%
                try{
                while(rs.next()){
                    name = rs.getString("name");
                    uid = rs.getString("uid");
                    query = "select " + sub + " from " + uid + " where date=curdate();";
                    rs2 = stmt2.executeQuery(query);
                    rs2.next();
                    String att = rs2.getString(sub);
            %>
                    <tr>
                        <td><%=name.toUpperCase()%></td>
                        <td><%=uid.toUpperCase()%></td>
            <%
                            if (att != null) {
            %>
                                <td colspan="2" style="padding-left: 20px;"><%= att %></td>
            <%
                            }
                            else{
            %>
                                <td style="padding-left: 20px;"><button onclick="pr_func('<%=uid%>')">Present</button></td>
                                <td style="padding-left: 20px;"><button onclick="ab_func('<%=uid%>')">Absent</button></td>
            <%
                            }
            %>   
                    </tr>
            <%
                }
                }catch(Exception e){
                    out.print(e);
                }
            %>
            <!-- Last row - Button to redirect to java servlet to run queries -->
            <tr><td colspan="4"><button id="done" onclick="exe()">Done</button></td></tr>
        </table>
        <!-- hidden form to pass queries -->
        <form id="enter" action="takeattendance" method="post">
            <input type="text" name="query" id="query" hidden>
            <input type="submit" hidden>
        </form>
        <center>
            <button onclick="window.location.href='index.jsp'"> Dashboard </button>
        </center>
    </body>
</html>
