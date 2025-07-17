<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.List, model.Inventory, model.Warehouse" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>FMart Supermarket Admin</title>
        <link href="Admin/css/styles.css" rel="stylesheet">
        <link href="Admin/css/admin-style.css" rel="stylesheet">
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <style>
            .pagination {
                margin-top: 1rem;
            }

            .pagination .page-item {
                margin: 0 3px;
            }

            .pagination .page-link {
                color: #007bff;
                border: 1px solid #dee2e6;
                padding: 6px 12px;
                border-radius: 5px;
                font-weight: 500;
                background-color: #fff;
                transition: all 0.2s ease-in-out;
            }

            .pagination .page-link:hover {
                background-color: #e9f0ff;
                text-decoration: none;
                border-color: #007bff;
                color: #0056b3;
            }

            .pagination .active .page-link {
                background-color: #007bff;
                border-color: #007bff;
                color: #fff;
                font-weight: bold;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            }

            .pagination .disabled .page-link {
                background-color: #f8f9fa;
                color: #adb5bd;
                border-color: #dee2e6;
                cursor: not-allowed;
            }

            .pagination .page-link:focus {
                box-shadow: none;
            }

            /* Dot (...) style */
            .pagination .page-item.disabled span.page-link {
                background: none;
                border: none;
                font-weight: bold;
                color: #6c757d;
                cursor: default;
            }
        </style>

    </head>

    <style>
        .pagination a.active {
            background-color: #007bff;
            color: white;
            border-radius: 4px;
        }
    </style>

    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
            <a class="navbar-brand logo-brand" href="index.jsp">FMart Supermarket</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
            <a href="index.jsp" class="frnt-link"><i class="fas fa-external-link-alt"></i>Home</a>
        </nav>
        <div id="layoutSidenav">
            <jsp:include page="adminsidebar.jsp"></jsp:include>
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid">
                            <h2 class="mt-30 page-title">Inventory</h2>
                            <ol class="breadcrumb mb-30">
                                <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                                <li class="breadcrumb-item active">Inventory</li>
                            </ol>

                            <!-- Bộ lọc warehouse -->
                            <div class="row justify-content-between">
                                <form action="InventoryManagementServlet" method="get" class="form-inline mb-3">
                                    <div class="input-group mr-2">
                                        <select name="warehouseID" class="form-control">
                                            <option value="">All Warehouses</option>
                                        <c:forEach var="warehouse" items="${warehouses}">
                                            <option value="${warehouse.warehouseID}" ${warehouse.warehouseID == param.warehouseID ? 'selected' : ''}>
                                                ${warehouse.warehouseName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="input-group-append">
                                        <button class="status-btn hover-btn" type="submit">Filter</button>
                                    </div>
                                </div>
                            </form>


                        </div>

                        <div class="row">
                            <div class="col-lg-12 col-md-12">
                                <div class="card card-static-2 mb-30">
                                    <div class="card-title-2">
                                        <h4>All Inventory</h4>
                                    </div>
                                    <div class="card-body-table">
                                        <div class="table-responsive">
                                            <table class="table ucp-table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th style="width: 60px;">ID</th>
                                                        <th style="width: 120px;">Product Name</th>
                                                        <th style="width: 150px;">Warehouse</th>
                                                        <th style="width: 100px;">Current Stock</th>
                                                        <th style="width: 100px;">Reserved Stock</th>
                                                        <th style="width: 140px;">Last Update</th>
                                                        <th style="width: 120px;">Location</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:if test="${not empty inventories}">
                                                        <c:forEach var="inv" items="${inventories}">
                                                            <tr>
                                                                <td>${inv.inventoryID}</td>
                                                                <td>
                                                                    <c:forEach var="pro" items="${products}">
                                                                        <c:if test="${pro.productID == inv.productID}">
                                                                            ${pro.productName}
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </td>
                                                                <td>
                                                                    <c:forEach var="warehouse" items="${warehouses}">
                                                                        <c:if test="${warehouse.warehouseID == inv.warehouseID}">
                                                                            ${warehouse.warehouseName}
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </td>
                                                                <td>${inv.currentStock}</td>
                                                                <td>${inv.reservedStock}</td>
                                                                <td>
                                                                    <fmt:formatDate value="${inv.lastStockUpdate}" pattern="yyyy-MM-dd HH:mm" />
                                                                </td>
                                                                <td>${inv.location}</td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:if>
                                                    <c:if test="${empty inventories}">
                                                        <tr>
                                                            <td colspan="7" class="text-center">No inventory found.</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>

                                            <%-- Xây query với warehouseID --%>
                                            <c:set var="queryStr">
                                                warehouseID=${param.warehouseID}
                                            </c:set>

                                            <nav aria-label="Page navigation" class="mt-4">
                                                <ul class="pagination justify-content-center">

                                                    <%-- Nút Previous --%>
                                                    <li class="page-item ${page == 1 ? 'disabled' : ''}">
                                                        <a class="page-link" href="InventoryManagementServlet?page=${page - 1}&${queryStr}">Previous</a>
                                                    </li>

                                                    <%-- Hiển thị trang 1→3, trang cuối-2→cuối, và trang gần hiện tại --%>
                                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                                        <c:if test="${i <= 3 || i > totalPages - 3 || (i >= page - 1 && i <= page + 1)}">
                                                            <li class="page-item ${i == page ? 'active' : ''}">
                                                                <a class="page-link" href="InventoryManagementServlet?page=${i}&${queryStr}">${i}</a>
                                                            </li>
                                                        </c:if>

                                                        <%-- Dấu ... sau trang 3 nếu có khoảng cách --%>
                                                        <c:if test="${i == 4 && page > 5}">
                                                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                                            </c:if>

                                                        <%-- Dấu ... trước 3 trang cuối nếu cần --%>
                                                        <c:if test="${i == totalPages - 3 && page < totalPages - 4}">
                                                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                                            </c:if>
                                                        </c:forEach>

                                                    <%-- Nút Next --%>
                                                    <li class="page-item ${page == totalPages || totalPages == 0 ? 'disabled' : ''}">
                                                        <a class="page-link" href="InventoryManagementServlet?page=${page + 1}&${queryStr}">Next</a>
                                                    </li>

                                                </ul>
                                            </nav>

                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-footer mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted-1">&copy; 2025 <b>FMart Supermarket</b>. by <a href="https://themeforest.net/user/gambolthemes">FMartlthemes</a></div>
                            <div class="footer-links">
                                <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/privacy_policy.jsp">Privacy Policy</a>
                                <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/term_and_conditions.jsp">Terms &amp; Conditions</a>
                            </div>
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
