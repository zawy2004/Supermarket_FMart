<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile - FMart</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container mt-5">
        <h2>Hồ sơ cá nhân</h2>
        
        <div>
            <h4>Ảnh đại diện hiện tại:</h4>
            <img src="<%=user.getProfileImageUrl() != null ? request.getContextPath() + "/" + user.getProfileImageUrl() : request.getContextPath() + "/User/images/avatar/default.png"%>" 
                 alt="Avatar" width="150" style="border-radius: 50%">
        </div>
        
        <form action="<%=request.getContextPath()%>/profile/uploadImage" method="post" enctype="multipart/form-data" class="mt-3">
            <div>
                <label>Chọn ảnh mới:</label><br>
                <input type="file" name="avatarFile" accept="image/*" required>
            </div>
            <button type="submit" class="btn btn-primary mt-2">Cập nhật ảnh</button>
        </form>
        
        <div class="mt-4">
            <a href="dashboard_overview.jsp" class="btn btn-secondary">Quay lại Dashboard</a>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>
