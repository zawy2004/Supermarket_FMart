<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>FMart Supermarket Reports</title>
        <link href="Admin/css/styles.css" rel="stylesheet">
        <link href="Admin/css/admin-style.css" rel="stylesheet">
        <link href="Admin/css/datepicker.min.css" rel="stylesheet">

        <!-- Vendor Stylesheets -->
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    </head>

    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
            <a class="navbar-brand logo-brand" href="index.html">FMart Supermarket</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
            <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/index.html" class="frnt-link"><i class="fas fa-external-link-alt"></i>Home</a>
        </nav>

        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <!-- Sidebar navigation -->
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <!-- Sidebar content here... -->
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h2 class="mt-30 page-title">All Reports</h2>
                        <ol class="breadcrumb mb-30">
                            <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
                            <li class="breadcrumb-item active">All Report</li>
                        </ol>

                        <!-- Search Form -->
                        <div class="row">
                            <div class="col-lg-4 col-md-5">
                                <div class="card card-static-2 mb-30">
                                    <div class="card-title-2">
                                        <h4>Search Reports</h4>
                                    </div>
                                    <div class="card-body-table">
                                        <form action="ReportServlet" method="get">
                                            <div class="form-group">
                                                <label for="searchName">Search by Customer Name</label>
                                                <input type="text" name="searchName" value="${searchName}" class="form-control" placeholder="Search by Customer Name">
                                            </div>
                                            <div class="form-group">
                                                <label for="status">Order Status</label>
                                                <select id="status" name="status" class="form-control">
                                                    <option value="">All Status</option>
                                                    <option value="Pending" ${status == 'Pending' ? 'selected' : ''}>Pending</option>
                                                    <option value="Confirmed" ${status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                                    <option value="Processing" ${status == 'Processing' ? 'selected' : ''}>Processing</option>
                                                    <option value="Completed" ${status == 'Completed' ? 'selected' : ''}>Completed</option>
                                                    <option value="Cancelled" ${status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="startDate">Start Date</label>
                                                <input type="date" class="form-control" id="startDate" name="startDate" value="${startDate}">
                                            </div>
                                            <div class="form-group">
                                                <label for="endDate">End Date</label>
                                                <input type="date" class="form-control" id="endDate" name="endDate" value="${endDate}">
                                            </div>
                                            <button type="submit" class="btn btn-primary">Search Orders</button>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <!-- Report Table -->
                            <div class="col-lg-8 col-md-7">
                                <div class="all-cate-tags">
                                    <div class="row">
                                        <!-- Report for Orders Per Hour -->
                                        <div class="col-lg-12 col-md-12">
                                            <div class="card card-static-2 mb-30">
                                                <div class="card-title-2 pb-3">
                                                    <h4>Orders Per Hour</h4>
                                                </div>
                                                <div class="card-body-table">
                                                    <div class="table-responsive">
                                                        <table class="table ucp-table table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th>Hours</th>
                                                                    <th>Total Orders</th>
                                                                    <th>Total Sales</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="report" items="${ordersPerHour}">
                                                                    <tr>
                                                                        <td>${report.hour}</td>
                                                                        <td>${report.totalOrders}</td>
                                                                        <td>$<fmt:formatNumber value="${report.totalSales}" type="number" minFractionDigits="2" /></td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Report for Orders Per Day -->
                                        <div class="col-lg-12 col-md-12">
                                            <div class="card card-static-2 mb-30">
                                                <div class="card-title-2 pb-3">
                                                    <h4>Orders Per Day</h4>
                                                </div>
                                                <div class="card-body-table">
                                                    <div class="table-responsive">
                                                        <table class="table ucp-table table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th>Year</th>
                                                                    <th>Month</th>
                                                                    <th>Day</th>
                                                                    <th>Total Orders</th>
                                                                    <th>Total Sales</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="report" items="${ordersPerDay}">
                                                                    <tr>
                                                                        <td>${report.year}</td>
                                                                        <td>${report.month}</td>
                                                                        <td>${report.day}</td>
                                                                        <td>${report.totalOrders}</td>
                                                                        <td>$<fmt:formatNumber value="${report.totalSales}" type="number" minFractionDigits="2" /></td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Export to Excel -->
                                        <form action="ReportServlet" method="get">
                                            <input type="hidden" name="export" value="excel">
                                            <input type="hidden" name="searchName" value="${searchName}">
                                            <input type="hidden" name="status" value="${status}">
                                            <input type="hidden" name="startDate" value="${startDate}">
                                            <input type="hidden" name="endDate" value="${endDate}">
                                            <button class="download-btn hover-btn" type="submit">Export to Excel</button>
                                        </form>


                                        <!-- Report for Orders Per Month -->
                                        <div class="col-lg-12 col-md-12">
                                            <div class="card card-static-2 mb-30">
                                                <div class="card-title-2 pb-3">
                                                    <h4>Orders Per Month</h4>
                                                </div>
                                                <div class="card-body-table">
                                                    <div class="table-responsive">
                                                        <table class="table ucp-table table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th>Year</th>
                                                                    <th>Month</th>
                                                                    <th>Total Orders</th>
                                                                    <th>Total Sales</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="report" items="${ordersPerMonth}">
                                                                    <tr>
                                                                        <td>${report.year}</td>
                                                                        <td>${report.month}</td>
                                                                        <td>${report.totalOrders}</td>
                                                                        <td>$<fmt:formatNumber value="${report.totalSales}" type="number" minFractionDigits="2" /></td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pagination -->
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="ReportServlet?page=${currentPage - 1}&searchName=${searchName}&status=${status}&startDate=${startDate}&endDate=${endDate}">Previous</a>
                                </li>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="ReportServlet?page=${i}&searchName=${searchName}&status=${status}&startDate=${startDate}&endDate=${endDate}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages || totalPages == 0 ? 'disabled' : ''}">
                                    <a class="page-link" href="ReportServlet?page=${currentPage + 1}&searchName=${searchName}&status=${status}&startDate=${startDate}&endDate=${endDate}">Next</a>
                                </li>
                            </ul>
                        </nav>

                    </div>
                </main>

                <footer class="py-4 bg-footer mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted-1">© 2025 <b>FMart Supermarket</b>. by <a href="https://themeforest.net/user/gambolthemes">Gambolthemes</a></div>
                            <div class="footer-links">
                                <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/privacy_policy.html">Privacy Policy</a>
                                <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/term_and_conditions.html">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>

        <script src="Admin/js/jquery.min.js"></script>
        <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="Admin/js/scripts.js"></script>
        <script src="Admin/js/datepicker.min.js"></script>
        <script src="Admin/js/i18n/datepicker.en.js"></script>

    </body>

</html>
