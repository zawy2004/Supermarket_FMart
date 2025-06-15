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
    <title>FMart Supermarket Admin</title>
    <link href="css/styles.css" rel="stylesheet">
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <div class="container">
        <h2>Add New Product</h2>
        <!-- Form to add new product -->
        <form action="add_product" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="productName">Product Name</label>
                <input type="text" class="form-control" id="productName" name="productName" required>
            </div>
            <div class="form-group">
                <label for="sku">SKU</label>
                <input type="text" class="form-control" id="sku" name="sku" required>
            </div>
            <div class="form-group">
                <label for="sellingPrice">Selling Price</label>
                <input type="number" class="form-control" id="sellingPrice" name="sellingPrice" required>
            </div>
            <div class="form-group">
                <label for="costPrice">Cost Price</label>
                <input type="number" class="form-control" id="costPrice" name="costPrice" required>
            </div>
            <div class="form-group">
                <label for="category">Category</label>
                <select class="form-control" id="category" name="category" required>
                    <option value="1">Fruits & Vegetables</option>
                    <option value="2">Grocery & Staples</option>
                    <!-- Add other categories -->
                </select>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea class="form-control" id="description" name="description" rows="4"></textarea>
            </div>
            <div class="form-group">
                <label for="productImage">Product Image</label>
                <input type="file" class="form-control" id="productImage" name="productImage" required>
            </div>
            <button type="submit" class="btn btn-primary">Add Product</button>
        </form>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>

</html>
