
package service;

import dao.WishlistDAO;
import model.Wishlist;

public class WishlistService {
    
    private WishlistDAO wishlistDAO;
    
    public WishlistService() {
        this.wishlistDAO = new WishlistDAO();
    }
    
    public void addToWishlist(Wishlist wishlistItem) {
        if (!wishlistDAO.isInWishlist(wishlistItem.getUserID(), wishlistItem.getProductID())) {
            wishlistDAO.addWishlistItem(wishlistItem);
        }
    }
    
    public void removeFromWishlist(int userId, int productId) {
        wishlistDAO.removeWishlistItem(userId, productId);
    }
    
    public boolean isInWishlist(int userId, int productId) {
        return wishlistDAO.isInWishlist(userId, productId);
    }
}
