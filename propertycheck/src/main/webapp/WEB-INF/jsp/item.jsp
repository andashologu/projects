<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<style>
    html, body{
        margin: 0;
        height: 100%;
    }
    #loader-wrapper {
        position: fixed;
        display: none;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 1000;
    background-color: rgba(128, 128, 128, 0.09);
    }
    .loader-container{
        width: 100%;
        display: flex;
        flex-direction: column;
        justify-content: center;

    }
    .loader{
        position: relative;
        border: 3px solid transparent;
    }
    .loader#line1 {
        border-top-color: #3498db;
        -webkit-animation: right 2s linear infinite; /* Chrome, Opera 15+, Safari 5+ */
        animation: right 2s linear infinite; /* Chrome, Firefox 16+, IE 10+, Opera */
    }

    .loader#line2 {
        border-top-color: #e74c3c;
        -webkit-animation: left 2.5s linear infinite; /* Chrome, Opera 15+, Safari 5+ */
        animation: left 2.5s linear infinite; /* Chrome, Firefox 16+, IE 10+, Opera */
    }

    .loader#line3 {
        border-top-color: #f9c922;
        -webkit-animation: right 3s linear infinite; /* Chrome, Opera 15+, Safari 5+ */
        animation: right 3s linear infinite; /* Chrome, Firefox 16+, IE 10+, Opera */
    }
    @keyframes right {
        0%   { 
            left: 0;
            right: 100%;
            width: 0px;
        }
        100% {
            left: 100%;
            right: 0;
            width: 300px;
        }
    }
    @keyframes left {
        0%   { 
            left: 100%;
            right: 0;
            width: 450px;
        }
        100% {
            left: 0;
            right: 100%;
            width: 0;
        }
    }

</style>
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
        <div id="loader-wrapper">
            <div class="loader-container">
                <div class="loader" id="line1"></div>
                <div class="loader" id="line2"></div>
                <div class="loader" id="line3"></div>
            </div>
        </div>
    </security:authorize>
    <script src="https://code.jquery.com/jquery-latest.min.js" type="text/javascript" ></script>
    <script src="/js/script.js" type="text/javascript"></script><!--work for both authorized and unauthorized-->
    <script src="/js/LoginModal.js" type="text/javascript"></script><!--work for both authorized and unauthorized-->

</body>
</html>