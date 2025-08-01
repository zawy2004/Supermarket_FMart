package scheduler;

import service.UserCouponService;
import dao.UserDAO;
import model.User;
import java.util.List;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Scheduler for automatic coupon assignments
 * Handles birthday coupons, loyalty rewards, and cleanup tasks
 */
public class CouponScheduler {
    
    private static final Logger logger = Logger.getLogger(CouponScheduler.class.getName());
    private static CouponScheduler instance;
    private ScheduledExecutorService scheduler;
    private UserCouponService userCouponService;
    private UserDAO userDAO;
    
    private CouponScheduler() {
        this.scheduler = Executors.newScheduledThreadPool(2);
        this.userCouponService = new UserCouponService();
        this.userDAO = new UserDAO();
    }
    
    public static synchronized CouponScheduler getInstance() {
        if (instance == null) {
            instance = new CouponScheduler();
        }
        return instance;
    }
    
    /**
     * Start all scheduled tasks
     */
    public void startScheduler() {
        logger.info("Starting CouponScheduler...");
        
        // Schedule birthday coupon check - runs daily at 9 AM
        scheduler.scheduleAtFixedRate(
            this::processBirthdayCoupons,
            getInitialDelayForDailyTask(9), // 9 AM
            TimeUnit.DAYS.toSeconds(1), // Every 24 hours
            TimeUnit.SECONDS
        );
        
        // Schedule expired coupon cleanup - runs weekly on Sunday at 2 AM
        scheduler.scheduleAtFixedRate(
            this::cleanupExpiredCoupons,
            getInitialDelayForWeeklyTask(Calendar.SUNDAY, 2), // Sunday 2 AM
            TimeUnit.DAYS.toSeconds(7), // Every 7 days
            TimeUnit.SECONDS
        );
        
        logger.info("CouponScheduler started successfully");
    }
    
    /**
     * Stop the scheduler
     */
    public void stopScheduler() {
        if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdown();
            try {
                if (!scheduler.awaitTermination(60, TimeUnit.SECONDS)) {
                    scheduler.shutdownNow();
                }
            } catch (InterruptedException e) {
                scheduler.shutdownNow();
                Thread.currentThread().interrupt();
            }
            logger.info("CouponScheduler stopped");
        }
    }
    
    /**
     * Process birthday coupons for users with birthday today
     */
    private void processBirthdayCoupons() {
        logger.info("Processing birthday coupons...");
        
        try {
            List<User> usersWithBirthdayToday = getUsersWithBirthdayToday();
            int assignedCount = 0;
            
            for (User user : usersWithBirthdayToday) {
                // Check if user already has birthday coupon this year
                if (!userCouponService.userHasCoupon(user.getUserId(), "BIRTHDAY20")) {
                    boolean assigned = userCouponService.assignBirthdayCoupon(user.getUserId());
                    if (assigned) {
                        assignedCount++;
                        logger.info("Birthday coupon assigned to user: " + user.getUserId());
                    }
                }
            }
            
            logger.info("Birthday coupon processing completed. Assigned: " + assignedCount + " coupons");
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error processing birthday coupons", e);
        }
    }
    
    /**
     * Clean up expired coupons
     */
    private void cleanupExpiredCoupons() {
        logger.info("Cleaning up expired coupons...");
        
        try {
            int cleanedCount = userCouponService.cleanupExpiredCoupons(30); // Remove coupons expired for 30+ days
            logger.info("Expired coupon cleanup completed. Cleaned: " + cleanedCount + " coupons");
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error cleaning up expired coupons", e);
        }
    }
    
    /**
     * Get users with birthday today
     */
    private List<User> getUsersWithBirthdayToday() {
        // This would need a specific query in UserDAO
        // For now, return empty list as placeholder
        // TODO: Implement getUsersWithBirthdayToday in UserDAO
        return List.of();
    }
    
    /**
     * Calculate initial delay for daily task
     */
    private long getInitialDelayForDailyTask(int targetHour) {
        Calendar now = Calendar.getInstance();
        Calendar target = Calendar.getInstance();
        target.set(Calendar.HOUR_OF_DAY, targetHour);
        target.set(Calendar.MINUTE, 0);
        target.set(Calendar.SECOND, 0);
        target.set(Calendar.MILLISECOND, 0);
        
        // If target time has passed today, schedule for tomorrow
        if (target.before(now)) {
            target.add(Calendar.DAY_OF_MONTH, 1);
        }
        
        return (target.getTimeInMillis() - now.getTimeInMillis()) / 1000;
    }
    
    /**
     * Calculate initial delay for weekly task
     */
    private long getInitialDelayForWeeklyTask(int targetDayOfWeek, int targetHour) {
        Calendar now = Calendar.getInstance();
        Calendar target = Calendar.getInstance();
        target.set(Calendar.DAY_OF_WEEK, targetDayOfWeek);
        target.set(Calendar.HOUR_OF_DAY, targetHour);
        target.set(Calendar.MINUTE, 0);
        target.set(Calendar.SECOND, 0);
        target.set(Calendar.MILLISECOND, 0);
        
        // If target time has passed this week, schedule for next week
        if (target.before(now)) {
            target.add(Calendar.WEEK_OF_YEAR, 1);
        }
        
        return (target.getTimeInMillis() - now.getTimeInMillis()) / 1000;
    }
    
    /**
     * Manual trigger for birthday coupon processing (for testing)
     */
    public void triggerBirthdayCouponProcessing() {
        logger.info("Manually triggering birthday coupon processing...");
        processBirthdayCoupons();
    }
    
    /**
     * Manual trigger for expired coupon cleanup (for testing)
     */
    public void triggerExpiredCouponCleanup() {
        logger.info("Manually triggering expired coupon cleanup...");
        cleanupExpiredCoupons();
    }
}
