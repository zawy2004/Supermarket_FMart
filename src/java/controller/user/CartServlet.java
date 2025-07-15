package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;
import model.ShoppingCart;
import service.ProductService;
import service.ShoppingCartService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {
    
    private ShoppingCartService cartService;
    private ProductService productService;
    
    // Available promo codes configuration
    private static final Map<String, PromoCode> PROMO_CODES = new HashMap<>();
    
    static {
        PROMO_CODES.put("SAVE10", new PromoCode("percentage", 10, 0, "10% off entire order"));
        PROMO_CODES.put("WELCOME20", new PromoCode("percentage", 20, 100000, "20% off (max 100,000₫)"));
        PROMO_CODES.put("FMART50", new PromoCode("percentage", 50, 100000, "50% off (max 100,000₫)"));
        PROMO_CODES.put("FLAT50K", new PromoCode("fixed", 50000, 0, "Flat 50,000₫ off"));
        PROMO_CODES.put("NEWUSER", new PromoCode("percentage", 15, 75000, "15% off for new users (max 75,000₫)"));
        PROMO_CODES.put("ILOVEFMART", new PromoCode("percentage", 20, 0, "20% off entire order"));
    }
    
    @Override
    public void init() throws ServletException {
        super.init();
        try {
            cartService = new ShoppingCartService();
            productService = new ProductService();
            System.out.println("CartServlet initialized successfully");
        } catch (Exception e) {
            System.err.println("Error initializing CartServlet: " + e.getMessage());
            throw new ServletException("Failed to initialize CartServlet", e);
        }
    }
    
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    
    // Add CORS headers for AJAX requests
    response.setHeader("Access-Control-Allow-Origin", "*");
    response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
    response.setHeader("Access-Control-Allow-Headers", "Content-Type");
    
    PrintWriter out = response.getWriter();
    
    try {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            out.print("{\"error\": \"User not logged in\", \"success\": false}");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String action = request.getParameter("action");
        System.out.println("CartServlet POST action: " + action + " for user: " + userId);
        
        if (action == null) {
            out.print("{\"error\": \"Missing action parameter\", \"success\": false}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        switch (action.toLowerCase()) {
            case "add":
                handleAddToCart(request, response, userId, out);
                break;
            case "update":
                handleUpdateCart(request, response, userId, out);
                break;
            case "remove":
                handleRemoveFromCart(request, response, userId, out);
                break;
            case "getcartitems":
                handleGetCartItems(request, response, userId, out);
                break;
            case "applypromo":
                handleApplyPromoCode(request, response, session, out);
                break;
            case "clearpromo":
                handleClearPromoCode(request, response, session, out);
                break;
            case "getcartsummary":
                handleGetCartSummary(request, response, userId, session, out);
                break;
            default:
                out.print("{\"error\": \"Invalid action: " + action + "\", \"success\": false}");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
        
    } catch (Exception e) {
        System.err.println("Error in CartServlet doPost: " + e.getMessage());
        e.printStackTrace();
        out.print("{\"error\": \"Server error: " + e.getMessage() + "\", \"success\": false}");
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
}
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            String action = request.getParameter("action");
            
            System.out.println("CartServlet GET action: " + action + " for user: " + userId);
            
            // Handle cart count request
            if ("count".equals(action)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                
                if (userId == null) {
                    out.print("{\"error\": \"User not logged in\", \"count\": 0, \"success\": false}");
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    return;
                }
                
                List<ShoppingCart> cartItems = cartService.getCartItemsByUserId(userId);
                int count = (cartItems != null) ? cartItems.size() : 0;
                out.print("{\"count\": " + count + ", \"success\": true}");
                return;
            }
            
            // Default: Return cart sidebar content
            if (userId == null) {
                response.sendRedirect("login");
                return;
            }
            
            // Get cart items and enrich with product information
            List<ShoppingCart> cartItems = cartService.getCartItemsByUserId(userId);
            
            if (cartItems != null && !cartItems.isEmpty()) {
                for (ShoppingCart item : cartItems) {
                    try {
                        Product product = productService.getProductById(item.getProductID());
                        if (product != null) {
                            item.setProductName(product.getProductName());
                            item.setSellingPrice(product.getSellingPrice());
                            // Use cost price if available, otherwise use selling price
                            double costPrice = product.getCostPrice() > 0 ? product.getCostPrice() : product.getSellingPrice();
                            item.setCostPrice(costPrice);
                            item.setUnit(product.getUnit());
                        } else {
                            System.err.println("Product not found for ID: " + item.getProductID());
                            // Set default values to prevent null pointer exceptions
                            item.setProductName("Product Not Found");
                            item.setSellingPrice(0.0);
                            item.setCostPrice(0.0);
                            item.setUnit("piece");
                        }
                    } catch (Exception e) {
                        System.err.println("Error enriching cart item " + item.getCartID() + ": " + e.getMessage());
                        // Set safe default values
                        item.setProductName("Error Loading Product");
                        item.setSellingPrice(0.0);
                        item.setCostPrice(0.0);
                        item.setUnit("piece");
                    }
                }
            }
            
            // Calculate cart summary
            CartSummary summary = calculateCartSummary(cartItems, session);
            
            // Set attributes for JSP
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", summary.subtotal);
            request.setAttribute("totalSaving", summary.totalSaving);
            request.setAttribute("deliveryCharge", summary.deliveryCharge);
            request.setAttribute("grandTotal", summary.grandTotal);
            request.setAttribute("promoDiscount", summary.promoDiscount);
            request.setAttribute("promoCode", session.getAttribute("promoCode"));
            
            System.out.println("Cart summary - Items: " + (cartItems != null ? cartItems.size() : 0) + 
                             ", Subtotal: " + summary.subtotal + 
                             ", Delivery: " + summary.deliveryCharge + 
                             ", Total: " + summary.grandTotal);
            
            request.getRequestDispatcher("/User/cart_sidebar.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in CartServlet doGet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("/User/error.jsp").forward(request, response);
        }
    }
    
    private void handleAddToCart(HttpServletRequest request, HttpServletResponse response, 
                            Integer userId, PrintWriter out) throws Exception {
    String productIdStr = request.getParameter("productId");
    String quantityStr = request.getParameter("quantity");
    String unit = request.getParameter("unit");
    
    System.out.println("Adding to cart - ProductID: " + productIdStr + ", Quantity: " + quantityStr);
    
    if (productIdStr == null || quantityStr == null) {
        out.print("{\"error\": \"Missing required parameters (productId, quantity)\", \"success\": false}");
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        return;
    }
    
    try {
        int productId = Integer.parseInt(productIdStr);
        int quantity = Integer.parseInt(quantityStr);
        
        if (quantity <= 0) {
            out.print("{\"error\": \"Quantity must be greater than 0\", \"success\": false}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        if (quantity > 999) {
            out.print("{\"error\": \"Maximum quantity is 999\", \"success\": false, \"maxQuantity\": 999}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        // Validate product exists and is active
        Product product = productService.getProductById(productId);
        if (product == null) {
            out.print("{\"error\": \"Product not found\", \"success\": false}");
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        if (!product.isIsActive()) {
            out.print("{\"error\": \"Product is not available\", \"success\": false}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        // Check stock availability
        if (product.getMinStockLevel() < quantity) {
            out.print("{\"error\": \"Insufficient stock. Available: " + product.getMinStockLevel() + 
                     "\", \"success\": false, \"availableStock\": " + product.getMinStockLevel() + "}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        // Check if item already exists in cart
        List<ShoppingCart> existingItems = cartService.getCartItemsByUserId(userId);
        ShoppingCart existingItem = null;
        
        if (existingItems != null) {
            for (ShoppingCart item : existingItems) {
                if (item.getProductID() == productId) {
                    existingItem = item;
                    break;
                }
            }
        }
        
        if (existingItem != null) {
            // Update existing item quantity
            int newQuantity = existingItem.getQuantity() + quantity;
            
            // Check if new quantity exceeds stock
            if (newQuantity > product.getMinStockLevel()) {
                out.print("{\"error\": \"Adding this quantity would exceed available stock. Available: " + 
                         product.getMinStockLevel() + ", Currently in cart: " + existingItem.getQuantity() + 
                         "\", \"success\": false, \"currentQuantity\": " + existingItem.getQuantity() + 
                         ", \"maxAddable\": " + Math.max(0, product.getMinStockLevel() - existingItem.getQuantity()) + "}");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            
            // Update existing item
            cartService.updateCartItem(existingItem.getCartID(), newQuantity);
            
            // Get updated cart count
            List<ShoppingCart> allCartItems = cartService.getCartItemsByUserId(userId);
            int cartCount = (allCartItems != null) ? allCartItems.size() : 0;
            
            out.print("{\"message\": \"Item quantity updated in cart\", \"success\": true, " +
                     "\"productName\": \"" + product.getProductName() + "\", " +
                     "\"quantity\": " + quantity + ", " +
                     "\"newQuantity\": " + newQuantity + ", " +
                     "\"cartId\": " + existingItem.getCartID() + ", " +
                     "\"cartCount\": " + cartCount + ", " +
                     "\"updated\": true}");
            
        } else {
            // Create new cart item
            ShoppingCart cartItem = new ShoppingCart();
            cartItem.setUserID(userId);
            cartItem.setProductID(productId);
            cartItem.setQuantity(quantity);
            cartItem.setUnit(unit != null && !unit.trim().isEmpty() ? unit : product.getUnit());
            cartItem.setAddedDate(new Date());
            
            cartService.addToCart(cartItem);
            
            // Get updated cart count
            List<ShoppingCart> allCartItems = cartService.getCartItemsByUserId(userId);
            int cartCount = (allCartItems != null) ? allCartItems.size() : 0;
            
            out.print("{\"message\": \"Item added to cart successfully\", \"success\": true, " +
                     "\"productName\": \"" + product.getProductName() + "\", " +
                     "\"quantity\": " + quantity + ", " +
                     "\"cartCount\": " + cartCount + ", " +
                     "\"sellingPrice\": " + product.getSellingPrice() + ", " +
                     "\"costPrice\": " + (product.getCostPrice() > 0 ? product.getCostPrice() : product.getSellingPrice()) + ", " +
                     "\"unit\": \"" + product.getUnit() + "\", " +
                     "\"updated\": false}");
        }
        
        System.out.println("Successfully processed add to cart: " + quantity + "x " + product.getProductName());
        
    } catch (NumberFormatException e) {
        out.print("{\"error\": \"Invalid number format for productId or quantity\", \"success\": false}");
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
    }
}
    
    private void handleGetCartItems(HttpServletRequest request, HttpServletResponse response, 
                               Integer userId, PrintWriter out) throws Exception {
    try {
        List<ShoppingCart> cartItems = cartService.getCartItemsByUserId(userId);
        
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("{\"success\": true, \"cartItems\": [");
        
        if (cartItems != null && !cartItems.isEmpty()) {
            for (int i = 0; i < cartItems.size(); i++) {
                ShoppingCart item = cartItems.get(i);
                Product product = productService.getProductById(item.getProductID());
                
                if (product != null) {
                    double sellingPrice = product.getSellingPrice();
                    double costPrice = product.getCostPrice() > 0 ? product.getCostPrice() : sellingPrice;
                    
                    jsonBuilder.append("{")
                        .append("\"cartId\": ").append(item.getCartID()).append(", ")
                        .append("\"productId\": ").append(item.getProductID()).append(", ")
                        .append("\"productName\": \"").append(product.getProductName()).append("\", ")
                        .append("\"quantity\": ").append(item.getQuantity()).append(", ")
                        .append("\"sellingPrice\": ").append(sellingPrice).append(", ")
                        .append("\"costPrice\": ").append(costPrice).append(", ")
                        .append("\"unit\": \"").append(product.getUnit()).append("\", ")
                        .append("\"isActive\": ").append(product.isIsActive()).append(", ")
                        .append("\"availableStock\": ").append(product.getMinStockLevel())
                        .append("}");
                    
                    if (i < cartItems.size() - 1) {
                        jsonBuilder.append(", ");
                    }
                }
            }
        }
        
        jsonBuilder.append("], \"cartCount\": ").append(cartItems != null ? cartItems.size() : 0).append("}");
        
        out.print(jsonBuilder.toString());
        
    } catch (Exception e) {
        out.print("{\"error\": \"Error retrieving cart items: " + e.getMessage() + "\", \"success\": false}");
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
}
    
    
    private void handleUpdateCart(HttpServletRequest request, HttpServletResponse response, 
                             Integer userId, PrintWriter out) throws Exception {
    String cartIdStr = request.getParameter("cartId");
    String quantityStr = request.getParameter("quantity");
    
    System.out.println("Updating cart - CartID: " + cartIdStr + ", Quantity: " + quantityStr);
    
    if (cartIdStr == null || quantityStr == null) {
        out.print("{\"error\": \"Missing required parameters (cartId, quantity)\", \"success\": false}");
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        return;
    }
    
    try {
        int cartId = Integer.parseInt(cartIdStr);
        int quantity = Integer.parseInt(quantityStr);
        
        if (quantity <= 0) {
            out.print("{\"error\": \"Quantity must be greater than 0\", \"success\": false}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        if (quantity > 999) {
            out.print("{\"error\": \"Maximum quantity is 999\", \"success\": false, \"maxQuantity\": 999}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        // Validate cart item exists and belongs to user
        ShoppingCart cartItem = cartService.getCartItemById(cartId);
        if (cartItem == null) {
            out.print("{\"error\": \"Cart item not found\", \"success\": false}");
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        if (cartItem.getUserID() != userId.intValue()) {
            out.print("{\"error\": \"Access denied - cart item belongs to different user\", \"success\": false}");
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        // Get product info for validation and response
        Product product = productService.getProductById(cartItem.getProductID());
        if (product == null) {
            out.print("{\"error\": \"Product not found\", \"success\": false}");
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Validate product is still active
        if (!product.isIsActive()) {
            out.print("{\"error\": \"Product is no longer available\", \"success\": false}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        // Validate stock availability
        if (quantity > product.getMinStockLevel()) {
            out.print("{\"error\": \"Quantity exceeds available stock. Available: " + product.getMinStockLevel() + 
                     "\", \"success\": false, \"maxQuantity\": " + product.getMinStockLevel() + 
                     ", \"availableStock\": " + product.getMinStockLevel() + "}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        // Update cart item
        cartService.updateCartItem(cartId, quantity);
        
        // Get updated cart count
        List<ShoppingCart> allCartItems = cartService.getCartItemsByUserId(userId);
        int cartCount = (allCartItems != null) ? allCartItems.size() : 0;
        
        // Calculate new item totals
        double sellingPrice = product.getSellingPrice();
        double costPrice = product.getCostPrice() > 0 ? product.getCostPrice() : sellingPrice;
        double itemTotal = sellingPrice * quantity;
        double itemOriginalTotal = costPrice * quantity;
        double itemSaving = (costPrice > sellingPrice) ? (costPrice - sellingPrice) * quantity : 0;
        
        // Return detailed response for frontend
        out.print("{\"message\": \"Cart updated successfully\", \"success\": true, " +
                 "\"cartId\": " + cartId + ", " +
                 "\"newQuantity\": " + quantity + ", " +
                 "\"cartCount\": " + cartCount + ", " +
                 "\"productName\": \"" + product.getProductName() + "\", " +
                 "\"sellingPrice\": " + sellingPrice + ", " +
                 "\"costPrice\": " + costPrice + ", " +
                 "\"itemTotal\": " + itemTotal + ", " +
                 "\"itemOriginalTotal\": " + itemOriginalTotal + ", " +
                 "\"itemSaving\": " + itemSaving + ", " +
                 "\"unit\": \"" + product.getUnit() + "\"}");
        
        System.out.println("Successfully updated cart item " + cartId + " to quantity " + quantity + 
                          " (Product: " + product.getProductName() + ", Total: " + itemTotal + ")");
        
    } catch (NumberFormatException e) {
        out.print("{\"error\": \"Invalid number format for cartId or quantity\", \"success\": false}");
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
    }
}
    
    private void handleRemoveFromCart(HttpServletRequest request, HttpServletResponse response, 
                                 Integer userId, PrintWriter out) throws Exception {
    String cartIdStr = request.getParameter("cartId");
    
    System.out.println("Removing from cart - CartID: " + cartIdStr);
    
    if (cartIdStr == null) {
        out.print("{\"error\": \"Missing required parameter: cartId\", \"success\": false}");
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        return;
    }
    
    try {
        int cartId = Integer.parseInt(cartIdStr);
        
        // Validate cart item exists and belongs to user
        ShoppingCart cartItem = cartService.getCartItemById(cartId);
        if (cartItem == null) {
            out.print("{\"error\": \"Cart item not found\", \"success\": false}");
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        if (cartItem.getUserID() != userId.intValue()) {
            out.print("{\"error\": \"Access denied - cart item belongs to different user\", \"success\": false}");
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        // Get product info for response
        String productName = "Unknown Product";
        double sellingPrice = 0;
        double costPrice = 0;
        String unit = "piece";
        
        try {
            Product product = productService.getProductById(cartItem.getProductID());
            if (product != null) {
                productName = product.getProductName();
                sellingPrice = product.getSellingPrice();
                costPrice = product.getCostPrice() > 0 ? product.getCostPrice() : sellingPrice;
                unit = product.getUnit();
            }
        } catch (Exception e) {
            System.err.println("Error getting product info for removal: " + e.getMessage());
        }
        
        // Remove cart item
        cartService.removeCartItem(cartId);
        
        // Get updated cart count
        List<ShoppingCart> remainingItems = cartService.getCartItemsByUserId(userId);
        int cartCount = (remainingItems != null) ? remainingItems.size() : 0;
        
        // Return detailed response
        out.print("{\"message\": \"Item removed from cart successfully\", \"success\": true, " +
                 "\"cartId\": " + cartId + ", " +
                 "\"productName\": \"" + productName + "\", " +
                 "\"cartCount\": " + cartCount + ", " +
                 "\"isEmpty\": " + (cartCount == 0) + ", " +
                 "\"sellingPrice\": " + sellingPrice + ", " +
                 "\"costPrice\": " + costPrice + ", " +
                 "\"unit\": \"" + unit + "\", " +
                 "\"removedQuantity\": " + cartItem.getQuantity() + "}");
        
        System.out.println("Successfully removed " + productName + " from cart (ID: " + cartId + 
                          "). Remaining items: " + cartCount);
        
    } catch (NumberFormatException e) {
        out.print("{\"error\": \"Invalid cart ID format\", \"success\": false}");
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
    }
}
    
    private void handleApplyPromoCode(HttpServletRequest request, HttpServletResponse response, 
                                     HttpSession session, PrintWriter out) throws Exception {
        String promoCode = request.getParameter("promoCode");
        
        System.out.println("Applying promo code: " + promoCode);
        
        if (promoCode == null || promoCode.trim().isEmpty()) {
            out.print("{\"error\": \"Promo code is required\", \"success\": false}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        promoCode = promoCode.trim().toUpperCase();
        
        // Check if promo code exists
        if (!PROMO_CODES.containsKey(promoCode)) {
            out.print("{\"error\": \"Invalid promo code\", \"success\": false, " +
                     "\"availableCodes\": [\"SAVE10\", \"WELCOME20\", \"FMART50\", \"FLAT50K\", \"NEWUSER\", \"ILOVEFMART\"]}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        // Check if same promo code is already applied
        String currentPromo = (String) session.getAttribute("promoCode");
        if (promoCode.equals(currentPromo)) {
            out.print("{\"message\": \"This promo code is already applied\", \"success\": true, " +
                     "\"promoCode\": \"" + promoCode + "\", \"alreadyApplied\": true}");
            return;
        }
        
        PromoCode promo = PROMO_CODES.get(promoCode);
        
        // Store promo code in session
        session.setAttribute("promoCode", promoCode);
        session.setAttribute("promoDiscount", promo.value);
        session.setAttribute("promoType", promo.type);
        session.setAttribute("promoMax", promo.max);
        
        out.print("{\"message\": \"Promo code applied successfully\", \"success\": true, " +
                 "\"promoCode\": \"" + promoCode + "\", " +
                 "\"description\": \"" + promo.description + "\", " +
                 "\"type\": \"" + promo.type + "\", " +
                 "\"value\": " + promo.value + ", " +
                 "\"max\": " + promo.max + "}");
        
        System.out.println("Successfully applied promo code: " + promoCode + " (" + promo.description + ")");
    }
    
    private void handleClearPromoCode(HttpServletRequest request, HttpServletResponse response, 
                                     HttpSession session, PrintWriter out) throws Exception {
        String removedPromo = (String) session.getAttribute("promoCode");
        
        // Clear promo code from session
        session.removeAttribute("promoCode");
        session.removeAttribute("promoDiscount");
        session.removeAttribute("promoType");
        session.removeAttribute("promoMax");
        
        out.print("{\"message\": \"Promo code cleared successfully\", \"success\": true" + 
                 (removedPromo != null ? ", \"removedPromo\": \"" + removedPromo + "\"" : "") + "}");
        
        System.out.println("Cleared promo code" + (removedPromo != null ? ": " + removedPromo : ""));
    }
    
    private void handleGetCartSummary(HttpServletRequest request, HttpServletResponse response, 
                                     Integer userId, HttpSession session, PrintWriter out) throws Exception {
        List<ShoppingCart> cartItems = cartService.getCartItemsByUserId(userId);
        CartSummary summary = calculateCartSummary(cartItems, session);
        
        out.print("{\"success\": true, " +
                 "\"subtotal\": " + summary.subtotal + ", " +
                 "\"totalSaving\": " + summary.totalSaving + ", " +
                 "\"deliveryCharge\": " + summary.deliveryCharge + ", " +
                 "\"promoDiscount\": " + summary.promoDiscount + ", " +
                 "\"grandTotal\": " + summary.grandTotal + ", " +
                 "\"totalQuantity\": " + summary.totalQuantity + ", " +
                 "\"itemCount\": " + (cartItems != null ? cartItems.size() : 0) + "}");
        
        System.out.println("Cart summary requested - Total: " + summary.grandTotal);
    }
    
    private CartSummary calculateCartSummary(List<ShoppingCart> cartItems, HttpSession session) {
        CartSummary summary = new CartSummary();
        
        if (cartItems == null || cartItems.isEmpty()) {
            return summary;
        }
        
        // Calculate subtotal, savings, and total quantity
        for (ShoppingCart item : cartItems) {
            try {
                Product product = productService.getProductById(item.getProductID());
                if (product != null) {
                    double sellingPrice = product.getSellingPrice();
                    double costPrice = product.getCostPrice() > 0 ? product.getCostPrice() : sellingPrice;
                    int quantity = item.getQuantity();
                    
                    // Calculate item subtotal
                    double itemSubtotal = sellingPrice * quantity;
                    summary.subtotal += itemSubtotal;
                    summary.totalQuantity += quantity;
                    
                    // Calculate savings (difference between cost price and selling price)
                    if (costPrice > sellingPrice) {
                        summary.totalSaving += (costPrice - sellingPrice) * quantity;
                    }
                    
                    // Update cart item with current product info
                    item.setSellingPrice(sellingPrice);
                    item.setCostPrice(costPrice);
                    item.setProductName(product.getProductName());
                    item.setUnit(product.getUnit());
                }
            } catch (Exception e) {
                System.err.println("Error calculating summary for cart item " + item.getCartID() + ": " + e.getMessage());
            }
        }
        
        // Calculate promo discount
        String promoCode = (String) session.getAttribute("promoCode");
        if (promoCode != null && PROMO_CODES.containsKey(promoCode)) {
            PromoCode promo = PROMO_CODES.get(promoCode);
            
            if ("percentage".equals(promo.type)) {
                summary.promoDiscount = summary.subtotal * (promo.value / 100.0);
                // Apply maximum discount limit if specified
                if (promo.max > 0) {
                    summary.promoDiscount = Math.min(summary.promoDiscount, promo.max);
                }
            } else if ("fixed".equals(promo.type)) {
                // Fixed amount discount, but not more than subtotal
                summary.promoDiscount = Math.min(promo.value, summary.subtotal);
            }
        }
        
        // Calculate delivery charge based on subtotal after promo discount
        double subtotalAfterPromo = summary.subtotal - summary.promoDiscount;
        summary.deliveryCharge = calculateDeliveryCharge(subtotalAfterPromo, summary.totalQuantity);
        
        // Calculate grand total
        summary.grandTotal = subtotalAfterPromo + summary.deliveryCharge;
        
        // Ensure no negative values
        summary.subtotal = Math.max(0, summary.subtotal);
        summary.totalSaving = Math.max(0, summary.totalSaving);
        summary.promoDiscount = Math.max(0, summary.promoDiscount);
        summary.deliveryCharge = Math.max(0, summary.deliveryCharge);
        summary.grandTotal = Math.max(0, summary.grandTotal);
        
        return summary;
    }
    
    private double calculateDeliveryCharge(double subtotal, int totalQuantity) {
        // Free delivery for orders over 500,000 VND
        if (subtotal >= 500000) {
            return 0;
        }
        
        // Base delivery charge: 30,000 VND
        // Additional charge: 5,000 VND per item
        // Maximum delivery charge: 100,000 VND
        final double baseCharge = 30000;
        final double perItemCharge = 5000;
        final double maxCharge = 100000;
        
        double calculatedCharge = baseCharge + (totalQuantity * perItemCharge);
        return Math.min(calculatedCharge, maxCharge);
    }
    
    // Inner classes for data structures
    private static class PromoCode {
        final String type;        // "percentage" or "fixed"
        final double value;       // percentage (0-100) or fixed amount
        final double max;         // maximum discount for percentage type (0 = no limit)
        final String description; // human-readable description
        
        public PromoCode(String type, double value, double max, String description) {
            this.type = type;
            this.value = value;
            this.max = max;
            this.description = description;
        }
    }
    
    private static class CartSummary {
        double subtotal = 0;           // Total price of all items before discounts
        double totalSaving = 0;        // Total savings from price differences (cost vs selling)
        double deliveryCharge = 0;     // Delivery/shipping charge
        double promoDiscount = 0;      // Discount from promo code
        double grandTotal = 0;         // Final total amount
        int totalQuantity = 0;         // Total number of items in cart
    }
    
    @Override
    public void destroy() {
        super.destroy();
        System.out.println("CartServlet destroyed");
    }
}