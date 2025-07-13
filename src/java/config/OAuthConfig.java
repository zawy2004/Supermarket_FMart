package config;

/**
 * OAuth Configuration class for managing Google and Facebook OAuth settings
 * @author thanh
 */
public class OAuthConfig {
    
    // Google OAuth Configuration
    public static final String GOOGLE_CLIENT_ID = "549548859496-abt5dfb1krnhv8lc1vnblaf92tojn0eh.apps.googleusercontent.com";
    public static final String GOOGLE_CLIENT_SECRET = "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";
    public static final String GOOGLE_AUTH_URL = "https://accounts.google.com/o/oauth2/v2/auth";
    public static final String GOOGLE_TOKEN_URL = "https://oauth2.googleapis.com/token";
    public static final String GOOGLE_USER_INFO_URL = "https://www.googleapis.com/oauth2/v3/userinfo";
    public static final String GOOGLE_SCOPE = "email profile";
    
    // Facebook OAuth Configuration
    public static final String FACEBOOK_CLIENT_ID = "1401431707636221"; // Cập nhật App ID thực
    public static final String FACEBOOK_CLIENT_SECRET = "b07b85e745a0b733ccf5371f1bea3f52"; // Cập nhật App Secret thực
    public static final String FACEBOOK_AUTH_URL = "https://www.facebook.com/v18.0/dialog/oauth";
    public static final String FACEBOOK_TOKEN_URL = "https://graph.facebook.com/v18.0/oauth/access_token";
    public static final String FACEBOOK_USER_INFO_URL = "https://graph.facebook.com/me?fields=id,name,email,picture";
    public static final String FACEBOOK_SCOPE = "email,public_profile";
    
    // Common settings
    public static final String BASE_URL = "http://localhost:8080"; // Thay đổi khi deploy production
    public static final String CONTEXT_PATH = "/Supermarket_FMart"; // Thay đổi theo context path của bạn
    
    /**
     * Get Google redirect URI
     */
    public static String getGoogleRedirectUri() {
        return BASE_URL + CONTEXT_PATH + "/User/login-google";
    }
    
    /**
     * Get Facebook redirect URI
     */
    public static String getFacebookRedirectUri() {
        return BASE_URL + CONTEXT_PATH + "/User/login-facebook";
    }
    
    /**
     * Check if Facebook OAuth is configured
     */
    public static boolean isFacebookConfigured() {
        return FACEBOOK_CLIENT_ID != null && !FACEBOOK_CLIENT_ID.isEmpty() &&
               FACEBOOK_CLIENT_SECRET != null && !FACEBOOK_CLIENT_SECRET.isEmpty();
    }
    
    /**
     * Check if Google OAuth is configured
     */
    public static boolean isGoogleConfigured() {
        return !GOOGLE_CLIENT_ID.isEmpty() && !GOOGLE_CLIENT_SECRET.isEmpty();
    }
}