     
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
                </main>
            <%@ include file="footer.jsp" %>
            </div>
        </div>
        <script src="js/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="vendor/chart/highcharts.js"></script>
        <script src="vendor/chart/exporting.js"></script>
        <script src="vendor/chart/export-data.js"></script>
        <script src="vendor/chart/accessibility.js"></script>
        <script src="js/scripts.js"></script>
        <script src="js/chart.js"></script>

    </body>

</html>
