<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Item</title>
</head>
<body>
    <security:authorize access="isAuthenticated()">
        <a href="/logout">Logout</a>
    </security:authorize>
    <script src="https://code.jquery.com/jquery-latest.min.js" type="text/javascript" ></script>
    <security:authorize access="!isAuthenticated()">
        <a id="login_button">Login</a>
        <script src="/js/LoginModal.js" type="text/javascript"></script>
    </security:authorize>



</body>
</html>