package controller.user;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;
import util.ValidationUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;

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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/User/sign_up.jsp");
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "sign_up.jsp not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String fullName = request.getParameter("fullname");
            String email = request.getParameter("emailaddress");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String dobStr = request.getParameter("dob");
            String gender = request.getParameter("gender");

            if (fullName == null || email == null || password == null || phone == null ||
                address == null || dobStr == null || gender == null) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            String code = request.getParameter("code1") + request.getParameter("code2") +
                          request.getParameter("code3") + request.getParameter("code4");
            HttpSession session = request.getSession();
            String verifyCode = (String) session.getAttribute("verifyCode");
            if (verifyCode == null || !verifyCode.equals(code)) {
                request.setAttribute("error", "Mã xác minh không hợp lệ hoặc đã hết hạn.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            if (!ValidationUtil.isValidEmail(email)) {
                request.setAttribute("error", "Email không hợp lệ.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }
            if (!ValidationUtil.isValidFullName(fullName)) {
                request.setAttribute("error", "Họ tên không hợp lệ (chỉ chứa chữ cái và khoảng trắng).");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }
            if (!ValidationUtil.isValidPhoneNumber(phone)) {
                request.setAttribute("error", "Số điện thoại không hợp lệ (phải bắt đầu bằng 0 và 10 chữ số).");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }
            if (!ValidationUtil.isValidAddress(address)) {
                request.setAttribute("error", "Địa chỉ không hợp lệ (chỉ chứa chữ, số, khoảng trắng).");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }
            if (!ValidationUtil.isValidPassword(password)) {
                request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ và số.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            Date dateOfBirth = Date.valueOf(dobStr.replaceFirst("(\\d{2})/(\\d{2})/(\\d{4})", "$3-$1-$2"));
            java.util.Date today = new java.util.Date();
            if (dateOfBirth.after(today)) {
                request.setAttribute("error", "Ngày sinh không được trong tương lai.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            if (!gender.equals("Male") && !gender.equals("Female") && !gender.equals("Other")) {
                request.setAttribute("error", "Giới tính không hợp lệ (chỉ Male, Female, hoặc Other).");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            String hashedPassword = PasswordUtil.hashPassword(password);

            User user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPasswordHash(hashedPassword);
            user.setPhoneNumber(phone);
            user.setAddress(address);
            user.setDateOfBirth(dateOfBirth);
            user.setGender(gender);
            user.setRoleId(1); // Customer
            user.setIsActive(true);
            user.setCreatedDate(new Timestamp(System.currentTimeMillis()));
            user.setLoginType("Email");  // Thêm dòng này để gán giá trị cho LoginType

            if (userDAO.existsByEmail(email)) {
                request.setAttribute("error", "Email đã tồn tại.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            if (userDAO.save(user)) {
    session.removeAttribute("verifyCode");
    session.setAttribute("user", user);
    // Sử dụng đường dẫn tuyệt đối để kiểm tra
    response.sendRedirect("/User/index.jsp");
} else {
    request.setAttribute("error", "Đăng ký thất bại do lỗi database.");
    forwardToJsp(request, response, "/User/sign_up.jsp");
}


        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi xử lý đăng ký: " + e.getMessage());
            forwardToJsp(request, response, "/User/sign_up.jsp");
            e.printStackTrace();
        }
    }

    private void forwardToJsp(HttpServletRequest request, HttpServletResponse response, String jspPath)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(jspPath);
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, jspPath + " not found");
        }
    }

    @Override
    public void destroy() {
        if (userDAO != null) {
            userDAO.close();
        }
    }
}