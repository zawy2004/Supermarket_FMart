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

@WebServlet("/User/login-google")
public class LoginGoogleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String AUTH_URL = "https://accounts.google.com/o/oauth2/v2/auth";
    private static final String TOKEN_URL = "https://oauth2.googleapis.com/token";
    private static final String USER_INFO_URL = "https://www.googleapis.com/oauth2/v3/userinfo";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ServletContext context = getServletContext();
        String code = request.getParameter("code");
        String clientId = context.getInitParameter("google.clientId");
        String clientSecret = context.getInitParameter("google.clientSecret");
        String redirectUri = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() 
                + request.getContextPath() + "/User/login-google"; // Đảm bảo khớp với JSP
        System.out.println("Generated Redirect URI: " + redirectUri); // Thêm log

        if (code == null || code.isEmpty()) {
            String authUrl = AUTH_URL + "?client_id=" + clientId 
                    + "&redirect_uri=" + redirectUri 
                    + "&response_type=code"
                    + "&scope=email profile"
                    + "&access_type=offline"
                    + "&prompt=consent";
            response.sendRedirect(authUrl);
            return;
        }

        try {
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

            JSONObject tokenJson = new JSONObject(tokenResponse);
            if (!tokenJson.has("access_token")) {
                System.out.println("Token Response Error: " + tokenResponse); // Log lỗi chi tiết
                throw new IOException("Không tìm thấy access_token: " + tokenResponse);
            }
            String accessToken = tokenJson.getString("access_token");

            // Lấy thông tin người dùng
            String userInfoResponse = Request.Get(USER_INFO_URL)
                    .addHeader("Authorization", "Bearer " + accessToken)
                    .execute().returnContent().asString();

            JSONObject userJson = new JSONObject(userInfoResponse);
            if (!userJson.has("email") || !userJson.has("sub")) {
                System.out.println("User Info Response Error: " + userInfoResponse); // Log lỗi chi tiết
                throw new IOException("Không tìm thấy email hoặc sub: " + userInfoResponse);
            }
            String email = userJson.getString("email");
            String fullName = userJson.optString("name", "Unknown");
            String googleId = userJson.getString("sub");

            // Kiểm tra và lưu vào cơ sở dữ liệu
            try (Connection conn = DatabaseConfig.getConnection();
                 PreparedStatement checkStmt = conn.prepareStatement("SELECT UserID FROM Users WHERE Email = ?")) {
                checkStmt.setString(1, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (!rs.next()) {
                        try (PreparedStatement insertStmt = conn.prepareStatement(
                                "INSERT INTO Users (Email, PasswordHash, LoginType, FullName, RoleID, IsActive) VALUES (?, ?, ?, ?, 1, 1)")) {
                            insertStmt.setString(1, email); // Sử dụng Email thay Username
                            insertStmt.setNull(2, java.sql.Types.VARCHAR); // PasswordHash NULL cho Google
                            insertStmt.setString(3, "Google"); // Thêm LoginType
                            insertStmt.setString(4, fullName);
                            insertStmt.executeUpdate();
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace(); // In stack trace chi tiết
                request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu: " + e.getMessage());
                request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response); // Sửa đường dẫn
                return;
            }

            // Lưu thông tin vào session và chuyển hướng
            session.setAttribute("userEmail", email);
            session.setAttribute("userFullName", fullName);
            response.sendRedirect(request.getContextPath() + "/User/index.jsp"); // Chuyển hướng đúng

        } catch (IOException e) {
            e.printStackTrace(); // In stack trace chi tiết
            request.setAttribute("errorMessage", "Đăng nhập Google thất bại: " + e.getMessage());
            request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response); // Sửa đường dẫn
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}