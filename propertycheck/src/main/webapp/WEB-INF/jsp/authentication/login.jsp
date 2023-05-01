<%@ taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link href="/css/style.css" rel="stylesheet" type="text/css">
        <link href="/css/tablet.style.css" rel="stylesheet" type="text/css">
        <link href="/css/mobilelandscape.style.css" rel="stylesheet" type="text/css">
        <link href="/css/mobileportrait.style.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div id="modal" class="page-padding full_centered">
            <div class="container">
                <div class="auth_form_wrapper">
                    <div class="radial_background"></div>
                    <button id="close_button" class="hidden">Close</button>
                    <form:form id="login_form" class="form-block"  action="/login" method="POST">
                        <div class="field-wrapper-2 lgn medium-margin">
                            <input class="text-field-2 large-text" type="text" placeholder="Username" name="username" value="${username}" minlength="3" maxlength="100"/>
                            <div class="horozontalline"></div>
                            <input class="text-field-2 large-text" type="password" placeholder="Password" name="password" value="${password}" minlength="8" maxlength="100"/>
                            <label id="error_label" class="error small-text">${message}</label>
                        </div>
                        <div class="field-wrapper">
                            <input class="button small-text" type="submit" value="Login"/>
                        </div>
                        <a href="" class="button small-text dark">Forgot password ?</a>
                        <a href="/signup" class="button small-text dark">Sign up</a>
                        <div style="margin-top: 25px;">
                            <input type="checkbox" id="rememberMe" name="rememberMe"/>
                            <label for="rememberMe" class="label-field small-text dark">Remember me</label>
                        </div>
                        <!--input  type="hidden" value="${cookie['XSRF-TOKEN'].getValue()}"/--><!--Not needed because form:form tags already do the job-->
                    </form:form>
                    <div class="overlay bottom"></div>
                </div>
            </div>
        </div>
    </body>
</html>