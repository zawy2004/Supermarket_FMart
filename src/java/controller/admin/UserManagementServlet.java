/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author gia huy
 */
@WebServlet(name = "UserManagementServlet", urlPatterns = {"/UserManagementServlet"})
public class UserManagementServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                listUsers(request, response);
            } else {
                switch (action) {
                    case "view" ->
                        viewUser(request, response);
                    case "edit" ->
                        showEditForm(request, response);
                    case "delete" ->
                        deleteUser(request, response);
                    default ->
                        listUsers(request, response);
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                updateUser(request, response);
            } else {
                response.sendRedirect("UserManagementServlet");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int page = 1;
        int pageSize = 5;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int offset = (page - 1) * pageSize;

        String keyword = request.getParameter("keyword");
        String roleIDStr = request.getParameter("roleID");

        Integer roleID = (roleIDStr != null && !roleIDStr.isEmpty()) ? Integer.parseInt(roleIDStr) : null;

        List<User> users = userDAO.searchUsers(keyword, roleID, offset, pageSize);
        int totalUsers = userDAO.countSearchUsers(keyword, roleID);
        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

        request.setAttribute("userList", users);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("roleID", roleIDStr); // để giữ trạng thái dropdown

        request.getRequestDispatcher("/Admin/customers.jsp").forward(request, response);
    }

    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.getUserById(id);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/Admin/customer_view.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.getUserById(id);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/Admin/customer_edit.jsp").forward(request, response);
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        // Lấy dữ liệu từ form
        int id = Integer.parseInt(request.getParameter("id"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dateOfBirth");
        Date dateOfBirth = null;

        if (dobStr != null && !dobStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // hoặc "dd/MM/yyyy" nếu bạn dùng định dạng khác
                Date parsedDate = sdf.parse(dobStr);
                dateOfBirth = new java.sql.Date(parsedDate.getTime());
            } catch (Exception e) {
                System.err.println("Lỗi định dạng ngày sinh: " + e.getMessage());
                dateOfBirth = null;
            }
        }

        String roleIdStr = request.getParameter("roleID");

        // Chuyển đổi ngày sinh
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate = sdf.parse(dobStr);
            dateOfBirth = new java.sql.Date(parsedDate.getTime());
        } catch (Exception e) {
            e.printStackTrace();
            dateOfBirth = null;
        }

        // Chuyển đổi Role ID
        int roleID = (roleIdStr != null && !roleIdStr.isEmpty()) ? Integer.parseInt(roleIdStr) : 1;

        // Tạo User object
        User user = new User();
        user.setUserId(id);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhoneNumber(phone);
        user.setAddress(address);
        user.setGender(gender);
        user.setDateOfBirth((java.sql.Date) dateOfBirth);
        user.setRoleId(roleID);
        user.setIsActive(true); // Có thể thay bằng request.getParameter("isActive") nếu dùng checkbox

        // Gọi DAO để cập nhật
        boolean success = userDAO.updateUser(user);

        if (success) {
            response.sendRedirect("UserManagementServlet"); // Trở lại danh sách người dùng
        } else {
            request.setAttribute("error", "Cập nhật thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("/Admin/customer_edit.jsp").forward(request, response);
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = userDAO.deleteUser(id);

        if (success) {
            response.sendRedirect("UserManagementServlet");
        } else {
            request.setAttribute("error", "Xoá người dùng thất bại!");
            listUsers(request, response); // hiển thị lại danh sách kèm thông báo
        }
    }

}
