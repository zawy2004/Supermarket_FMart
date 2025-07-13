package controller.user;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

@WebServlet("/my-address")
public class UserAddressServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        request.setAttribute("address", user.getAddress());
        request.getRequestDispatcher("/User/dashboard_my_address.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String address = request.getParameter("address");
        String error = null;

        if (address == null || address.trim().isEmpty()) {
            error = "Address cannot be empty.";
        } else if (address.trim().length() < 10) {
            error = "Address must be at least 10 characters.";
        } else if (address.trim().length() > 255) {
            error = "Address cannot exceed 255 characters.";
        }

        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("address", address);
            request.getRequestDispatcher("User/dashboard_my_address.jsp").forward(request, response);
            return;
        }
        
        userDAO.updateAddress(user.getUserId(), address);
        user.setAddress(address);  // cập nhật lại session
        session.setAttribute("user", user);

        request.setAttribute("success", "Address updated successfully.");
        request.setAttribute("address", address);
        request.getRequestDispatcher("User/dashboard_my_address.jsp").forward(request, response);
    }
}