package service;

import dao.UserDAO;
import model.User;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Service class for User operations
 * Handles business logic for user management and coupon integration
 */
public class UserService {

    private static final Logger logger = Logger.getLogger(UserService.class.getName());
    private UserDAO userDAO = new UserDAO();
    private UserCouponService userCouponService = new UserCouponService();

    /**
     * Create new user with automatic welcome coupon assignment
     */
    public boolean createUserWithWelcomeCoupon(User user) {
        try {
            // Save user first
            boolean userSaved = userDAO.save(user);

            if (userSaved) {
                // Get the user ID (assuming it's set after save)
                User savedUser = userDAO.findByEmail(user.getEmail());
                if (savedUser != null) {
                    // Auto-assign welcome coupon
                    userCouponService.autoAssignCoupons(savedUser.getUserId(), "registration");
                    logger.info("Welcome coupon assigned to new user: " + savedUser.getUserId());
                }
            }

            return userSaved;

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error creating user with welcome coupon", e);
            return false;
        }
    }

    /**
     * Check and assign birthday coupons for users
     * This method should be called daily by a scheduler
     */
    public void processBirthdayCoupons() {
        try {
            List<User> usersWithBirthdayToday = getUsersWithBirthdayToday();

            for (User user : usersWithBirthdayToday) {
                // Check if user already has birthday coupon this year
                if (!userCouponService.userHasCoupon(user.getUserId(), "BIRTHDAY20")) {
                    userCouponService.assignBirthdayCoupon(user.getUserId());
                    logger.info("Birthday coupon assigned to user: " + user.getUserId());
                }
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error processing birthday coupons", e);
        }
    }

    /**
     * Process loyalty rewards based on user activity
     */
    public void processLoyaltyRewards(int userId, int totalOrders, double totalSpent) {
        try {
            // VIP criteria: 10+ orders and 5M+ spent
            if (totalOrders >= 10 && totalSpent >= 5000000) {
                if (!userCouponService.userHasCoupon(userId, "VIP15")) {
                    userCouponService.assignVIPCoupon(userId);
                    logger.info("VIP coupon assigned to loyal customer: " + userId);
                }
            }

            // Comeback coupon for inactive users (can be triggered by login after long period)
            // This logic can be expanded based on business requirements

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error processing loyalty rewards for user " + userId, e);
        }
    }

    /**
     * Get users with birthday today
     */
    private List<User> getUsersWithBirthdayToday() {
        // This method would need to be implemented in UserDAO
        // For now, return empty list as placeholder
        return List.of();
    }

    /**
     * Update user login and check for comeback coupon
     */
    public void updateUserLogin(int userId) {
        try {
            // Update last login date
            userDAO.updateLastLoginDate(userId);

            // Check if user should get comeback coupon
            // (e.g., if they haven't logged in for 30+ days)
            // This logic can be implemented based on business requirements

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating user login for user " + userId, e);
        }
    }

    /**
     * Get user by ID
     */
    public User getUserById(int userId) {
        try {
            return userDAO.findById(userId);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting user by ID: " + userId, e);
            return null;
        }
    }

    /**
     * Get user by email
     */
    public User getUserByEmail(String email) {
        try {
            return userDAO.findByEmail(email);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting user by email: " + email, e);
            return null;
        }
    }

    /**
     * Update user information
     */
    public boolean updateUser(User user) {
        try {
            return userDAO.updateUserInfo(user);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating user: " + user.getUserId(), e);
            return false;
        }
    }
}
