
package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CheckLoginServlet", urlPatterns = {"/checkLogin"})
public class CheckLoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("userId") != null;
        
        System.out.println("CheckLoginServlet: loggedIn = " + loggedIn + ", userId = " + (session != null ? session.getAttribute("userId") : "null"));
        
        out.print("{\"loggedIn\": " + loggedIn + "}");
        out.flush();
    }
}
