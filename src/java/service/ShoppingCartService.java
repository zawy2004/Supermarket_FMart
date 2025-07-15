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
    
    /**
     * Add item to cart. If item already exists, update quantity.
     * @param cartItem The cart item to add
     */
    public void addToCart(ShoppingCart cartItem) {
        try {
            ShoppingCart existingItem = cartDAO.getCartItem(cartItem.getUserID(), cartItem.getProductID());
            
            if (existingItem != null) {
                // Item already exists, update quantity
                existingItem.setQuantity(existingItem.getQuantity() + cartItem.getQuantity());
                existingItem.setUnit(cartItem.getUnit());
                existingItem.setAddedDate(new Date());
                cartDAO.updateCartItem(existingItem);
                System.out.println("Updated existing cart item. New quantity: " + existingItem.getQuantity());
            } else {
                // New item, add to cart
                cartItem.setAddedDate(new Date());
                cartDAO.addCartItem(cartItem);
                System.out.println("Added new item to cart: ProductID " + cartItem.getProductID());
            }
        } catch (Exception e) {
            System.err.println("Error in addToCart: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to add item to cart: " + e.getMessage());
        }
    }
    
    /**
     * Update cart item quantity by cart ID
     * @param cartId The cart item ID
     * @param quantity The new quantity
     */
    public void updateCartItem(int cartId, int quantity) {
        try {
            ShoppingCart cartItem = cartDAO.getCartItemById(cartId);
            if (cartItem != null) {
                cartItem.setQuantity(quantity);
                cartItem.setAddedDate(new Date());
                cartDAO.updateCartItem(cartItem);
                System.out.println("Updated cart item " + cartId + " to quantity " + quantity);
            } else {
                System.err.println("Cart item not found for ID: " + cartId);
                throw new RuntimeException("Cart item not found");
            }
        } catch (Exception e) {
            System.err.println("Error in updateCartItem: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to update cart item: " + e.getMessage());
        }
    }
    
    /**
     * Update cart item using ShoppingCart object
     * @param cartItem The cart item to update
     */
    public void updateCartItem(ShoppingCart cartItem) {
        try {
            cartItem.setAddedDate(new Date());
            cartDAO.updateCartItem(cartItem);
            System.out.println("Updated cart item: " + cartItem.getCartID());
        } catch (Exception e) {
            System.err.println("Error in updateCartItem with object: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to update cart item: " + e.getMessage());
        }
    }
    
    /**
     * Remove cart item by cart ID
     * @param cartId The cart item ID
     */
    public void removeCartItem(int cartId) {
        try {
            cartDAO.removeCartItem(cartId);
            System.out.println("Removed cart item: " + cartId);
        } catch (Exception e) {
            System.err.println("Error in removeCartItem: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to remove cart item: " + e.getMessage());
        }
    }
    
    /**
     * Get all cart items for a user
     * @param userId The user ID
     * @return List of cart items
     */
    public List<ShoppingCart> getCartItemsByUserId(int userId) {
        try {
            List<ShoppingCart> cartItems = cartDAO.getCartItemsByUserId(userId);
            System.out.println("Retrieved " + (cartItems != null ? cartItems.size() : 0) + " cart items for user " + userId);
            return cartItems;
        } catch (Exception e) {
            System.err.println("Error in getCartItemsByUserId: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Get a specific cart item by cart ID
     * @param cartId The cart item ID
     * @return ShoppingCart object or null if not found
     */
    public ShoppingCart getCartItemById(int cartId) {
        try {
            ShoppingCart cartItem = cartDAO.getCartItemById(cartId);
            if (cartItem != null) {
                System.out.println("Retrieved cart item: " + cartId);
            } else {
                System.out.println("Cart item not found: " + cartId);
            }
            return cartItem;
        } catch (Exception e) {
            System.err.println("Error in getCartItemById: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Get a cart item for a specific user and product
     * @param userId The user ID
     * @param productId The product ID
     * @return ShoppingCart object or null if not found
     */
    public ShoppingCart getCartItem(int userId, int productId) {
        try {
            ShoppingCart cartItem = cartDAO.getCartItem(userId, productId);
            if (cartItem != null) {
                System.out.println("Found existing cart item for user " + userId + " and product " + productId);
            }
            return cartItem;
        } catch (Exception e) {
            System.err.println("Error in getCartItem: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Check if a product is in wishlist
     * @param userId The user ID
     * @param productId The product ID
     * @return true if in wishlist, false otherwise
     */
    public boolean isInWishlist(int userId, int productId) {
        try {
            boolean inWishlist = wishlistDAO.isInWishlist(userId, productId);
            System.out.println("Product " + productId + " in wishlist for user " + userId + ": " + inWishlist);
            return inWishlist;
        } catch (Exception e) {
            System.err.println("Error in isInWishlist: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Clear all cart items for a user
     * @param userId The user ID
     * @return true if successful, false otherwise
     */
    public boolean clearCart(int userId) {
        try {
            List<ShoppingCart> cartItems = getCartItemsByUserId(userId);
            if (cartItems != null && !cartItems.isEmpty()) {
                for (ShoppingCart item : cartItems) {
                    cartDAO.removeCartItem(item.getCartID());
                }
                System.out.println("Cleared " + cartItems.size() + " items from cart for user " + userId);
                return true;
            } else {
                System.out.println("No items to clear for user " + userId);
                return true;
            }
        } catch (Exception e) {
            System.err.println("Error in clearCart: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Get total number of items in cart
     * @param userId The user ID
     * @return total item count
     */
    public int getCartItemCount(int userId) {
        try {
            List<ShoppingCart> cartItems = getCartItemsByUserId(userId);
            int count = cartItems != null ? cartItems.size() : 0;
            System.out.println("Cart item count for user " + userId + ": " + count);
            return count;
        } catch (Exception e) {
            System.err.println("Error in getCartItemCount: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }
    
    /**
     * Get total quantity of all items in cart
     * @param userId The user ID
     * @return total quantity
     */
    public int getTotalCartQuantity(int userId) {
        try {
            List<ShoppingCart> cartItems = getCartItemsByUserId(userId);
            int totalQuantity = 0;
            
            if (cartItems != null) {
                for (ShoppingCart item : cartItems) {
                    totalQuantity += item.getQuantity();
                }
            }
            
            System.out.println("Total cart quantity for user " + userId + ": " + totalQuantity);
            return totalQuantity;
        } catch (Exception e) {
            System.err.println("Error in getTotalCartQuantity: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }
    
    /**
     * Check if a specific product is in user's cart
     * @param userId The user ID
     * @param productId The product ID
     * @return true if product is in cart, false otherwise
     */
    public boolean isProductInCart(int userId, int productId) {
        try {
            ShoppingCart cartItem = getCartItem(userId, productId);
            boolean inCart = cartItem != null;
            System.out.println("Product " + productId + " in cart for user " + userId + ": " + inCart);
            return inCart;
        } catch (Exception e) {
            System.err.println("Error in isProductInCart: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Validate cart item ownership
     * @param cartId The cart item ID
     * @param userId The user ID
     * @return true if cart item belongs to user, false otherwise
     */
    public boolean validateCartItemOwnership(int cartId, int userId) {
        try {
            ShoppingCart cartItem = getCartItemById(cartId);
            if (cartItem != null && cartItem.getUserID() == userId) {
                System.out.println("Cart item " + cartId + " belongs to user " + userId);
                return true;
            } else {
                System.out.println("Cart item " + cartId + " does not belong to user " + userId);
                return false;
            }
        } catch (Exception e) {
            System.err.println("Error in validateCartItemOwnership: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Update cart item quantity with validation
     * @param cartId The cart item ID
     * @param quantity The new quantity
     * @param userId The user ID (for validation)
     * @return true if successful, false otherwise
     */
    public boolean updateCartItemWithValidation(int cartId, int quantity, int userId) {
        try {
            // Validate ownership
            if (!validateCartItemOwnership(cartId, userId)) {
                System.err.println("Access denied: Cart item " + cartId + " does not belong to user " + userId);
                return false;
            }
            
            // Validate quantity
            if (quantity <= 0) {
                System.err.println("Invalid quantity: " + quantity);
                return false;
            }
            
            // Update quantity
            updateCartItem(cartId, quantity);
            return true;
            
        } catch (Exception e) {
            System.err.println("Error in updateCartItemWithValidation: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Remove cart item with validation
     * @param cartId The cart item ID
     * @param userId The user ID (for validation)
     * @return true if successful, false otherwise
     */
    public boolean removeCartItemWithValidation(int cartId, int userId) {
        try {
            // Validate ownership
            if (!validateCartItemOwnership(cartId, userId)) {
                System.err.println("Access denied: Cart item " + cartId + " does not belong to user " + userId);
                return false;
            }
            
            // Remove item
            removeCartItem(cartId);
            return true;
            
        } catch (Exception e) {
            System.err.println("Error in removeCartItemWithValidation: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}