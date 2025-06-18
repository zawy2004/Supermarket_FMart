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
import java.sql.Timestamp;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        System.out.println("Initializing LoginServlet...");
        userDAO = new UserDAO();
        if (userDAO.testConnection()) {
            System.out.println("UserDAO initialized successfully");
        } else {
            System.err.println("UserDAO initialization failed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra có thông báo success từ reset password không
        HttpSession session = request.getSession();
        String loginSuccessMessage = (String) session.getAttribute("loginSuccessMessage");
        if (loginSuccessMessage != null) {
            request.setAttribute("successMessage", loginSuccessMessage);
            session.removeAttribute("loginSuccessMessage");
        }
        
        // Kiểm tra có Remember Me cookie không
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("rememberedEmail".equals(cookie.getName())) {
                    request.setAttribute("rememberedEmail", cookie.getValue());
                    break;
                }
            }
        }
        
        // Chuyển hướng đến trang đăng nhập
        RequestDispatcher dispatcher = request.getRequestDispatcher("/User/sign_in.jsp");
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "sign_in.jsp not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("=== Login Process Started ===");
        
        try {
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            boolean rememberMe = "on".equals(request.getParameter("remember_me"));

            System.out.println("Login attempt - Email: " + email + ", Phone: " + phone + ", RememberMe: " + rememberMe);

            // Validation cơ bản
            if ((email == null || email.trim().isEmpty()) && (phone == null || phone.trim().isEmpty())) {
                request.setAttribute("errorMessage", "Vui lòng nhập email hoặc số điện thoại.");
                forwardToLogin(request, response);
                return;
            }

            if (password == null || password.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng nhập mật khẩu.");
                forwardToLogin(request, response);
                return;
            }

            // Xác định login bằng email hay phone
            String loginIdentifier = null;
            if (email != null && !email.trim().isEmpty()) {
                if (!ValidationUtil.isValidEmail(email)) {
                    request.setAttribute("errorMessage", "Email không hợp lệ.");
                    forwardToLogin(request, response);
                    return;
                }
                loginIdentifier = email.trim();
            } else if (phone != null && !phone.trim().isEmpty()) {
                if (!ValidationUtil.isValidPhoneNumber(phone)) {
                    request.setAttribute("errorMessage", "Số điện thoại không hợp lệ.");
                    forwardToLogin(request, response);
                    return;
                }
                loginIdentifier = phone.trim();
                // Nếu login bằng phone, cần tìm user bằng phone number
                User userByPhone = getUserByPhone(phone.trim());
                if (userByPhone != null) {
                    loginIdentifier = userByPhone.getEmail(); // Chuyển về email để dùng trong getUserByEmail
                }
            }

            if (loginIdentifier == null) {
                request.setAttribute("errorMessage", "Không thể xác định thông tin đăng nhập.");
                forwardToLogin(request, response);
                return;
            }

            // Tìm user trong database
            User user = userDAO.getUserByEmail(loginIdentifier);
            if (user == null) {
                System.out.println("User not found: " + loginIdentifier);
                request.setAttribute("errorMessage", "Tài khoản không tồn tại.");
                
                // Thêm gợi ý forgot password nếu user không tồn tại
                request.setAttribute("showForgotPassword", true);
                forwardToLogin(request, response);
                return;
            }

            // Kiểm tra tài khoản có bị khóa không
            if (!user.isActive()) {
                System.out.println("User account is inactive: " + loginIdentifier);
                request.setAttribute("errorMessage", "Tài khoản đã bị khóa. Vui lòng liên hệ admin.");
                forwardToLogin(request, response);
                return;
            }

            // Kiểm tra xem có phải tài khoản OAuth không
            if (user.getPasswordHash() == null) {
                String provider = user.getAuthProvider() != null ? user.getAuthProvider() : "social media";
                System.out.println("User trying to login with password but account is OAuth: " + loginIdentifier);
                request.setAttribute("errorMessage", "Tài khoản này được tạo bằng " + provider + ". Vui lòng đăng nhập bằng " + provider + ".");
                forwardToLogin(request, response);
                return;
            }

            // Xác minh mật khẩu
            if (!PasswordUtil.verifyPassword(password, user.getPasswordHash())) {
                System.out.println("Password verification failed for: " + loginIdentifier);
                request.setAttribute("errorMessage", "Mật khẩu không đúng.");
                
                // Thêm gợi ý forgot password nếu sai mật khẩu
                request.setAttribute("showForgotPassword", true);
                request.setAttribute("suggestedEmail", user.getEmail()); // Để pre-fill vào form forgot password
                
                forwardToLogin(request, response);
                return;
            }

            System.out.println("Login successful for user: " + user.getEmail());

            // Tạo session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userFullName", user.getFullName());
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("loginType", "Local");

            // Cập nhật last login date
            user.setLastLoginDate(new Timestamp(System.currentTimeMillis()));
            // Có thể thêm method updateLastLogin trong UserDAO nếu cần

            // Xử lý Remember Me
            if (rememberMe) {
                // Tạo cookie cho Remember Me (7 ngày)
                Cookie emailCookie = new Cookie("rememberedEmail", user.getEmail());
                emailCookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
                emailCookie.setPath("/");
                emailCookie.setHttpOnly(true);
                response.addCookie(emailCookie);
                System.out.println("Remember Me cookie set for: " + user.getEmail());
            } else {
                // Xóa Remember Me cookie nếu user không chọn remember
                Cookie emailCookie = new Cookie("rememberedEmail", "");
                emailCookie.setMaxAge(0);
                emailCookie.setPath("/");
                response.addCookie(emailCookie);
            }

            // Xóa các session liên quan đến forgot password (nếu có)
            clearForgotPasswordSession(session);

            System.out.println("=== Login Process Completed Successfully ===");

            // Kiểm tra có redirect URL không (từ filter authentication)
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                session.removeAttribute("redirectAfterLogin");
                response.sendRedirect(redirectUrl);
            } else {
                // Chuyển hướng về trang chủ
                response.sendRedirect(request.getContextPath() + "/home");
            }

        } catch (Exception e) {
            System.err.println("Login error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            forwardToLogin(request, response);
        }
    }

    private User getUserByPhone(String phoneNumber) {
        // Method để tìm user bằng số điện thoại
        // Cần implement trong UserDAO hoặc tạo method mới
        try {
            // Tạm thời return null, bạn có thể implement sau
            // return userDAO.getUserByPhone(phoneNumber);
            return null;
        } catch (Exception e) {
            System.err.println("Error getting user by phone: " + e.getMessage());
            return null;
        }
    }

    private void clearForgotPasswordSession(HttpSession session) {
        // Xóa tất cả thông tin liên quan đến forgot password
        session.removeAttribute("resetToken");
        session.removeAttribute("resetTokenTime");
        session.removeAttribute("resetEmail");
        session.removeAttribute("resetAttempts");
        session.removeAttribute("resetFirstAttemptTime");
        session.removeAttribute("resendAttempts");
        session.removeAttribute("codeVerified");
        session.removeAttribute("verifyCode");
        session.removeAttribute("verifyCodeTime");
        session.removeAttribute("sendAttempts");
    }

    private void forwardToLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("User/sign_in.jsp");
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "sign_in.jsp not found");
        }
    }

    @Override
    public void destroy() {
        System.out.println("Destroying LoginServlet...");
        if (userDAO != null) {
            userDAO.close();
        }
    }
}