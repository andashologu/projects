<%@ taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Signup &#8212; TZM</title>
        <link href="css/style.css" rel="stylesheet" type="text/css">
        <link href="css/tablet.style.css" rel="stylesheet" type="text/css">
        <link href="css/mobilelandscape.style.css" rel="stylesheet" type="text/css">
        <link href="css/mobileportrait.style.css" rel="stylesheet" type="text/css">
    </head>
    <body style="padding: 0 50px; display: flex; flex-direction: column; justify-content: center;">
        <div id="modal" style="padding: 0; margin: 0 auto; max-width: 1200px;" class="page-padding">
            <div style="background: linear-gradient(90deg, #efefef 50%, white 50%);" class="container grid_2">
                <div>
                    
                </div>
                <div class="auth_form_wrapper large">
                    <div style="opacity: 0.1;" class="background_image_2"></div>
                        <svg style="position: absolute;" id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 31.96 25.06">
                            <rect fill="#efefef" class="cls-1" y="1.51" width="8" height="4"/>
                            <rect fill="#efefef" class="cls-1" x="4" y="5.51" width="4" height="19.55"/>
                            <rect fill="#efefef" class="cls-1" x="9" y="1.51" width="4" height="4"/>
                            <polygon fill="#efefef" class="cls-1" points="11 25.06 14 1.51 18 1.51 15 25.06 11 25.06"/>
                            <rect fill="#efefef" class="cls-1" x="18" y="21.06" width="4" height="4"/>
                            <path fill="#efefef" class="cls-1" d="m18,20.06h4s0-6.06,0-6.06c0,0,.2-1.63,1.41-1.75l1.71-.05,1.41.04c1.27.03,1.41,1.76,1.41,1.76v11.06h4.02v-11.17s-.02-3.5-.28-4.38c0,0-.05-2.74-3.74-2.73-2.33-.01-2.97,2.71-2.97,2.71,0,0-.37-2.72-2.97-2.71,0,0-2.5-.03-4,0v13.28Z"/>
                        </svg>
                    <form:form class="form-block" method="POST" action="/signup" modelAttribute="user">
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
                            <!--label class="label-field small-text small-margin dark bold-text">Address details</label>
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
                            </div-->
                        </div>
                        <div style="width: max-content;" class="field-wrapper-2 medium-margin">
                            <label class="label-field small-text small-margin dark bold-text">Email<span class="error">*</span></label>
                            <input class="text-field small-text" type="email" placeholder="e.g myname@gmail.com" value="${user.email}" name="email"/>
                            <form:errors path="email" class="error small-text"/>
                        </div>
                        <div style="width: max-content;" class="field-wrapper-2 medium-margin">
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
                        <!--Put more content here, such as our going back to the login if already have an account...-->
                    </form:form>
                </div>
            </div>
        </div>
    </body>
</html>