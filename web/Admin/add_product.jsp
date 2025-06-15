<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
    <link href="Admin/css/styles.css" rel="stylesheet">
    <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Add New Product</h2>

    <form action="ProductServlet" method="post">
        <input type="hidden" name="action" value="add">
            <input type="hidden" name="productId" value="${product.productID}">

        <div class="row">
            <div class="col-md-6 mb-3">
                <label>Product Name</label>
                <input name="productName" class="form-control" required>
            </div>
            <div class="col-md-6 mb-3">
                <label>SKU</label>
                <input name="sku" class="form-control">
            </div>
            <div class="col-md-6 mb-3">
                <label>Category ID</label>
                <input type="number" name="categoryID" class="form-control" required>
            </div>
            <div class="col-md-6 mb-3">
                <label>Supplier ID</label>
                <input type="number" name="supplierID" class="form-control" required>
            </div>
            <div class="col-md-12 mb-3">
                <label>Description</label>
                <textarea name="description" class="form-control"></textarea>
            </div>
            <div class="col-md-6 mb-3">
                <label>Unit</label>
                <input name="unit" class="form-control">
            </div>
            <div class="col-md-6 mb-3">
                <label>Cost Price</label>
                <input type="number" step="0.01" name="costPrice" class="form-control">
            </div>
            <div class="col-md-6 mb-3">
                <label>Selling Price</label>
                <input type="number" step="0.01" name="sellingPrice" class="form-control">
            </div>
            <div class="col-md-6 mb-3">
                <label>Min Stock Level</label>
                <input type="number" name="minStockLevel" class="form-control">
            </div>
            <div class="col-md-6 mb-3">
                <label>Status</label>
                <select name="isActive" class="form-control">
                    <option value="true">Active</option>
                    <option value="false">Inactive</option>
                </select>
            </div>
            <div class="col-md-6 mb-3">
                <label>Weight</label>
                <input type="number" step="0.01" name="weight" class="form-control">
            </div>
            <div class="col-md-6 mb-3">
                <label>Dimensions</label>
                <input name="dimensions" class="form-control">
            </div>
            <div class="col-md-6 mb-3">
                <label>Expiry Days</label>
                <input type="number" name="expiryDays" class="form-control">
            </div>
            <div class="col-md-6 mb-3">
                <label>Brand</label>
                <input name="brand" class="form-control">
            </div>
            <div class="col-md-6 mb-3">
                <label>Origin</label>
                <input name="origin" class="form-control">
            </div>
        </div>

        <button type="submit" class="btn btn-success">Add Product</button>
        <a href="ProductServlet" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
