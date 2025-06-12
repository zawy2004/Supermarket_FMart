<!DOCTYPE html>
<html lang="en">

<!-- Mirrored from gambolthemes.net/html-items/gambo_admin_new/general_setting_analytics.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:10:15 GMT -->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description-gambolthemes" content="">
	<meta name="author-gambolthemes" content="">
	<title>FMart Supermarket Admin</title>
	<link href="css/styles.css" rel="stylesheet">
	<link href="css/admin-style.css" rel="stylesheet">
	
	<!-- Vendor Stylesheets -->
	<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
	
</head>

    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
            <a class="navbar-brand logo-brand" href="index.jsp">FMart Supermarket</a>
			<button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
            <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/index.jsp" class="frnt-link"><i class="fas fa-external-link-alt"></i>Home</a>
            <ul class="navbar-nav ms-auto mr-md-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <a class="dropdown-item admin-dropdown-item" href="edit_profile.jsp">Edit Profile</a>
						<a class="dropdown-item admin-dropdown-item" href="change_password.jsp">Change Password</a>
                        <a class="dropdown-item admin-dropdown-item" href="login.jsp">Logout</a>
                    </div>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <a class="nav-link" href="index.jsp">
								<div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Dashboard
							</a>
                             <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
								<div class="sb-nav-link-icon"><i class="fas fa-newspaper"></i></div>
                                Posts
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
							</a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
									<a class="nav-link sub_nav_link" href="posts.jsp">All Posts</a>
									<a class="nav-link sub_nav_link" href="add_post.jsp">Add New</a>
									<a class="nav-link sub_nav_link" href="post_categories.jsp">Categories</a>
									<a class="nav-link sub_nav_link" href="post_tags.jsp">Tags</a>
								</nav>
                            </div>		
							<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLocations" aria-expanded="false" aria-controls="collapseLocations">
								<div class="sb-nav-link-icon"><i class="fas fa-map-marker-alt"></i></div>
                                Locations
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
							</a>
                            <div class="collapse" id="collapseLocations" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
									<a class="nav-link sub_nav_link" href="locations.jsp">All Locations</a>
									<a class="nav-link sub_nav_link" href="add_location.jsp">Add Location</a>
								</nav>
                            </div>		
							<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseAreas" aria-expanded="false" aria-controls="collapseAreas">
								<div class="sb-nav-link-icon"><i class="fas fa-map-marked-alt"></i></div>
                                Areas
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
							</a>
                            <div class="collapse" id="collapseAreas" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
									<a class="nav-link sub_nav_link" href="areas.jsp">All Areas</a>
									<a class="nav-link sub_nav_link" href="add_area.jsp">Add Area</a>
								</nav>
                            </div>
							<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseCategories" aria-expanded="false" aria-controls="collapseCategories">
								<div class="sb-nav-link-icon"><i class="fas fa-list"></i></div>
                                Categories
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
							</a>
                            <div class="collapse" id="collapseCategories" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
									<a class="nav-link sub_nav_link" href="category.jsp">All Categories</a>
									<a class="nav-link sub_nav_link" href="add_category.jsp">Add Category</a>
								</nav>
                            </div>
							<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseShops" aria-expanded="false" aria-controls="collapseShops">
								<div class="sb-nav-link-icon"><i class="fas fa-store"></i></div>
                                Shops
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
							</a>
                            <div class="collapse" id="collapseShops" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
									<a class="nav-link sub_nav_link" href="shops.jsp">All Shops</a>
									<a class="nav-link sub_nav_link" href="add_shop.jsp">Add Shop</a>
								</nav>
                            </div>
							<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseProducts" aria-expanded="false" aria-controls="collapseProducts">
								<div class="sb-nav-link-icon"><i class="fas fa-box"></i></div>
                                Products
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
							</a>
                            <div class="collapse" id="collapseProducts" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
									<a class="nav-link sub_nav_link" href="products.jsp">All Products</a>
									<a class="nav-link sub_nav_link" href="add_product.jsp">Add Product</a>
								</nav>
                            </div>
							<a class="nav-link" href="orders.jsp">
								<div class="sb-nav-link-icon"><i class="fas fa-cart-arrow-down"></i></div>
                                Orders
							</a>
							<a class="nav-link" href="customers.jsp">
								<div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                                Customers
							</a>
							<a class="nav-link" href="offers.jsp">
								<div class="sb-nav-link-icon"><i class="fas fa-gift"></i></div>
                                Offers
							</a>
							<a class="nav-link" href="pages.jsp">
								<div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                Pages
							</a>
                            <a class="nav-link" href="menu.jsp">
								<div class="sb-nav-link-icon"><i class="fas fa-layer-group"></i></div>
                                Menu
							</a>
							<a class="nav-link" href="updater.jsp">
								<div class="sb-nav-link-icon"><i class="fas fa-cloud-upload-alt"></i></div>
                                Updater
							</a>
							<a class="nav-link active" href="#" data-bs-toggle="collapse" data-bs-target="#collapseSettings" aria-expanded="true" aria-controls="collapseSettings">
								<div class="sb-nav-link-icon"><i class="fas fa-cog"></i></div>
                                Setting
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
							</a>
                            <div class="collapse show" id="collapseSettings" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
									<a class="nav-link sub_nav_link active" href="general_setting.jsp">General Settings</a>
									<a class="nav-link sub_nav_link" href="payment_setting.jsp">Payment Settings</a>
									<a class="nav-link sub_nav_link" href="email_setting.jsp">Email Settings</a>
								</nav>
                            </div>
							<a class="nav-link" href="reports.jsp">
								<div class="sb-nav-link-icon"><i class="fas fa-chart-bar"></i></div>
                                Reports
							</a>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h2 class="mt-30 page-title">General Setting</h2>
                        <ol class="breadcrumb mb-30">
                            <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active">General Setting</li>
                        </ol>
                        <div class="row">
							<div class="col-lg-4 col-md-6">
								<div class="left-side-tabs">
									<div class="dashboard-left-links">
										<a href="general_setting.jsp" class="user-item"><i class="fas fa-cogs"></i>Site Setting</a>
										<a href="general_setting_logo.jsp" class="user-item"><i class="far fa-image"></i>Logo</a>
										<a href="general_setting_favicon.jsp" class="user-item"><i class="far fa-image"></i>Favicon</a>
										<a href="general_setting_analytics.jsp" class="user-item active"><i class="fas fa-chart-line"></i>Google Analytics</a>
										<a href="general_setting_contact.jsp" class="user-item"><i class="fas fa-briefcase"></i>Contact Setting</a>
									</div>
								</div>
							</div>
							<div class="col-lg-8 col-md-6">
								<div class="card card-static-2 mb-30">
									<div class="card-title-2">
										<h4>Google Analytics (UA ID) Setting</h4> 
									</div>
									<div class="card-body-table">
										<div class="news-content-right pd-20">
											<div class="row">
												<div class="col-lg-12">
													<div class="form-group">
														<label class="form-label">Tracking Id*</label>
														<input type="text" type="text" class="form-control" value="UA-157373595-1" placeholder="UA-">
													</div>
													<button class="save-btn hover-btn" type="submit">Save Changes</button>
												</div>
											</div>
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
		
		<!-- Javascripts -->
        <script src="js/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="js/scripts.js"></script>
		
    </body>

<!-- Mirrored from gambolthemes.net/html-items/gambo_admin_new/general_setting_analytics.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:10:15 GMT -->
</html>
