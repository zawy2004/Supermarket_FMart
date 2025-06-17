package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.http.client.fluent.Request;
import org.json.JSONObject;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

import dao.UserDAO;
import model.User;

@WebServlet("/User/login-facebook")
public class LoginFacebookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String AUTH_URL = "https://www.facebook.com/v18.0/dialog/oauth";
    private static final String TOKEN_URL = "https://graph.facebook.com/v18.0/oauth/access_token";
    private static final String USER_INFO_URL = "https://graph.facebook.com/me?fields=id,name,email,picture";
    
    // THÔNG TIN APP FACEBOOK - ĐÃ CẬP NHẬT
    private static final String CLIENT_ID = "632448446522489"; // Facebook App ID
    private static final String CLIENT_SECRET = "836d6a17118dd20a7763450ba4635a91"; // Facebook App Secret

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String code = request.getParameter("code");
        String error = request.getParameter("error");
        String errorDescription = request.getParameter("error_description");
        
        // Tạo redirect URI động
        String redirectUri = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() 
                + request.getContextPath() + "/User/login-facebook";
        
        System.out.println("=== Facebook OAuth Process ===");
        System.out.println("Redirect URI: " + redirectUri);
        System.out.println("Received code: " + code);
        System.out.println("Error parameter: " + error);
        System.out.println("Error description: " + errorDescription);

        // Kiểm tra nếu user từ chối quyền
        if (error != null) {
            System.out.println("Facebook OAuth error: " + error);
            String errorMsg = "Facebook login failed";
            if ("access_denied".equals(error)) {
                errorMsg = "Facebook login was cancelled by user.";
            } else if (errorDescription != null) {
                errorMsg = "Facebook error: " + errorDescription;
            }
            request.setAttribute("errorMessage", errorMsg);
            request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response);
            return;
        }

        // Nếu chưa có code, redirect để lấy authorization code
        if (code == null || code.isEmpty()) {
            // Kiểm tra App ID có phải placeholder không
            if ("YOUR_FACEBOOK_APP_ID".equals(CLIENT_ID) || "632448446522489".equals(CLIENT_ID)) {
                request.setAttribute("errorMessage", 
                    "Facebook App is not configured properly. Please update CLIENT_ID and CLIENT_SECRET in LoginFacebookServlet.java with real Facebook App credentials.");
                request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response);
                return;
            }
            
            String state = String.valueOf(System.currentTimeMillis()); // CSRF protection
            String authUrl = AUTH_URL 
                    + "?client_id=" + CLIENT_ID 
                    + "&redirect_uri=" + java.net.URLEncoder.encode(redirectUri, "UTF-8")
                    + "&scope=" + java.net.URLEncoder.encode("email,public_profile", "UTF-8")
                    + "&response_type=code"
                    + "&state=" + state;
            
            System.out.println("Redirecting to Facebook: " + authUrl);
            response.sendRedirect(authUrl);
            return;
        }

        // Kiểm tra App credentials một lần nữa (chỉ kiểm tra placeholder)
        if ("YOUR_FACEBOOK_APP_ID".equals(CLIENT_ID) || "YOUR_FACEBOOK_APP_SECRET".equals(CLIENT_SECRET)
            || "632448446522489".equals(CLIENT_ID) || "836d6a17118dd20a7763450ba4635a91".equals(CLIENT_SECRET)) {
            request.setAttribute("errorMessage", 
                "Facebook App credentials are not configured. Please set real CLIENT_ID and CLIENT_SECRET from your Facebook App.");
            request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response);
            return;
        }

        try {
            // Bước 1: Lấy access token
            System.out.println("Step 1: Getting access token...");
            String tokenRequestUrl = TOKEN_URL 
                    + "?client_id=" + CLIENT_ID 
                    + "&redirect_uri=" + java.net.URLEncoder.encode(redirectUri, "UTF-8")
                    + "&client_secret=" + CLIENT_SECRET 
                    + "&code=" + code;
            
            System.out.println("Token request URL: " + tokenRequestUrl.replace(CLIENT_SECRET, "***SECRET***"));
            
            String tokenResponse = Request.Get(tokenRequestUrl)
                    .connectTimeout(10000)
                    .socketTimeout(10000)
                    .execute().returnContent().asString();

            System.out.println("Token response: " + tokenResponse);
            
            // Xử lý response từ Facebook
            String accessToken = null;
            if (tokenResponse.contains("access_token")) {
                if (tokenResponse.startsWith("{")) {
                    // JSON response
                    JSONObject tokenJson = new JSONObject(tokenResponse);
                    if (tokenJson.has("error")) {
                        JSONObject errorObj = tokenJson.getJSONObject("error");
                        String errorType = errorObj.optString("type", "unknown");
                        String errorMessage = errorObj.optString("message", "Unknown Facebook error");
                        throw new IOException("Facebook token error [" + errorType + "]: " + errorMessage);
                    }
                    accessToken = tokenJson.getString("access_token");
                } else {
                    // Query string response (legacy)
                    String[] params = tokenResponse.split("&");
                    for (String param : params) {
                        if (param.startsWith("access_token=")) {
                            accessToken = param.substring("access_token=".length());
                            break;
                        }
                    }
                }
            }
            
            if (accessToken == null || accessToken.isEmpty()) {
                throw new IOException("Cannot extract access_token from Facebook response: " + tokenResponse);
            }
            System.out.println("Access token obtained successfully");

            // Bước 2: Lấy thông tin user từ Facebook
            System.out.println("Step 2: Getting user info...");
            String userInfoUrl = USER_INFO_URL + "&access_token=" + accessToken;
            String userInfoResponse = Request.Get(userInfoUrl)
                    .connectTimeout(10000)
                    .socketTimeout(10000)
                    .execute().returnContent().asString();

            System.out.println("User info response: " + userInfoResponse);
            
            JSONObject userJson = new JSONObject(userInfoResponse);
            if (userJson.has("error")) {
                JSONObject errorObj = userJson.getJSONObject("error");
                String errorMessage = errorObj.optString("message", "Cannot get user info");
                throw new IOException("Facebook user info error: " + errorMessage);
            }
            
            // Kiểm tra các field bắt buộc
            if (!userJson.has("id")) {
                throw new IOException("Facebook did not provide user ID");
            }
            if (!userJson.has("email")) {
                throw new IOException("Facebook did not provide email. Please make sure you granted email permission.");
            }
            
            String email = userJson.getString("email");
            String fullName = userJson.optString("name", "Facebook User");
            String facebookId = userJson.getString("id");
            String picture = null;
            
            // Lấy URL ảnh đại diện
            if (userJson.has("picture") && userJson.getJSONObject("picture").has("data")) {
                JSONObject pictureData = userJson.getJSONObject("picture").getJSONObject("data");
                if (!pictureData.optBoolean("is_silhouette", true)) {
                    picture = pictureData.optString("url", null);
                }
            }

            System.out.println("Facebook user data - Email: " + email + ", Name: " + fullName + ", ID: " + facebookId);

            // Bước 3: Xử lý user trong database
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByEmail(email);
            
            if (user == null) {
                // Tạo user mới
                System.out.println("Creating new Facebook user...");
                user = new User();
                user.setEmail(email);
                user.setFullName(fullName);
                user.setUsername(email); // Sử dụng email làm username
                user.setPasswordHash(null); // OAuth user không có password
                user.setAuthProvider("Facebook");
                user.setExternalID(facebookId);
                user.setRoleId(1); // Role Customer
                user.setIsActive(true);
                user.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                user.setLastLoginDate(new Timestamp(System.currentTimeMillis()));
                if (picture != null) {
                    user.setProfileImageUrl(picture);
                }
                
                boolean saved = userDAO.save(user);
                if (!saved) {
                    throw new SQLException("Failed to save new Facebook user to database");
                }
                System.out.println("New Facebook user created with ID: " + user.getUserId());
            } else {
                // Update existing user info
                System.out.println("Updating existing user with Facebook data...");
                user.setLastLoginDate(new Timestamp(System.currentTimeMillis()));
                
                // Cập nhật thông tin Facebook nếu chưa có hoặc khác
                if (user.getAuthProvider() == null || !user.getAuthProvider().equals("Facebook")) {
                    user.setAuthProvider("Facebook");
                }
                if (user.getExternalID() == null || !user.getExternalID().equals(facebookId)) {
                    user.setExternalID(facebookId);
                }
                if (user.getProfileImageUrl() == null && picture != null) {
                    user.setProfileImageUrl(picture);
                }
                
                // Cập nhật tên nếu trống
                if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
                    user.setFullName(fullName);
                }
                
                System.out.println("User info updated");
            }

            // Bước 4: Tạo session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userEmail", email);
            session.setAttribute("userFullName", fullName);
            session.setAttribute("loginType", "Facebook");
            session.setAttribute("userId", user.getUserId());
            
            System.out.println("Session created successfully for user: " + email);
            System.out.println("=== Facebook OAuth Success ===");

            // Chuyển hướng về trang chủ
            response.sendRedirect(request.getContextPath() + "/home");

        } catch (IOException e) {
            System.err.println("Facebook OAuth IOException: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Facebook login connection failed: " + e.getMessage());
            request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("Facebook OAuth SQLException: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error during Facebook login. Please try again.");
            request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Facebook OAuth Exception: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unexpected error during Facebook login. Please try again.");
            request.getRequestDispatcher("/User/sign_in.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}