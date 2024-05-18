
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


public class enterholiday extends HttpServlet{
    
    Connection con;
    Statement stmt;
    ResultSet rs;
    String query;

    public enterholiday() throws SQLException, ClassNotFoundException{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/attendance", "root", "abc");
        stmt = con.createStatement();
    }
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        
        String name = request.getParameter("name");
        String date = request.getParameter("date");
        
        query = "insert into holiday values(\"" + date + "\", \"" + name + "\");";
        
        int result = -1;
        
        try {
            result = stmt.executeUpdate(query);
        } catch (SQLException ex) {
            Logger.getLogger(enter.class.getName()).log(Level.SEVERE, null, ex);
        }catch(Exception e){
            out.print(e);
        }
        
        if (result==1){
            System.out.println("Inserted!");
        }
        
        out.print("<script>window.location.replace(\"registerholiday.html\")</script>");
        
    }

}
