<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Product" %>
<%@ page import="dao.ProductDAO" %>

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
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
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
                            <h2 class="mt-30 page-title">Product Details</h2>
                            <ol class="breadcrumb mb-30">
                                <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="ProductServlet">Products</a></li>
                                <li class="breadcrumb-item active">Product View</li>
                            </ol>

                            <div class="row">
                                <div class="col-lg-5 col-md-6">
                                    <div class="card card-static-2 mb-30">
                                        <div class="card-body-table pt-4">
                                            <div class="product-owner-content-left text-center pd-20">
                                                <!-- Hi?n th? hình ?nh s?n ph?m -->
                                                <div class="product_img">
                                                    <img src="Admin/${productMainImage}" alt="${product.productName}" style="max-width: 120px; max-height: 120px;">
                                            </div>


                                            <ul class="product-dt-purchases">
                                                <li>
                                                    <div class="product-status">
                                                        Price <span class="badge-item-2 badge-status">${product.sellingPrice}</span>
                                                    </div>
                                                </li>
                                                <li>
                                                    <div class="product-status">
                                                        Category <span class="badge-item-2 badge-status">${product.categoryID}</span>
                                                    </div>
                                                </li>
                                            </ul>
                                            <div class="product-owner-dts">
                                                <div class="product-owner-dt-list">
                                                    <span class="left-dt">SKU</span>
                                                    <span class="right-dt">${product.sku}</span>
                                                </div>
                                                <div class="product-owner-dt-list">
                                                    <span class="left-dt">Brand</span>
                                                    <span class="right-dt">${product.brand}</span>
                                                </div>
                                                <div class="product-owner-dt-list">
                                                    <span class="left-dt">Description</span>
                                                    <span class="right-dt">${product.description}</span>
                                                </div>
                                                <div class="product-owner-dt-list">
                                                    <span class="left-dt">Created</span>
                                                    <span class="right-dt">${product.createdDate}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <a href="ProductServlet?action=edit&productId=${product.productID}" class="btn btn-sm btn-primary">Edit</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </main>

                <footer class="py-4 bg-footer mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted-1">© 2025 <b>FMart Supermarket</b></div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>

        <script src="Admin/js/jquery.min.js"></script>
        <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="Admin/js/scripts.js"></script>
    </body>
</html>