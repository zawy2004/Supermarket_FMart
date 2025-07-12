<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- fallback nếu user null --%>
<%
    model.User user = (model.User) session.getAttribute("user");
    if (user == null) {
        user = new model.User();
        user.setFullName("Demo User");
        user.setPhoneNumber("+84987654321");
        user.setAddress("123 Default Street, District 1, HCMC");
        session.setAttribute("user", user);
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <title>FMart - My Address</title>
        <link rel="icon" type="image/png" href="images/fav.png">
        <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="User/vendor/unicons-2.0.1/css/unicons.css" rel="stylesheet">
        <link href="User/css/style.css" rel="stylesheet">
        <link href="User/css/responsive.css" rel="stylesheet">
        <link href="User/css/night-mode.css" rel="stylesheet">
        <link href="User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="User/vendor/OwlCarousel/assets/owl.carousel.css" rel="stylesheet">
        <link href="User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="User/vendor/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet">
    </head>
    <body>
        <!-- Modal Add/Edit -->
        <div id="address_model" class="modal fade" tabindex="-1">
            <div class="modal-dialog category-area">
                <div class="modal-content category-model-content">
                    <div class="modal-header">
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                            <i class="uil uil-multiply"></i>
                        </button>
                    </div>
                    <div class="modal-body">
                        <h4 class="mb-0">${user.address == null || user.address.isEmpty() ? "Add New Address" : "Update Address"}</h4>
                        <form action="profile?action=updateAddress" method="post">
                            <div class="form-group mt-3">
                                <label>Your Full Address*</label>
                                <textarea name="address" class="form-control" required minlength="10" maxlength="255"
                                          placeholder="Enter your full address">${user.address}</textarea>
                            </div>
                            <button type="submit" class="save-btn14 w-100 hover-btn mt-4">Save</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="header.jsp"/>

        <div class="wrapper">
            <div class="gambo-Breadcrumb">
                <div class="container">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active">My Address</li>
                    </ol>
                </div>
            </div>
            <div class="dashboard-group">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 text-center">
                            <div class="user-dt">
                                <img src="images/avatar/img-5.jpg" alt="">
                                <h4>${user.fullName}</h4>
                                <p>${user.phoneNumber}</p>
                                <div>Points: ${user.points}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>  

            <div class="container mt-4">
                <div class="row">
                    <div class="col-xl-3 col-lg-4">
                        <div class="left-side-tabs">
                            <div class="dashboard-left-links">
                                <a href="profile?action=overview" class="user-item active"><i class="uil uil-apps"></i>Overview</a>
                                <a href="profile?action=orders" class="user-item"><i class="uil uil-box"></i>My Orders</a>
                                <a href="profile?action=wishlist" class="user-item"><i class="uil uil-heart"></i>My Wishlist</a>
                                <a href="profile?action=wallet" class="user-item"><i class="uil uil-wallet"></i>My Wallet</a>
                                <a href="profile?action=addresses" class="user-item"><i class="uil uil-location-point"></i>My Address</a>
                                <a href="logout" class="user-item"><i class="uil uil-exit"></i>Logout</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-9 col-lg-8">
                        <div class="dashboard-right">
                            <div class="main-title-tab mb-4">
                                <h4><i class="uil uil-location-point"></i>My Address</h4>
                            </div>
                            <div class="pdpt-bg">
                                <div class="pdpt-title">
                                    <h4>My Address</h4>
                                </div>
                                <div class="address-body">
                                    <button class="add-address hover-btn" data-bs-toggle="modal" data-bs-target="#address_model">
                                        ${user.address == null || user.address.isEmpty() ? "Add Address" : "Edit Address"}
                                    </button>
                                    <div class="address-item mt-3">
                                        <div class="address-icon1"><i class="uil uil-map-marker"></i></div>
                                        <div class="address-dt-all">
                                            <h4>Current Address</h4>
                                            <p>${user.address}</p>
                                            <ul class="action-btns">
                                                <li><a href="#" data-bs-toggle="modal" data-bs-target="#address_model" class="action-btn"><i class="uil uil-edit"></i></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <c:if test="${not empty success}">
                                        <div class="alert alert-success mt-2">${success}</div>
                                    </c:if>
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger mt-2">${error}</div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>  
        </div>

        <jsp:include page="footer.jsp"/>

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
