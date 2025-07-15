package service;

import dao.WishlistDAO;
import model.Wishlist;
import model.Product;

import java.util.List;

public class WishlistService {
    private WishlistDAO wishlistDAO = new WishlistDAO();

    public void addToWishlist(Wishlist item) {
        if (!wishlistDAO.isInWishlist(item.getUserID(), item.getProductID())) {
            wishlistDAO.addWishlistItem(item);
        }
    }
    public void removeFromWishlist(int userId, int productId) {
        wishlistDAO.removeWishlistItem(userId, productId);
    }
    public List<Product> getWishlistItems(int userId) {
        return wishlistDAO.getWishlistProducts(userId);
    }
    public boolean isInWishlist(int userId, int productId) {
        return wishlistDAO.isInWishlist(userId, productId);
    }
}
