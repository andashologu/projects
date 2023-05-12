<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messaging - PropertyCheck</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/tablet.style.css" rel="stylesheet" type="text/css">
    <link href="/css/mobilelandscape.style.css" rel="stylesheet" type="text/css">
    <link href="/css/mobileportrait.style.css" rel="stylesheet" type="text/css">
    <style>
        @import url("https://fonts.googleapis.com/css?family=Red+Hat+Display:400,500,900&display=swap");
        body {
            font-family: Red hat Display, sans-serif;
        }
        .medium-text {
            letter-spacing: 0.5px;
        }
    </style>
</head>
<!--https://codepen.io/mubangadv/pen/rXrOQa-->
<body>
    <div class="container">
        <div class="full_block grid_3">
            <div class="chat_item contacts">
                <div class="chat_component">
                    <c:forEach var="contact" items="${contacts}">
                        <div class="contact row small-margin">
                            <div class="profile_pic"></div>
                            <div class="field-wrapper-2">
                                <c:if test = "${contact.getSender().getUsername() != username}">
                                    <div class="label-field medium-text dark bold-text">${contact.getSender().getUsername()}</div><!--label tag does not inherit cursor-->
                                </c:if>
                                <c:if test = "${contact.getRecipient().getUsername() != username}">
                                    <div class="label-field medium-text dark bold-text">${contact.getRecipient().getUsername()}</div><!--label tag does not inherit cursor-->
                                </c:if>
                                <div style="justify-content: space-between;" class="row small-margin">
                                    <p class="small-text light">${contact.getMessage()}</p>
                                    <label class="label-field small-text light">${contact.getTime()}</label>
                                </div>
                                <div class="horozontalline"></div>
                            </div>
                        </div>
                        
                    </c:forEach>
                </div>
            </div>
            <div class="chat_item content">
                <div class="row small-margin">
                    <div class="profile_pic"></div>
                    <div class="field-wrapper-2 small-margin">
                        <!--NB, to do.. company name mucst be unique-->
                        <label class="label-field medium-text dark bold-text">Username</label>
                        <label class="label-field small-text light">Online status</label>
                    </div>
                </div>
                <div style="width: 90%; margin-left: 5%; margin-right: 5%;" class="horozontalline medium-margin"></div>
                <div class="messages">
                    <div id="messages" class="field-wrapper-2">
                        <div class="field-wrapper-2 small-margin">
                            <div class="row">
                                <label class="label-field small-text dark bold-text">Username</label>
                                <label class="label-field small-text light">time</label>
                            </div>
                            <p class="small-text dark">Message here. The filed will need to have maximum width for logn messages. Just kidding will need to test first...</p>
                            <label class="label-field small-text light">Message status</label>
                        </div>
                        <div class="field-wrapper-2 small-margin">
                            <div class="row">
                                <label class="label-field small-text dark bold-text">You</label>
                                <label class="label-field small-text light">time</label>
                            </div>
                            <p class="small-text dark">Your response here. All messages will be aligned left</p>
                            <label class="label-field small-text light">Message status</label>
                        </div>
                    </div>
                    <div class="field-wrapper-2">
                        <input class="text-field-2 small-text dark" type="text" placeholder="type message...">
                    </div>
                </div>
            </div>
            <!--div class="chat_item profile">
                <!--iframe></iframe-->
            </div-->
        </div>
    </div>
</body>
</html>