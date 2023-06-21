<%@ taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login &#8212; TZM</title>
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
                background-color: transparent;
            }
            .horozontalline {
                background: #efefef;
                height: 1.5px;
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
    <body style="background: linear-gradient(90deg, #efefef 50%, transparent 50%);">
        <div id="modal" class="page-padding full_centered">
            <div class="container">
                <div style="box-shadow: 0 0 6px #efefef inset; background: linear-gradient(90deg, white 50%, #efefef 50%);" class="auth_form_wrapper drop-shadow lifted">
                    <button id="close_button" class="hidden">Close</button>
                    <form:form style="border-radius: 5px; box-shadow: -1px 0px 1px #efefef inset;" id="login_form" class="form-block"  action="/login" method="POST">
                        <h1 style="text-align: left;" class="small-heading dark">&#x2022; TZM &#x2022;</h1>
                        <div class="field-wrapper-2 medium-margin">
                            <input class="text-field-2 small-text" type="text" placeholder="Username" name="username" value="${username}" minlength="3" maxlength="100"/>
                            <div style="width: 200px;" class="horozontalline"></div>
                            <input  class="text-field-2 small-text" type="password" placeholder="Password" name="password" value="${password}" minlength="8" maxlength="100"/>
                            <label id="error_label" class="error small-text">${message}</label>
                        </div>
                        <div style="gap: 10px;" class="field-wrapper-2">
                            <div style="column-gap: 1em;" class="row">
                                <div style="min-width: 50%; border-radius: 35px; justify-content: space-evenly;"  class="button small-text">
                                    <input class="submit small-text" type="submit" value="Login"/>
                                    <svg xmlns="http://www.w3.org/2000/svg" height="25" viewBox="0 -960 960 960" width="25"><path fill="white" d="M540-263q-9-9-9-21.5t8-20.5l147-147H190q-13 0-21.5-8.5T160-482q0-13 8.5-21.5T190-512h496L538-660q-9-9-8.5-21t9.5-21q9-8 21.5-8t20.5 8l199 199q5 5 7 10t2 11q0 6-2 11t-7 10L582-263q-9 9-21 9t-21-9Z"/></svg>
                                </div>
                                <div style="align-content: center; flex-wrap: wrap;" class="row">
                                    <label class="label-field small-text dark">OR</label>
                                    <a style="margin: auto 0; white-space: nowrap; padding: 0; text-decoration: underline;"  id="signup_btn" href="/signup" class="button small-text dark">Sign up</a>
                                </div>
                            </div>
                            <a style="max-width: 50%;" id="pwd_btn" href="" class="button small-text dark small-margin">Forgot password ?</a>
                        </div>
                        <!--a id="signup_btn" href="/signup" class="button small-text dark">Sign up</a-->
                        <div style="display: flex; max-width: 50%;">
                            <input type="checkbox" id="rememberMe" name="rememberMe"/>
                            <label style="font-style: italic;" for="rememberMe" class="small-text dark">Keep me Signed in</label>
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