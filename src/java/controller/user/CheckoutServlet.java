//package controller.user;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import model.Product;
//import model.ProductImage;
//import model.ShoppingCart;
//import service.ProductService;
//import service.ShoppingCartService;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.List;
//
//@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
//public class CheckoutServlet extends HttpServlet {
//
//    private ProductService productService;
//    private ShoppingCartService cartService;
//
//    @Override
//    public void init() throws ServletException {
//        super.init();
//        productService = new ProductService();
//        cartService = new ShoppingCartService();
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try {
//            HttpSession session = request.getSession(false);
//            Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
//            System.out.println("CheckoutServlet: userId = " + userId);
//
//            if (userId == null) {
//                response.sendRedirect("login");
//                return;
//            }
//
//            // Lấy thông tin từ "Order Now"
//            String productIdStr = request.getParameter("productId");
//            String productName = request.getParameter("productName");
//            String quantityStr = request.getParameter("quantity");
//            String unit = request.getParameter("unit");
//            String sellingPriceStr = request.getParameter("sellingPrice");
//            String totalPriceStr = request.getParameter("totalPrice");
//
//            // Khởi tạo danh sách giỏ hàng tạm
//            List<ShoppingCart> cartItems = new ArrayList<>();
//            double cartTotal = 0.0;
//            double totalSaving = 0.0;
//            double deliveryCharge = 1.0; // Giá trị mặc định
//
//            // Chỉ xử lý sản phẩm từ "Order Now" nếu có productIdStr
//            if (productIdStr != null && quantityStr != null && sellingPriceStr != null) {
//                int productId = Integer.parseInt(productIdStr);
//                int quantity = Integer.parseInt(quantityStr);
//                double sellingPrice = Double.parseDouble(sellingPriceStr);
//                double totalPrice = Double.parseDouble(totalPriceStr);
//                double costPrice = productService.getProductById(productId).getCostPrice();
//
//                ShoppingCart orderItem = new ShoppingCart();
//                orderItem.setUserID(userId);
//                orderItem.setProductID(productId);
//                orderItem.setQuantity(quantity);
//                orderItem.setUnit(unit);
//                orderItem.setAddedDate(new Date());
//                orderItem.setProductName(productName);
//                orderItem.setSellingPrice(sellingPrice);
//                orderItem.setCostPrice(costPrice > 0 ? costPrice : sellingPrice);
//                cartItems.add(orderItem);
//
//                cartTotal = totalPrice;
//                if (costPrice > sellingPrice) {
//                    totalSaving = (costPrice - sellingPrice) * quantity;
//                }
//            } else {
//                // Nếu không có productIdStr, lấy giỏ hàng (cho trường hợp checkout từ giỏ)
//                List<ShoppingCart> existingCartItems = cartService.getCartItemsByUserId(userId);
//                if (existingCartItems != null && !existingCartItems.isEmpty()) {
//                    cartItems.addAll(existingCartItems);
//                    for (ShoppingCart item : existingCartItems) {
//                        Product p = productService.getProductById(item.getProductID());
//                        if (p != null) {
//                            item.setProductName(p.getProductName());
//                            item.setSellingPrice(p.getSellingPrice());
//                            item.setCostPrice(p.getCostPrice());
//                            cartTotal += p.getSellingPrice() * item.getQuantity();
//                            if (p.getCostPrice() > p.getSellingPrice()) {
//                                totalSaving += (p.getCostPrice() - p.getSellingPrice()) * item.getQuantity();
//                            }
//                        }
//                    }
//                }
//            }
//
//            // Lấy hình ảnh chính của sản phẩm từ "Order Now" nếu có
//            String mainImageUrl = "images/product/default.jpg";
//            if (productIdStr != null) {
//                int productId = Integer.parseInt(productIdStr);
//                List<ProductImage> productImages = productService.getProductImagesByProductId(productId);
//                mainImageUrl = productImages.stream()
//                        .filter(ProductImage::isIsMainImage)
//                        .findFirst()
//                        .map(ProductImage::getImageUrl)
//                        .orElse(productImages.isEmpty() ? "images/product/default.jpg" : productImages.get(0).getImageUrl());
//            }
//
//            // Set attributes
//            request.setAttribute("product", productIdStr != null ? productService.getProductById(Integer.parseInt(productIdStr)) : null);
//            request.setAttribute("mainImageUrl", mainImageUrl);
//            request.setAttribute("quantity", quantityStr != null ? Integer.parseInt(quantityStr) : 1);
//            request.setAttribute("unit", unit);
//            request.setAttribute("cartItems", cartItems);
//            request.setAttribute("cartTotal", cartTotal);
//            request.setAttribute("totalSaving", totalSaving);
//            request.setAttribute("deliveryCharge", deliveryCharge);
//            request.setAttribute("productPrice", sellingPriceStr != null ? Double.parseDouble(sellingPriceStr) : 0.0);
//            request.setAttribute("productOriginalPrice", productIdStr != null ? productService.getProductById(Integer.parseInt(productIdStr)).getCostPrice() : 0.0);
//
//            request.getRequestDispatcher("/User/checkout.jsp").forward(request, response);
//
//        } catch (Exception e) {
//            System.err.println("Error in CheckoutServlet doGet: " + e.getMessage());
//            e.printStackTrace();
//            request.setAttribute("error", "System error: " + e.getMessage());
//            request.getRequestDispatcher("/User/error.jsp").forward(request, response);
//        }
//    }
//}

package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;
import model.ProductImage;
import model.ShoppingCart;
import service.ProductService;
import service.ShoppingCartService;
import service.CouponService;
import model.Order;
import model.OrderDetail;
import util.CouponValidationUtil.ValidationException;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    private ProductService productService;
    private ShoppingCartService cartService;
    private CouponService couponService;

    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductService();
        cartService = new ShoppingCartService();
        couponService = new CouponService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
            System.out.println("CheckoutServlet: userId = " + userId);

            if (userId == null) {
                response.sendRedirect("login");
                return;
            }

            // Lấy thông tin từ "Order Now"
            String productIdStr = request.getParameter("productId");
            String productName = request.getParameter("productName");
            String quantityStr = request.getParameter("quantity");
            String unit = request.getParameter("unit");
            String sellingPriceStr = request.getParameter("sellingPrice");
            String totalPriceStr = request.getParameter("totalPrice");

            // Khởi tạo danh sách giỏ hàng tạm
            List<ShoppingCart> cartItems = new ArrayList<>();
            double cartTotal = 0.0;
            double totalSaving = 0.0;
            double deliveryCharge = 30000; // Giá trị mặc định

            // Chỉ xử lý sản phẩm từ "Order Now" nếu có productIdStr
            if (productIdStr != null && quantityStr != null && sellingPriceStr != null) {
                int productId = Integer.parseInt(productIdStr);
                int quantity = Integer.parseInt(quantityStr);
                double sellingPrice = Double.parseDouble(sellingPriceStr);
                double totalPrice = Double.parseDouble(totalPriceStr);
                double costPrice = productService.getProductById(productId).getCostPrice();

                ShoppingCart orderItem = new ShoppingCart();
                orderItem.setUserID(userId);
                orderItem.setProductID(productId);
                orderItem.setQuantity(quantity);
                orderItem.setUnit(unit);
                orderItem.setAddedDate(new Date());
                orderItem.setProductName(productName);
                orderItem.setSellingPrice(sellingPrice);
                orderItem.setCostPrice(costPrice > 0 ? costPrice : sellingPrice);
                cartItems.add(orderItem);

                cartTotal = totalPrice;
                if (costPrice > sellingPrice) {
                    totalSaving = (costPrice - sellingPrice) * quantity;
                }
            } else {
                // Nếu không có productIdStr, lấy giỏ hàng (cho trường hợp checkout từ giỏ)
                List<ShoppingCart> existingCartItems = cartService.getCartItemsByUserId(userId);
                if (existingCartItems != null && !existingCartItems.isEmpty()) {
                    cartItems.addAll(existingCartItems);
                    for (ShoppingCart item : existingCartItems) {
                        Product p = productService.getProductById(item.getProductID());
                        if (p != null) {
                            item.setProductName(p.getProductName());
                            item.setSellingPrice(p.getSellingPrice());
                            item.setCostPrice(p.getCostPrice());
                            cartTotal += p.getSellingPrice() * item.getQuantity();
                            if (p.getCostPrice() > p.getSellingPrice()) {
                                totalSaving += (p.getCostPrice() - p.getSellingPrice()) * item.getQuantity();
                            }
                        }
                    }
                }
            }

            // Lấy hình ảnh chính của sản phẩm từ "Order Now" nếu có
            String mainImageUrl = "images/product/default.jpg";
            if (productIdStr != null) {
                int productId = Integer.parseInt(productIdStr);
                List<ProductImage> productImages = productService.getProductImagesByProductId(productId);
                mainImageUrl = productImages.stream()
                        .filter(ProductImage::isIsMainImage)
                        .findFirst()
                        .map(ProductImage::getImageUrl)
                        .orElse(productImages.isEmpty() ? "images/product/default.jpg" : productImages.get(0).getImageUrl());
            }

            // Set attributes
            request.setAttribute("product", productIdStr != null ? productService.getProductById(Integer.parseInt(productIdStr)) : null);
            request.setAttribute("mainImageUrl", mainImageUrl);
            request.setAttribute("quantity", quantityStr != null ? Integer.parseInt(quantityStr) : 1);
            request.setAttribute("unit", unit);
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", cartTotal);
            request.setAttribute("totalSaving", totalSaving);
            request.setAttribute("deliveryCharge", deliveryCharge);
            request.setAttribute("productPrice", sellingPriceStr != null ? Double.parseDouble(sellingPriceStr) : 0.0);
            request.setAttribute("productOriginalPrice", productIdStr != null ? productService.getProductById(Integer.parseInt(productIdStr)).getCostPrice() : 0.0);

            request.getRequestDispatcher("/User/checkout.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Error in CheckoutServlet doGet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("/User/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
            if (userId == null) {
                response.sendRedirect("login");
                return;
            }

            // Lấy thông tin từ form
            String couponCode = request.getParameter("appliedCouponCode");
            double appliedDiscount = request.getParameter("appliedDiscount") != null ? Double.parseDouble(request.getParameter("appliedDiscount")) : 0.0;
            String paymentMethod = request.getParameter("paymentmethod"); // Giả định từ checkout.jsp
            String phone = request.getParameter("phone");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String province = request.getParameter("province");
            String district = request.getParameter("district");
            String ward = request.getParameter("ward");
            String street = request.getParameter("street");
            String notes = request.getParameter("notes");
            String deliveryDate = request.getParameter("deliveryDate");
            String deliveryTime = request.getParameter("deliveryTime");

            // Lấy giỏ hàng từ session hoặc request
            List<ShoppingCart> cartItems = (List<ShoppingCart>) request.getAttribute("cartItems");
            double cartTotal = request.getAttribute("cartTotal") != null ? (Double) request.getAttribute("cartTotal") : 0.0;
            double deliveryCharge = request.getAttribute("deliveryCharge") != null ? (Double) request.getAttribute("deliveryCharge") : 1.0;

            // Tạo đối tượng Order
            Order order = new Order();
            order.setCustomerID(userId);
            order.setOrderDate(new Date());
            order.setOrderType("Online");
            order.setStatus("Pending");
            order.setTotalAmount(cartTotal);
            order.setDiscountAmount(appliedDiscount);
            order.setTaxAmount(0.0);
            order.setFinalAmount(cartTotal + deliveryCharge - appliedDiscount);
            order.setPaymentStatus("Pending");
            order.setPaymentMethod(paymentMethod);
            order.setDeliveryAddress(province + ", " + district + ", " + ward + ", " + street);
            // Xử lý delivery date
            java.sql.Date sqlDeliveryDate = null;
            if (deliveryDate != null && !deliveryDate.isEmpty()) {
                if (deliveryDate.contains("days")) {
                    // Nếu là "X days", tính từ ngày hiện tại
                    int days = Integer.parseInt(deliveryDate.split(" ")[0]);
                    java.time.LocalDate futureDate = java.time.LocalDate.now().plusDays(days);
                    sqlDeliveryDate = java.sql.Date.valueOf(futureDate);
                } else {
                    // Nếu là ngày cụ thể, parse trực tiếp
                    try {
                        sqlDeliveryDate = java.sql.Date.valueOf(deliveryDate);
                    } catch (IllegalArgumentException e) {
                        // Nếu format không đúng, set null
                        sqlDeliveryDate = null;
                    }
                }
            }
            order.setDeliveryDate(sqlDeliveryDate);
            order.setNotes(notes);

            // Xử lý mã giảm giá - Validate trước khi tạo order
            if (couponCode != null && !couponCode.trim().isEmpty()) {
                try {
                    // Validate coupon cho user và order amount
                    couponService.validateCouponForUser(couponCode, userId, cartTotal + deliveryCharge);

                    // Tính toán discount
                    double calculatedDiscount = couponService.calculateDiscount(couponCode, cartTotal + deliveryCharge);

                    // Kiểm tra discount có khớp với frontend không (nếu có appliedDiscount từ frontend)
                    if (appliedDiscount > 0 && Math.abs(calculatedDiscount - appliedDiscount) > 0.01) {
                        request.setAttribute("error", "Số tiền giảm giá đã thay đổi. Vui lòng áp dụng lại mã giảm giá.");
                        request.setAttribute("cartItems", cartItems);
                        request.setAttribute("cartTotal", cartTotal);
                        request.setAttribute("deliveryCharge", deliveryCharge);
                        request.getRequestDispatcher("/User/checkout.jsp").forward(request, response);
                        return;
                    }

                    // Cập nhật discount amount chính xác
                    appliedDiscount = calculatedDiscount;
                    order.setDiscountAmount(appliedDiscount);
                    order.setFinalAmount(cartTotal + deliveryCharge - appliedDiscount);

                    // Lưu coupon code vào session để sử dụng sau khi tạo order
                    session.setAttribute("pendingCouponCode", couponCode);
                    session.setAttribute("pendingCouponDiscount", appliedDiscount);

                } catch (SQLException | ValidationException e) {
                    request.setAttribute("error", "Lỗi khi áp dụng mã giảm giá: " + e.getMessage());
                    request.setAttribute("cartItems", cartItems);
                    request.setAttribute("cartTotal", cartTotal);
                    request.setAttribute("deliveryCharge", deliveryCharge);
                    request.getRequestDispatcher("/User/checkout.jsp").forward(request, response);
                    return;
                }
            }

            // Tạo danh sách OrderDetail
            List<OrderDetail> orderDetails = new ArrayList<>();
            for (ShoppingCart item : cartItems) {
                OrderDetail detail = new OrderDetail();
                detail.setProductID(item.getProductID());
                detail.setQuantity(item.getQuantity());
                detail.setUnitPrice(item.getSellingPrice());
                detail.setTotalPrice(item.getSellingPrice() * item.getQuantity());
                orderDetails.add(detail);
            }

            // Tạo đơn hàng (giả định có OrderDAO hoặc OrderService)
            int orderId = 0; // Giả định tạo đơn hàng, cần tích hợp với OrderService
            // orderId = orderService.createOrderFromCart(order, orderDetails); // Cần triển khai OrderService

            // Xóa giỏ hàng nếu checkout từ giỏ
            if (request.getParameter("productId") == null) {
                cartService.clearCart(userId);
            }

            // Chuyển hướng dựa trên phương thức thanh toán
            if ("VNPAY".equals(paymentMethod)) {
                response.sendRedirect(request.getContextPath() + "/vnpay-payment?orderId=" + orderId + "&amount=" + order.getFinalAmount());
            } else if ("PAYOS".equals(paymentMethod)) {
                response.sendRedirect(request.getContextPath() + "/payos-payment?orderId=" + orderId + "&amount=" + order.getFinalAmount() + "&description=Thanh toan don hang " + order.getOrderNumber());
            } else {
                // COD
                // Cần tích hợp OrderService để lưu đơn hàng
                // orderService.updatePaymentStatus(orderId, "Pending", "Confirmed");
                response.sendRedirect(request.getContextPath() + "/order-confirmation?orderId=" + orderId);
            }

        } catch (Exception e) {
            System.err.println("Error in CheckoutServlet doPost: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("/User/error.jsp").forward(request, response);
        }
    }
}