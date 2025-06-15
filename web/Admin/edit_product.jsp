<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <link href="Admin/css/styles.css" rel="stylesheet">
    <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Product</h2>

    <c:if test="${not empty product}">
        <form action="ProductServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="productId" value="${product.productID}">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label>Product Name</label>
                    <input name="productName" value="${product.productName}" class="form-control" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label>SKU</label>
                    <input name="sku" value="${product.sku}" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label>Category ID</label>
                    <input type="number" name="categoryID" value="${product.categoryID}" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label>Supplier ID</label>
                    <input type="number" name="supplierID" value="${product.supplierID}" class="form-control">
                </div>
                <div class="col-md-12 mb-3">
                    <label>Description</label>
                    <textarea name="description" class="form-control">${product.description}</textarea>
                </div>
                <div class="col-md-6 mb-3">
                    <label>Unit</label>
                    <input name="unit" value="${product.unit}" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label>Cost Price</label>
                    <input type="number" step="0.01" name="costPrice" value="${product.costPrice}" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label>Selling Price</label>
                    <input type="number" step="0.01" name="sellingPrice" value="${product.sellingPrice}" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label>Min Stock Level</label>
                    <input type="number" name="minStockLevel" value="${product.minStockLevel}" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label>Status</label>
                    <select name="isActive" class="form-control">
                        <option value="true" ${product.isActive ? "selected" : ""}>Active</option>
                        <option value="false" ${!product.isActive ? "selected" : ""}>Inactive</option>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label>Weight</label>
                    <input type="number" step="0.01" name="weight" value="${product.weight}" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label>Dimensions</label>
                    <input name="dimensions" value="${product.dimensions}" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label>Expiry Days</label>
                    <input type="number" name="expiryDays" value="${product.expiryDays}" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label>Brand</label>
                    <input name="brand" value="${product.brand}" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label>Origin</label>
                    <input name="origin" value="${product.origin}" class="form-control">
                </div>
            </div>

            <button type="submit" class="btn btn-success">Update</button>
            <a href="ProductServlet" class="btn btn-secondary">Cancel</a>
        </form>
    </c:if>

    <c:if test="${empty product}">
        <div class="alert alert-danger mt-3">Product not found.</div>
        <a href="ProductServlet" class="btn btn-secondary">Back</a>
    </c:if>
</div>
</body>
</html>
