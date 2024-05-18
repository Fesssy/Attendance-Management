package com.imran.attendance;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class logout extends HttpServlet {

    HttpSession session;
    Enumeration en;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        try{
            session = request.getSession(false);
        
            en = session.getAttributeNames();
            while (en.hasMoreElements()) {
                String nextElement = "" + en.nextElement();
                session.removeAttribute(nextElement);
            }
        }catch (Exception e){}finally{
            out.print("<script>window.location.replace('login.html')</script>");
        }
        
    }

}
