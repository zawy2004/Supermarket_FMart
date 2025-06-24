package controller.admin;

import model.Coupon;
import service.CouponService;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CouponManagementServlet extends HttpServlet {
    private CouponService couponService = new CouponService();
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("list".equals(action)) {
            try {
                request.setAttribute("coupons", couponService.getAllCoupons());
                request.getRequestDispatcher("Admin/couponList.jsp").forward(request, response);
            } catch (SQLException e) {
                request.setAttribute("errorMessage", e.getMessage());
                request.getRequestDispatcher("Admin/couponList.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("Admin/coupon.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("create".equals(action)) {
            createCoupon(request, response);
        } else if ("apply".equals(action)) {
            applyCoupon(request, response);
        }
    }

    private void createCoupon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Coupon coupon = new Coupon();
            coupon.setCouponCode(request.getParameter("couponCode"));
            coupon.setCouponName(request.getParameter("couponName"));
            coupon.setDescription(request.getParameter("description"));
            coupon.setDiscountType(request.getParameter("discountType"));
            coupon.setDiscountValue(Double.parseDouble(request.getParameter("discountValue")));
            coupon.setMinOrderAmount(request.getParameter("minOrderAmount") != null ? Double.parseDouble(request.getParameter("minOrderAmount")) : 0);
            coupon.setMaxDiscountAmount(request.getParameter("maxDiscountAmount") != null ? Double.parseDouble(request.getParameter("maxDiscountAmount")) : 0);
            coupon.setUsageLimit(Integer.parseInt(request.getParameter("usageLimit")));
            coupon.setOrderLimit(request.getParameter("orderLimit") != null ? Integer.parseInt(request.getParameter("orderLimit")) : 0);
            coupon.setStartDate(new java.sql.Date(dateFormat.parse(request.getParameter("startDate")).getTime()));
            coupon.setEndDate(new java.sql.Date(dateFormat.parse(request.getParameter("endDate")).getTime()));
            coupon.setCreatedBy(Integer.parseInt(request.getParameter("createdBy")));

            int couponId = couponService.createCoupon(coupon);
            if (couponId > 0) {
                response.sendRedirect("CouponManagementServlet?action=list");
            } else {
                request.setAttribute("errorMessage", "Failed to create coupon.");
                request.getRequestDispatcher("Admin/coupon.jsp").forward(request, response);
            }
        } catch (SQLException | ParseException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("Admin/coupon.jsp").forward(request, response);
        }
    }

    private void applyCoupon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String couponCode = request.getParameter("couponCode");
            int createdBy = Integer.parseInt(request.getParameter("createdBy"));

            double discount = couponService.applyCouponToOrder(orderId, couponCode, createdBy);
            if (discount > 0) {
                request.setAttribute("discount", discount);
                request.setAttribute("orderId", orderId);
                request.getRequestDispatcher("Admin/applyCouponResult.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to apply coupon or invalid coupon.");
                request.getRequestDispatcher("Admin/applyCouponResult.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("Admin/applyCouponResult.jsp").forward(request, response);
        }

    }
}