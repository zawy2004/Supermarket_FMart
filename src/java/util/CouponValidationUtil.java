package util;

import model.Coupon;
import java.sql.Date;
import java.util.regex.Pattern;

public class CouponValidationUtil {
    
    private static final Pattern COUPON_CODE_PATTERN = Pattern.compile("^[A-Z0-9]{3,20}$");
    private static final double MIN_DISCOUNT_VALUE = 0.01;
    private static final double MAX_PERCENTAGE_DISCOUNT = 100.0;
    private static final int MIN_USAGE_LIMIT = 1;
    private static final int MAX_USAGE_LIMIT = 100000;

    public static class ValidationException extends Exception {
        public ValidationException(String message) {
            super(message);
        }
    }

    public static void validateCoupon(Coupon coupon) throws ValidationException {
        validateCouponCode(coupon.getCouponCode());
        validateCouponName(coupon.getCouponName());
        validateDiscountType(coupon.getDiscountType());
        validateDiscountValue(coupon.getDiscountType(), coupon.getDiscountValue());
        validateDateRange(coupon.getStartDate(), coupon.getEndDate());
        validateUsageLimit(coupon.getUsageLimit());
        validateMinOrderAmount(coupon.getMinOrderAmount());
        validateMaxDiscountAmount(coupon.getDiscountType(), coupon.getDiscountValue(), coupon.getMaxDiscountAmount());
    }

    private static void validateCouponCode(String couponCode) throws ValidationException {
        if (couponCode == null || couponCode.trim().isEmpty()) {
            throw new ValidationException("Mã coupon không được để trống");
        }
        
        String code = couponCode.trim().toUpperCase();
        if (!COUPON_CODE_PATTERN.matcher(code).matches()) {
            throw new ValidationException("Mã coupon chỉ được chứa chữ cái và số, độ dài 3-20 ký tự");
        }
    }

    private static void validateCouponName(String couponName) throws ValidationException {
        if (couponName == null || couponName.trim().isEmpty()) {
            throw new ValidationException("Tên coupon không được để trống");
        }
        
        if (couponName.trim().length() < 3 || couponName.trim().length() > 100) {
            throw new ValidationException("Tên coupon phải có độ dài từ 3 đến 100 ký tự");
        }
    }

    private static void validateDiscountType(String discountType) throws ValidationException {
        if (discountType == null || discountType.trim().isEmpty()) {
            throw new ValidationException("Loại giảm giá không được để trống");
        }
        
        if (!"Percentage".equals(discountType) && !"Fixed".equals(discountType)) {
            throw new ValidationException("Loại giảm giá phải là 'Percentage' hoặc 'Fixed'");
        }
    }

    private static void validateDiscountValue(String discountType, double discountValue) throws ValidationException {
        if (discountValue < MIN_DISCOUNT_VALUE) {
            throw new ValidationException("Giá trị giảm giá phải lớn hơn " + MIN_DISCOUNT_VALUE);
        }

        if ("Percentage".equals(discountType)) {
            if (discountValue > MAX_PERCENTAGE_DISCOUNT) {
                throw new ValidationException("Phần trăm giảm giá không được vượt quá " + MAX_PERCENTAGE_DISCOUNT + "%");
            }
        } else if ("Fixed".equals(discountType)) {
            if (discountValue > 10000000) { // 10 triệu VND
                throw new ValidationException("Số tiền giảm giá không được vượt quá 10,000,000 VND");
            }
        }
    }

    private static void validateDateRange(Date startDate, Date endDate) throws ValidationException {
        if (startDate == null) {
            throw new ValidationException("Ngày bắt đầu không được để trống");
        }
        
        if (endDate == null) {
            throw new ValidationException("Ngày kết thúc không được để trống");
        }

        if (startDate.after(endDate)) {
            throw new ValidationException("Ngày bắt đầu phải trước ngày kết thúc");
        }

        Date now = new Date(System.currentTimeMillis());
        if (endDate.before(now)) {
            throw new ValidationException("Ngày kết thúc phải sau thời điểm hiện tại");
        }

        // Check if duration is too long (max 1 year)
        long duration = endDate.getTime() - startDate.getTime();
        long oneYear = 365L * 24 * 60 * 60 * 1000; // milliseconds in a year
        if (duration > oneYear) {
            throw new ValidationException("Thời gian hiệu lực coupon không được vượt quá 1 năm");
        }
    }

    private static void validateUsageLimit(int usageLimit) throws ValidationException {
        if (usageLimit < MIN_USAGE_LIMIT || usageLimit > MAX_USAGE_LIMIT) {
            throw new ValidationException("Giới hạn sử dụng phải từ " + MIN_USAGE_LIMIT + " đến " + MAX_USAGE_LIMIT);
        }
    }

    private static void validateMinOrderAmount(double minOrderAmount) throws ValidationException {
        if (minOrderAmount < 0) {
            throw new ValidationException("Số tiền đơn hàng tối thiểu phải >= 0");
        }
        
        if (minOrderAmount > 50000000) { // 50 triệu VND
            throw new ValidationException("Số tiền đơn hàng tối thiểu không được vượt quá 50,000,000 VND");
        }
    }

    private static void validateMaxDiscountAmount(String discountType, double discountValue, double maxDiscountAmount) throws ValidationException {
        if (maxDiscountAmount < 0) {
            throw new ValidationException("Số tiền giảm tối đa phải >= 0");
        }

        // For fixed discount, max discount should not be less than discount value
        if ("Fixed".equals(discountType) && maxDiscountAmount > 0 && maxDiscountAmount < discountValue) {
            throw new ValidationException("Số tiền giảm tối đa không được nhỏ hơn giá trị giảm giá");
        }
    }

    /**
     * Validate if coupon can be applied to an order
     */
    public static void validateCouponUsage(Coupon coupon, double orderAmount, int userUsageCount) throws ValidationException {
        if (coupon == null) {
            throw new ValidationException("Coupon không tồn tại");
        }

        if (!coupon.isActive()) {
            throw new ValidationException("Coupon đã bị vô hiệu hóa");
        }

        if (coupon.isExpired()) {
            throw new ValidationException("Coupon đã hết hạn");
        }

        if (!coupon.isStarted()) {
            throw new ValidationException("Coupon chưa có hiệu lực");
        }

        if (coupon.getUsageCount() >= coupon.getUsageLimit()) {
            throw new ValidationException("Coupon đã đạt giới hạn sử dụng");
        }

        if (orderAmount < coupon.getMinOrderAmount()) {
            throw new ValidationException("Đơn hàng chưa đạt giá trị tối thiểu: " + 
                String.format("%,.0f VND", coupon.getMinOrderAmount()));
        }

        if (coupon.getOrderLimit() > 0 && userUsageCount >= coupon.getOrderLimit()) {
            throw new ValidationException("Bạn đã sử dụng hết số lần cho phép với coupon này");
        }
    }

    public static String formatErrorMessage(String field, String message) {
        return String.format("[%s] %s", field, message);
    }
}