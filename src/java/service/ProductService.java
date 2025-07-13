package service;

import dao.ProductDAO;
import model.Product;
import java.util.*;
import java.util.stream.Collectors;
import model.ProductImage;

public class ProductService {

    /**
     * Lấy tất cả sản phẩm
     */
    public List<Product> getAllProducts() {
        return ProductDAO.getAllProducts();
    }

    /**
     * Lấy chỉ sản phẩm active
     */
    public List<Product> getActiveProducts() {
        return ProductDAO.getActiveProducts();
    }

    /**
     * Lấy sản phẩm theo ID
     */
    public Product getProductById(int productId) {
        return ProductDAO.getProductById(productId);
    }

    /**
     * Lấy sản phẩm theo category ID
     */
    public List<Product> getProductsByCategory(int categoryId) {
        return ProductDAO.getProductsByCategory(categoryId);
    }

    /**
     * Tìm kiếm sản phẩm theo từ khóa
     */
// Trong ProductService.java, thay thế method searchProducts

public List<Product> searchProducts(String keyword) {
    if (keyword == null || keyword.trim().isEmpty()) {
        return new ArrayList<>();
    }
    
    String searchKeyword = keyword.trim();
    System.out.println("ProductService.searchProducts called with: " + searchKeyword);
    
    // Thử search thông thường trước
    List<Product> results = ProductDAO.searchProducts(searchKeyword);
    
    // Nếu không có kết quả, thử các chiến lược khác
    if (results.isEmpty()) {
        System.out.println("No direct matches, trying alternative search strategies...");
        
        // 1. Thử search bỏ dấu (nếu có)
        String normalizedKeyword = removeVietnameseAccents(searchKeyword);
        if (!normalizedKeyword.equals(searchKeyword)) {
            results = ProductDAO.searchProducts(normalizedKeyword);
        }
        
        // 2. Thử search từng từ
        if (results.isEmpty()) {
            results = searchByWords(searchKeyword);
        }
        
        // 3. Thử search gần đúng
        if (results.isEmpty()) {
            results = fuzzySearch(searchKeyword);
        }
    }
    
    System.out.println("Total search results: " + results.size());
    return results;
}

// Helper method: Search từng từ riêng biệt
private List<Product> searchByWords(String keyword) {
    List<Product> results = new ArrayList<>();
    String[] words = keyword.toLowerCase().split("\\s+");
    
    for (String word : words) {
        if (word.length() > 2) { // Chỉ search từ có ít nhất 3 ký tự
            List<Product> wordResults = ProductDAO.searchProducts(word);
            for (Product p : wordResults) {
                // Tránh duplicate
                if (!results.contains(p)) {
                    results.add(p);
                }
            }
        }
    }
    
    return results;
}

// Helper method: Fuzzy search (tìm kiếm gần đúng)
private List<Product> fuzzySearch(String keyword) {
    List<Product> allProducts = ProductDAO.getActiveProducts();
    List<Product> fuzzyResults = new ArrayList<>();
    
    keyword = keyword.toLowerCase();
    
    for (Product product : allProducts) {
        String productName = product.getProductName().toLowerCase();
        
        // Kiểm tra nếu tên sản phẩm chứa bất kỳ từ nào trong keyword
        String[] keywordWords = keyword.split("\\s+");
        int matchCount = 0;
        
        for (String word : keywordWords) {
            if (word.length() > 2 && productName.contains(word)) {
                matchCount++;
            }
        }
        
        // Nếu match ít nhất 1 từ, thêm vào kết quả
        if (matchCount > 0) {
            fuzzyResults.add(product);
        }
    }
    
    return fuzzyResults;
}

// Helper method: Bỏ dấu tiếng Việt (basic version)
private String removeVietnameseAccents(String str) {
    if (str == null) return "";
    
    str = str.replaceAll("[àáạảãâầấậẩẫăằắặẳẵ]", "a");
    str = str.replaceAll("[ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴ]", "A");
    str = str.replaceAll("[èéẹẻẽêềếệểễ]", "e");
    str = str.replaceAll("[ÈÉẸẺẼÊỀẾỆỂỄ]", "E");
    str = str.replaceAll("[ìíịỉĩ]", "i");
    str = str.replaceAll("[ÌÍỊỈĨ]", "I");
    str = str.replaceAll("[òóọỏõôồốộổỗơờớợởỡ]", "o");
    str = str.replaceAll("[ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]", "O");
    str = str.replaceAll("[ùúụủũưừứựửữ]", "u");
    str = str.replaceAll("[ÙÚỤỦŨƯỪỨỰỬỮ]", "U");
    str = str.replaceAll("[ỳýỵỷỹ]", "y");
    str = str.replaceAll("[ỲÝỴỶỸ]", "Y");
    str = str.replaceAll("[đ]", "d");
    str = str.replaceAll("[Đ]", "D");
    
    return str;
}
    /**
     * Lọc sản phẩm theo khoảng giá
     */
    public List<Product> filterProductsByPrice(List<Product> products, double minPrice, double maxPrice) {
        if (products == null) {
            return new ArrayList<>();
        }

        return products.stream()
                .filter(p -> p.getSellingPrice() >= minPrice && p.getSellingPrice() <= maxPrice)
                .collect(Collectors.toList());
    }

    /**
     * Sắp xếp sản phẩm theo tiêu chí
     */
    public List<Product> sortProducts(List<Product> products, String sortBy) {
        if (products == null || products.isEmpty()) {
            return new ArrayList<>();
        }

        List<Product> sortedProducts = new ArrayList<>(products);

        switch (sortBy != null ? sortBy.toLowerCase() : "") {
            case "price_asc":
                sortedProducts.sort(Comparator.comparing(Product::getSellingPrice));
                break;
            case "price_desc":
                sortedProducts.sort(Comparator.comparing(Product::getSellingPrice).reversed());
                break;
            case "name_asc":
                sortedProducts.sort(Comparator.comparing(Product::getProductName));
                break;
            case "name_desc":
                sortedProducts.sort(Comparator.comparing(Product::getProductName).reversed());
                break;
            case "newest":
                sortedProducts.sort(Comparator.comparing(Product::getCreatedDate).reversed());
                break;
            case "discount":
                sortedProducts.sort((p1, p2) -> {
                    double discount1 = calculateDiscountPercent(p1);
                    double discount2 = calculateDiscountPercent(p2);
                    return Double.compare(discount2, discount1); // Giảm dần
                });
                break;
            default:
                // Mặc định sắp xếp theo tên
                sortedProducts.sort(Comparator.comparing(Product::getProductName));
                break;
        }

        return sortedProducts;
    }

    /**
     * Tính phần trăm giảm giá
     */
    private double calculateDiscountPercent(Product product) {
        if (product.getCostPrice() > 0 && product.getSellingPrice() < product.getCostPrice()) {
            return ((product.getCostPrice() - product.getSellingPrice()) / product.getCostPrice()) * 100;
        }
        return 0;
    }

    /**
     * Lấy số lượng sản phẩm theo từng category
     */
    public Map<Integer, Integer> getProductCountByCategory() {
        Map<Integer, Integer> countMap = new HashMap<>();
        List<Product> products = getActiveProducts();

        for (Product product : products) {
            int categoryId = product.getCategoryID();
            countMap.put(categoryId, countMap.getOrDefault(categoryId, 0) + 1);
        }

        return countMap;
    }

    /**
     * Lấy sản phẩm nổi bật (có giảm giá)
     */
    public List<Product> getFeaturedProducts(int limit) {
        return ProductDAO.getFeaturedProducts(limit);
    }

    /**
     * Lấy sản phẩm mới nhất
     */
    public List<Product> getNewestProducts(int limit) {
        return ProductDAO.getNewestProducts(limit);
    }

    /**
     * Lấy sản phẩm có giảm giá
     */
    public List<Product> getDiscountedProducts(int limit) {
        return ProductDAO.getDiscountedProducts(limit);
    }

    /**
     * Lấy sản phẩm liên quan
     */
    public List<Product> getRelatedProducts(int productId, int limit) {
        return ProductDAO.getRelatedProducts(productId, limit);
    }

    /**
     * Lấy sản phẩm theo khoảng giá từ database
     */
    public List<Product> getProductsByPriceRange(double minPrice, double maxPrice) {
        return ProductDAO.getProductsByPriceRange(minPrice, maxPrice);
    }

    /**
     * Đếm số sản phẩm theo category
     */
    public int countProductsByCategory(int categoryId) {
        return ProductDAO.countProductsByCategory(categoryId);
    }

    /**
     * Thêm sản phẩm mới
     */
    public boolean addProduct(Product product) {
        try {
            ProductDAO.addProduct(product);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Cập nhật sản phẩm
     */
    public boolean updateProduct(Product product) {
        try {
            ProductDAO.updateProduct(product);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Xóa sản phẩm
     */
    public boolean deleteProduct(int productId) {
        try {
            ProductDAO.deleteProduct(productId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Kiểm tra sản phẩm có tồn tại không
     */
    public boolean isProductExists(int productId) {
        Product product = getProductById(productId);
        return product != null && product.isIsActive(); // Sử dụng method name hiện tại
    }

    /**
     * Lấy tất cả sản phẩm với phân trang
     */
    public List<Product> getProductsByPage(int offset, int pageSize) {
        return ProductDAO.getProductsByPage(offset, pageSize);
    }

    /**
     * Đếm tổng số sản phẩm
     */
    public int getTotalProducts() {
        return ProductDAO.getTotalProducts();
    }
    
    public List<ProductImage> getProductImagesByProductId(int productId) {
    return ProductDAO.getProductImagesByProductId(productId);
}
    
}