package controller.user;

import dao.ShoppingCartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.OrderDetail;
import model.ShoppingCart;
import model.Product;
import service.OrderService;
import service.ProductService;
import service.VnpayService;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "ProcessCheckoutServlet", urlPatterns = {"/processCheckout"})
public class ProcessCheckoutServlet extends HttpServlet {

    private OrderService orderService;
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
        productService = new ProductService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession(false);
            int customerId;
            if (session == null || session.getAttribute("userId") == null) {
                request.setAttribute("error", "Phiên đăng nhập đã hết. Vui lòng đăng nhập lại.");
                request.getRequestDispatcher("login").forward(request, response);
                return;
            }
            customerId = Integer.parseInt(session.getAttribute("userId").toString());

            // Lấy thông tin từ request
            String paymentMethod = safe(request.getParameter("paymentmethod"));
            String name = safe(request.getParameter("name"));
            String email = safe(request.getParameter("email"));
            String phone = safe(request.getParameter("phone"));
            String province = safe(request.getParameter("province"));
            String district = safe(request.getParameter("district"));
            String ward = safe(request.getParameter("ward"));
            String street = safe(request.getParameter("street"));
            String deliveryAddress = String.join(", ", street, ward, district, province);
            String notes = safe(request.getParameter("notes"));
            String deliveryDateStr = safe(request.getParameter("deliveryDate"));
            String deliveryTime = safe(request.getParameter("deliveryTime"));

            // Xử lý ngày giao hàng
            LocalDate deliveryLocalDate;
            if ("today".equals(deliveryDateStr)) {
                deliveryLocalDate = LocalDate.now();
            } else if ("tomorrow".equals(deliveryDateStr)) {
                deliveryLocalDate = LocalDate.now().plusDays(1);
            } else {
                // Kiểm tra deliveryDateStr không null và không rỗng trước khi parse
                if (deliveryDateStr != null && !deliveryDateStr.isEmpty()) {
                    String[] parts = deliveryDateStr.split(" ");
                    int days = 0;
                    if (parts.length > 0 && !parts[0].isEmpty()) {
                        try {
                            days = Integer.parseInt(parts[0]);
                        } catch (NumberFormatException e) {
                            // Xử lý khi parse lỗi (ví dụ gán days = 0 hoặc log lỗi)
                            days = 0;
                        }
                    }
                    deliveryLocalDate = LocalDate.now().plusDays(days);
                } else {
                    // Nếu rỗng hoặc null, gán ngày giao mặc định (ví dụ hôm nay)
                    deliveryLocalDate = LocalDate.now();
                }
            }

            Date deliveryDate = Date.from(deliveryLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());

            // Lấy giỏ hàng
            ShoppingCartDAO cartDAO = new ShoppingCartDAO();
            List<ShoppingCart> cartItems = cartDAO.getCartItemsByUserId(customerId);
            if (cartItems.isEmpty()) {
                request.setAttribute("error", "Giỏ hàng rỗng.");
                request.getRequestDispatcher("checkout").forward(request, response);
                return;
            }

            double subtotal = 0;
            List<OrderDetail> orderDetails = new ArrayList<>();
            for (ShoppingCart item : cartItems) {
                Product product = productService.getProductById(item.getProductID());
                double unitPrice = product.getSellingPrice();
                int quantity = item.getQuantity();
                double discountPercent = 0;
                double discountAmount = 0;
                double totalPrice = unitPrice * quantity;

                subtotal += totalPrice;

                OrderDetail detail = new OrderDetail();
                detail.setProductID(item.getProductID());
                detail.setQuantity(quantity);
                detail.setUnitPrice(unitPrice);
                detail.setDiscountPercent(discountPercent);
                detail.setDiscountAmount(discountAmount);
                detail.setTotalPrice(totalPrice);

                orderDetails.add(detail);
            }

            double deliveryCharge = 30000;
            double taxAmount = 0;
            double discountAmount = 0;
            double finalAmount = subtotal + deliveryCharge + taxAmount - discountAmount;

            // Tạo Order object
            Order order = new Order();
            order.setCustomerID(customerId);
            order.setOrderDate(new Date());
            order.setOrderType("Online");
            order.setStatus("Pending");
            order.setTotalAmount(subtotal);
            order.setDiscountAmount(discountAmount);
            order.setTaxAmount(taxAmount);
            order.setFinalAmount(finalAmount);
            order.setPaymentStatus("Pending");
            order.setPaymentMethod(paymentMethod);
            order.setDeliveryAddress(deliveryAddress);
            order.setDeliveryDate(deliveryDate);
            order.setCompletedDate(null);
            order.setProcessedBy(0);

            String additionalNotes = "Customer Name: " + name + "\n"
                    + "Email: " + email + "\n"
                    + "Phone: " + phone + "\n"
                    + "Delivery Time: " + deliveryTime + "\n"
                    + "Delivery Charge: " + deliveryCharge;
            order.setNotes(notes.isEmpty() ? additionalNotes : notes + "\n" + additionalNotes);

            // Tạo đơn hàng và chi tiết
            int orderId = orderService.createOrderFromCart(order, orderDetails);
            if (orderId == -1) {
                throw new Exception("Tạo đơn hàng thất bại.");
            }
            order.setOrderID(orderId);

            if ("cod".equals(paymentMethod)) {
                orderService.updateOrderStatus(orderId, "Confirmed");
                orderService.updatePaymentStatus(orderId, "Pending", "Confirmed");

                cartDAO.removeAllCartItemsByUserId(customerId);
                if (session != null) {
                    session.removeAttribute("cartItems");
                }

                request.setAttribute("order", order);
                request.setAttribute("name", name);
                request.setAttribute("phone", phone);
                request.setAttribute("finalAmount", finalAmount);
                request.getRequestDispatcher("/User/order_confirmation.jsp").forward(request, response);

            } else if ("vnpay".equals(paymentMethod)) {
                String vnpUrl = new VnpayService().createPaymentUrl(order, request);
                response.sendRedirect(vnpUrl);

            } else if ("payos".equals(paymentMethod)) {
                String description = "Thanh toán đơn hàng FMart #" + orderId;
                String redirectUrl = request.getContextPath() + "/payos-payment?orderId=" + orderId
                        + "&amount=" + (long) finalAmount
                        + "&description=" + URLEncoder.encode(description, StandardCharsets.UTF_8);
                response.sendRedirect(redirectUrl);

            } else {
                request.setAttribute("error", "Phương thức thanh toán không hợp lệ.");
                request.getRequestDispatcher("/User/checkout.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("/User/checkout.jsp").forward(request, response);
        }
    }

    private String safe(String s) {
        return s != null ? s.trim() : "";
    }
}
