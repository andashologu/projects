<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat - MarketZone</title>
    <script src="https://code.jquery.com/jquery-latest.min.js" type="text/javascript" ></script>
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/tablet.style.css" rel="stylesheet" type="text/css">
    <link href="/css/mobilelandscape.style.css" rel="stylesheet" type="text/css">
    <link href="/css/mobileportrait.style.css" rel="stylesheet" type="text/css">
    <style>
        .medium-text {
            letter-spacing: 0.5px;
        }
    </style>
    <style>
        .load-more {
            position: relative;
            display: block;
            cursor: pointer;
            width: 20px; 
            height: 20px;
            margin-top: 20px;
            left: 50%;
        }
        .load-more:before, .load-more:after {
            position: absolute;
            display: block;
            content: '';
            width: 10px; 
            height: 10px;
            left: 50%; 
            top: 50%;
            border-width: 2px;
            border-style: solid;
            border-color: transparent;
            border-bottom-color: #cacaca;
            border-right-color: #cacaca;
            /*border-radius: 0 0 5px 0;*/
            transform: translate(-50%, -50%) rotate(45deg);
            transition: all .4s ease-in-out;
        }
        .load-more.active:before {
            border-radius: 50%;
            animation: .8s rotate .4s linear forwards infinite;
        }
        .load-more.active:after {
            width: 20px; 
            height: 20px;
            border-radius: 50%;
            animation:
                .8s rotate2 .4s linear forwards infinite;
        }
        @keyframes rotate {
            to {
                transform: translate(-50%, -50%) rotate(405deg);
            }
        }
        @keyframes rotate2 {
            to {
                transform: translate(-50%, -50%) rotate(-315deg);
            }
        }
        .load-more.disabled:before, .load-more.disabled:after {
        margin-top: 0;
            transform: translate(-50%, -50%) rotate(135deg) rotateY(180deg);
        }
    </style>
    <style>
        .sender{
            box-shadow: 1px 1px 3px 0 #cacaca;
            align-self: flex-end;
        }
        .recipient{
            border: 1px solid #cacaca;
        }
        @media screen and (max-width: 478px){
            .recipient{
                border: 0.3px solid black;
            }
        }
        .messages{
            width: 95%;
            padding-left: 5%;
        }
        div.message{/*seperate label.message which is time*/
            border-radius: 15px;
            width: max-content;
            max-width: 300px;
            padding: 10px 7px;
            margin: 10px;
            background-color: white;
        }
        .recipient-wrapper, .sender-wrapper{
            display: flex;
            flex-direction: column;
        }
        
        .recipient-wrapper > :first-child{
            border-radius:  15px 15px 15px 0;
        }
        .sender-wrapper > :last-child{
            border-radius:  15px 0 15px 15px;
        }
        .sender-wrapper > :first-child{/*must override last-child of sender*/
            border-radius:  15px 15px 0 15px;
        }
        .recipient-wrapper > :last-child{
            border-radius:  0 15px 15px 15px;
        }
    </style>
</head>
<body>
    <div style="background-color: #cacaca2a;" class="full_block grid_3">
        <div id="chat_contacts" class="chat_item contacts">
            <div style="background-color: white; flex-grow: 0; padding: 20px 35px;"class="field-wrapper-2">
                <input class="search-field smaller-text dark" type="text" placeholder="Search">
            </div>
            <div style="background-color:transparent" class="horozontalline"></div>
            <div style="background-color: white;" class="flexi-content-wrapper">
                <div style="padding: 15px 10px;" class="flexi-content">
                    <div style="flex-grow: 0;" id="contacts" class="field-wrapper-2"></div>
                    <div id="contacts_loader" class="load-more" onclick="loadContacts()"></div>
                </div>
            </div>
        </div>
        <div style="position: absolute" id="loader_messages-content" class="load-more"></div>
        <div id="chat_content" class="chat_item content">
            <div style="background-color: white; padding-bottom: 15px" id="content" class="content-wrapper-2"></div>
        </div>
        <div class="chat_item profile">
            <!--iframe></iframe-->
        </div>
    </div>
    <script>
        var pagenumber = 0;
        var page_number = 0;
        var pagesize = 1;
        var page_size = 3;
        var chat_id = null;
        window.onload = loadContacts();
        function loadContacts(){
            $("#contacts_loader").addClass("active");
            if(document.getElementById("contacts")){
                var newElement = null;
                $.get("/chat/api/contacts?pagenumber="+pagenumber+"&pagesize="+pagesize, function(html){
                    newElement = document.createElement('div');
                    newElement.innerHTML = html;
                    while(newElement.getElementsByClassName('contact').length > 0 ){//must not use for loop. as the newElement length keeps changing when prepending elements
                        $("#contacts").append(newElement.getElementsByClassName('contact')[0]);
                    }
                    $("#contacts").append(newElement);//for script variables; hasNextMessages
                    if(hasNextContacts === 'false'){
                        document.getElementById("contacts_loader").remove();
                    };
                    pagenumber++;
                })
                .fail(function(){
                    alert("could not load new contacts");
                })
                .always(function(){
                    $("#contacts_loader").removeClass("active");
                    newElement.remove();
                });
            }
        }
        function loadMessages(){
            $("#messages_loader").addClass("active");
            if(document.getElementById("messages")){
                var newElement = null;
                $.get("/chat/api/messages?id="+chat_id+"&pagenumber="+page_number+"&pagesize="+page_size, function(html){
                    newElement = document.createElement('div');
                    newElement.innerHTML = html;
                    var count = 0;
                    var size = newElement.getElementsByClassName('message').length; //initial or before prepend
                    while(newElement.getElementsByClassName('message').length > 0 ){//must not use for loop. as the newElement length keeps changing when prepending elements
                        count++;
                        if(count > size){
                            alert("Messages could not be loaded because internal error occured.");
                            break;//avoid looping while loop forever in case of an error
                        }
                        var first_child = document.getElementById("messages").firstChild;//there must be no space inside this element in order firstchild to return null if empty
                        if(first_child !== null){
                            if(first_child.classList.contains("sender-wrapper") && newElement.getElementsByClassName('message')[0].classList.contains("sender")){
                                first_child.prepend(newElement.getElementsByClassName('message')[0]);
                            }
                            else if(first_child.classList.contains("recipient-wrapper") && newElement.getElementsByClassName('message')[0].classList.contains("recipient")){
                                first_child.prepend(newElement.getElementsByClassName('message')[0]);
                            }
                            else if(newElement.getElementsByClassName('message')[0].classList.contains("label-field")){
                                $("#messages").prepend(newElement.getElementsByClassName('message')[0]);
                            }
                            else{
                                if(newElement.getElementsByClassName('message')[0].classList.contains("sender")){
                                    var elSender = document.createElement('div');//must be recreated as new element
                                    elSender.classList.add('sender-wrapper');
                                    elSender.prepend(newElement.getElementsByClassName('message')[0]);
                                    $("#messages").prepend(elSender);
                                }
                                else if(newElement.getElementsByClassName('message')[0].classList.contains("recipient")){
                                    var elRecipent = document.createElement('div');//must be recreated as new element
                                    elRecipent.classList.add('recipient-wrapper');
                                    elRecipent.prepend(newElement.getElementsByClassName('message')[0]);
                                    $("#messages").prepend(elRecipent);
                                }
                                else{//nothing to add
                                }
                            }
                        }
                        else{
                            if(newElement.getElementsByClassName('message')[0].classList.contains("sender")){
                                var elSender = document.createElement('div');//must be recreated as new element
                                elSender.classList.add('sender-wrapper');
                                elSender.prepend(newElement.getElementsByClassName('message')[0]);
                                $("#messages").prepend(elSender);
                            }
                            if(newElement.getElementsByClassName('message')[0].classList.contains("recipient")){
                                var elRecipent = document.createElement('div');//must be recreated as new element
                                elRecipent.classList.add('recipient-wrapper');
                                elRecipent.prepend(newElement.getElementsByClassName('message')[0]);
                                $("#messages").prepend(elRecipent);
                            }
                        }
                    }
                    $("#messages").append(newElement);//for script variables; hasNextMessages
                    if(hasNextMessages === 'false'){
                        document.getElementById("messages_loader").remove();
                    };
                    page_number++;
                })
                .fail(function(){
                    alert("could not load previous messages");
                })
                .always(function(){
                    $("#messages_loader").removeClass("active");
                    newElement.remove();
                });
            }
        }
        function showContactsOnly(){
            document.getElementById("chat_content").style.display = "none";
            document.getElementById("chat_contacts").style.display = "flex";
        }
        let mobileMediaQuery = window.matchMedia('(max-width: 478px)');
        onresize = () => {
            if(!mobileMediaQuery.matches){
                document.getElementById("chat_contacts").style.display = "flex";
                document.getElementById("chat_content").style.display = "flex";
            }
            else{
                if(chat_id === null){
                    document.getElementById("chat_contacts").style.display = "flex";
                    document.getElementById("chat_content").style.display = "none";
                }
                else{
                    document.getElementById("chat_contacts").style.display = "none";
                    document.getElementById("chat_content").style.display = "flex";
                }
            }
        }
        function loadContent(element){
            if(mobileMediaQuery.matches){
                document.getElementById("chat_contacts").style.display = "none";
                document.getElementById("chat_content").style.display = "flex";
            }
            page_number = 0;
            chat_id = element.id.replace(/[^\d]/g, '');
            document.getElementById("loader_messages-content").style.display = "block";
            $("#loader_messages-content").addClass("active");
            $.ajax({
                url: "/chat/api/content?id="+chat_id,
                type: "GET", 
                success: function(html){
                    document.getElementById("loader_messages-content").style.display = "none";
                    document.getElementById("content").innerHTML = html;
                    loadMessages();
                },
                error: function(){
                    document.getElementById("loader_messages-content").style.display = "none";
                    alert("could not load content");
                }
            });
        }
        function replyMsg(element){
            var id = element.id.replace(/[^\d]/g, '');
            alert("id = "+id);
        }
    </script>
    <script></script>
</body>
</html>