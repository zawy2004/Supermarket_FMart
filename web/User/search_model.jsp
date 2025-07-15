<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="search_model" class="header-cate-model main-gambo-model modal fade" tabindex="-1" role="dialog" aria-modal="false">
    <div class="modal-dialog search-ground-area" role="document">
        <div class="category-area-inner">
            <div class="modal-header">
                <button type="button" class="close btn-close" data-dismiss="modal" aria-label="Close">
                    <i class="uil uil-multiply"></i>
                </button>
            </div>
            <div class="category-model-content modal-content"> 
                <!-- ENHANCED SEARCH HEADER -->
                <div class="search-header">
                    <form action="shop" method="get" style="position: relative;">
                        <input type="search" 
                               name="search" 
                               placeholder="Search for products..." 
                               value="${search}"
                               style="width: 100%; padding: 15px 60px 15px 20px; border: 2px solid #f0f0f0; border-radius: 25px; font-size: 16px; outline: none;">
                        <button type="submit" 
                                style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); background: #007bff; color: white; border: none; padding: 8px 15px; border-radius: 20px; cursor: pointer;">
                            <i class="uil uil-search"></i>
                        </button>
                    </form>
                </div>
                
                <!-- SEARCH BY CATEGORY - ENHANCED -->
                <div class="search-by-cat" style="margin-top: 20px;">
                    <h5 style="margin-bottom: 15px; color: #333; font-weight: 600;">Search by Category:</h5>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px;">
                        <!-- Static categories - replace with dynamic when categories work -->
                        <a href="shop?categoryId=1" class="single-cat" style="display: flex; flex-direction: column; align-items: center; padding: 15px; background: #f8f9fa; border-radius: 10px; text-decoration: none; transition: all 0.3s ease;">
                            <div class="icon" style="margin-bottom: 10px;">
                                <img src="User/images/category/icon-1.svg" alt="Vegetables & Fruits" style="width: 40px; height: 40px;">
                            </div>
                            <div class="text" style="color: #333; font-size: 14px; font-weight: 500; text-align: center;">Vegetables & Fruits</div>
                        </a>
                        
                        <a href="shop?categoryId=2" class="single-cat" style="display: flex; flex-direction: column; align-items: center; padding: 15px; background: #f8f9fa; border-radius: 10px; text-decoration: none; transition: all 0.3s ease;">
                            <div class="icon" style="margin-bottom: 10px;">
                                <img src="User/images/category/icon-2.svg" alt="Grocery & Staples" style="width: 40px; height: 40px;">
                            </div>
                            <div class="text" style="color: #333; font-size: 14px; font-weight: 500; text-align: center;">Grocery & Staples</div>
                        </a>
                        
                        <a href="shop?categoryId=3" class="single-cat" style="display: flex; flex-direction: column; align-items: center; padding: 15px; background: #f8f9fa; border-radius: 10px; text-decoration: none; transition: all 0.3s ease;">
                            <div class="icon" style="margin-bottom: 10px;">
                                <img src="User/images/category/icon-3.svg" alt="Dairy & Eggs" style="width: 40px; height: 40px;">
                            </div>
                            <div class="text" style="color: #333; font-size: 14px; font-weight: 500; text-align: center;">Dairy & Eggs</div>
                        </a>
                        
                        <a href="shop?categoryId=4" class="single-cat" style="display: flex; flex-direction: column; align-items: center; padding: 15px; background: #f8f9fa; border-radius: 10px; text-decoration: none; transition: all 0.3s ease;">
                            <div class="icon" style="margin-bottom: 10px;">
                                <img src="User/images/category/icon-4.svg" alt="Beverages" style="width: 40px; height: 40px;">
                            </div>
                            <div class="text" style="color: #333; font-size: 14px; font-weight: 500; text-align: center;">Beverages</div>
                        </a>
                        
                        <a href="shop?categoryId=5" class="single-cat" style="display: flex; flex-direction: column; align-items: center; padding: 15px; background: #f8f9fa; border-radius: 10px; text-decoration: none; transition: all 0.3s ease;">
                            <div class="icon" style="margin-bottom: 10px;">
                                <img src="User/images/category/icon-5.svg" alt="Snacks" style="width: 40px; height: 40px;">
                            </div>
                            <div class="text" style="color: #333; font-size: 14px; font-weight: 500; text-align: center;">Snacks</div>
                        </a>
                        
                        <a href="shop?categoryId=6" class="single-cat" style="display: flex; flex-direction: column; align-items: center; padding: 15px; background: #f8f9fa; border-radius: 10px; text-decoration: none; transition: all 0.3s ease;">
                            <div class="icon" style="margin-bottom: 10px;">
                                <img src="User/images/category/icon-6.svg" alt="Home Care" style="width: 40px; height: 40px;">
                            </div>
                            <div class="text" style="color: #333; font-size: 14px; font-weight: 500; text-align: center;">Home Care</div>
                        </a>
                        
                        <!-- Dynamic categories if available -->
                        <c:forEach var="category" items="${categories}">
                            <c:if test="${category.categoryID > 6}">
                                <a href="shop?categoryId=${category.categoryID}" class="single-cat" style="display: flex; flex-direction: column; align-items: center; padding: 15px; background: #f8f9fa; border-radius: 10px; text-decoration: none; transition: all 0.3s ease;">
                                    <div class="icon" style="margin-bottom: 10px;">
                                        <img src="${category.imageUrl}" alt="${category.categoryName}" style="width: 40px; height: 40px;">
                                    </div>
                                    <div class="text" style="color: #333; font-size: 14px; font-weight: 500; text-align: center;">${category.categoryName}</div>
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                
                <!-- QUICK SEARCH SUGGESTIONS -->
                <div style="margin-top: 25px; padding-top: 20px; border-top: 1px solid #e0e0e0;">
                    <h6 style="margin-bottom: 15px; color: #666; font-weight: 600;">Popular Searches:</h6>
                    <div style="display: flex; flex-wrap: wrap; gap: 8px;">
                        <a href="shop?search=milk" style="padding: 8px 15px; background: #e3f2fd; color: #1976d2; border-radius: 20px; text-decoration: none; font-size: 13px; transition: all 0.3s ease;">Milk</a>
                        <a href="shop?search=bread" style="padding: 8px 15px; background: #f3e5f5; color: #7b1fa2; border-radius: 20px; text-decoration: none; font-size: 13px; transition: all 0.3s ease;">Bread</a>
                        <a href="shop?search=eggs" style="padding: 8px 15px; background: #fff3e0; color: #f57c00; border-radius: 20px; text-decoration: none; font-size: 13px; transition: all 0.3s ease;">Eggs</a>
                        <a href="shop?search=fruits" style="padding: 8px 15px; background: #e8f5e8; color: #388e3c; border-radius: 20px; text-decoration: none; font-size: 13px; transition: all 0.3s ease;">Fruits</a>
                        <a href="shop?search=vegetables" style="padding: 8px 15px; background: #fce4ec; color: #c2185b; border-radius: 20px; text-decoration: none; font-size: 13px; transition: all 0.3s ease;">Vegetables</a>
                        <a href="shop?search=snacks" style="padding: 8px 15px; background: #ffebee; color: #d32f2f; border-radius: 20px; text-decoration: none; font-size: 13px; transition: all 0.3s ease;">Snacks</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
/* Hover effects for categories */
.single-cat:hover {
    background: #007bff !important;
    color: white !important;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,123,255,0.3);
}

.single-cat:hover .text {
    color: white !important;
}

/* Mobile responsive */
@media (max-width: 768px) {
    .search-by-cat div {
        grid-template-columns: repeat(2, 1fr) !important;
        gap: 10px !important;
    }
    
    .single-cat {
        padding: 10px !important;
    }
    
    .single-cat .icon img {
        width: 30px !important;
        height: 30px !important;
    }
    
    .single-cat .text {
        font-size: 12px !important;
    }
}
</style>