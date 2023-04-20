<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Signup</title>
        <link href="css/style.css" rel="stylesheet" type="text/css">
        <link href="css/tablet.style.css" rel="stylesheet" type="text/css">
        <link href="css/mobilelandscape.style.css" rel="stylesheet" type="text/css">
        <link href="css/mobileportrait.style.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div class="page-padding">
            <div class="container">
                <div class="auth_form_wrapper large">
                    <div class="auth-component">
                        <p class="large-text light medium-margin" style="text-align: center">We would love to be with you!</p>
                            <img class="authlogo top" alt="logo" src="/images/authlogo.svg" hight="75" width="350"/>
                        <div class="horozontalline-wrapper">
                            <div class="horozontalline"></div>
                        </div>
                    </div>
                    <form:form class="form-block" method="POST" action="/signup" modelAttribute="user">
                        <p class="large-text bold-text medium-margin">Please complete all the information below:</p>
                        <div class="field-wrapper-2 small-margin">
                            <label class="label-field large-text small-margin">Full name</label>
                            <div class="field-wrapper">
                                <div class="field-wrapper-2">
                                    <input class="text-field medium-text" type="text" placeholder="First name" value="${user.firstname}" pattern="^[a-zA-Z]*$" name="firstname" minlength="3" maxlength="100"/>
                                    <form:errors path="firstname" class="error small-text"/>
                                </div>
                                <div class="field-wrapper-2">
                                    <input class="text-field medium-text" type="text" placeholder="Last name" value="${user.lastname}" pattern="^[a-zA-Z]*$" name="lastname" minlength="3" maxlength="100"/>
                                    <form:errors path="lastname" class="error small-text"/>
                                </div>
                            </div>
                        </div>
                        <div class="field-wrapper-2 medium-margin">
                            <label class="label-field large-text small-margin">Email</label>
                            <input class="text-field medium-text" type="email" placeholder="e.g myname@gmail.com" value="${user.email}" name="email" minlength="10" maxlength="100"/>
                            <form:errors path="email" class="error small-text"/>
                        </div>
                        <div class="field-wrapper medium-margin">
                            <label class="label-field large-text">Username</label>
                            <div class="field-wrapper-2">
                                <input class="text-field medium-text" type="text" value="${user.username}" name="username" minlength="3" maxlength="100"/>
                                <form:errors path="username" class="error small-text"/>
                            </div>
                        </div>
                        <div class="field-wrapper medium-margin">
                            <label class="label-field large-text">Passoword</label>
                            <div class="field-wrapper-2">
                                <input type="password" class="text-field medium-text" value="${user.password}" name="password" minlength="8" maxlength="100"/>
                                <form:errors path="password" class="error small-text"/>
                            </div>
                        </div>
                        <input class="submit-button medium-text medium-margin" type="submit" value="Signup"/>
                        <div class="horozontalline"></div>
                    </form:form>
                    <img class="authlogo" alt="logo" src="/images/authlogo.svg" hight="75" width="350"/>
                </div>
            </div>
        </div>
    </body>
</html>