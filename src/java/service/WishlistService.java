package service;

import dao.WishlistDAO;
import model.Wishlist;
import java.util.List;
import model.Product;

public class WishlistService {
    
    private final WishlistDAO wishlistDAO;

    public WishlistService() {
        this.wishlistDAO = new WishlistDAO();
    }

    /**
     * Thêm sản phẩm vào wishlist nếu chưa có
     */
    public void addToWishlist(Wishlist wishlistItem) {
        if (!wishlistDAO.isInWishlist(wishlistItem.getUserID(), wishlistItem.getProductID())) {
            wishlistDAO.addWishlistItem(wishlistItem);
        }
    }

    /**
     * Xóa sản phẩm khỏi wishlist
     */
    public void removeFromWishlist(int userId, int productId) {
        wishlistDAO.removeWishlistItem(userId, productId);
    }

    /**
     * Kiểm tra sản phẩm đã có trong wishlist hay chưa
     */
    public boolean isInWishlist(int userId, int productId) {
        return wishlistDAO.isInWishlist(userId, productId);
    }

    /**
     * Lấy danh sách sản phẩm wishlist của user
     */
    public List<Product> getWishlistItems(int userId) {
        return wishlistDAO.getWishlistProducts(userId);
    }
}
