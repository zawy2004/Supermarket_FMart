
package service;

import dao.ShoppingCartDAO;
import dao.WishlistDAO;
import model.ShoppingCart;

import java.util.Date;
import java.util.List;

public class ShoppingCartService {
    
    private ShoppingCartDAO cartDAO;
    private WishlistDAO wishlistDAO;
    
    public ShoppingCartService() {
        this.cartDAO = new ShoppingCartDAO();
        this.wishlistDAO = new WishlistDAO();
    }
    
    public void addToCart(ShoppingCart cartItem) {
        ShoppingCart existingItem = cartDAO.getCartItem(cartItem.getUserID(), cartItem.getProductID());
        if (existingItem != null) {
            existingItem.setQuantity(existingItem.getQuantity() + cartItem.getQuantity());
            existingItem.setUnit(cartItem.getUnit());
            existingItem.setAddedDate(new Date());
            cartDAO.updateCartItem(existingItem);
        } else {
            cartItem.setAddedDate(new Date());
            cartDAO.addCartItem(cartItem);
        }
    }
    
    public void updateCartItem(int cartId, int quantity) {
        ShoppingCart cartItem = cartDAO.getCartItemById(cartId);
        if (cartItem != null) {
            cartItem.setQuantity(quantity);
            cartItem.setAddedDate(new Date());
            cartDAO.updateCartItem(cartItem);
        }
    }
    
    public void removeCartItem(int cartId) {
        cartDAO.removeCartItem(cartId);
    }
    
    public List<ShoppingCart> getCartItemsByUserId(int userId) {
        return cartDAO.getCartItemsByUserId(userId);
    }
    
    public boolean isInWishlist(int userId, int productId) {
        return wishlistDAO.isInWishlist(userId, productId);
    }
}
