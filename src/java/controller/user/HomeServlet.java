package controller.user;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Product;
import model.ShoppingCart;
import service.CategoryService;
import service.ProductService;
import service.ShoppingCartService;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    
    private ProductService productService;
    private CategoryService categoryService;
    private ShoppingCartService cartService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        try {
            productService = new ProductService();
            categoryService = new CategoryService();
            cartService = new ShoppingCartService();
            System.out.println("SingleProductServlet initialized successfully!");
        } catch (Exception e) {
            System.err.println("Error initializing SingleProductServlet: " + e.getMessage());
            throw new ServletException("Failed to initialize SingleProductServlet", e);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== HomeServlet accessed ===");
        
        try {
            // Kiểm tra trạng thái đăng nhập
            HttpSession session = request.getSession(false);
            boolean isLoggedIn = session != null && session.getAttribute("userId") != null;
            
            System.out.println("User login status: " + isLoggedIn);
            
            // Set các attributes để JSP sử dụng
            request.setAttribute("isLoggedIn", isLoggedIn);
            
            if (isLoggedIn) {
                // Nếu đã đăng nhập, set thông tin user
                request.setAttribute("userFullName", session.getAttribute("userFullName"));
                request.setAttribute("userEmail", session.getAttribute("userEmail"));
                request.setAttribute("userId", session.getAttribute("userId"));
                
                System.out.println("User info set - Name: " + session.getAttribute("userFullName") + 
                                 ", Email: " + session.getAttribute("userEmail"));
            }
            
            Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
            System.out.println("SingleProductServlet: userId = " + userId);
            
            List<ShoppingCart> cartItems = null;
            double cartTotal = 0.0;
            double totalSaving = 0.0;
            double deliveryCharge = 30000;
            
            if (userId != null) {
                cartItems = cartService.getCartItemsByUserId(userId);
                for (ShoppingCart item : cartItems) {
                    Product p = productService.getProductById(item.getProductID());
                    if (p != null) {
                        cartTotal += p.getSellingPrice() * item.getQuantity();
                        if (p.getCostPrice() > p.getSellingPrice()) {
                            totalSaving += (p.getCostPrice() - p.getSellingPrice()) * item.getQuantity();
                        }
                        item.setProductName(p.getProductName());
                        item.setSellingPrice(p.getSellingPrice());
                        item.setCostPrice(p.getCostPrice());
                    }
                }
            }
            

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", cartTotal);
            request.setAttribute("totalSaving", totalSaving);
            request.setAttribute("deliveryCharge", deliveryCharge);
            
            // Kiểm tra có thông báo logout không (từ URL parameter)
            String logoutMessage = request.getParameter("logout");
            if ("success".equals(logoutMessage)) {
                request.setAttribute("logoutMessage", "Bạn đã đăng xuất thành công!");
            }
            
            // Forward đến trang index
            request.getRequestDispatcher("/User/index.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("HomeServlet error: " + e.getMessage());
            e.printStackTrace();
            
            // Nếu có lỗi, vẫn forward đến index nhưng không set user info
            request.setAttribute("isLoggedIn", false);
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi tải trang chủ.");
            request.getRequestDispatcher("/User/index.jsp").forward(request, response);
        }
        
       
           
            
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}