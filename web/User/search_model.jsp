
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
                <div class="search-header">
                    <form action="shop" method="get">
                        <input type="search" name="search" placeholder="Search for products..." value="${search}">
                        <button type="submit"><i class="uil uil-search"></i></button>
                    </form>
                </div>
                <div class="search-by-cat">
                    <c:forEach var="category" items="${categories}">
                        <a href="shop?categoryId=${category.categoryID}" class="single-cat">
                            <div class="icon">
                                <img src="${category.imageUrl}" alt="${category.categoryName}">
                            </div>
                            <div class="text">${category.categoryName}</div>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
