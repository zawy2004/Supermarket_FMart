<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from gambolthemes.net/html-items/gambo_admin_new/index.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:09:41 GMT -->
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
        <jsp:include page="header.jsp"></jsp:include>
            <div id="layoutSidenav">
            <jsp:include page="adminsidebar.jsp"></jsp:include>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h2 class="mt-30 page-title">Dashboard</h2>
                        <ol class="breadcrumb mb-30">
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>
                        <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <div class="dashboard-report-card purple">
                                    <div class="card-content">
                                        <span class="card-title">Order Pending</span>
                                        <span class="card-count">2</span>
                                    </div>
                                    <div class="card-media">
                                        <i class="fab fa-rev"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="dashboard-report-card red">
                                    <div class="card-content">
                                        <span class="card-title">Order Cancel</span>
                                        <span class="card-count">0</span>
                                    </div>
                                    <div class="card-media">
                                        <i class="far fa-times-circle"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="dashboard-report-card info">
                                    <div class="card-content">
                                        <span class="card-title">Order Process</span>
                                        <span class="card-count">5</span>
                                    </div>
                                    <div class="card-media">
                                        <i class="fas fa-sync-alt rpt_icon"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="dashboard-report-card success">
                                    <div class="card-content">
                                        <span class="card-title">Today Income</span>
                                        <span class="card-count">$9568.00</span>
                                    </div>
                                    <div class="card-media">
                                        <i class="fas fa-money-bill rpt_icon"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-12 col-md-12">
                                <div class="card card-static-1 mb-30">
                                    <div class="card-body">
                                        <div id="earningGraph"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-12 col-md-12">
                                <div class="card card-static-2 mb-30">
                                    <div class="card-title-2 pb-3">
                                        <h4>Recent Orders</h4>
                                        <a href="orders.jsp" class="view-btn hover-btn">View All</a> 
                                    </div>
                                    <div class="card-body-table">
                                        <div class="table-responsive">
                                            <table class="table ucp-table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th style="width:130px">Order ID</th>
                                                        <th>Item</th>
                                                        <th style="width:200px">Date</th>
                                                        <th style="width:300px">Address</th>
                                                        <th style="width:130px">Status</th>
                                                        <th style="width:130px">Total</th>
                                                        <th style="width:100px">Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>ORDER12345</td>
                                                        <td>
                                                            <a href="#" target="_blank">Product Title Here</a>
                                                        </td>
                                                        <td>
                                                            <span class="delivery-time">15/06/2020</span>
                                                            <span class="delivery-time">4:00PM - 6.00PM</span>
                                                        </td>
                                                        <td>#0000, St No. 8, Shahid Karnail Singh Nagar, MBD Mall, Frozpur road, Ludhiana, 141001</td>
                                                        <td>
                                                            <span class="badge-item badge-status">Pending</span>
                                                        </td>
                                                        <td>$90</td>
                                                        <td class="action-btns">
                                                            <a href="order_view.jsp" class="views-btn"><i class="fas fa-eye"></i></a>
                                                            <a href="order_edit.jsp" class="edit-btn"><i class="fas fa-edit"></i></a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>ORDER12346</td>
                                                        <td>
                                                            <a href="#" target="_blank">Product Title Here</a>
                                                        </td>
                                                        <td>
                                                            <span class="delivery-time">13/06/2020</span>
                                                            <span class="delivery-time">2:00PM - 4.00PM</span>
                                                        </td>
                                                        <td>#0000, St No. 8, Shahid Karnail Singh Nagar, MBD Mall, Frozpur road, Ludhiana, 141001</td>
                                                        <td>
                                                            <span class="badge-item badge-status">Pending</span>
                                                        </td>
                                                        <td>$105</td>
                                                        <td class="action-btns">
                                                            <a href="order_view.jsp" class="views-btn"><i class="fas fa-eye"></i></a>
                                                            <a href="order_edit.jsp" class="edit-btn"><i class="fas fa-edit"></i></a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>ORDER12347</td>
                                                        <td>
                                                            <a href="#" target="_blank">Product Title Here</a>
                                                        </td>
                                                        <td>
                                                            <span class="delivery-time">13/6/2020</span>
                                                            <span class="delivery-time">5:00PM - 7.00PM</span>
                                                        </td>
                                                        <td>#0000, St No. 8, Shahid Karnail Singh Nagar, MBD Mall, Frozpur road, Ludhiana, 141001</td>
                                                        <td>
                                                            <span class="badge-item badge-status">Pending</span>
                                                        </td>
                                                        <td>$60</td>
                                                        <td class="action-btns">
                                                            <a href="order_view.jsp" class="views-btn"><i class="fas fa-eye"></i></a>
                                                            <a href="order_edit.jsp" class="edit-btn"><i class="fas fa-edit"></i></a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>ORDER12348</td>
                                                        <td>
                                                            <a href="#" target="_blank">Product Title Here</a>
                                                        </td>
                                                        <td>
                                                            <span class="delivery-time">12/06/2020</span>
                                                            <span class="delivery-time">01:00PM - 3.00PM</span>
                                                        </td>
                                                        <td>#0000, St No. 8, Shahid Karnail Singh Nagar, MBD Mall, Frozpur road, Ludhiana, 141001</td>
                                                        <td>
                                                            <span class="badge-item badge-status">Pending</span>
                                                        </td>
                                                        <td>$120</td>
                                                        <td class="action-btns">
                                                            <a href="order_view.jsp" class="views-btn"><i class="fas fa-eye"></i></a>
                                                            <a href="order_edit.jsp" class="edit-btn"><i class="fas fa-edit"></i></a>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
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
                            <div class="text-muted-1">© 2025 <b>FMart Supermarket</b>. by <a href="https://themeforest.net/user/gambolthemes">FMartlthemes</a></div>
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
        <script src="Admin/vendor/chart/highcharts.js"></script>
        <script src="Admin/vendor/chart/exporting.js"></script>
        <script src="Admin/vendor/chart/export-data.js"></script>
        <script src="Admin/vendor/chart/accessibility.js"></script>
        <script src="Admin/js/scripts.js"></script>
        <script src="Admin/js/chart.js"></script>

    </body>

    <!-- Mirrored from gambolthemes.net/html-items/gambo_admin_new/index.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:09:55 GMT -->
</html>