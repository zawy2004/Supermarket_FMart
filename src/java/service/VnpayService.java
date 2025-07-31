package service;

import jakarta.servlet.http.HttpServletRequest;
import model.Order;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

public class VnpayService {

    // ĐIỀN THÔNG SỐ ĐÚNG TỪ VNPAY SANDBOX CỦA BẠN!
    private static final String vnp_TmnCode = "QU9L1USH";
    private static final String vnp_HashSecret = "WJWCE8BH1HNVS3ZX9G8DMERUOMDRIU13";
    private static final String vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    private static final String vnp_ReturnUrl = "http://localhost:8080/Supermarket_FMart/vnpay-return";

    // Tạo URL thanh toán chuyển hướng đến VNPAY
    public String createPaymentUrl(Order order, HttpServletRequest request) throws Exception {
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", "2.1.0");
        vnp_Params.put("vnp_Command", "pay");
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);

        // Số tiền phải nhân 100, không có dấu chấm/phẩy/phân cách!
        long amount = Math.round(order.getFinalAmount() * 100);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));

        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", order.getOrderNumber());
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang #" + order.getOrderNumber());
        vnp_Params.put("vnp_OrderType", "other");
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", getIpAddress(request));

        // Thời gian giao dịch và hết hạn (phải theo GMT+7)
        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        vnp_Params.put("vnp_CreateDate", formatter.format(cld.getTime()));
        cld.add(Calendar.MINUTE, 15);
        vnp_Params.put("vnp_ExpireDate", formatter.format(cld.getTime()));

        // Sắp xếp thứ tự a-z theo yêu cầu VNPAY
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);

        // 1. hashData KHÔNG encode value, chỉ ghép a=b&c=d...
        StringBuilder hashData = new StringBuilder();
        // 2. queryString encode cả key và value cho URL
        StringBuilder query = new StringBuilder();
        for (int i = 0; i < fieldNames.size(); i++) {
            String name = fieldNames.get(i);
            String value = vnp_Params.get(name);
            hashData.append(name).append("=").append(value);
            query.append(URLEncoder.encode(name, StandardCharsets.US_ASCII.toString()))
                 .append("=")
                 .append(URLEncoder.encode(value, StandardCharsets.US_ASCII.toString()));
            if (i < fieldNames.size() - 1) {
                hashData.append("&");
                query.append("&");
            }
        }

        // In debug ra log để test chữ ký nếu cần
        System.out.println("==== VNPAY DEBUG ====");
        System.out.println("hashData: " + hashData);
        System.out.println("query: " + query);
        System.out.println("secret: " + vnp_HashSecret);
        System.out.println("=====================");

        // Tạo SHA512 (chữ ký bảo mật)
        String vnp_SecureHash = hmacSHA512(vnp_HashSecret, hashData.toString());
        query.append("&vnp_SecureHash=").append(vnp_SecureHash);

        return vnp_Url + "?" + query.toString();
    }

    // Kiểm tra chữ ký khi callback từ VNPAY
    public static boolean verifyReturn(HttpServletRequest request) {
        Map<String, String> vnp_Params = new HashMap<>();
        for (String key : request.getParameterMap().keySet()) {
            if (key.startsWith("vnp_")) {
                vnp_Params.put(key, request.getParameter(key));
            }
        }
        String vnp_SecureHash = vnp_Params.remove("vnp_SecureHash");
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        for (int i = 0; i < fieldNames.size(); i++) {
            String name = fieldNames.get(i);
            String value = vnp_Params.get(name);
            hashData.append(name).append("=").append(value);
            if (i < fieldNames.size() - 1) hashData.append("&");
        }
        String computedHash = hmacSHA512(vnp_HashSecret, hashData.toString());
        return computedHash.equalsIgnoreCase(vnp_SecureHash);
    }

    // Lấy IP thực của client
    private static String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null || ip.isEmpty()) ip = request.getRemoteAddr();
        return ip;
    }

    // Hàm ký HMAC SHA512 (chuẩn)
    private static String hmacSHA512(final String key, final String data) {
        try {
            Mac hmac512 = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            hmac512.init(secretKey);
            byte[] result = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(2 * result.length);
            for (byte b : result) sb.append(String.format("%02x", b & 0xff));
            return sb.toString();
        } catch (Exception ex) {
            throw new RuntimeException("Failed to generate HMAC SHA512: " + ex.getMessage(), ex);
        }
    }
}