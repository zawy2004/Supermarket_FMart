<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>FMart - Shop Grid</title>
    <link href="User/css/style.css" rel="stylesheet">
    <link href="User/css/responsive.css" rel="stylesheet">
    <link href="User/css/night-mode.css" rel="stylesheet">
    <link href="User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="User/vendor/OwlCarousel/assets/owl.carousel.css" rel="stylesheet">
    <link href="User/vendor/OwlCarousel/assets/owl.theme.default.min.css" rel="stylesheet">
    <link href="User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="User/vendor/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet">
</head>
<body>
    <!-- Header -->
    <jsp:include page="header.jsp"/>
    <!-- Filter Sidebar -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasFilter" aria-labelledby="offcanvasFilterLabel">
        <div class="offcanvas-header bs-canvas-header side-cart-header p-3">
            <div class="d-inline-block main-cart-title" id="offcanvasFilterLabel">Filter</div>
            <button type="button" class="close-btn" data-bs-dismiss="offcanvas" aria-label="Close">
                <i class="uil uil-multiply"></i>
            </button>
        </div>
        <div class="offcanvas-body p-0">
            <div class="filter-items">
                <div class="filtr-cate-title"><h4>Categories</h4></div>
                <div class="filter-item-body scrollstyle_4">
                    <ul class="cte-select">
                        <li>
                            <a href="shop_grid" <c:if test="${empty currentCatId}">class="fw-bold text-success"</c:if>>Tất cả</a>
                        </li>
                        <c:forEach var="cat" items="${categories}">
                            <li>
                                <a href="shop_grid?cat=${cat.categoryID}" 
                                   <c:if test="${cat.categoryID == currentCatId}">class="fw-bold text-success"</c:if>>
                                    ${cat.categoryName}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb -->
    <div class="gambo-Breadcrumb">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">
                                <c:choose>
                                    <c:when test="${not empty currentCatId}">
                                        <c:forEach var="cat" items="${categories}">
                                            <c:if test="${cat.categoryID == currentCatId}">${cat.categoryName}</c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>Tất cả sản phẩm</c:otherwise>
                                </c:choose>
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!-- Body -->
    <div class="wrapper">
        <div class="all-product-grid">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product-top-dt">
                            <div class="product-left-title">
                                <h2>
                                    <c:choose>
                                        <c:when test="${not empty currentCatId}">
                                            <c:forEach var="cat" items="${categories}">
                                                <c:if test="${cat.categoryID == currentCatId}">${cat.categoryName}</c:if>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>Tất cả sản phẩm</c:otherwise>
                                    </c:choose>
                                </h2>
                            </div>
                            <a href="#" class="filter-btn" data-bs-toggle="offcanvas" data-bs-target="#offcanvasFilter" aria-controls="offcanvasFilter">Filters</a>
                            <div class="product-sort main-form">
                                <select class="selectpicker" data-width="25%">
                                    <option value="0">Popularity</option>
                                    <option value="1">Price - Low to High</option>
                                    <option value="2">Price - High to Low</option>
                                    <option value="3">Alphabetical</option>
                                    <option value="4">Saving - High to Low</option>
                                    <option value="5">Saving - Low to High</option>
                                    <option value="6">% Off - High to Low</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Sản phẩm động -->
                <div class="product-list-view">
                    <div class="row">
                        <c:forEach var="product" items="${products}">
                                                <tr>
                                                    
                                                    <td>${product.productID}</td>
                                                    <td>
                                                        <div class="cate-img-5">
                                                            <img src="Admin/images/product/img-1.jpg" alt="">
                                                        </div>
                                                    </td>
                                                    <td>${product.productName}</td>
                                                    <td>
                                                        <c:forEach var="cat" items="${categories}">
                                                            <c:if test="${cat.categoryID == product.categoryID}">
                                                                ${cat.categoryName}
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>




                                                    <td>${product.createdDate}</td>
                                                    <td><span class="badge-item badge-status">${product.isActive ? 'Active' : 'Inactive'}</span></td>

                                                </tr>
                                            </c:forEach>
                        <c:if test="${empty products}">
                            <div class="col-12"><p>Không có sản phẩm nào.</p></div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer -->
    <jsp:include page="footer.jsp"/>
    <!-- JS -->
    <script src="User/js/jquery.min.js"></script>
    <script src="User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="User/vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
    <script src="User/vendor/OwlCarousel/owl.carousel.js"></script>
    <script src="User/js/jquery.countdown.min.js"></script>
    <script src="User/js/custom.js"></script>
    <script src="User/js/offset_overlay.js"></script>
    <script src="User/js/night-mode.js"></script>
</body>
</html>
