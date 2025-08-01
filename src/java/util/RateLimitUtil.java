package util;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

/**
 * Simple rate limiting utility using sliding window approach
 */
public class RateLimitUtil {
    
    // Rate limit configurations
    private static final int COUPON_REQUESTS_PER_MINUTE = 10;
    private static final long WINDOW_SIZE_MS = 60 * 1000; // 1 minute
    
    // Storage for rate limit data
    private static final ConcurrentHashMap<String, RateLimitData> rateLimitMap = new ConcurrentHashMap<>();
    
    /**
     * Check if request is allowed for coupon operations
     */
    public static boolean isAllowedCouponRequest(String clientId) {
        return isAllowed(clientId, COUPON_REQUESTS_PER_MINUTE);
    }
    
    /**
     * Generic rate limiting check
     */
    private static boolean isAllowed(String clientId, int maxRequests) {
        long currentTime = System.currentTimeMillis();
        
        rateLimitMap.compute(clientId, (key, data) -> {
            if (data == null) {
                data = new RateLimitData();
            }
            
            // Clean old requests outside the window
            if (currentTime - data.windowStart.get() >= WINDOW_SIZE_MS) {
                data.windowStart.set(currentTime);
                data.requestCount.set(0);
            }
            
            return data;
        });
        
        RateLimitData data = rateLimitMap.get(clientId);
        
        // Check if within limit
        if (data.requestCount.get() < maxRequests) {
            data.requestCount.incrementAndGet();
            return true;
        }
        
        return false;
    }
    
    /**
     * Get remaining requests for client
     */
    public static int getRemainingRequests(String clientId, int maxRequests) {
        RateLimitData data = rateLimitMap.get(clientId);
        if (data == null) {
            return maxRequests;
        }
        
        long currentTime = System.currentTimeMillis();
        
        // If window expired, reset
        if (currentTime - data.windowStart.get() >= WINDOW_SIZE_MS) {
            return maxRequests;
        }
        
        return Math.max(0, maxRequests - data.requestCount.get());
    }
    
    /**
     * Get time until window reset (in seconds)
     */
    public static long getTimeUntilReset(String clientId) {
        RateLimitData data = rateLimitMap.get(clientId);
        if (data == null) {
            return 0;
        }
        
        long currentTime = System.currentTimeMillis();
        long windowEnd = data.windowStart.get() + WINDOW_SIZE_MS;
        
        if (currentTime >= windowEnd) {
            return 0;
        }
        
        return (windowEnd - currentTime) / 1000; // Convert to seconds
    }
    
    /**
     * Clear rate limit data for client (for testing or admin purposes)
     */
    public static void clearRateLimit(String clientId) {
        rateLimitMap.remove(clientId);
    }
    
    /**
     * Clean up expired entries (should be called periodically)
     */
    public static void cleanup() {
        long currentTime = System.currentTimeMillis();
        
        rateLimitMap.entrySet().removeIf(entry -> {
            RateLimitData data = entry.getValue();
            return currentTime - data.windowStart.get() >= WINDOW_SIZE_MS * 2; // Keep for 2 windows
        });
    }
    
    /**
     * Get client identifier from request (IP + User ID if available)
     */
    public static String getClientId(String ipAddress, Integer userId) {
        if (userId != null) {
            return "user_" + userId + "_" + ipAddress;
        }
        return "ip_" + ipAddress;
    }
    
    /**
     * Rate limit data holder
     */
    private static class RateLimitData {
        final AtomicLong windowStart = new AtomicLong(System.currentTimeMillis());
        final AtomicInteger requestCount = new AtomicInteger(0);
    }
}
