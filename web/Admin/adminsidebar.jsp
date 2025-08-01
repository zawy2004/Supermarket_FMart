<%-- 
    Document   : adminsidebar
    Created on : Jun 25, 2025, 3:49:34 PM
    Author     : gia huy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                           
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
                            <a class="nav-link" href="UserManagementServlet">
                                <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                                User
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
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseSettings" aria-expanded="false" aria-controls="collapseSettings">
                                <div class="sb-nav-link-icon"><i class="fas fa-cog"></i></div>
                                Setting
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseSettings" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link sub_nav_link" href="general_setting.jsp">General Settings</a>
                                    <a class="nav-link sub_nav_link" href="payment_setting.jsp">Payment Settings</a>
                                    <a class="nav-link sub_nav_link" href="email_setting.jsp">Email Settings</a>
                                </nav>
                            </div>
                           
                        </div>
                    </div>
                </nav>
            </div>
