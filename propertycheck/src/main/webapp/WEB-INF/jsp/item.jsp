<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/tablet.style.css" rel="stylesheet" type="text/css">
    <link href="/css/mobilelandscape.style.css" rel="stylesheet" type="text/css">
    <link href="/css/mobileportrait.style.css" rel="stylesheet" type="text/css">
    <title>Item</title>
</head>
<body>
    <security:authorize access="isAuthenticated()">
        <button type="button" id="logout_button">Logout</button>
    </security:authorize>
    <security:authorize access="!isAuthenticated()">
        <a id="login_button">Login</a>
        <modal-login></modal-login>
    </security:authorize>
    <script src="https://code.jquery.com/jquery-latest.min.js" type="text/javascript" ></script>
    <script src="/js/LoginModal.js" type="text/javascript"></script><!--work for both authorized and unauthorized-->



</body>
</html>