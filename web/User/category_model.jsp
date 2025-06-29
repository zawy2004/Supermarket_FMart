
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="header-cate-model main-gambo-model modal fade" id="category_model" tabindex="-1" role="dialog" aria-modal="false">
    <div class="modal-dialog category-area" role="document">
        <div class="category-area-inner">
            <div class="modal-header">
                <button type="button" class="close btn-close" data-dismiss="modal" aria-label="Close">
                    <i class="uil uil-multiply"></i>
                </button>
            </div>
            <div class="category-model-content modal-content"> 
                <div class="cate-header">
                    <h4>Select Category</h4>
                </div>
                <ul class="category-by-cat">
                    <c:forEach var="category" items="${categories}">
                        <li>
                            <a href="shop?categoryId=${category.categoryID}" class="single-cat-item">
                                <div class="icon">
                                    <img src="${category.imageUrl}" alt="${category.categoryName}">
                                </div>
                                <div class="text">${category.categoryName}</div>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
                <a href="shop" class="morecate-btn"><i class="uil uil-apps"></i>More Categories</a>
            </div>
        </div>
    </div>
</div>
