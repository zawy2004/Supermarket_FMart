package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import org.json.JSONObject;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

import config.OAuthConfig;
import dao.UserDAO;
import model.User;

@WebServlet("/User/login-google")
public class LoginGoogleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String code = request.getParameter("code");
        String redirectUri = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() 
                + request.getContextPath() + "/User/login-google";
        
        System.out.println("=== Google OAuth Process ===");
        System.out.println("Redirect URI: " + redirectUri);
        System.out.println("Received code: " + code);

        // Nếu chưa có code, redirect để lấy authorization code
        if (code == null || code.isEmpty()) {
            // Kiểm tra Google OAuth có được config chưa
            if (!OAuthConfig.isGoogleConfigured()) {
                request.setAttribute("errorMessage", 
                    "Google OAuth is not configured properly. Please update CLIENT_ID and CLIENT_SECRET in OAuthConfig.java.");
                request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response);
                return;
            }
            
            String authUrl = OAuthConfig.GOOGLE_AUTH_URL + "?client_id=" + OAuthConfig.GOOGLE_CLIENT_ID 
                    + "&redirect_uri=" + redirectUri 
                    + "&response_type=code"
                    + "&scope=" + OAuthConfig.GOOGLE_SCOPE
                    + "&access_type=offline"
                    + "&prompt=consent";
            System.out.println("Redirecting to: " + authUrl);
            response.sendRedirect(authUrl);
            return;
        }

        try {
            // Bước 1: Lấy access token
            System.out.println("Step 1: Getting access token...");
            String tokenResponse = Request.Post(OAuthConfig.GOOGLE_TOKEN_URL)
                    .bodyForm(Form.form()
                            .add("code", code)
                            .add("client_id", OAuthConfig.GOOGLE_CLIENT_ID)
                            .add("client_secret", OAuthConfig.GOOGLE_CLIENT_SECRET)
                            .add("redirect_uri", redirectUri)
                            .add("grant_type", "authorization_code")
                            .build())
                    .execute().returnContent().asString();

            System.out.println("Token response: " + tokenResponse);
            
            JSONObject tokenJson = new JSONObject(tokenResponse);
            if (!tokenJson.has("access_token")) {
                throw new IOException("Cannot get access_token: " + tokenResponse);
            }
            String accessToken = tokenJson.getString("access_token");
            System.out.println("Access token obtained successfully");

            // Bước 2: Lấy thông tin user từ Google
            System.out.println("Step 2: Getting user info...");
            String userInfoResponse = Request.Get(OAuthConfig.GOOGLE_USER_INFO_URL)
                    .addHeader("Authorization", "Bearer " + accessToken)
                    .execute().returnContent().asString();

            System.out.println("User info response: " + userInfoResponse);
            
            JSONObject userJson = new JSONObject(userInfoResponse);
            if (!userJson.has("email") || !userJson.has("sub")) {
                throw new IOException("Cannot get email or sub: " + userInfoResponse);
            }
            
            String email = userJson.getString("email");
            String fullName = userJson.optString("name", "Google User");
            String googleId = userJson.getString("sub");
            String picture = userJson.optString("picture", null);

            System.out.println("User data - Email: " + email + ", Name: " + fullName + ", GoogleId: " + googleId);

            // Bước 3: Xử lý user trong database
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByEmail(email);
            
            if (user == null) {
                // Tạo user mới
                System.out.println("Creating new user...");
                user = new User();
                user.setEmail(email);
                user.setFullName(fullName);
                user.setUsername(email); // Sử dụng email làm username
                user.setPasswordHash(null); // OAuth user không có password
                user.setAuthProvider("Google");
                user.setExternalID(googleId);
                user.setRoleId(1); // Role Customer
                user.setIsActive(true);
                user.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                user.setProfileImageUrl(picture);
                
                boolean saved = userDAO.save(user);
                if (!saved) {
                    throw new SQLException("Failed to save new Google user");
                }
                System.out.println("New Google user created with ID: " + user.getUserId());
            } else {
                // Update existing user info
                System.out.println("Updating existing user...");
                user.setLastLoginDate(new Timestamp(System.currentTimeMillis()));
                
                // Cập nhật thông tin Google nếu chưa có
                if (user.getAuthProvider() == null || !user.getAuthProvider().equals("Google")) {
                    user.setAuthProvider("Google");
                    user.setExternalID(googleId);
                }
                if (user.getProfileImageUrl() == null && picture != null) {
                    user.setProfileImageUrl(picture);
                }
                
                // Cập nhật tên nếu trống
                if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
                    user.setFullName(fullName);
                }
                
                // Cập nhật user trong database (nếu cần)
                System.out.println("User info updated");
            }

            // Bước 4: Tạo session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userEmail", email);
            session.setAttribute("userFullName", fullName);
            session.setAttribute("loginType", "Google");
            session.setAttribute("userId", user.getUserId()); // Thêm dòng này để đồng bộ với LoginFacebookServlet
            
            System.out.println("Session created successfully");
            System.out.println("=== Google OAuth Success ===");

            // Chuyển hướng về trang chủ
            response.sendRedirect(request.getContextPath() + "/home");

        } catch (IOException e) {
            System.err.println("Google OAuth IOException: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Google login failed: " + e.getMessage());
            request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("Google OAuth SQLException: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error during Google login: " + e.getMessage());
            request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Google OAuth Exception: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unexpected error during Google login: " + e.getMessage());
            request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}