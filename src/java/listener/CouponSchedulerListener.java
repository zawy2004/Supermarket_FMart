package listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import scheduler.CouponScheduler;
import java.util.logging.Logger;

/**
 * Context listener to start and stop the coupon scheduler
 * when the application starts and stops
 */
@WebListener
public class CouponSchedulerListener implements ServletContextListener {
    
    private static final Logger logger = Logger.getLogger(CouponSchedulerListener.class.getName());
    private CouponScheduler couponScheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        logger.info("Starting Coupon Scheduler...");
        
        try {
            couponScheduler = CouponScheduler.getInstance();
            couponScheduler.startScheduler();
            
            // Store scheduler instance in servlet context for potential manual access
            sce.getServletContext().setAttribute("couponScheduler", couponScheduler);
            
            logger.info("Coupon Scheduler started successfully");
            
        } catch (Exception e) {
            logger.severe("Failed to start Coupon Scheduler: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        logger.info("Stopping Coupon Scheduler...");
        
        try {
            if (couponScheduler != null) {
                couponScheduler.stopScheduler();
            }
            
            // Remove from servlet context
            sce.getServletContext().removeAttribute("couponScheduler");
            
            logger.info("Coupon Scheduler stopped successfully");
            
        } catch (Exception e) {
            logger.severe("Error stopping Coupon Scheduler: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
