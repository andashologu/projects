<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat &#8212; TZm</title>
    <script src="https://code.jquery.com/jquery-latest.min.js" type="text/javascript" ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/tablet.style.css" rel="stylesheet" type="text/css">
    <link href="/css/mobilelandscape.style.css" rel="stylesheet" type="text/css">
    <link href="/css/mobileportrait.style.css" rel="stylesheet" type="text/css">
    <style>
        .load-more {
            position: relative;
            display: block;
            cursor: pointer;
            width: 20px; 
            height: 20px;
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
            border-bottom-color: white;
            border-right-color: white;
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
        @media screen and (max-width: 478px){
            #loader_messages-content{
                display: none;
            }
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
        .message.sender{
            box-shadow: 0px 0px 2px 0 #cacaca;
            padding-left: 15px;
            align-self: flex-end;
        }
        .message-wrapper{
            display: flex;
            flex-direction: row;
            justify-content: center;
            column-gap: 0.3em;
        }
        .message-wrapper.recipient{
            align-self: flex-start;
        }
        .message-wrapper.sender{
            align-self: flex-end;
        }
        .message-wrapper.sender .reply-icon{
            order: -1; /*make last child first*/
        }
        .message-wrapper.sender .msg-status{
            text-align: right;
        }
        .message.recipient{
            border: 1px solid #cacaca;
            padding-right: 15px;
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
            background-color: white;
        }
        .recipient-wrapper, .sender-wrapper{
            display: flex;
            flex-direction: column;
            margin-bottom: 5.7em;
        }
        
        .recipient-wrapper > :first-child .message{
            border-radius:  15px 15px 15px 0;
        }
        .sender-wrapper > :last-child .message{
            border-radius:  15px 0 15px 15px;
        }
        .sender-wrapper > :first-child .message{/*must override last-child of sender*/
            border-radius:  15px 15px 0 15px;
        }
        .recipient-wrapper > :last-child .message{
            border-radius:  0 15px 15px 15px;
        }
        .reply-icon{
            display: none;
            cursor: pointer;
        }
        .message-wrapper:hover .reply-icon{
            display: block;
        }
        .message.sender .time{
            text-align: right;
        }
        .msg-status{
            display: none;
        }
        #messages > :last-child:not(.recipient-wrapper) > :last-child .msg-status{
            display: block;
        }
        @media screen and (max-width: 478px){/*must always be at the end to override above styles*/
            .message.recipient {
                border: none;
            }
            .message.sender {
                box-shadow: none;
            }
            .message.recipient, .message.sender{
                background-color: #cacaca2a;
                box-shadow: inset 0px 0px 3px 0px #cacaca4a;
            }
        }
    </style>
</head>
<body>
    <div style="background-color: #cacaca2a;" class="full_block grid_3">
        <div id="chat_contacts" class="chat_item contacts">
            <div style="padding: 20px; background-color: white;" class="search-wrapper row">
                <div style="flex-grow: 1; box-shadow: 0px 0px 2px 0 #cacaca; border-radius: 35px; padding: 0 10px;" class="row">
                    <svg style="cursor:pointer; margin: auto 0;" xmlns="http://www.w3.org/2000/svg" height="20" viewBox="0 -960 960 960" width="20"><path fill="gray" d="M372-312q-115.162 0-195.081-80Q97-472 97-585t80-193q80-80 193.5-80t193 80Q643-698 643-584.85q0 44.85-12.5 83.35Q618-463 593-429l236 234q14 14.556 14 34.278T829-127q-14.533 15-34.489 15-19.955 0-33.511-15L526-361q-29 22.923-68.459 35.962Q418.082-312 372-312Zm-.647-94q74.897 0 126.272-52.25T549-585q0-74.5-51.522-126.75T371.353-764q-75.436 0-127.895 52.25Q191-659.5 191-585t52.311 126.75Q295.623-406 371.353-406Z"/></svg>
                    <input  style="padding-left: 0; flex-grow: 1;" class="search-field smaller-text dark" type="text" placeholder="Search for contacts">
                    <label style="border-left: 1px solid #cacaca; margin: auto 0; padding-left: 5px;" class="label-field light">SEARCH</label>
                </div>
            </div>
            <div style="background-color:transparent" class="horozontalline"></div>
            <div style="background-color: white;" class="flexi-content-wrapper">
                <div style="padding: 15px 10px;" class="flexi-content">
                    <div style="flex-grow: 0;" id="contacts" class="field-wrapper-2"></div>
                    <div style="margin: 20px auto; width: max-content; background-color: black; border-radius: 50%; padding: 5px;">
                        <div id="contacts_loader" class="load-more" onclick="loadContacts()"></div>
                    </div>
                </div>
            </div>
        </div>
        <div id="loader_messages-content" style="position: absolute; margin: 20px auto; left: 50%; transform: translate(-50%, 0); width: max-content; background-color: black; border-radius: 50%;">
            <div style="margin: 5px;" class="load-more"></div>
        </div>
        <div id="chat_content" class="chat_item content">
            <div style="background-color: white; padding-bottom: 15px" id="content" class="content-wrapper-2"></div>
        </div>
        <div class="chat_item profile">
            <!--iframe></iframe-->
        </div>
    </div>
    <script type="text/javascript">
        //script for loading contacts and messages
        var pagenumber = 0;
        var page_number = 0;
        var pagesize = 1;
        var page_size = 3;
        var chat_id = null;
        var chat_username = null;
        function loadContacts(){
            $("#contacts_loader").addClass("active");
            $("#contacts_loader").css('pointer-events', 'none');
            if(document.getElementById("contacts")){
                var newElement = null;
                $.get("/chat/api/contacts?pagenumber="+pagenumber+"&pagesize="+pagesize, function(html){
                    newElement = document.createElement('div');
                    newElement.innerHTML = html;
                    while(newElement.getElementsByClassName('contact').length > 0 ){//must not use for loop. as the newElement length keeps changing when prepending elements
                        subscribeToUser(newElement.getElementsByClassName('contact')[0].getAttribute("id"));//must come before append. Append will remove the element; //must wait for stomp connection to be establised
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
                    $("#contacts_loader").css('pointer-events', '');//set with css
                });
            }
        }
        var recipient_wrapper_count = null;
        var sender_wrapper_count = null;
        var initialId = 0; //0 instead of null wont covert to Long
        function loadMessages(){
            $("#messages_loader").addClass("active");
            $("#messages_loader").css('pointer-events', 'none');
            if(document.getElementById("messages")){
                var newElement = null;
                $.get("/chat/api/messages?initialId="+initialId+"&username="+chat_username+"&id="+chat_id+"&pagenumber="+page_number+"&pagesize="+page_size, function(html){
                    newElement = document.createElement('div');
                    newElement.innerHTML = html;
                    var count = 0;
                    var size = newElement.getElementsByClassName('message-wrapper').length; //initial or before prepend
                    sender_wrapper_count = 0;
                    recipient_wrapper_count = 0;
                    var msg_status = null;
                    while(newElement.getElementsByClassName('message-wrapper').length > 0 ){//must not use for loop. as the newElement length keeps changing when prepending elements
                        if(initialId === 0){
                            if(newElement.getElementsByClassName('message-wrapper').length = 1){
                                initialId = newElement.getElementsByClassName('message-wrapper')[0].getAttribute("id").replace(/[^\d]/g, '');
                            }
                        }
                        count++;
                        if(count > size){
                            alert("Messages could not be loaded because internal error occured.");
                            break;//avoid looping while loop forever in case of an error
                        }
                        var first_child = document.getElementById("messages").firstChild;//there must be no space inside this element in order firstchild to return null if empty
                        if(sender_wrapper_count === 1 && recipient_wrapper_count === 0){//check last sender_wrapper that has more than one message with different msq_status
                            if(first_child.querySelector(".msg-status")){
                                new_msg_status = first_child.querySelector(".msg-status").innerHTML;
                                if(msg_status !== null && new_msg_status !== msg_status){
                                    first_child.querySelector(".msg-status").style.display = "block";
                                    msg_status = new_msg_status;
                                }
                                else{
                                    msg_status = new_msg_status;
                                }
                            }
                        }
                        if(first_child !== null){
                            if(first_child.classList.contains("sender-wrapper") && newElement.getElementsByClassName('message-wrapper')[0].classList.contains("sender")){
                                first_child.prepend(newElement.getElementsByClassName('message-wrapper')[0]);
                            }
                            else if(first_child.classList.contains("recipient-wrapper") && newElement.getElementsByClassName('message-wrapper')[0].classList.contains("recipient")){
                                first_child.prepend(newElement.getElementsByClassName('message-wrapper')[0]);
                            }
                            else if(newElement.getElementsByClassName('message-wrapper')[0].classList.contains("label-field")){
                                $("#messages").prepend(newElement.getElementsByClassName('message-wrapper')[0]);
                            }
                            else{
                                if(newElement.getElementsByClassName('message-wrapper')[0].classList.contains("sender")){
                                    var elSender = document.createElement('div');//must be recreated as new element
                                    elSender.classList.add('sender-wrapper');
                                    elSender.prepend(newElement.getElementsByClassName('message-wrapper')[0]);
                                    $("#messages").prepend(elSender);
                                    sender_wrapper_count++;
                                }
                                else if(newElement.getElementsByClassName('message-wrapper')[0].classList.contains("recipient")){
                                    var elRecipent = document.createElement('div');//must be recreated as new element
                                    elRecipent.classList.add('recipient-wrapper');
                                    elRecipent.prepend(newElement.getElementsByClassName('message-wrapper')[0]);
                                    $("#messages").prepend(elRecipent);
                                    recipient_wrapper_count++;
                                }
                                else{//nothing to add
                                }
                            }
                        }
                        else{
                            addNewMessage(newElement, false);
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
                    $("#messages_loader").css('pointer-events', '');//set with css
                    newElement.remove();
                });
            }
        }
        function addNewMessage(newElement, isNew){
            if(newElement.getElementsByClassName('message-wrapper')[0].classList.contains("sender")){
                var elSender = document.createElement('div');//must be recreated as new element
                elSender.classList.add('sender-wrapper');
                elSender.prepend(newElement.getElementsByClassName('message-wrapper')[0]);
                if(!isNew){
                    $("#messages").prepend(elSender);
                }
                else{
                    $("#messages").append(elSender);
                }
                sender_wrapper_count++;
            }
            else if(newElement.getElementsByClassName('message-wrapper')[0].classList.contains("recipient")){
                var elRecipent = document.createElement('div');//must be recreated as new element
                elRecipent.classList.add('recipient-wrapper');
                elRecipent.prepend(newElement.getElementsByClassName('message-wrapper')[0]);
                if(!isNew){
                    $("#messages").prepend(elRecipent);
                }
                else{
                    $("#messages").append(elRecipent);
                }
                recipient_wrapper_count++;
            }
            else{
                console.log("no match")
            }
        }
        function loadContent(element){
            initialId = 0;
            if(mobileMediaQuery.matches){
                document.getElementById("chat_contacts").style.display = "none";
            }
            page_number = 0;
            chat_id = element.id.replace(/[^\d]/g, '');
            chat_username = $(element).data("id");
            console.log("chat_username: "+chat_username);
            document.getElementById("loader_messages-content").style.display = "block";
            $("#loader_messages-content .load-more").addClass("active");
            $.ajax({
                url: "/chat/api/content?username="+chat_username+"&id="+chat_id,
                type: "GET", 
                success: function(html){
                    document.getElementById("loader_messages-content").style.display = "none";
                    $("#loader_messages-content .load-more").removeClass("active");
                    document.getElementById("content").innerHTML = html;
                    if(mobileMediaQuery.matches){
                        document.getElementById("chat_content").style.display = "flex";
                    }
                    loadMessages();
                },
                error: function(){
                    document.getElementById("loader_messages-content").style.display = "none";
                    $("#loader_messages-content .load-more").removeClass("active");
                    alert("could not load content");
                }
            });
        }
        
    </script>
    <script type="text/javascript">
        //basic script
        var repliedMsg = null;
        var repliedMsgId = null;
        function showContactsOnly(){
            document.getElementById("chat_content").style.display = "none";
            document.getElementById("content").innerHTML = "";
            chat_id = null;
            document.getElementById("loader_messages-content").style.display = "none";
            document.getElementById("chat_contacts").style.display = "flex";
        }
        let mobileMediaQuery = window.matchMedia('(max-width: 478px)');
        onresize = () => {
            if(!mobileMediaQuery.matches){
                document.getElementById("chat_contacts").style.display = "flex";
                document.getElementById("chat_content").style.display = "flex";
                if(chat_id === null){
                    document.getElementById("loader_messages-content").style.display = "block";
                }
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
                document.getElementById("loader_messages-content").style.display = "none";
            }
        }
        function openReply(element){
            var id = element.id.replace(/[^\d]/g, '');
            repliedMsgId = "msg_"+id;
            repliedMsg = document.getElementById(repliedMsgId).innerHTML;
            $("#replied_msg").css("display", "block");
            document.getElementById("replied_msg").querySelector("p").innerHTML = repliedMsg;
            document.getElementById("replied_msg").querySelector("button").setAttribute("id", "close_msg_"+id);
        }
        function closeReply(element){
            var id = element.id.replace(/[^\d]/g, '');
            repliedMsgId = null;
            repliedMsg = null;
            $("#replied_msg").css("display", "none");
            document.getElementById("replied_msg").querySelector("p").innerHTML = "";
            document.getElementById("replied_msg").querySelector("button").setAttribute("id", "close_msg_(id)");
        }
        function navigateToMessage(element){
            var id = element.id.replace(/[^\d]/g, '');
            alert("id = "+id);
        }
    </script>
    <script type="text/javascript">
        //websocket
        var headerName = "${_csrf.headerName}";
        var parameterName = "${_csrf.parameterName}";
        var token = "${_csrf.token}";

        var headers = {};
        headers[headerName] = token;

        var stomp = null;
        var socket = null;
        function connect(){
            socket = new SockJS('/ws');
            stomp = Stomp.over(socket);
            stomp.connect(headers, function(frame) {
                window.onload = loadContacts();//must subscribe each contact when stomp connection has been established
                stomp.subscribe('/user/queue/typingstatus', function(result) {
                    //
                });
                stomp.subscribe('/user/queue/messagestatus', function(result) {
                    //will recieve a specific message id to update a specific message. from /chat/api/messages & /chat/sendmessage
                    //will also recieve recipient id to make sure the recipient is in view...
                    //to do: if its not last message, hide status
                    console.log("status: "+JSON.parse(result.body).status);
                    if(chat_id == JSON.parse(result.body).recipientId){//=== wont work for this
                        console.log(document.getElementById("msg_sts_"+JSON.parse(result.body).messageId));
                        if(document.getElementById("msg_sts_"+JSON.parse(result.body).messageId)){
                            document.getElementById("msg_sts_"+JSON.parse(result.body).messageId).innerHTML = JSON.parse(result.body).status;
                        }
                    }
                });
                stomp.subscribe('/user/queue/recievemessage', function(result) {
                    var text = JSON.parse(result.body).text;
                    //however the initial is sent, it will remail sent there if user is not subscribed

                    /*var text = document.getElementById('privateText').value;
                        var to = document.getElementById('to').value;
                        stompClient.send("/app/specific/test", {}, JSON.stringify({'text':text, 'to':to, 'timezone': timezone}));*/
                    if(chat_id == JSON.parse(result.body).senderId){//seen
                        $.ajax({
                        url: "/chat/message?insert=false",//does not insert into database
                        data: {'messageId': JSON.parse(result.body).messageId, 'recipientId':chat_id, 'text':text, 'to':chat_username},
                        type: "POST", 
                        beforeSend: function(xhr){
                            xhr.setRequestHeader(headerName, token);
                        },
                        success: function(html){
                            //console.log(html);

                            newElement = document.createElement('div');
                            newElement.innerHTML = html;
                            last_child = document.getElementById("messages").lastChild;
                            if(last_child !==null){
                                if(last_child.classList.contains("recipient-wrapper") && newElement.getElementsByClassName('message-wrapper')[0].classList.contains("recipient")){
                                    last_child.append(newElement.getElementsByClassName('message-wrapper')[0]);
                                }
                                else{
                                    addNewMessage(newElement, true);
                                }
                            }
                            else{
                                addNewMessage(newElement, true);
                            }
                        },
                        error: function(error, xhr){
                            alert("Error !! Could not send message !");
                        }
                    });
                    }
                    else{//dilivered 
                        //sent and delivered are controlled by /chat/message
                    }
                });
            });
        }
        function subscribeToUser(userId){
            userId = userId.replace(/[^\d]/g, '');
            stomp.subscribe('/topic/friend/' + userId, function(result) {
                //show onlinestatus
                if(document.getElementById("status_"+JSON.parse(result.body).userId)){
                    document.getElementById("status_"+JSON.parse(result.body).userId).innerHTML = JSON.parse(result.body).status;
                }

            },
            {id: userId});
        }
        function unsubscribeFromUser(userId){
            stomp.unsubscribe(userId);
        }
        function sendTypingStatus(status) {
            var isTyping = status;//true or false
            var username = ""; //dont use chat_id to avoid querying database everytime for username
            stomp.send("/app/specific/typingstatus", {}, JSON.stringify({'isTyping':isTyping, 'to': chat_username}));
        }
        connect();
        window.addEventListener('visibilitychange', () => {
            /*Problem !!!
                Page visibilty only detects tab focus , or in other words it detects switching of tabs, and not background/foreground status of the broswer.
                And, when app/browser is pushed to the background, websocket is closed. So, there is no way to perform reconnect when the user pull back the app.
                The slight solution for now is put a button label reconned after websocket is closed.
            */
            if (socket.readyState === 2 | socket.readyState === 3) {
                connect();//reconnect
            }
        });
        
        socket.onclose =function(event){
            console.log("websocket closed");
            stomp.unsubscribe();
            socket.disconnect();
            //then show reconnect button
            //also disable send message button
        }
        var text = null;
        var last_child = null;
        function sendPrivateMessage() {
            text = document.getElementById('privateText').value;
            document.getElementById('privateText').value = "";
            $.ajax({
                url: "/chat/message?insert=true",//Must insert into database
                data: {'recipientId':chat_id, 'text':text, 'to':chat_username},
                type: "POST", 
                beforeSend: function(xhr){
                    xhr.setRequestHeader(headerName, token);
                },
                success: function(html){
                    newElement = document.createElement('div');
                    newElement.innerHTML = html;
                    last_child = document.getElementById("messages").lastChild;
                    if(last_child !==null){
                        if(last_child.classList.contains("sender-wrapper") && newElement.getElementsByClassName('message-wrapper')[0].classList.contains("sender")){
                            last_child.append(newElement.getElementsByClassName('message-wrapper')[0]);
                        }
                        else{
                            addNewMessage(newElement, true);
                        }
                    }
                    else{
                        addNewMessage(newElement, true);
                    }
                },
                error: function(error, xhr){
                    alert("Error !! Could not send message !");
                }
            });
        }
    </script>
</body>
</html>