<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>FMart - Dashboard</title>
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <link rel="icon" type="image/png" href="images/fav.png">
        <link href="User/css/style.css" rel="stylesheet">
        <link href="User/css/responsive.css" rel="stylesheet">
        <link href="User/css/night-mode.css" rel="stylesheet">
        <link href="User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <div class="wrapper">
                <div class="gambo-Breadcrumb">
                    <div class="container">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home">Home</a></li>
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>
                    </div>
                </div>

                <div class="dashboard-group">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="user-dt">
                                    <div class="user-img">
                                        <img src="${user.profileImageUrl != null ? user.profileImageUrl : 'User/images/avatar/img-5.jpg'}" alt="profile">
                                    <form action="${pageContext.request.contextPath}/profile/uploadImage" method="post" enctype="multipart/form-data">
                                        <div class="img-add">
                                            <input type="file" name="avatarFile" id="file" onchange="this.form.submit()">
                                            <label for="file"><i class="uil uil-camera-plus"></i></label>
                                        </div>
                                    </form>
                                </div>
                                <h4>${user.fullName}</h4>
                                <p>${user.phoneNumber != null ? user.phoneNumber : user.email}
                                    <a href="#"><i class="uil uil-edit"></i></a>
                                </p>
                                <div class="earn-points">
                                    <img src="User/images/Dollar.svg" alt="">Points : <span>20</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-xl-3 col-lg-4 col-md-12">
                            <div class="dashboard-left-links">
                                <a href="profile?action=overview" class="user-item active"><i class="uil uil-apps"></i>Overview</a>
                                <a href="profile?action=orders" class="user-item"><i class="uil uil-box"></i>My Orders</a>
                                <a href="profile?action=wishlist" class="user-item"><i class="uil uil-heart"></i>My Wishlist</a>
                                <a href="profile?action=wallet" class="user-item"><i class="uil uil-wallet"></i>My Wallet</a>
                                <a href="profile?action=addresses" class="user-item"><i class="uil uil-location-point"></i>My Address</a>
                                <a href="logout" class="user-item"><i class="uil uil-exit"></i>Logout</a>
                            </div>
                        </div>

                        <div class="col-xl-9 col-lg-8 col-md-12">
                            <div class="dashboard-right">
                                <h4 class="mb-3"><i class="uil uil-apps"></i> Overview</h4>
                                <div class="welcome-text mb-4">
                                    <h2>Hi! ${user.fullName}</h2>
                                </div>
                                <div class="row">
                                    <div class="col-xl-6">
                                        <div class="pdpt-bg mb-4">
                                            <div class="pdpt-title"><h4>My Rewards</h4></div>
                                            <div class="ddsh-body">
                                                <h2>6 Rewards</h2>
                                                <ul>
                                                    <li><a href="#" class="small-reward-dt hover-btn">Won $2</a></li>
                                                    <li><a href="#" class="small-reward-dt hover-btn">Won 40% Off</a></li>
                                                    <li><a href="#" class="small-reward-dt hover-btn">Cashback $1</a></li>
                                                    <li><a href="#" class="rewards-link5">+More</a></li>
                                                </ul>
                                            </div>
                                            <a href="#" class="more-link14">Rewards and Details <i class="uil uil-angle-double-right"></i></a>
                                        </div>
                                    </div>
                                    <div class="col-xl-6">
                                        <div class="pdpt-bg mb-4">
                                            <div class="pdpt-title"><h4>My Orders</h4></div>
                                            <div class="ddsh-body">
                                                <h2>2 Recent Purchases</h2>
                                                <ul class="order-list-145">
                                                    <li>
                                                        <div class="smll-history">
                                                            <div class="order-title">2 Items</div>
                                                            <div class="order-status">On the way</div>
                                                            <p>$22</p>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                            <a href="profile?action=orders" class="more-link14">All Orders <i class="uil uil-angle-double-right"></i></a>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="pdpt-bg mb-4">
                                            <div class="pdpt-title"><h4>My Wallet</h4></div>
                                            <div class="wllt-body">
                                                <h2>Credits $100</h2>
                                                <ul class="wallet-list">
                                                    <li><a href="#"><i class="uil uil-card-atm"></i>Payment Methods</a></li>
                                                    <li><a href="#"><i class="uil uil-gift"></i>3 Offers Active</a></li>
                                                    <li><a href="#"><i class="uil uil-coins"></i>Points Earning</a></li>
                                                </ul>
                                            </div>
                                            <a href="profile?action=wallet" class="more-link14">Wallet Details <i class="uil uil-angle-double-right"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
        <script src="User/js/jquery.min.js"></script>
        <script src="User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="User/js/custom.js"></script>
    </body>
</html>
