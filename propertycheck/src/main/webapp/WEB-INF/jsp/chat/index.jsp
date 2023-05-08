<!DOCTYPE html>
<html lang="en">
    <style>
        .full_block{
            width: 100%;
            height: 100vh;
        }
        .grid_3 {
            width: 100%;
            grid-template-rows: auto;
            grid-template-columns: 1fr 1.2fr 0.8fr;
            grid-auto-columns: 1fr;
            display: grid;
        }
        .chat_item.contacts{
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            justify-content: flex-end;
        }
        .chat_item.content{
            display: flex;
            flex-direction: column;
            align-self: end;
            justify-content: center;
        }
        .chat_item.profile{
            background-color: white;
        }
        .chat_component{
            min-height: 80vh;
            border-radius: 5px 5px 0 0;
            width: 80%;
            background-color: white;
        }
        .bar{
            display: flex;
            column-gap: 1.3em;
            padding: 15px 25px;
        }
        .profile_pic{
            width: 4rem;
            height: 4rem;
            background-size: cover;
            background-position: center;
            border-radius: 50%;
            background-color: #cacaca;
        }
        .messages{
            min-height: 80vh;
            width: 100%;
        }

    </style>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messaging - PropertyCheck</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/tablet.style.css" rel="stylesheet" type="text/css">
    <link href="/css/mobilelandscape.style.css" rel="stylesheet" type="text/css">
    <link href="/css/mobileportrait.style.css" rel="stylesheet" type="text/css">
</head>
<style>
    .medium-text {
    letter-spacing: 0.5px;
}
</style>
<!--https://codepen.io/mubangadv/pen/rXrOQa-->
<body style="background-color: #cacaca2a;">
    <div class="container">
        <div class="full_block grid_3">
            <div class="chat_item contacts">
                <div class="chat_component"></div>
            </div>
            <div class="chat_item content">
                <div class="bar">
                    <div class="profile_pic"></div>
                    <div class="field-wrapper-2">
                        <!--NB, to do.. company name mucst be unique-->
                        <label class="label-field medium-text dark bold-text">Username/ company name (if applicable) </label>
                        <label class="label-field small-text light">last seen</label>
                    </div>
                </div>
                <div style="width: 80%; margin: auto 10%;" class="horozontalline"></div>
                <div class="messages"></div>
                <div class="input"></div>
            </div>
            <div class="chat_item profile"></div>
        </div>
    </div>
</body>
</html>