<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, shrink-to-fit=9">
    <meta name="description" content="FMart Blog - No Sidebar">
    <meta name="author" content="FMartlthemes">
    <title>FMart - Blog No Sidebar</title>
    <link rel="icon" type="image/png" href="images/fav.png">
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="User/vendor/unicons-2.0.1/css/unicons.css" rel="stylesheet">
    <link href="User/css/style.css" rel="stylesheet">
    <link href="User/css/responsive.css" rel="stylesheet">
    <link href="User/css/night-mode.css" rel="stylesheet">
    <link href="User/css/step-wizard.css" rel="stylesheet">
    <link href="User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="User/vendor/OwlCarousel/assets/owl.carousel.css" rel="stylesheet">
    <link href="User/vendor/OwlCarousel/assets/owl.theme.default.min.css" rel="stylesheet">
    <link href="User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="User/vendor/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet">
</head>
<body>
    <!-- Thêm dữ liệu ảo -->
    <c:set var="blogList" value="${blogList == null ? [
        {id: 1, title: 'Optimizing Inventory at FMart', date: '2025-07-18', category: 'FMart Operations', image: 'img-1.jpg', summary: 'Learn how FMart uses inventory techniques...', likes: 15},
        {id: 2, title: 'Student Projects in FMart System', date: '2025-07-12', category: 'Student Projects', image: 'img-2.jpg', summary: 'Discover student contributions to FMart...', likes: 10},
        {id: 3, title: 'Enhancing Delivery at FPT Campus', date: '2025-07-05', category: 'Delivery Solutions', image: 'img-3.jpg', summary: 'Explore delivery improvements at FMart...', likes: 8}
    ] : blogList}" />

    <jsp:include page="header.jsp" />
    <div class="wrapper">
        <div class="default-dt">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="default_tabs">
                            <nav>
                                <div class="nav nav-tabs tab_default justify-content-center">
                                    <a class="nav-item nav-link" href="about_us">About</a>
                                    <a class="nav-item nav-link active" href="our_blog">Blog</a>
                                    <a class="nav-item nav-link" href="career">Careers</a>
                                    <a class="nav-item nav-link" href="press">Press</a>
                                </div>
                            </nav>
                        </div>
                        <div class="title129">
                            <h2>Insights, ideas, and stories</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="blog-gambo">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <c:forEach var="blog" items="${blogList}">
                            <div class="blog-item">
                                <a href="blog_detail_view.jsp?blogId=${blog.id}" class="blog-img">
                                    <img src="User/images/blog/${blog.image}" alt="${blog.title}">
                                    <div class="blog-cate-badge">${blog.category}</div>
                                </a>
                                <div class="date-icons-group">
                                    <div class="blog-time sz-14">${blog.date}</div>
                                    <ul class="like-share-icons">
                                        <li>
                                            <a href="#" class="like-share"><i class="uil uil-thumbs-up"></i><span>${blog.likes}</span></a>
                                        </li>
                                        <li>
                                            <a href="#" class="like-share"><i class="uil uil-share-alt"></i></a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="blog-detail">
                                    <h4>${blog.title}</h4>
                                    <p>${blog.summary}</p>
                                    <a href="blog_detail_view.jsp?blogId=${blog.id}">Read More</a>
                                </div>
                            </div>
                        </c:forEach>
                        <div class="blog-more-btn">
                            <a href="#" class="blog-btn hover-btn">More View</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
    <script src="User/js/jquery.min.js"></script>
    <script src="User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="User/vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
    <script src="User/vendor/OwlCarousel/owl.carousel.js"></script>
    <script src="User/js/jquery.countdown.min.js"></script>
    <script src="User/js/custom.js"></script>
    <script src="User/js/product.thumbnail.slider.js"></script>
    <script src="User/js/offset_overlay.js"></script>
    <script src="User/js/night-mode.js"></script>
</body>
</html>
