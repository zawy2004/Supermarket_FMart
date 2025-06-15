<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Product" %>
<%@ page import="dao.ProductDAO" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Edit Product - FMart Supermarket</title>
    <link href="css/styles.css" rel="stylesheet">
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
        <a class="navbar-brand logo-brand" href="index.jsp">FMart Supermarket</a>
    </nav>

    <div class="container-fluid">
        <h2 class="mt-30 page-title">Edit Product</h2>

        <!-- Form ?? ch?nh s?a s?n ph?m -->
        <form action="update_product" method="post">
            <!-- Tr??ng ?n ch?a productID -->
            <input type="hidden" name="productID" value="${product.productID}"> <!-- Tr??ng này c?n có trong form -->

            <div class="form-group">
                <label for="productName">Product Name</label>
                <input type="text" class="form-control" id="productName" name="productName" value="${product.productName}">
            </div>

            <div class="form-group">
                <label for="sku">SKU</label>
                <input type="text" class="form-control" id="sku" name="sku" value="${product.sku}">
            </div>

            <div class="form-group">
                <label for="sellingPrice">Selling Price</label>
                <input type="text" class="form-control" id="sellingPrice" name="sellingPrice" value="${product.sellingPrice}">
            </div>

            <div class="form-group">
                <label for="costPrice">Cost Price</label>
                <input type="text" class="form-control" id="costPrice" name="costPrice" value="${product.costPrice}">
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea class="form-control" id="description" name="description">${product.description}</textarea>
            </div>

            <!-- Các tr??ng khác -->

            <button type="submit" class="btn btn-primary">Update Product</button>
        </form>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
</body>

</html>
