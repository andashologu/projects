<%@ taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<html lang="en">
    <style>
        .text-field.large-text{
            font-size: 18px;
            padding: 8px 0;
        }
    </style>
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
            <div class="background_image_2"></div>
            <div class="container">
                <div class="auth_form_wrapper">
                    <div class="background_image_2"></div>
                    <button id="close_button" class="hidden">Close</button>
                    <form:form id="login_form" class="form-block"  action="/login" method="POST">
                        <h1 style="margin-left: auto; margin-right: auto;" class="small-heading dark">PropertyCheck</h1>
                        <div class="field-wrapper-2 lgn medium-margin">
                            <input class="text-field large-text" type="text" placeholder="Username" name="username" value="${username}" minlength="3" maxlength="100"/>
                            <input  class="text-field large-text" type="password" placeholder="Password" name="password" value="${password}" minlength="8" maxlength="100"/>
                            <label id="error_label" class="error small-text">${message}</label>
                        </div>
                        <input style="margin: auto;" class="button small-text" type="submit" value="Login"/>
                        <a style="margin-left: auto; margin-right: auto;" href="" class="button small-text dark small-margin">Forgot password ?</a>
                        <div style="flex-direction: row;" class="field-wrapper lgn small-margin">
                            <div style="margin: auto 0" class="horozontalline"></div>
                            <label class="label-field small-text dark">OR</label>
                            <div style="margin: auto 0" class="horozontalline"></div>
                        </div>
                        <a style="margin: auto;" href="/signup" class="button small-text dark">Sign up</a>
                        <div style="margin-top: 25px;">
                            <input type="checkbox" id="rememberMe" name="rememberMe"/>
                            <label for="rememberMe" class="label-field small-text dark">Remember me next time</label>
                        </div>
                        <!--Put more content here, such as our social media links-->
                        <!--input  type="hidden" value="${cookie['XSRF-TOKEN'].getValue()}"/--><!--Not needed because form:form tags already do the job-->
                    </form:form>
                    <div class="overlay bottom"></div>
                </div>
            </div>
        </div>
    </body>
</html>