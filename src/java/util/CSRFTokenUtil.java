package util;

import config.CouponConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Logger;

/**
 * CSRF Token utility for security
 */
public class CSRFTokenUtil {

    private static final Logger logger = Logger.getLogger(CSRFTokenUtil.class.getName());
    private static final String CSRF_TOKEN_ATTR = "csrfToken";
    private static final String CSRF_TOKEN_TIME_ATTR = "csrfTokenTime";
    private static final SecureRandom secureRandom = new SecureRandom();

    // Cache for token validation (in production, use Redis or database)
    private static final ConcurrentHashMap<String, Long> tokenCache = new ConcurrentHashMap<>();
    
    /**
     * Generate a new CSRF token and store it in session
     */
    public static String generateToken(HttpSession session) {
        byte[] tokenBytes = new byte[TOKEN_LENGTH];
        secureRandom.nextBytes(tokenBytes);
        String token = Base64.getUrlEncoder().withoutPadding().encodeToString(tokenBytes);
        
        session.setAttribute(CSRF_TOKEN_SESSION_KEY, token);
        return token;
    }
    
    /**
     * Get existing CSRF token from session, or generate new one if not exists
     */
    public static String getToken(HttpSession session) {
        String token = (String) session.getAttribute(CSRF_TOKEN_SESSION_KEY);
        if (token == null) {
            token = generateToken(session);
        }
        return token;
    }
    
    /**
     * Validate CSRF token
     */
    public static boolean validateToken(HttpSession session, String submittedToken) {
        if (submittedToken == null || submittedToken.trim().isEmpty()) {
            return false;
        }
        
        String sessionToken = (String) session.getAttribute(CSRF_TOKEN_SESSION_KEY);
        if (sessionToken == null) {
            return false;
        }
        
        // Use constant-time comparison to prevent timing attacks
        return constantTimeEquals(sessionToken, submittedToken.trim());
    }
    
    /**
     * Constant-time string comparison to prevent timing attacks
     */
    private static boolean constantTimeEquals(String a, String b) {
        if (a.length() != b.length()) {
            return false;
        }
        
        int result = 0;
        for (int i = 0; i < a.length(); i++) {
            result |= a.charAt(i) ^ b.charAt(i);
        }
        
        return result == 0;
    }
    
    /**
     * Remove CSRF token from session (for logout)
     */
    public static void removeToken(HttpSession session) {
        session.removeAttribute(CSRF_TOKEN_SESSION_KEY);
    }

    /**
     * Validate CSRF token from request (new method for enhanced security)
     */
    public static boolean validateToken(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }

        String requestToken = request.getParameter("csrfToken");
        if (requestToken == null) {
            requestToken = request.getHeader("X-CSRF-Token");
        }

        return validateToken(session, requestToken);
    }
}
