<!DOCTYPE html>
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
    <body style="position: fixed; width: 100%">
        <div id="modal" class="page-padding full_centered">
            <div class="container">
                <div class="auth_form_wrapper">
                    <form id="login_form" class="form-block"  action="/login">
                        <div class="field-wrapper-2 lgn medium-margin">
                            <input class="text-field-2 large-text" type="text" placeholder="Username" name="username" minlength="3" maxlength="100"/>
                            <div class="horozontalline"></div>
                            <input class="text-field-2 large-text" type="password" placeholder="Password" name="password" minlength="8" maxlength="100"/>
                        </div>
                        <div class="field-wrapper">
                            <input class="button small-text" type="submit" value="Login"/>
                        </div>
                        <a href="" class="link-field small-text">Forgot password ?</a>
                        <div style="margin-top: 25px;">
                            <input type="checkbox" name="rememberMe"/>
                            <label class="label-field small-text">Remember me</label>
                        </div>
                        <label id="error_label" class="error small-text">${message}</label>
                    </form>
                    <div class="overlay bottom"></div>
                    <div class="field-wrapper bottom">
                        <div>
                            <label class="link-field small-text">New to PropertyCheck?</label>
                            <a href="/signup" class="link-field small-text small-margin">Create an account</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>