<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="webjars/jquery/1.9.1/jquery.min.js"></script
        <title>Document</title>
    </head>
    <body>
        <security:authorize access="isAuthenticated()">
            <form:form action="/logout" method="POST">
                <input type="submit" value="Logout"/>
            </form:form>
        </security:authorize>
        <security:authorize access="!isAuthenticated()">
            <a href="/login">Login</a>
        </security:authorize>

 
        


    </body>
</html>

