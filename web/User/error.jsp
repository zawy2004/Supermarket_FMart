<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FMart - Error</title>
    <link href="User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="User/css/style.css" rel="stylesheet">
</head>
<body>
    <div class="container text-center py-5">
        <h2>Error</h2>
        <p class="text-danger">${error != null ? error : 'An unexpected error occurred'}</p>
        <a href="shop" class="btn btn-primary">Return to Shop</a>
    </div>
    <script src="User/js/jquery.min.js"></script>
    <script src="User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>