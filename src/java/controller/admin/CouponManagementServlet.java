package controller.admin;

import model.Coupon;
import model.User;
import service.CouponService;
import util.CouponValidationUtil.ValidationException;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/coupon")
public class CouponManagementServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(CouponManagementServlet.class.getName());
    private CouponService couponService = new CouponService();
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check admin authentication
        if (!isAdminAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        
        try {
            switch (action != null ? action : "list") {
                case "list":
                    handleListCoupons(request, response);
                    break;
                case "create":
                    handleShowCreateForm(request, response);
                    break;
                case "edit":
                    handleShowEditForm(request, response);
                    break;
                case "view":
                    handleViewCoupon(request, response);
                    break;
                case "stats":
                    handleShowStatistics(request, response);
                    break;
                default:
                    handleListCoupons(request, response);
                    break;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error in CouponManagementServlet", e);
            request.setAttribute("errorMessage", "Lỗi kết nối cơ sở dữ liệu. Vui lòng thử lại.");
            request.getRequestDispatcher("/Admin/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check admin authentication
        if (!isAdminAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        
        try {
            switch (action != null ? action : "") {
                case "create":
                    handleCreateCoupon(request, response);
                    break;
                case "update":
                    handleUpdateCoupon(request, response);
                    break;
                case "delete":
                    handleDeleteCoupon(request, response);
                    break;
                case "bulk_action":
                    handleBulkAction(request, response);
                    break;
                case "apply":
                    handleApplyCoupon(request, response);
                    break;
                case "toggle_status":
                    handleToggleStatus(request, response);
                    break;
                case "check_code":
                    handleCheckCouponCode(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                    break;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error in CouponManagementServlet POST", e);
            request.setAttribute("errorMessage", "Lỗi kết nối cơ sở dữ liệu. Vui lòng thử lại.");
            forwardToErrorPage(request, response);
        } catch (ValidationException e) {
            request.setAttribute("errorMessage", e.getMessage());
            forwardToErrorPage(request, response);
        }
    }

    private void handleListCoupons(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        // Lấy tham số tìm kiếm và phân trang
        String keyword = request.getParameter("keyword");
        String statusFilter = request.getParameter("status");
        String typeFilter = request.getParameter("type");

        // Xử lý phân trang
        int page = 1;
        int pageSize = 10;

        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.trim().isEmpty()) {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        int offset = (page - 1) * pageSize;

        // Lấy danh sách coupon với tìm kiếm và phân trang
        List<Coupon> coupons = couponService.searchCoupons(keyword, statusFilter, typeFilter, offset, pageSize);
        int totalCoupons = couponService.countSearchCoupons(keyword, statusFilter, typeFilter);
        int totalPages = (int) Math.ceil((double) totalCoupons / pageSize);

        // Set attributes cho JSP
        request.setAttribute("coupons", coupons);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCoupons", totalCoupons);
        request.setAttribute("keyword", keyword);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("typeFilter", typeFilter);

        // Chuyển đến trang quản lý coupon mới thay vì couponList.jsp
        request.getRequestDispatcher("/Admin/manage_coupons.jsp").forward(request, response);
    }

    private void handleShowCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Generate suggested coupon code
        String suggestedCode = couponService.generateCouponCodeSuggestion("NEW");
        request.setAttribute("suggestedCode", suggestedCode);
        request.getRequestDispatcher("/Admin/coupon.jsp").forward(request, response);
    }

    private void handleShowEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        String couponIdStr = request.getParameter("couponId");
        if (couponIdStr == null || couponIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing coupon ID");
            return;
        }

        try {
            int couponId = Integer.parseInt(couponIdStr);
            Coupon coupon = couponService.getCouponById(couponId);
            
            if (coupon == null) {
                request.setAttribute("errorMessage", "Không tìm thấy coupon với ID: " + couponId);
                handleListCoupons(request, response);
                return;
            }

            request.setAttribute("coupon", coupon);
            request.setAttribute("isEdit", true);
            request.getRequestDispatcher("/Admin/coupon.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid coupon ID format");
        }
    }

    private void handleViewCoupon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        String couponIdStr = request.getParameter("couponId");
        if (couponIdStr == null || couponIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing coupon ID");
            return;
        }

        try {
            int couponId = Integer.parseInt(couponIdStr);
            Coupon coupon = couponService.getCouponById(couponId);
            
            if (coupon == null) {
                request.setAttribute("errorMessage", "Không tìm thấy coupon với ID: " + couponId);
                handleListCoupons(request, response);
                return;
            }

            // Get usage history for this coupon
            var usageHistory = couponService.getOrderCouponUsage(couponId);
            
            request.setAttribute("coupon", coupon);
            request.setAttribute("usageHistory", usageHistory);
            request.getRequestDispatcher("/Admin/coupon_detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid coupon ID format");
        }
    }

    private void handleShowStatistics(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        var stats = couponService.getCouponUsageStatistics();
        request.setAttribute("couponStats", stats);
        request.getRequestDispatcher("/Admin/couponStats.jsp").forward(request, response);
    }

    private void handleCreateCoupon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ValidationException {
        
        try {
            Coupon coupon = buildCouponFromRequest(request);
            
            // Get current user from session
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            if (currentUser != null) {
                coupon.setCreatedBy(currentUser.getUserId());
            } else {
                throw new ValidationException("Không thể xác định người tạo coupon");
            }

            int couponId = couponService.createCoupon(coupon);
            
            if (couponId > 0) {
                request.setAttribute("successMessage", "Tạo coupon thành công với mã: " + coupon.getCouponCode());
                response.sendRedirect(request.getContextPath() + "/admin/coupon?action=list&success=created");
            } else {
                request.setAttribute("errorMessage", "Không thể tạo coupon. Vui lòng thử lại.");
                request.setAttribute("coupon", coupon); // Keep form data
                request.getRequestDispatcher("/Admin/coupon.jsp").forward(request, response);
            }
            
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Định dạng ngày không hợp lệ");
            request.getRequestDispatcher("/Admin/coupon.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu số không hợp lệ");
            request.getRequestDispatcher("/Admin/coupon.jsp").forward(request, response);
        }
    }

    private void handleApplyCoupon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ValidationException {
        
        String orderIdStr = request.getParameter("orderId");
        String couponCode = request.getParameter("couponCode");
        String orderAmountStr = request.getParameter("orderAmount");

        if (orderIdStr == null || couponCode == null || orderAmountStr == null) {
            request.setAttribute("errorMessage", "Thiếu thông tin cần thiết");
            request.getRequestDispatcher("/Admin/applyCouponResult.jsp").forward(request, response);
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            double orderAmount = Double.parseDouble(orderAmountStr);
            
            // Get current user
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            int userId = currentUser != null ? currentUser.getUserId() : 1;

            double discount = couponService.applyCouponToOrder(orderId, couponCode, userId, orderAmount);
            
            if (discount > 0) {
                request.setAttribute("discount", discount);
                request.setAttribute("orderId", orderId);
                request.setAttribute("couponCode", couponCode);
                request.setAttribute("successMessage", "Áp dụng coupon thành công");
            } else {
                request.setAttribute("errorMessage", "Không thể áp dụng coupon");
            }
            
            request.getRequestDispatcher("/Admin/applyCouponResult.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu số không hợp lệ");
            request.getRequestDispatcher("/Admin/applyCouponResult.jsp").forward(request, response);
        }
    }

    private void handleToggleStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        String couponIdStr = request.getParameter("couponId");
        String statusStr = request.getParameter("status");

        if (couponIdStr == null || statusStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        try {
            int couponId = Integer.parseInt(couponIdStr);
            boolean status = Boolean.parseBoolean(statusStr);
            
            boolean updated = couponService.updateCouponStatus(couponId, status);
            
            if (updated) {
                response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật trạng thái thành công\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể cập nhật trạng thái\"}");
            }
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameter format");
        }
    }

    private void handleCheckCouponCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        String couponCode = request.getParameter("couponCode");
        
        if (couponCode == null || couponCode.trim().isEmpty()) {
            response.getWriter().write("{\"available\": false, \"message\": \"Mã coupon không được để trống\"}");
            return;
        }

        boolean available = couponService.isCouponCodeAvailable(couponCode.trim());
        
        response.setContentType("application/json");
        if (available) {
            response.getWriter().write("{\"available\": true, \"message\": \"Mã coupon có thể sử dụng\"}");
        } else {
            response.getWriter().write("{\"available\": false, \"message\": \"Mã coupon đã tồn tại\"}");
        }
    }

    private Coupon buildCouponFromRequest(HttpServletRequest request) throws ParseException, ValidationException {
        Coupon coupon = new Coupon();
        
        // Basic information
        coupon.setCouponCode(getRequiredParameter(request, "couponCode"));
        coupon.setCouponName(getRequiredParameter(request, "couponName"));
        coupon.setDescription(request.getParameter("description"));
        
        // Discount information
        coupon.setDiscountType(getRequiredParameter(request, "discountType"));
        coupon.setDiscountValue(parseDouble(request, "discountValue", true));
        coupon.setMinOrderAmount(parseDouble(request, "minOrderAmount", false));
        coupon.setMaxDiscountAmount(parseDouble(request, "maxDiscountAmount", false));
        
        // Usage limits
        coupon.setUsageLimit(parseInt(request, "usageLimit", true));
        coupon.setOrderLimit(parseInt(request, "orderLimit", false));
        
        // Date range
        coupon.setStartDate(parseDate(request, "startDate", true));
        coupon.setEndDate(parseDate(request, "endDate", true));
        
        return coupon;
    }

    private String getRequiredParameter(HttpServletRequest request, String paramName) throws ValidationException {
        String value = request.getParameter(paramName);
        if (value == null || value.trim().isEmpty()) {
            throw new ValidationException("Tham số bắt buộc bị thiếu: " + paramName);
        }
        return value.trim();
    }

    private double parseDouble(HttpServletRequest request, String paramName, boolean required) throws ValidationException {
        String value = request.getParameter(paramName);
        
        if (value == null || value.trim().isEmpty()) {
            if (required) {
                throw new ValidationException("Tham số bắt buộc bị thiếu: " + paramName);
            }
            return 0.0;
        }
        
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException e) {
            throw new ValidationException("Giá trị số không hợp lệ cho " + paramName + ": " + value);
        }
    }

    private int parseInt(HttpServletRequest request, String paramName, boolean required) throws ValidationException {
        String value = request.getParameter(paramName);
        
        if (value == null || value.trim().isEmpty()) {
            if (required) {
                throw new ValidationException("Tham số bắt buộc bị thiếu: " + paramName);
            }
            return 0;
        }
        
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            throw new ValidationException("Giá trị số nguyên không hợp lệ cho " + paramName + ": " + value);
        }
    }

    private java.sql.Date parseDate(HttpServletRequest request, String paramName, boolean required) 
            throws ParseException, ValidationException {
        
        String value = request.getParameter(paramName);
        
        if (value == null || value.trim().isEmpty()) {
            if (required) {
                throw new ValidationException("Tham số bắt buộc bị thiếu: " + paramName);
            }
            return null;
        }
        
        try {
            java.util.Date parsedDate = dateFormat.parse(value);
            return new java.sql.Date(parsedDate.getTime());
        } catch (ParseException e) {
            throw new ParseException("Định dạng ngày không hợp lệ cho " + paramName + ": " + value, e.getErrorOffset());
        }
    }

    private boolean isAdminAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }
        
        User user = (User) session.getAttribute("user");
        return user != null && ("admin".equals(user.getRole()) || "manager".equals(user.getRole()));
    }

    private void forwardToErrorPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if ("create".equals(action)) {
            request.getRequestDispatcher("/Admin/coupon.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/Admin/couponList.jsp").forward(request, response);
        }
    }

    // Phương thức cập nhật coupon
    private void handleUpdateCoupon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ValidationException {

        String couponIdStr = request.getParameter("couponId");
        if (couponIdStr == null || couponIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Thiếu ID coupon");
            handleListCoupons(request, response);
            return;
        }

        try {
            int couponId = Integer.parseInt(couponIdStr);
            Coupon coupon = buildCouponFromRequest(request);
            coupon.setCouponId(couponId);

            boolean updated = couponService.updateCoupon(coupon);

            if (updated) {
                response.sendRedirect(request.getContextPath() + "/admin/coupon?action=list&success=updated");
            } else {
                request.setAttribute("errorMessage", "Không thể cập nhật coupon");
                request.setAttribute("coupon", coupon);
                request.setAttribute("isEdit", true);
                request.getRequestDispatcher("/Admin/coupon.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID coupon không hợp lệ");
            handleListCoupons(request, response);
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Định dạng ngày không hợp lệ");
            request.getRequestDispatcher("/Admin/coupon.jsp").forward(request, response);
        }
    }

    // Phương thức xóa coupon
    private void handleDeleteCoupon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String couponIdStr = request.getParameter("couponId");
        if (couponIdStr == null || couponIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing coupon ID");
            return;
        }

        try {
            int couponId = Integer.parseInt(couponIdStr);
            boolean deleted = couponService.deleteCoupon(couponId);

            response.setContentType("application/json");
            if (deleted) {
                response.getWriter().write("{\"success\": true, \"message\": \"Xóa coupon thành công\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể xóa coupon\"}");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid coupon ID format");
        }
    }

    // Phương thức xử lý bulk actions
    private void handleBulkAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String action = request.getParameter("bulk_action");
        String[] couponIds = request.getParameterValues("coupon_ids");

        if (action == null || couponIds == null || couponIds.length == 0) {
            response.sendRedirect(request.getContextPath() + "/admin/coupon?action=list&error=invalid_bulk");
            return;
        }

        int successCount = 0;

        try {
            for (String idStr : couponIds) {
                int couponId = Integer.parseInt(idStr);

                switch (action) {
                    case "activate":
                        if (couponService.updateCouponStatus(couponId, true)) {
                            successCount++;
                        }
                        break;
                    case "deactivate":
                        if (couponService.updateCouponStatus(couponId, false)) {
                            successCount++;
                        }
                        break;
                    case "delete":
                        if (couponService.deleteCoupon(couponId)) {
                            successCount++;
                        }
                        break;
                }
            }

            String message = "Đã xử lý thành công " + successCount + "/" + couponIds.length + " coupon";
            response.sendRedirect(request.getContextPath() + "/admin/coupon?action=list&success=" +
                                java.net.URLEncoder.encode(message, "UTF-8"));

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/coupon?action=list&error=invalid_id");
        }
    }

    @Override
    public String getServletInfo() {
        return "CouponManagementServlet - Handles admin coupon management operations";
    }
}