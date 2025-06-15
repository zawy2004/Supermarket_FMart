<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Category</title>
    <link href="Admin/css/styles.css" rel="stylesheet">
    <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Add Category</h2>
    <form action="CategoryServlet" method="post">
        <input type="hidden" name="action" value="add">
        <div class="mb-3">
            <label class="form-label">Category Name</label>
            <input name="categoryName" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control"></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Parent Category ID</label>
            <input type="number" name="parentCategoryID" class="form-control" value="0">
        </div>
        <div class="mb-3">
            <label class="form-label">Image URL</label>
            <input name="imageUrl" class="form-control">
        </div>
        <div class="mb-3">
            <label class="form-label">Status</label>
            <select name="isActive" class="form-control">
                <option value="true">Active</option>
                <option value="false">Inactive</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Display Order</label>
            <input type="number" name="displayOrder" class="form-control" value="1">
        </div>
        <button type="submit" class="btn btn-success">Save</button>
        <a href="CategoryServlet" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
