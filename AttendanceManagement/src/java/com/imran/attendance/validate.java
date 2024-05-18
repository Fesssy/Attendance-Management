
package com.imran.attendance;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class validate extends HttpServlet{
    
    Connection con;
    Statement stmt;
    ResultSet rs;
    String query;
    HttpSession session;
    PrintWriter out;
    

    public validate() throws SQLException, ClassNotFoundException{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/attendance", "root", "abc");
        stmt = con.createStatement();
    }
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        out = response.getWriter();
        session = request.getSession();
        
        String uid = request.getParameter("uid");
        String password = request.getParameter("password");
        
        query = "select * from students where (uid=\'" + uid + "\' AND password=\'" + password + "\');";
        int result = 0;
        try {
            rs = stmt.executeQuery(query);
            while(rs.next()){
            result ++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(enter.class.getName()).log(Level.SEVERE, null, ex);
        }catch(Exception e){
            out.print(e);
        }
        
        if (result==1){
            session.setAttribute("uid", uid);
            out.print("<script>window.location.replace(\"index.jsp\")</script>");
        }
        else{
            out.print("<script>window.location.replace(\"login.html\")</script>");
        }
        
        
        
    }

}
