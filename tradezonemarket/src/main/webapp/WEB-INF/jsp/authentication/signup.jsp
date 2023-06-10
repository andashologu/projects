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
            <div class="container grid_2">
                <div>
                    
                </div>
                <div class="auth_form_wrapper large">
                    <div style="opacity: 0.1;" class="background_image_2"></div>
                    <div class="auth-component">
                        <h1 class="small-heading dark small-margin">TradeZoneMarket</h1>
                        <p class="large-text dark medium-margin">Signup Form</p>
                        <!--img class="authlogo top" alt="logo" src="/images/authlogo.svg" hight="75" width="350"/-->
                        <div class="horozontalline-wrapper">
                            <div class="horozontalline"></div>
                        </div>
                    </div>
                    <form:form class="form-block" method="POST" action="/signup" modelAttribute="user">
                            <p class="small-text small-margin dark">Please note the following: Compulsory fields are marked with<span class="error">*</span></p>
                        <div class="field-wrapper-2 small-margin">
                            <label class="label-field small-text small-margin dark bold-text">Full name</label>
                            <div class="field-wrapper">
                                <div class="field-wrapper-2">
                                    <input class="text-field small-text" type="text" placeholder="First name" value="${user.firstname}" name="firstname"/>
                                    <form:errors path="firstname" class="error small-text"/>
                                </div>
                                <div class="field-wrapper-2">
                                    <input class="text-field small-text dark" type="text" placeholder="Last name" value="${user.lastname}" name="lastname"/>
                                    <form:errors path="lastname" class="error small-text"/>
                                </div>
                            </div>
                        </div>
                        <div class="field-wrapper-2">
                            <label class="label-field small-text small-margin dark bold-text">Address details</label>
                            <div class="field-wrapper">
                                <div class="field-wrapper-2">
                                    <input class="text-field small-text dark" type="text" placeholder="Street" value="${user.address.street}" name="address.street"/>
                                    <form:errors path="address.street" class="error small-text"/>
                                </div>
                                <div class="field-wrapper-2">
                                    <input class="text-field small-text" type="text" placeholder="City" value="${user.address.city}" name="address.city"/>
                                    <form:errors path="address.city" class="error small-text"/>
                                </div>
                            </div>
                            <div class="field-wrapper">
                                <div class="field-wrapper-2">
                                    <input class="text-field small-text" type="text" placeholder="Country" value="${user.address.country}" name="address.country"/>
                                    <form:errors path="address.country" class="error small-text"/>
                                </div>
                                <div class="field-wrapper-2">
                                    <input class="text-field small-text dark" type="number" placeholder="Zip code" value="${user.address.zip}" name="address.zip"/>
                                    <form:errors path="address.zip" class="error small-text"/>
                                </div>
                            </div>
                        </div>
                        <div class="field-wrapper-2 medium-margin">
                            <label class="label-field small-text small-margin dark bold-text">Email<span class="error">*</span></label>
                            <input class="text-field small-text" type="email" placeholder="e.g myname@gmail.com" value="${user.email}" name="email"/>
                            <form:errors path="email" class="error small-text"/>
                        </div>
                        <div class="field-wrapper-2 medium-margin">
                            <label class="label-field small-text small-margin dark bold-text">Company</label>
                            <input class="text-field small-text" type="text" placeholder="company name" value="${user.company}" name="company"/>
                            <form:errors path="company" class="error small-text"/>
                        </div>
                        <div class="field-wrapper small-margin">
                            <label class="label-field small-text dark bold-text small-margin">Username<span class="error">*</span></label>
                            <div class="field-wrapper-2">
                                <input class="text-field small-text" type="text" placeholder="e.g Smith" value="${user.username}" name="username"/>
                                <form:errors path="username" class="error small-text"/>
                            </div>
                        </div>
                        <div class="field-wrapper medium-margin">
                            <label class="label-field small-text dark bold-text small-margin">Passoword<span class="error">*</span></label>
                            <div class="field-wrapper-2">
                                <input class="text-field small-text" type="password" placeholder="********" value="${user.password}" name="password"/>
                                <form:errors path="password" class="error small-text"/>
                            </div>
                        </div>
                        <input style="min-width: 280px; margin: 0 auto; border-radius: 5px;" class="button small-text" type="submit" value="Submit"/>
                        <div class="horozontalline"></div>
                        <!--Put more content here, such as our going back to the login if already have an account...-->
                    </form:form>
                </div>
            </div>
        </div>
    </body>
</html>