<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
    </head>
    <body>
        <security:authorize access="isAuthenticated()">
            <a href="/logout">Logout</a>
        </security:authorize>
        <security:authorize access="!isAuthenticated()">
            <a href="/login">Login</a>
        </security:authorize>

 
        


    </body>
</html>

