package config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Configuration reader for coupon system
 */
public class CouponConfig {
    
    private static final Logger logger = Logger.getLogger(CouponConfig.class.getName());
    private static Properties properties = new Properties();
    
    static {
        loadProperties();
    }
    
    private static void loadProperties() {
        try (InputStream input = CouponConfig.class.getClassLoader()
                .getResourceAsStream("application.properties")) {
            if (input != null) {
                properties.load(input);
                logger.info("Loaded coupon configuration successfully");
            } else {
                logger.warning("application.properties not found, using default values");
                setDefaultProperties();
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Error loading application.properties", e);
            setDefaultProperties();
        }
    }
    
    private static void setDefaultProperties() {
        // Default coupon codes and expiry days
        properties.setProperty("coupon.default.fmart50k.code", "FMART50K");
        properties.setProperty("coupon.default.fmart50k.expiry_days", "90");
        properties.setProperty("coupon.default.birthday20.code", "BIRTHDAY20");
        properties.setProperty("coupon.default.birthday20.expiry_days", "60");
        properties.setProperty("coupon.default.vip15.code", "VIP15");
        properties.setProperty("coupon.default.vip15.expiry_days", "180");
        properties.setProperty("coupon.default.comeback100k.code", "COMEBACK100K");
        properties.setProperty("coupon.default.comeback100k.expiry_days", "30");
        
        // Security defaults
        properties.setProperty("csrf.token.expiry_minutes", "30");
        properties.setProperty("rate.limit.max_requests", "100");
        properties.setProperty("rate.limit.time_window_minutes", "15");
        
        // Performance defaults
        properties.setProperty("coupon.search.page_size", "20");
        properties.setProperty("coupon.statistics.cache_minutes", "10");
    }
    
    public static String getProperty(String key) {
        return properties.getProperty(key);
    }
    
    public static String getProperty(String key, String defaultValue) {
        return properties.getProperty(key, defaultValue);
    }
    
    public static int getIntProperty(String key, int defaultValue) {
        try {
            String value = properties.getProperty(key);
            return value != null ? Integer.parseInt(value) : defaultValue;
        } catch (NumberFormatException e) {
            logger.warning("Invalid integer value for property " + key + ", using default: " + defaultValue);
            return defaultValue;
        }
    }
    
    public static boolean getBooleanProperty(String key, boolean defaultValue) {
        String value = properties.getProperty(key);
        return value != null ? Boolean.parseBoolean(value) : defaultValue;
    }
    
    // Coupon-specific getters
    public static String getFmart50kCode() {
        return getProperty("coupon.default.fmart50k.code", "FMART50K");
    }
    
    public static int getFmart50kExpiryDays() {
        return getIntProperty("coupon.default.fmart50k.expiry_days", 90);
    }
    
    public static String getBirthday20Code() {
        return getProperty("coupon.default.birthday20.code", "BIRTHDAY20");
    }
    
    public static int getBirthday20ExpiryDays() {
        return getIntProperty("coupon.default.birthday20.expiry_days", 60);
    }
    
    public static String getVip15Code() {
        return getProperty("coupon.default.vip15.code", "VIP15");
    }
    
    public static int getVip15ExpiryDays() {
        return getIntProperty("coupon.default.vip15.expiry_days", 180);
    }
    
    public static String getComeback100kCode() {
        return getProperty("coupon.default.comeback100k.code", "COMEBACK100K");
    }
    
    public static int getComeback100kExpiryDays() {
        return getIntProperty("coupon.default.comeback100k.expiry_days", 30);
    }
    
    // Security getters
    public static int getCsrfTokenExpiryMinutes() {
        return getIntProperty("csrf.token.expiry_minutes", 30);
    }
    
    public static int getRateLimitMaxRequests() {
        return getIntProperty("rate.limit.max_requests", 100);
    }
    
    public static int getRateLimitTimeWindowMinutes() {
        return getIntProperty("rate.limit.time_window_minutes", 15);
    }
    
    // Performance getters
    public static int getCouponSearchPageSize() {
        return getIntProperty("coupon.search.page_size", 20);
    }
    
    public static int getCouponStatisticsCacheMinutes() {
        return getIntProperty("coupon.statistics.cache_minutes", 10);
    }
}
