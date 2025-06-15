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
    <link href="Admin/css/styles.css" rel="stylesheet">
    <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <div class="container">
        <h2>Add New Product</h2>
        <!-- Form to add new product -->
        <form action="ProductServlet" method="post"> <!-- N?u dùng file upload -->
    <input type="hidden" name="action" value="add">

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
        <input type="number" step="0.01" class="form-control" id="sellingPrice" name="sellingPrice" required>
    </div>

    <div class="form-group">
        <label for="costPrice">Cost Price</label>
        <input type="number" step="0.01" class="form-control" id="costPrice" name="costPrice" required>
    </div>

    <div class="form-group">
        <label for="categoryID">Category</label>
        <select class="form-control" id="categoryID" name="categoryID" required>
            <option value="1">Fruits & Vegetables</option>
            <option value="2">Grocery & Staples</option>
        </select>
    </div>

    <div class="form-group">
        <label for="supplierID">Supplier ID</label>
        <input type="number" class="form-control" id="supplierID" name="supplierID" required>
    </div>

    <div class="form-group">
        <label for="description">Description</label>
        <textarea class="form-control" id="description" name="description"></textarea>
    </div>

    <div class="form-group">
        <label for="unit">Unit</label>
        <input type="text" class="form-control" id="unit" name="unit">
    </div>

    <div class="form-group">
        <label for="minStockLevel">Min Stock Level</label>
        <input type="number" class="form-control" id="minStockLevel" name="minStockLevel">
    </div>

    <div class="form-group">
        <label for="isActive">Status</label>
        <select name="isActive" id="isActive" class="form-control">
            <option value="true">Active</option>
            <option value="false">Inactive</option>
        </select>
    </div>

    <div class="form-group">
        <label for="weight">Weight</label>
        <input type="number" step="0.01" class="form-control" id="weight" name="weight">
    </div>

    <div class="form-group">
        <label for="dimensions">Dimensions</label>
        <input type="text" class="form-control" id="dimensions" name="dimensions">
    </div>

    <div class="form-group">
        <label for="expiryDays">Expiry Days</label>
        <input type="number" class="form-control" id="expiryDays" name="expiryDays">
    </div>

    <div class="form-group">
        <label for="brand">Brand</label>
        <input type="text" class="form-control" id="brand" name="brand">
    </div>

    <div class="form-group">
        <label for="origin">Origin</label>
        <input type="text" class="form-control" id="origin" name="origin">
    </div>

    <button type="submit" class="btn btn-success">Add Product</button>
    <a href="ProductServlet" class="btn btn-secondary">Cancel</a>
</form>

    </div>

    <script src="Admin/js/jquery.min.js"></script>
    <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>

</html>
