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
import java.text.SimpleDateFormat;
import java.util.Calendar;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        System.out.println("Initializing RegisterServlet...");
        userDAO = new UserDAO();
        // Test connection
        if (userDAO.testConnection()) {
            System.out.println("UserDAO initialized successfully");
        } else {
            System.err.println("UserDAO initialization failed");
        }
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
        System.out.println("=== Starting Registration Process ===");
        
        try {
            String fullName = request.getParameter("fullname");
            String email = request.getParameter("emailaddress");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String dobStr = request.getParameter("dob");
            String gender = request.getParameter("gender");

            System.out.println("Received parameters:");
            System.out.println("- fullName: " + fullName);
            System.out.println("- email: " + email);
            System.out.println("- phone: " + phone);
            System.out.println("- address: " + address);
            System.out.println("- dob: " + dobStr);
            System.out.println("- gender: " + gender);

            // Kiểm tra các field bắt buộc
            if (fullName == null || email == null || password == null || phone == null ||
                address == null || dobStr == null || gender == null) {
                System.err.println("Missing required fields");
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            // Lấy mã OTP nhập từ client
            String code1 = request.getParameter("code1");
            String code2 = request.getParameter("code2");
            String code3 = request.getParameter("code3");
            String code4 = request.getParameter("code4");

            // Kiểm tra tất cả các field OTP đều không null và không empty
            if (code1 == null || code1.trim().isEmpty() ||
                code2 == null || code2.trim().isEmpty() ||
                code3 == null || code3.trim().isEmpty() ||
                code4 == null || code4.trim().isEmpty()) {
                System.err.println("Incomplete OTP code");
                request.setAttribute("error", "Vui lòng nhập đầy đủ mã OTP 4 số.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            String code = code1.trim() + code2.trim() + code3.trim() + code4.trim();

            // Kiểm tra OTP chỉ chứa số và đúng 4 ký tự
            if (!code.matches("\\d{4}")) {
                System.err.println("Invalid OTP format: " + code);
                request.setAttribute("error", "Mã OTP phải là 4 chữ số.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            // Lấy mã OTP và thời gian tạo từ session
            HttpSession session = request.getSession();
            String verifyCode = (String) session.getAttribute("verifyCode");
            Timestamp codeTime = (Timestamp) session.getAttribute("verifyCodeTime");

            // Debug log
            System.out.println("OTP Verification:");
            System.out.println("- OTP nhập: " + code);
            System.out.println("- OTP session: " + verifyCode);
            System.out.println("- SessionID: " + session.getId());
            System.out.println("- Code time: " + codeTime);

            // KIỂM TRA OTP TRƯỚC KHI TIẾP TỤC
            if (verifyCode == null) {
                System.err.println("OTP not found in session");
                request.setAttribute("error", "Bạn chưa gửi mã xác thực hoặc đã hết hạn, hãy nhấn Gửi lại!");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            if (!verifyCode.equals(code)) {
                System.err.println("OTP mismatch - Expected: " + verifyCode + ", Got: " + code);
                request.setAttribute("error", "Mã xác minh không đúng, hãy kiểm tra lại mã gửi về email.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            if (codeTime != null) {
                long currentTime = System.currentTimeMillis();
                long otpTime = codeTime.getTime();
                long timeDiff = currentTime - otpTime;
                long maxTime = 15 * 60 * 1000; // 15 phút
                
                if (timeDiff > maxTime) {
                    System.err.println("OTP expired - Time diff: " + (timeDiff / 1000) + " seconds");
                    request.setAttribute("error", "Mã xác minh đã hết hạn, hãy nhấn Gửi lại!");
                    forwardToJsp(request, response, "/User/sign_up.jsp");
                    return;
                }
            }

            System.out.println("OTP validation passed successfully");
            
            // Validation các field khác
            if (!ValidationUtil.isValidEmail(email)) {
                System.err.println("Invalid email format: " + email);
                request.setAttribute("error", "Email không hợp lệ.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }
            if (!ValidationUtil.isValidFullName(fullName)) {
                System.err.println("Invalid full name: " + fullName);
                request.setAttribute("error", "Họ tên không hợp lệ (chỉ chứa chữ cái và khoảng trắng).");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }
            if (!ValidationUtil.isValidPhoneNumber(phone)) {
                System.err.println("Invalid phone number: " + phone);
                request.setAttribute("error", "Số điện thoại không hợp lệ (phải bắt đầu bằng 0 và 10 chữ số).");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }
            if (!ValidationUtil.isValidAddress(address)) {
                System.err.println("Invalid address: " + address);
                request.setAttribute("error", "Địa chỉ không hợp lệ (chỉ chứa chữ, số, khoảng trắng).");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }
            if (!ValidationUtil.isValidPassword(password)) {
                System.err.println("Invalid password format");
                request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ và số.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            System.out.println("All validations passed");

            // Kiểm tra ngày sinh - CẢI THIỆN LOGIC
            java.util.Date utilDate;
            try {
                utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(dobStr);
            } catch (Exception e) {
                System.err.println("Invalid date format: " + dobStr);
                request.setAttribute("error", "Định dạng ngày sinh không hợp lệ.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }
            
            Date dateOfBirth = new Date(utilDate.getTime());
            
            // Lấy ngày hiện tại (chỉ ngày, không tính giờ)
            Calendar today = Calendar.getInstance();
            today.set(Calendar.HOUR_OF_DAY, 0);
            today.set(Calendar.MINUTE, 0);
            today.set(Calendar.SECOND, 0);
            today.set(Calendar.MILLISECOND, 0);
            
            Calendar birthCalendar = Calendar.getInstance();
            birthCalendar.setTime(dateOfBirth);
            birthCalendar.set(Calendar.HOUR_OF_DAY, 0);
            birthCalendar.set(Calendar.MINUTE, 0);
            birthCalendar.set(Calendar.SECOND, 0);
            birthCalendar.set(Calendar.MILLISECOND, 0);
            
            // Kiểm tra ngày sinh không được sau ngày hiện tại
            if (birthCalendar.after(today)) {
                System.err.println("Future birth date: " + dateOfBirth + " (Today: " + today.getTime() + ")");
                request.setAttribute("error", "Ngày sinh không được sau ngày hiện tại.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }
            
            // Kiểm tra độ tuổi hợp lý (ví dụ: ít nhất 13 tuổi, không quá 120 tuổi)
            Calendar minAge = Calendar.getInstance();
            minAge.add(Calendar.YEAR, -13);  // 13 tuổi
            
            Calendar maxAge = Calendar.getInstance();
            maxAge.add(Calendar.YEAR, -120); // 120 tuổi
            
            if (birthCalendar.after(minAge)) {
                System.err.println("Age too young: " + dateOfBirth);
                request.setAttribute("error", "Bạn phải ít nhất 13 tuổi để đăng ký.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }
            
            if (birthCalendar.before(maxAge)) {
                System.err.println("Age too old: " + dateOfBirth);
                request.setAttribute("error", "Ngày sinh không hợp lệ.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            if (!gender.equals("Male") && !gender.equals("Female") && !gender.equals("Other")) {
                System.err.println("Invalid gender: " + gender);
                request.setAttribute("error", "Giới tính không hợp lệ (chỉ Male, Female, hoặc Other).");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            // Kiểm tra email đã tồn tại
            System.out.println("Checking if email exists...");
            if (userDAO.existsByEmail(email)) {
                System.err.println("Email already exists: " + email);
                request.setAttribute("error", "Email đã tồn tại.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
                return;
            }

            System.out.println("Email is available");

            // Hash password
            System.out.println("Hashing password...");
            String hashedPassword = PasswordUtil.hashPassword(password);
            System.out.println("Password hashed successfully");

            // Tạo user object
            System.out.println("Creating user object...");
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
            user.setUsername(email);           // Username lấy từ email
            user.setAuthProvider("Local");     // Set AuthProvider
            user.setExternalID(null);          // Set ExternalID

            System.out.println("User object created, attempting to save...");

            // Lưu user vào database
            boolean saveResult = userDAO.save(user);
            System.out.println("Save result: " + saveResult);
            
            if (saveResult) {
                // Xóa OTP khỏi session
                session.removeAttribute("verifyCode");
                session.removeAttribute("verifyCodeTime");
                session.removeAttribute("sendAttempts");
                
                // Lưu user vào session để hiển thị tên trên header
                session.setAttribute("user", user);
                
                System.out.println("User saved successfully with ID: " + user.getUserId());
                
                // Trả về JSON response cho AJAX
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"success\": true, \"message\": \"Đăng ký thành công!\"}");

            } else {
                System.err.println("Failed to save user to database");
                request.setAttribute("error", "Đăng ký thất bại do lỗi database.");
                forwardToJsp(request, response, "/User/sign_up.jsp");
            }

        } catch (Exception e) {
            System.err.println("Registration error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi xử lý đăng ký: " + e.getMessage());
            forwardToJsp(request, response, "/User/sign_up.jsp");
        }
        
        System.out.println("=== Registration Process Completed ===");
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
        System.out.println("Destroying RegisterServlet...");
        if (userDAO != null) {
            userDAO.close();
        }
    }
}