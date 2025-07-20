<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List, model.StockMovement, model.Product" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Stock Movements - FMart Admin</title>
        <link href="Admin/css/styles.css" rel="stylesheet">
        <link href="Admin/css/admin-style.css" rel="stylesheet">
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">\
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

    <body class="sb-nav-fixed">
       <!-- Header -->
            <jsp:include page="header.jsp"></jsp:include>
        <div id="layoutSidenav">
            <!-- Sidebar -->
            <jsp:include page="managersidebar.jsp"></jsp:include>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h2 class="mt-30 page-title">Stock Movements</h2>
                        <ol class="breadcrumb mb-30">
                            <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active">Stock Movements</li>
                        </ol>

                        <!-- Bộ lọc -->
                        <form action="StockMovementServlet" method="get" class="form-inline mb-3">
                            <select name="productID" class="form-control mr-2">
                                <option value="">All Products</option>
                                <c:forEach var="pro" items="${products}">
                                    <option value="${pro.productID}" ${pro.productID == param.productID ? 'selected' : ''}>
                                        ${pro.productName}
                                    </option>
                                </c:forEach>
                            </select>

                            <select name="movementType" class="form-control mr-2">
                                <option value="">All Types</option>
                                <option value="IN" ${param.movementType == 'IN' ? 'selected' : ''}>IN</option>
                                <option value="OUT" ${param.movementType == 'OUT' ? 'selected' : ''}>OUT</option>
                                <option value="ADJUSTMENT" ${param.movementType == 'ADJUSTMENT' ? 'selected' : ''}>ADJUSTMENT</option>
                            </select>

                            <button class="status-btn hover-btn" type="submit">Filter</button>
                        </form>

                        <div class="card card-static-2 mb-30">
                            <div class="card-title-2">
                                <h4>All Stock Movements</h4>
                            </div>
                            <div class="card-body-table">
                                <div class="table-responsive">
                                    <table class="table ucp-table table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Product</th>
                                                <th>Type</th>
                                                <th>Qty</th>
                                                <th>Reason</th>
                                                <th>Reference</th>
                                                <th>Unit Cost</th>
                                                <th>Created By</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${not empty movements}">
                                                <c:forEach var="m" items="${movements}">
                                                    <tr>
                                                        <td>${m.movementID}</td>
                                                        <td>
                                                            <c:forEach var="pro" items="${products}">
                                                                <c:if test="${pro.productID == m.productID}">
                                                                    ${pro.productName}
                                                                </c:if>
                                                            </c:forEach>
                                                        </td>
                                                        <td>${m.movementType}</td>
                                                        <td>${m.quantity}</td>
                                                        <td>${m.reason}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${m.referenceID != null}">
                                                                    ${m.referenceType} #${m.referenceID}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    -
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>

                                                        <td>
                                                            <fmt:formatNumber value="${m.unitCost}" type="currency" currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                                        </td>

                                                        <td>${m.createdBy}</td>
                                                        <td><fmt:formatDate value="${m.movementDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${empty movements}">
                                                <tr><td colspan="9" class="text-center">No stock movements found.</td></tr>
                                            </c:if>
                                        </tbody>
                                    </table>

                                    <%-- Xây query --%>
                                    <c:set var="queryStr">
                                        productID=${param.productID}&movementType=${param.movementType}
                                    </c:set>

                                    <nav aria-label="Page navigation" class="mt-4">
                                        <ul class="pagination justify-content-center">

                                            <%-- Previous --%>
                                            <li class="page-item ${page == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="StockMovementServlet?page=${page - 1}&${queryStr}">Previous</a>
                                            </li>

                                            <%-- Hiển thị các trang từ 1 đến 3 --%>
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <c:if test="${i <= 3 
                                                              || i > totalPages - 3 
                                                              || (i >= page - 1 && i <= page + 1)}">
                                                      <li class="page-item ${i == page ? 'active' : ''}">
                                                          <a class="page-link" href="StockMovementServlet?page=${i}&${queryStr}">${i}</a>
                                                      </li>
                                                </c:if>

                                                <%-- Hiển thị dấu "..." sau trang 3 nếu cần --%>
                                                <c:if test="${i == 4 && page > 5}">
                                                    <li class="page-item disabled"><span class="page-link">...</span></li>
                                                    </c:if>

                                                <%-- Hiển thị dấu "..." trước 3 trang cuối nếu cần --%>
                                                <c:if test="${i == totalPages - 3 && page < totalPages - 4}">
                                                    <li class="page-item disabled"><span class="page-link">...</span></li>
                                                    </c:if>
                                                </c:forEach>

                                            <%-- Next --%>
                                            <li class="page-item ${page == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="StockMovementServlet?page=${page + 1}&${queryStr}">Next</a>
                                            </li>
                                        </ul>
                                    </nav>

                                   
                                </div>
                            </div>
                        </div>
                    </div>
                </main>

                <footer class="py-4 bg-footer mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted-1">&copy; 2025 <b>FMart Supermarket</b></div>
                            <div class="footer-links">
                                <a href="#">Privacy Policy</a>
                                <a href="#">Terms & Conditions</a>
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
