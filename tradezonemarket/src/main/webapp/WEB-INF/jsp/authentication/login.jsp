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
        <style>
            .text-field-2.large-text, .text-field.large-text-2::placeholder{
                font-size: 16px;
            }
            .text-field-2 {
                position: relative;
                width: 120%;
                left: -10%;
            }
            @media screen and (max-width: 478px){
                body{
                    background-color: #cacaca2a;
                }
                .page-padding.full_centered{
                    min-height: auto;
                }
                /*#pwd_btn{
                    padding-bottom: 0;
                }*/
                #signup_btn{
                    padding-top: 0;
                }
            }
        </style>
    </head>
    <body>
        <div id="modal" class="page-padding full_centered">
            <div class="container">
                <div class="auth_form_wrapper">
                    <button id="close_button" class="hidden">Close</button>
                    <form:form id="login_form" class="form-block"  action="/login" method="POST">
                        <h1 style="text-align: left;" class="small-heading dark">TradeZoneMarket</h1>
                        <div class="field-wrapper-2 medium-margin">
                            <input class="text-field-2 small-text" type="text" placeholder="Username" name="username" value="${username}" minlength="3" maxlength="100"/>
                            <div style="width: 200px;" class="horozontalline"></div>
                            <input  class="text-field-2 small-text" type="password" placeholder="Password" name="password" value="${password}" minlength="8" maxlength="100"/>
                            <label id="error_label" class="error small-text">${message}</label>
                        </div>
                        <div style="margin: 0 auto; gap: 10px;" class="field-wrapper-2">
                            <input class="button small-text" type="submit" value="Login"/>
                            <a id="pwd_btn" href="" class="button small-text dark small-margin">Forgot password ?</a>
                        </div>
                        <div style="flex-direction: row;" class="field-wrapper lgn small-margin">
                            <div style="margin: auto 0" class="horozontalline"></div>
                            <label class="label-field small-text dark">OR</label>
                            <div style="margin: auto 0" class="horozontalline"></div>
                        </div>
                        <a id="signup_btn" href="/signup" class="button small-text dark">Sign up</a>
                        <div style="display: flex; margin-top: 25px;">
                            <input type="checkbox" id="rememberMe" name="rememberMe"/>
                            <label style="font-style: italic;" for="rememberMe" class="smaller-text dark">Remember me next time</label>
                        </div>
                        <!--Put more content here, such as our social media links-->
                        <!--input  type="hidden" value="${cookie['XSRF-TOKEN'].getValue()}"/-->
                        <!--Not needed because form:form tags already do the job-->
                    </form:form>
                    <div class="overlay bottom"></div>
                </div>
            </div>
        </div>
    </body>
</html>