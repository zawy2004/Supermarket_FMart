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
    public List<Product> searchProducts(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return new ArrayList<>();
        }
        return ProductDAO.searchProducts(keyword.trim());
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