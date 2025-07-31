<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>FMart - My Orders</title>
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <link rel="stylesheet" href="User/vendor/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="User/vendor/fontawesome-free/css/all.min.css">
        <link rel="stylesheet" href="User/css/style.css">
        <link rel="stylesheet" href="User/css/responsive.css">
        <link rel="stylesheet" href="User/css/night-mode.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>

        <jsp:include page="header.jsp" />

        <div class="wrapper">
            <div class="gambo-Breadcrumb">
                <div class="container">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="home">Home</a></li>
                        <li class="breadcrumb-item active">My Orders</li>
                    </ol>
                </div>
            </div>

            <div class="dashboard-group">
                <div class="container">
                    <div class="row">
                        <!-- Sidebar -->
                        <div class="col-xl-3 col-lg-4">
                            <div class="dashboard-left-links">
                                <a href="profile?action=overview" class="user-item"><i class="uil uil-apps"></i>Overview</a>
                                <a href="profile?action=orders" class="user-item active"><i class="uil uil-box"></i>My Orders</a>
                                <a href="wishlist" class="user-item"><i class="uil uil-heart"></i>My Wishlist</a>
                                <a href="profile?action=wallet" class="user-item"><i class="uil uil-wallet"></i>My Wallet</a>
                                <a href="profile?action=addresses" class="user-item"><i class="uil uil-location-point"></i>My Address</a>
                                <a href="logout" class="user-item"><i class="uil uil-exit"></i>Logout</a>
                            </div>
                        </div>

                        <!-- Orders Section -->
                        <div class="col-xl-9 col-lg-8">
                            <div class="dashboard-right">
                                <h4 class="mb-4"><i class="uil uil-box"></i> My Orders</h4>

                                <!-- Status Tabs -->
                                <div class="btn-group mb-4" role="group">
                                    <button type="button" class="btn btn-outline-primary status-tab" data-status="Pending">Pending</button>
                                    <button type="button" class="btn btn-outline-primary status-tab" data-status="Confirmed">Confirmed</button>
                                    <button type="button" class="btn btn-outline-primary status-tab" data-status="Shipping">Shipping</button>
                                    <button type="button" class="btn btn-outline-primary status-tab" data-status="Delivered">Delivered</button>
                                    <button type="button" class="btn btn-outline-primary status-tab" data-status="Canceled">Canceled</button>
                                </div>

                                <!-- Order Results -->
                                <div id="order-container">
                                    <p>Select a status to view your orders.</p>
                                </div>
                                <div class="text-center mt-3" id="load-more-wrapper" style="display: none;">
                                    <button class="btn btn-outline-success" id="load-more-btn">Load More</button>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <script>
            $(document).ready(function () {
                $(".status-tab").click(function () {
                    $(".status-tab").removeClass("btn-primary").addClass("btn-outline-primary");
                    $(this).removeClass("btn-outline-primary").addClass("btn-primary");

                    const status = $(this).data("status");
                    $("#order-container").html("<p>Loading orders...</p>");

                    $.get("order-by-status", {status: status}, function (data) {
                        $("#order-container").html(data);
                    }).fail(function () {
                        $("#order-container").html("<p>Error loading orders.</p>");
                    });
                });
            });
            
    
    let currentStatus = '';
    let offset = 0;
    const limit = 3; // mỗi lần load 3 đơn hàng

    function loadOrders(status, append = false) {
        $.get("order-by-status", { status: status, offset: offset, limit: limit }, function (data) {
            if (append) {
                $("#order-container").append(data);
            } else {
                $("#order-container").html(data);
            }

            // Nếu số lượng item trả về < limit => ẩn nút Load More
            if ($(data).filter(".order-card").length < limit) {
                $("#load-more-wrapper").hide();
            } else {
                $("#load-more-wrapper").show();
            }
        }).fail(function () {
            $("#order-container").html("<p>Error loading orders.</p>");
            $("#load-more-wrapper").hide();
        });
    }

    $(document).ready(function () {
        $(".status-tab").click(function () {
            $(".status-tab").removeClass("btn-primary").addClass("btn-outline-primary");
            $(this).removeClass("btn-outline-primary").addClass("btn-primary");

            currentStatus = $(this).data("status");
            offset = 0;
            loadOrders(currentStatus, false);
        });

        $("#load-more-btn").click(function () {
            offset += limit;
            loadOrders(currentStatus, true);
        });
    });
        </script>

        <script src="User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="User/js/custom.js"></script>
    </body>
</html>
