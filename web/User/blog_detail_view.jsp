<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, shrink-to-fit=9">
    <meta name="description" content="FMart Blog - Detailed view of a blog post">
    <meta name="author" content="FMartlthemes">
    <title>FMart - Blog Detail: ${blog.title}</title>
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
    <style>
        .blog-detail {
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .blog-meta {
            font-size: 14px;
            color: #666;
            margin-bottom: 15px;
        }
        .blog-meta span {
            margin-right: 15px;
        }
        .blog-img {
            max-width: 100%;
            height: auto;
            margin-bottom: 20px;
            border-radius: 8px;
        }
        .blog-content {
            line-height: 1.6;
            color: #333;
        }
        .blog-actions a {
            margin-right: 15px;
            color: #007bff;
            text-decoration: none;
        }
        .blog-actions a:hover {
            color: #0056b3;
        }
        @media (max-width: 768px) {
            .blog-detail {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <!-- Thêm dữ liệu ảo -->
    <c:set var="blog" value="${blog == null ? {
        id: 1,
        title: 'Optimizing Inventory at FMart',
        date: '2025-07-18',
        category: 'FMart Operations',
        image: 'img-1.jpg',
        content: '<p>Learn how the FMart team at FPT University is using advanced inventory techniques to ensure product availability. This blog explores real-time tracking and student-led innovations in managing stock levels efficiently.</p>',
        likes: 15
    } : blog}" />
    <c:set var="relatedBlogs" value="${relatedBlogs == null ? [
        {id: 2, title: 'Student Projects', image: 'img-2.jpg', date: '2025-07-12'},
        {id: 3, title: 'Enhancing Delivery', image: 'img-3.jpg', date: '2025-07-05'}
    ] : relatedBlogs}" />

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
                        <div class="blog-detail">
                            <c:if test="${empty blog}">
                                <div class="error-message">No blog data available. Please check the blog ID.</div>
                            </c:if>
                            <c:if test="${not empty blog}">
                                <h2>${blog.title}</h2>
                                <div class="blog-meta">
                                    <span class="blog-time">Published on: ${blog.date}</span>
                                    <span class="blog-category">Category: ${blog.category}</span>
                                </div>
                                <img src="User/images/blog/img-1.jpg" alt="${blog.title}" class="blog-img" onerror="this.src='User/images/blog/no-image.jpg'">
                                <div class="blog-content">
                                    ${blog.content}
                                </div>
                                <div class="blog-actions">
                                    <a href="#" class="like-share"><i class="uil uil-thumbs-up"></i> <span>${blog.likes}</span> Likes</a>
                                    <a href="#" class="like-share" onclick="shareArticle()"><i class="uil uil-share-alt"></i> Share</a>
                                </div>
                            </c:if>
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
    <script>
        function shareArticle() {
            const title = "${blog.title}";
            const url = window.location.href;
            if (navigator.share) {
                navigator.share({
                    title: title,
                    url: url
                }).then(() => console.log('Shared successfully'))
                  .catch((error) => console.error('Error sharing:', error));
            } else {
                alert('Sharing not supported on this browser. Copy the URL: ' + url);
            }
        }
    </script>
</body>
</html>
