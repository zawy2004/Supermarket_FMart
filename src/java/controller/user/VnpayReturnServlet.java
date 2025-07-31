package controller.user;

import com.sun.jdi.connect.spi.Connection;
import config.DatabaseConfig;
import service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.*;
import service.VnpayService;

@WebServlet("/vnpay-return")
public class VnpayReturnServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        boolean valid = VnpayService.verifyReturn(req);
        if (valid) {
            // Thanh toán thành công -> cập nhật order, hiển thị thông báo cho user
            req.setAttribute("success", true);
        } else {
            // Sai chữ ký!
            req.setAttribute("success", false);
            req.setAttribute("error", "Sai chữ ký VNPAY!");
        }
        req.getRequestDispatcher("/User/vnpay_result.jsp").forward(req, resp);
    }
}