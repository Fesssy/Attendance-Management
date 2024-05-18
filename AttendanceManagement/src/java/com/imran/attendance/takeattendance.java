package com.imran.attendance;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class takeattendance extends HttpServlet {
    
    Connection con;
    Statement stmt;
    ResultSet rs;
    String query;
    HttpSession session;
    PrintWriter out;
    
    public takeattendance() throws SQLException, ClassNotFoundException{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/attendance", "root", "abc");
        stmt = con.createStatement();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        query = request.getParameter("query");
        out=response.getWriter();
        
        String[] queries = query.split("[;]");
        for (String myquery: queries){
            try{
                int result = stmt.executeUpdate(myquery);
            }catch(Exception e){
                out.print("Unsuccessfull");
                out.print("Exception Occured :- " + e);
            }
        }
        out.print("<script>window.location.href='markingattendance.jsp'</script>");
        
    }

}
