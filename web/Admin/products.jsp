<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product, model.Category" %>
<%@ page import="dao.ProductDAO,dao.CategoryDAO" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description-gambolthemes" content="">
        <meta name="author-gambolthemes" content="">
        <title>FMart Supermarket Admin</title>
        <link href="Admin/css/styles.css" rel="stylesheet">
        <link href="Admin/css/admin-style.css" rel="stylesheet">

        <!-- Vendor Stylesheets -->
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    </head>

    <body class="sb-nav-fixed">
        <body class="sb-nav-fixed">
        <!-- Header -->
            <jsp:include page="header.jsp"></jsp:include>
        <div id="layoutSidenav">
            <!-- Sidebar -->
            <jsp:include page="managersidebar.jsp"></jsp:include>
            

            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h2 class="mt-30 page-title">Products</h2>
                        <ol class="breadcrumb mb-30">
                            <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active">Products</li>
                        </ol>
                        <div class="row justify-content-between">
                            <div class="col-lg-12">
                                <a href="ProductServlet?action=add"class="btn btn-sm btn-primary">Add New</a>
                            </div>
                            <div class="col-lg-3 col-md-4">
                                <div class="bulk-section mt-30">
                                    <div class="input-group">
                                        <select id="action" name="action" class="form-control">
                                            <option selected>Bulk Actions</option>
                                            <option value="1">Active</option>
                                            <option value="2">Inactive</option>
                                            <option value="3">Delete</option>
                                        </select>
                                        <div class="input-group-append">
                                            <button class="status-btn hover-btn" type="submit">Apply</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-5 col-md-6">
                                <div class="bulk-section mt-30">
                                    <form action="ProductServlet" method="get" class="form-inline" style="gap: 8px;">
                                        <input type="hidden" name="action" value="list" />
                                        <input
                                            type="text"
                                            class="form-control"
                                            name="keyword"
                                            placeholder="Search by name, SKU, brand..."
                                            value="${param.keyword != null ? param.keyword : ''}"
                                            style="min-width: 160px;"
                                            />
                                        <select name="categoryId" class="form-control" style="min-width: 120px;">
                                            <option value="">All Categories</option>
                                            <c:forEach var="cat" items="${categories}">
                                                <option value="${cat.categoryID}" <c:if test="${param.categoryId == cat.categoryID}">selected</c:if>>${cat.categoryName}</option>
                                            </c:forEach>
                                        </select>
                                        <button class="status-btn hover-btn btn btn-primary" type="submit">Search</button>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Display Product Table -->
                        <div class="card card-static-2 mt-30 mb-30">
                            <div class="card-title-2 pb-3">
                                <h4>All Products</h4>
                            </div>
                            <div class="card-body-table">
                                <div class="table-responsive">
                                    <table class="table ucp-table table-hover">
                                        <thead>
                                            <tr>
                                                <th style="width:60px"><input type="checkbox" class="check-all"></th>
                                                <th style="width:60px">ID</th>
                                                <th style="width:100px">Image</th>
                                                <th>Name</th>
                                                <th>Category</th>
                                                <th>Created</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>  
                                        </thead>
                                        <tbody>
                                            <c:forEach var="product" items="${products}">
                                                <tr>
                                                    <td><input type="checkbox" class="check-item" name="ids[]" value="${product.productID}"></td>
                                                    <td>${product.productID}</td>
                                                    <td>
                                                        <div class="cate-img-5">
                                                            <img src="User/${productMainImages[product.productID]}" alt="${product.productName}" style="max-width: 60px; max-height: 60px;">
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
                                                    <td class="action-btns">
                                                        <a href="ProductServlet?action=view&productId=${product.productID}" class="view-shop-btn" title="View"><i class="fas fa-eye"></i></a>
                                                        <a href="ProductServlet?action=edit&productId=${product.productID}" class="btn btn-sm btn-primary">Edit</a>
                                                        <a href="ProductServlet?action=delete&productId=${product.productID}"
                                                           class="btn btn-sm btn-danger"
                                                           onclick="return confirm('Are you sure you want to delete this product?');">
                                                            Delete
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <nav aria-label="Page navigation" class="mt-4">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item <c:if test='${page == 1}'>disabled</c:if>'">
                                                <a class="page-link"
                                                   href="?page=${page-1}&keyword=${param.keyword}&categoryId=${param.categoryId}">Previous</a>
                                        </li>
                                        <c:choose>
                                            <c:when test="${totalPages <= 7}">
                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                                    <li class="page-item <c:if test='${i == page}'>active</c:if>'">
                                                            <a class="page-link"
                                                               href="?page=${i}&keyword=${param.keyword}&categoryId=${param.categoryId}">${i}</a>
                                                    </li>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item <c:if test='${1 == page}'>active</c:if>'">
                                                        <a class="page-link"
                                                           href="?page=1&keyword=${param.keyword}&categoryId=${param.categoryId}">1</a>
                                                </li>
                                                <c:if test="${page > 4}">
                                                    <li class="page-item disabled"><span class="page-link">...</span></li>
                                                    </c:if>
                                                    <c:forEach var="i" begin="${page-1}" end="${page+1}">
                                                        <c:if test="${i > 1 && i < totalPages}">
                                                        <li class="page-item <c:if test='${i == page}'>active</c:if>'">
                                                                <a class="page-link"
                                                                   href="?page=${i}&keyword=${param.keyword}&categoryId=${param.categoryId}">${i}</a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${page < totalPages - 3}">
                                                    <li class="page-item disabled"><span class="page-link">...</span></li>
                                                    </c:if>
                                                <li class="page-item <c:if test='${totalPages == page}'>active</c:if>'">
                                                        <a class="page-link"
                                                           href="?page=${totalPages}&keyword=${param.keyword}&categoryId=${param.categoryId}">${totalPages}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                        <li class="page-item <c:if test='${page == totalPages || totalPages == 0}'>disabled</c:if>'">
                                                <a class="page-link"
                                                   href="?page=${page+1}&keyword=${param.keyword}&categoryId=${param.categoryId}">Next</a>
                                        </li>
                                    </ul>
                                </nav>

                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="Admin/js/jquery.min.js"></script>
        <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="Admin/js/scripts.js"></script>
    </body>

</html>