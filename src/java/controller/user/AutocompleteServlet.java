package controller.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ProductDAO;
import model.Product;

@WebServlet("/AutocompleteServlet")
public class AutocompleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        
        PrintWriter out = response.getWriter();
        
        if (keyword == null || keyword.trim().length() < 2) {
            out.print("[]");
            return;
        }
        
        try {
            System.out.println("🔍 AutocompleteServlet: Searching for '" + keyword + "'");
            
            // Get suggestions using enhanced search
            List<Product> suggestions = ProductDAO.getAutocompleteSuggestions(keyword.trim());
            
            if (suggestions.isEmpty()) {
                // Try fallback search
                suggestions = ProductDAO.searchProducts(keyword.trim());
                // Limit to top 8 results for autocomplete
                if (suggestions.size() > 8) {
                    suggestions = suggestions.subList(0, 8);
                }
            }
            
            System.out.println("🔍 Found " + suggestions.size() + " suggestions");
            
            // Build JSON response
            StringBuilder json = new StringBuilder();
            json.append("[");
            
            for (int i = 0; i < suggestions.size(); i++) {
                Product p = suggestions.get(i);
                if (i > 0) json.append(",");
                
                // Determine image URL
                String imageUrl = p.getImageUrl();
                if (imageUrl == null || imageUrl.isEmpty() || "null".equals(imageUrl)) {
                    imageUrl = "User/images/product/img-" + p.getProductID() + ".jpg";
                }
                
                // Build product JSON
                json.append("{")
                    .append("\"productId\":").append(p.getProductID()).append(",")
                    .append("\"productName\":\"").append(escapeJson(p.getProductName())).append("\",")
                    .append("\"sellingPrice\":").append(p.getSellingPrice()).append(",")
                    .append("\"costPrice\":").append(p.getCostPrice()).append(",")
                    .append("\"brand\":\"").append(escapeJson(p.getBrand() != null ? p.getBrand() : "")).append("\",")
                    .append("\"description\":\"").append(escapeJson(p.getDescription() != null ? p.getDescription() : "")).append("\",")
                    .append("\"unit\":\"").append(escapeJson(p.getUnit() != null ? p.getUnit() : "")).append("\",")
                    .append("\"imageUrl\":\"").append(escapeJson(imageUrl)).append("\",")
                    .append("\"isActive\":").append(p.isIsActive()).append(",")
                    .append("\"categoryId\":").append(p.getCategoryID()).append(",")
                    .append("\"inStock\":").append(p.getMinStockLevel() > 0 ? "true" : "false")
                    .append("}");
            }
            
            json.append("]");
            out.print(json.toString());
            
            System.out.println("🔍 JSON Response: " + (json.length() > 200 ? 
                json.substring(0, 200) + "..." : json.toString()));
            
        } catch (Exception e) {
            System.err.println("🔍 Error in AutocompleteServlet: " + e.getMessage());
            e.printStackTrace();
            out.print("[]");
        } finally {
            out.flush();
        }
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"")
                 .replace("\n", "\\n")
                 .replace("\r", "\\r")
                 .replace("\t", "\\t")
                 .replace("\\", "\\\\");
    }
}