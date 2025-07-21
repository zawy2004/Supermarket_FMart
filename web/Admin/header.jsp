<%-- 
    Document   : header
    Created on : Jul 15, 2025, 6:51:57 PM
    Author     : gia huy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
%>
< <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
    <a class="navbar-brand logo-brand" href="index.jsp">FMart Supermarket</a>
    <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
    <a href="" class="frnt-link"><i class="fas fa-external-link-alt"></i>Home</a>
    <% if (user != null) { %>
    <% if (user.getRoleId() == 2) { %>
    <a class="navbar-brand logo-brand" href="index.jsp">Staff</a>
    <% } else if (user.getRoleId() == 3) { %>
    <a class="navbar-brand logo-brand" href="index.jsp">Admin</a>
    <% } else if (user.getRoleId() == 4) { %>
    <a class="navbar-brand logo-brand" href="index.jsp">Manager</a>
    <% } %>
    <% } %>
    <ul class="navbar-nav ms-auto mr-md-0">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <% if (user != null) {%>
                <%= user.getFullName()%>
                <% } else { %>

                <% } %>
                <i class="fas fa-user fa-fw">

                </i>
            </a>
            <div class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
<!--                <a class="dropdown-item admin-dropdown-item" href="edit_profile.jsp">Edit Profile</a>
                <a class="dropdown-item admin-dropdown-item" href="change_password.jsp">Change Password</a>-->
                <a class="dropdown-item admin-dropdown-item" href="logout">Logout</a>
            </div>
        </li>
    </ul>
</nav>

