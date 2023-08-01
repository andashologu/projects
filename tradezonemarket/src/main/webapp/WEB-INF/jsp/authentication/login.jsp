<%@ taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login &#8212; TZm</title>
        <link href="/css/style.css" rel="stylesheet" type="text/css">
        <link href="/css/tablet.style.css" rel="stylesheet" type="text/css">
        <link href="/css/mobilelandscape.style.css" rel="stylesheet" type="text/css">
        <link href="/css/mobileportrait.style.css" rel="stylesheet" type="text/css">
        <style>
            .text-field-2.large-text, .text-field.large-text-2::placeholder{
                font-size: 16px;
            }
            .horozontalline {
                background: #efefef;
                height: 1.5px;
            }
            .button{
                min-height: 35px;
            }
            #rememberMe + label:hover{
                color: black;
            }
            #signup_btn{
                box-shadow: 0px 0px 2px 0px #cacaca; 
            }
            svg#Laye_1{
                display: block;
            }
            svg#Layer_2{
                display: none;
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
                .auth_form_wrapper{
                    height: 100vh;
                }
                #signup_btn{
                    border: 1px solid #cacaca; 
                    box-shadow: none;
                }
                svg#Layer_1{
                    display: none;
                }
                svg#Layer_2{
                    display: block;
                }
            }
        </style>
    </head>
    <body style="background: linear-gradient(90deg, #efefef 50%, whitesmoke 50%);">
        <div id="modal" class="page-padding full_centered">
            <div class="container">
                <div style="box-shadow: 0 0 6px #efefef inset;" class="auth_form_wrapper drop-shadow lifted">
                    <button id="close_button" class="hidden">Close</button>
                    <div></div>
                    <svg style="height: 50%; width: 100%; background: linear-gradient(90deg, whitesmoke 50%, transparent 50%);" id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 31.96 25.06">
                        <rect fill="#efefef" class="cls-1" y="1.51" width="8" height="4"/>
                        <rect fill="#efefef" class="cls-1" x="4" y="5.51" width="4" height="19.55"/>
                        <rect fill="#efefef" class="cls-1" x="9" y="1.51" width="4" height="4"/>
                        <polygon fill="white" class="cls-1" points="11 25.06 14 1.51 18 1.51 15 25.06 11 25.06"/>
                        <rect fill="whitesmoke" class="cls-1" x="18" y="21.06" width="4" height="4"/>
                        <path fill="whitesmoke" class="cls-1" d="m18,20.06h4s0-6.06,0-6.06c0,0,.2-1.63,1.41-1.75l1.71-.05,1.41.04c1.27.03,1.41,1.76,1.41,1.76v11.06h4.02v-11.17s-.02-3.5-.28-4.38c0,0-.05-2.74-3.74-2.73-2.33-.01-2.97,2.71-2.97,2.71,0,0-.37-2.72-2.97-2.71,0,0-2.5-.03-4,0v13.28Z"/>
                    </svg>
                    <svg style="height: 50%; width: 100%; background: linear-gradient(90deg, #efefef 50%, transparent 50%);" id="Layer_2" data-name="Layer 2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 31.96 25.06">
                        <rect fill="whitesmoke" class="cls-1" y="1.51" width="8" height="4"/>
                        <rect fill="whitesmoke" class="cls-1" x="4" y="5.51" width="4" height="19.55"/>
                        <rect fill="whitesmoke" class="cls-1" x="9" y="1.51" width="4" height="4"/>
                        <polygon fill="white" class="cls-1" points="11 25.06 14 1.51 18 1.51 15 25.06 11 25.06"/>
                        <rect fill="#efefef" class="cls-1" x="18" y="21.06" width="4" height="4"/>
                        <path fill="#efefef" class="cls-1" d="m18,20.06h4s0-6.06,0-6.06c0,0,.2-1.63,1.41-1.75l1.71-.05,1.41.04c1.27.03,1.41,1.76,1.41,1.76v11.06h4.02v-11.17s-.02-3.5-.28-4.38c0,0-.05-2.74-3.74-2.73-2.33-.01-2.97,2.71-2.97,2.71,0,0-.37-2.72-2.97-2.71,0,0-2.5-.03-4,0v13.28Z"/>
                    </svg>
                    <form:form id="login_form" class="form-block"  action="/login" method="POST">
                        <div class="field-wrapper-2">
                            <input class="text-field-2 small-text" type="text" placeholder="Username" name="username" value="${username}" minlength="3" maxlength="100"/>
                            <div style="width: 200px;" class="horozontalline"></div>
                            <input  class="text-field-2 small-text" type="password" placeholder="Password" name="password" value="${password}" minlength="8" maxlength="100"/>
                            <label id="error_label" class="error small-text">${message}</label>
                        </div>
                        <div style="gap: 10px;" class="field-wrapper-2 medium-margin">
                            <div style="column-gap: 0;" class="row">
                                <div style="min-width: 50%; justify-content: space-evenly;"  class="button small-text">
                                    <input class="submit smaller-text" type="submit" value="Login"/>
                                </div>
                                <a style="flex-grow: 1; justify-content: center;"  id="signup_btn" href="/signup" class="button smaller-text dark">
                                    Sign up
                                    <svg xmlns="http://www.w3.org/2000/svg" height="25" viewBox="0 -960 960 960" width="25"><path fill="gray" d="M540-263q-9-9-9-21.5t8-20.5l147-147H190q-13 0-21.5-8.5T160-482q0-13 8.5-21.5T190-512h496L538-660q-9-9-8.5-21t9.5-21q9-8 21.5-8t20.5 8l199 199q5 5 7 10t2 11q0 6-2 11t-7 10L582-263q-9 9-21 9t-21-9Z"/></svg></a>
                            </div>
                            <c:if test = "${message != null}">
                                <a id="pwd_btn" style="color:darkblue ;text-decoration: underline;" href="" class="button small-text dark small-margin">Forgot password?</a>
                            </c:if>
                        </div>
                        <!--a id="signup_btn" href="/signup" class="button small-text dark">Sign up</a-->
                        <div style="display: flex;">
                            <input type="checkbox" id="rememberMe" name="rememberMe"/>
                            <label style="font-style: italic;" for="rememberMe" class="small-text light">Keep me Signed in</label>
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