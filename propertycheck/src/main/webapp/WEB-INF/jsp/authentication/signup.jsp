<%@ taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
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
        <div id="modal" style="padding: 0" class="page-padding">
            <div class="container">
                <div class="auth_form_wrapper large">
                    <div style="opacity: 0.1;" class="background_image_2"></div>
                    <div class="auth-component">
                        <h1 class="small-heading dark small-margin">PropertyCheck</h1>
                        <p class="large-text dark medium-margin">Signup Form</p>
                        <!--img class="authlogo top" alt="logo" src="/images/authlogo.svg" hight="75" width="350"/-->
                        <div class="horozontalline-wrapper">
                            <div class="horozontalline"></div>
                        </div>
                    </div>
                    <form:form class="form-block" method="POST" action="/signup" modelAttribute="user">
                        <!--p class="large-text light medium-margin">Complete information below:</p-->
                        <div class="field-wrapper-2 small-margin">
                            <label class="label-field small-text small-margin dark bold-text">Full name</label>
                            <div class="field-wrapper">
                                <div class="field-wrapper-2">
                                    <input class="text-field small-text" type="text" placeholder="First name" value="${user.firstname}" pattern="^[a-zA-Z]*$" name="firstname" minlength="3" maxlength="100"/>
                                    <form:errors path="firstname" class="error small-text"/>
                                </div>
                                <div class="field-wrapper-2">
                                    <input class="text-field small-text dark" type="text" placeholder="Last name" value="${user.lastname}" pattern="^[a-zA-Z]*$" name="lastname" minlength="3" maxlength="100"/>
                                    <form:errors path="lastname" class="error small-text"/>
                                </div>
                            </div>
                        </div>
                        <div class="field-wrapper-2">
                            <label class="label-field small-text small-margin dark bold-text">Address details</label>
                            <div class="field-wrapper small-margin">
                                <div class="field-wrapper-2">
                                    <input class="text-field small-text dark" type="text" placeholder="Street" value="${user.address.street}" name="address.street" minlength="3" maxlength="100"/>
                                    <form:errors path="address.street" class="error small-text"/>
                                </div>
                                <div class="field-wrapper-2">
                                    <input class="text-field small-text" type="text" placeholder="City" value="${user.address.city}" name="address.city" minlength="3" maxlength="100"/>
                                    <form:errors path="address.city" class="error small-text"/>
                                </div>
                            </div>
                            <div class="field-wrapper">
                                <div class="field-wrapper-2">
                                    <input class="text-field small-text" type="text" placeholder="Country" value="${user.address.country}" name="address.country" minlength="3" maxlength="100"/>
                                    <form:errors path="address.country" class="error small-text"/>
                                </div>
                                <div class="field-wrapper-2">
                                    <input class="text-field small-text dark" type="number" placeholder="Postal code" value="${user.address.zip}" name="address.zip" minlength="3" maxlength="100"/>
                                    <form:errors path="address.zip" class="error small-text"/>
                                </div>
                            </div>
                        </div>
                        <div class="field-wrapper-2 medium-margin">
                            <label class="label-field small-text small-margin dark bold-text">Email</label>
                            <input class="text-field small-text" type="email" placeholder="e.g myname@gmail.com" value="${user.email}" name="email" minlength="10" maxlength="100"/>
                            <form:errors path="email" class="error small-text"/>
                        </div>
                        <div class="field-wrapper small-margin">
                            <label class="label-field small-text dark bold-text">Username</label>
                            <div class="field-wrapper-2">
                                <input class="text-field small-text" type="text" placeholder="e.g Smith" value="${user.username}" name="username" pattern="^[a-zA-Z]*$" title="Only letters allowed" minlength="3" maxlength="100"/>
                                <form:errors path="username" class="error small-text"/>
                            </div>
                        </div>
                        <div class="field-wrapper medium-margin">
                            <label class="label-field small-text dark bold-text">Passoword</label>
                            <div class="field-wrapper-2">
                                <input class="text-field small-text" type="password" placeholder="********" value="${user.password}" name="password"/>
                                <form:errors path="password" class="error small-text"/>
                            </div>
                        </div>
                        <input class="submit-button medium-text medium-margin" type="submit" value="Submit"/>
                        <div class="horozontalline"></div>
                        <!--Put more content here, such as our going back to the login if already have an account...-->
                        <input type="hidden" name="_csrf.parameterName" value="_csrf.token"/>
                    </form:form>
                </div>
            </div>
        </div>
    </body>
</html>