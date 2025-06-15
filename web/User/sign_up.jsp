<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $("#sendCode").click(function() {
                var email = $("#emailaddress").val();
                $.ajax({
                    url: "${pageContext.request.contextPath}/SendVerificationCodeServlet",
                    type: "POST",
                    data: { emailaddress: email },
                    success: function(response) {
                        var data = JSON.parse(response);
                        alert(data.message);
                    },
                    error: function(xhr, status, error) {
                        alert("Error sending verification code: " + error + "\nStatus: " + status + "\nResponse: " + xhr.responseText);
                    }
                });
            });

            $("#resendCode").click(function() {
                var email = $("#emailaddress").val();
                $.ajax({
                    url: "${pageContext.request.contextPath}/SendVerificationCodeServlet",
                    type: "POST",
                    data: { emailaddress: email },
                    success: function(response) {
                        var data = JSON.parse(response);
                        alert(data.message);
                    },
                    error: function(xhr, status, error) {
                        alert("Error resending verification code: " + error + "\nStatus: " + status + "\nResponse: " + xhr.responseText);
                    }
                });
            });

            $("#registerForm").submit(function(e) {
                e.preventDefault();
                var formData = $(this).serialize();
                $.ajax({
                    url: "${pageContext.request.contextPath}/register",
                    type: "POST",
                    data: formData,
                    success: function(response) {
                        window.location.href = "${pageContext.request.contextPath}/index.jsp";
                    },
                    error: function(xhr) {
                        alert("Registration failed: " + xhr.responseText);
                    }
                });
            });
        });
    </script>
</head>
<body>
    <form id="registerForm">
        <h2>Sign Up</h2>
        <input type="text" name="fullname" placeholder="Full Name" value="David My" required><br>
        <input type="email" id="emailaddress" name="emailaddress" placeholder="Email Address" value="ewi042650@gmail.com" required><br>
        <input type="text" name="phone" placeholder="Phone Number" value="0774454307" required><br>
        <input type="text" name="address" placeholder="Address" value="da nang" required><br>
        <input type="date" name="dob" placeholder="mm/dd/yyyy" value="2004-06-26" required><br>
        <select name="gender" required>
            <option value="">Select Gender</option>
            <option value="Male" selected>Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
        </select><br>
        <input type="text" name="code1" maxlength="1" size="1">-
        <input type="text" name="code2" maxlength="1" size="1">-
        <input type="text" name="code3" maxlength="1" size="1">-
        <input type="text" name="code4" maxlength="1" size="1">
        <button type="button" id="sendCode">Send</button>
        <button type="button" id="resendCode">Resend Code</button><br>
        <input type="password" name="password" placeholder="Password" value="Password123" required><br>
        <button type="submit">Sign Up Now</button>
    </form>
</body>
</html>