package controller.user;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;
import util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;

// <editor-fold defaultstate="collapsed" desc="Register Servlet">
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
    }

    /**
     * Xử lý yêu cầu POST từ form đăng ký.
     * Lấy dữ liệu, validate, tạo đối tượng User, và lưu vào database.
     *
     * @param request  đối tượng HttpServletRequest chứa dữ liệu từ client
     * @param response đối tượng HttpServletResponse để trả về kết quả
     * @throws ServletException nếu có lỗi servlet
     * @throws IOException      nếu có lỗi I/O
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy dữ liệu từ form
            String username = request.getParameter("username");
            String fullName = request.getParameter("fullname");
            String email = request.getParameter("emailaddress");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String dobStr = request.getParameter("dob");
            String gender = request.getParameter("gender");

            // Kiểm tra null
            if (username == null || fullName == null || email == null || password == null || phone == null ||
                address == null || dobStr == null || gender == null) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                return;
            }

            // Ghép mã xác minh
            String code = request.getParameter("code1") + request.getParameter("code2") +
                          request.getParameter("code3") + request.getParameter("code4");

            // Kiểm tra mã xác minh
            HttpSession session = request.getSession();
            String verifyCode = (String) session.getAttribute("verifyCode");
            if (verifyCode == null || !verifyCode.equals(code)) {
                request.setAttribute("error", "Mã xác minh không hợp lệ.");
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                return;
            }

            // Kiểm tra hợp lệ ban đầu
            if (!ValidationUtil.isValidEmail(email)) {
                request.setAttribute("error", "Email không hợp lệ.");
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                return;
            }
            if (!ValidationUtil.isValidUsername(username)) {
                request.setAttribute("error", "Tên người dùng không hợp lệ (tối đa 10 ký tự, chỉ chữ/số/_).");
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                return;
            }
            if (!ValidationUtil.isValidFullName(fullName)) {
                request.setAttribute("error", "Họ tên không hợp lệ (chỉ chứa chữ cái và khoảng trắng).");
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                return;
            }
            if (!ValidationUtil.isValidPhoneNumber(phone)) {
                request.setAttribute("error", "Số điện thoại không hợp lệ (phải bắt đầu bằng 0 và 10 chữ số).");
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                return;
            }
            if (!ValidationUtil.isValidAddress(address)) {
                request.setAttribute("error", "Địa chỉ không hợp lệ (chỉ chứa chữ, số, khoảng trắng).");
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                return;
            }

            // Xử lý ngày sinh
            Date dateOfBirth = null;
            if (dobStr == null || dobStr.trim().isEmpty()) {
                request.setAttribute("error", "Ngày sinh không được để trống.");
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                return;
            }
            try {
                dateOfBirth = Date.valueOf(dobStr); // Chuyển đổi sang Date
                java.util.Date today = new java.util.Date();
                if (dateOfBirth.after(today)) {
                    request.setAttribute("error", "Ngày sinh không được trong tương lai.");
                    request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                    return;
                }
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Ngày sinh không hợp lệ (định dạng phải là yyyy-MM-dd): " + e.getMessage());
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                return;
            }

            // Validate gender
            if (gender != null && !gender.trim().isEmpty() && !gender.equals("Male") && !gender.equals("Female") && !gender.equals("Other")) {
                request.setAttribute("error", "Giới tính không hợp lệ (chỉ Male, Female, hoặc Other).");
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                return;
            }

            // Mã hóa mật khẩu
            String hashedPassword;
            try {
                hashedPassword = PasswordUtil.hashPassword(password);
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Mật khẩu không hợp lệ: " + e.getMessage());
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                return;
            }

            // Tạo và validate đối tượng User
            User user = new User();
            try {
                user.setUsername(username);
                user.setFullName(fullName);
                user.setEmail(email);
                user.setPasswordHash(hashedPassword);
                user.setPhoneNumber(phone);
                user.setAddress(address);
                user.setDateOfBirth(dateOfBirth);
                user.setGender(gender);
                user.setRoleID(2); // ROLE_USER
                user.setIsActive(true);
                user.setCreatedDate(new Timestamp(System.currentTimeMillis()));
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Dữ liệu không hợp lệ: " + e.getMessage());
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                return;
            }

            // Kiểm tra email tồn tại
            if (userDAO.existsByEmail(email)) {
                request.setAttribute("error", "Email đã tồn tại.");
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
                return;
            }

            // Lưu vào DB
            boolean success = userDAO.save(user);
            if (success) {
                session.removeAttribute("verifyCode"); // Xóa mã xác minh sau khi đăng ký thành công
                response.sendRedirect("sign_in.jsp?success=true");
            } else {
                request.setAttribute("error", "Đăng ký thất bại do lỗi database hoặc dữ liệu không hợp lệ.");
                request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
            }
        } catch (ServletException e) {
            request.setAttribute("error", "Lỗi servlet khi xử lý đăng ký: " + e.getMessage());
            request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
        } catch (IOException e) {
            request.setAttribute("error", "Lỗi I/O khi xử lý đăng ký: " + e.getMessage());
            request.getRequestDispatcher("/sign_up.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    // </editor-fold>
}