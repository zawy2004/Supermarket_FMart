package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.payos.PayOS;
import vn.payos.type.PaymentData;
import vn.payos.type.CheckoutResponseData;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/payos-payment")
public class PayOSServlet extends HttpServlet {

    private static final String CLIENT_ID = "50032a94-280b-47e6-a908-2d24d3b34cdc";
    private static final String API_KEY = "e033deaa-9077-4ec4-93e7-6cf22ca22a35";
    private static final String CHECKSUM_KEY = "a3f3783d1d812c03681f37ffca91d429404a90082918274b191621a2b86d7f92";

    private static final String RETURN_URL = "http://localhost:8080/Supermarket_FMart/success";
    private static final String CANCEL_URL = "http://localhost:8080/Supermarket_FMart/cancel";

    private PayOS payOS;

    @Override
    public void init() throws ServletException {
        payOS = new PayOS(CLIENT_ID, API_KEY, CHECKSUM_KEY);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy tham số
            long orderId = Long.parseLong(request.getParameter("orderId"));
            double amountDouble = Double.parseDouble(request.getParameter("amount"));
            int amount = (int) amountDouble;

            String rawDescription = request.getParameter("description");
            String description = rawDescription != null && rawDescription.length() > 25
                    ? rawDescription.substring(0, 25)
                    : rawDescription;

            // Tạo dữ liệu thanh toán
            PaymentData paymentData = PaymentData.builder()
                    .orderCode(orderId)
                    .amount(amount)
                    .description(description)
                    .returnUrl(RETURN_URL + "?orderCode=" + orderId)
                    .cancelUrl(CANCEL_URL + "?orderCode=" + orderId)
                    .build();

            // Tạo liên kết thanh toán
            CheckoutResponseData checkoutResponse = payOS.createPaymentLink(paymentData);
            String checkoutUrl = checkoutResponse.getCheckoutUrl();

            // Điều hướng người dùng đến trang thanh toán
            response.sendRedirect(checkoutUrl);

        } catch (Exception e) {
            e.printStackTrace();
            String errorMessage = "Lỗi khi tạo thanh toán PayOS: " + e.getMessage();
            response.sendRedirect("/checkout?error=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}