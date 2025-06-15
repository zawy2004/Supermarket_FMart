package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletContext;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import org.json.JSONObject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import config.DatabaseConfig;

@WebServlet("/User/login-facebook")
public class LoginFacebookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String AUTH_URL = "https://www.facebook.com/v20.0/dialog/oauth";
    private static final String TOKEN_URL = "https://graph.facebook.com/v20.0/oauth/access_token";
    private static final String USER_INFO_URL = "https://graph.facebook.com/me?fields=id,name,email";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ServletContext context = getServletContext();
        String code = request.getParameter("code");
        String clientId = context.getInitParameter("facebook.clientId");
        String clientSecret = context.getInitParameter("facebook.clientSecret");
        String redirectUri = "http://localhost:8080/Supermarket_FMart/User/login-facebook"; // Đảm bảo khớp với cấu hình OAuth

        System.out.println("Generated Redirect URI: " + redirectUri); // Log URI được tạo
        System.out.println("Received code: " + code); // Log mã code từ request
        System.out.println("Client ID: " + clientId); // Log Client ID
        System.out.println("Client Secret: " + clientSecret); // Log Client Secret

        if (code == null || code.isEmpty()) {
            String authUrl = AUTH_URL + "?client_id=" + clientId 
                    + "&redirect_uri=" + redirectUri 
                    + "&scope=email,public_profile"
                    + "&response_type=code";
            System.out.println("Redirecting to Auth URL: " + authUrl); // Log URL xác thực
            response.sendRedirect(authUrl);
            return;
        }

        try {
            // Log dữ liệu gửi đi để lấy access token
            System.out.println("Sending request to TOKEN_URL with: " + Form.form()
                    .add("code", code)
                    .add("client_id", clientId)
                    .add("client_secret", clientSecret)
                    .add("redirect_uri", redirectUri)
                    .add("grant_type", "authorization_code")
                    .build());

            // Lấy access token
            String tokenResponse = Request.Post(TOKEN_URL)
                    .bodyForm(Form.form()
                            .add("code", code)
                            .add("client_id", clientId)
                            .add("client_secret", clientSecret)
                            .add("redirect_uri", redirectUri)
                            .add("grant_type", "authorization_code")
                            .build())
                    .execute().returnContent().asString();

            System.out.println("Token Response: " + tokenResponse); // Log phản hồi token

            JSONObject tokenJson = new JSONObject(tokenResponse);
            if (!tokenJson.has("access_token")) {
                System.out.println("Token Response Error: " + tokenResponse); // Log lỗi chi tiết
                throw new IOException("Không tìm thấy access_token: " + tokenResponse);
            }
            String accessToken = tokenJson.getString("access_token");
            System.out.println("Access Token: " + accessToken); // Log access token

            // Lấy thông tin người dùng
            String userInfoResponse = Request.Get(USER_INFO_URL)
                    .addHeader("Authorization", "Bearer " + accessToken)
                    .execute().returnContent().asString();

            System.out.println("User Info Response: " + userInfoResponse); // Log phản hồi thông tin người dùng

            JSONObject userJson = new JSONObject(userInfoResponse);
            if (!userJson.has("email") || !userJson.has("id")) {
                System.out.println("User Info Response Error: " + userInfoResponse); // Log lỗi chi tiết
                throw new IOException("Không tìm thấy email hoặc id: " + userInfoResponse);
            }
            String email = userJson.getString("email");
            String fullName = userJson.optString("name", "Unknown");
            String facebookId = userJson.getString("id");

            System.out.println("User Data - Email: " + email + ", FullName: " + fullName + ", FacebookId: " + facebookId); // Log dữ liệu người dùng

            // Kiểm tra và lưu vào cơ sở dữ liệu
            try (Connection conn = DatabaseConfig.getConnection()) {
                System.out.println("Database connection established successfully."); // Log kết nối DB
                PreparedStatement checkStmt = conn.prepareStatement("SELECT UserID FROM Users WHERE Email = ?");
                checkStmt.setString(1, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (!rs.next()) {
                        // Thử các giá trị LoginType khác nhau
                        String[] loginTypeOptions = {"External", "Social", null}; // Thử nghiệm các giá trị
                        boolean inserted = false;
                        for (String loginType : loginTypeOptions) {
                            try (PreparedStatement insertStmt = conn.prepareStatement(
                                    "INSERT INTO Users (Email, PasswordHash, LoginType, FullName, RoleID, IsActive) VALUES (?, ?, ?, ?, 1, 1)")) {
                                insertStmt.setString(1, email);
                                insertStmt.setNull(2, java.sql.Types.VARCHAR); // PasswordHash NULL
                                if (loginType != null) {
                                    insertStmt.setString(3, loginType); // Sử dụng giá trị không null
                                } else {
                                    insertStmt.setNull(3, java.sql.Types.VARCHAR); // Sử dụng null
                                }
                                insertStmt.setString(4, fullName);
                                insertStmt.executeUpdate();
                                System.out.println("New user inserted with LoginType: " + (loginType != null ? loginType : "null")); // Log khi thêm người dùng mới
                                inserted = true;
                                break; // Thoát nếu thành công
                            } catch (SQLException e) {
                                System.out.println("Failed with LoginType " + (loginType != null ? loginType : "null") + ": " + e.getMessage()); // Log lỗi
                            }
                        }
                        if (!inserted) {
                            throw new SQLException("No valid LoginType found for insertion.");
                        }
                    } else {
                        System.out.println("User already exists: " + email); // Log khi người dùng đã tồn tại
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace(); // In stack trace chi tiết
                System.out.println("SQLException: " + e.getMessage()); // Log lỗi SQL
                request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu: " + e.getMessage());
                request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response);
                return;
            }

            // Lưu thông tin vào session và chuyển hướng
            session.setAttribute("userEmail", email);
            session.setAttribute("userFullName", fullName);
            System.out.println("Session set - userEmail: " + email + ", userFullName: " + fullName); // Log session
            response.sendRedirect(request.getContextPath() + "/User/index.jsp"); // Chuyển hướng đúng

        } catch (IOException e) {
            e.printStackTrace(); // In stack trace chi tiết
            System.out.println("IOException: " + e.getMessage()); // Log lỗi IOException
            request.setAttribute("errorMessage", "Đăng nhập Facebook thất bại: " + e.getMessage());
            request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}