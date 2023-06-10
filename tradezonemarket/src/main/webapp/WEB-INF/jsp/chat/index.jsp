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
                background-color: #cacaca2a;
            }
            .message.sender {
                box-shadow: none;
                background-color: #cacaca2a;
            }
        }
    </style>
</head>
<body>
    <div style="background-color: #cacaca2a;" class="full_block grid_3">
        <div id="chat_contacts" class="chat_item contacts">
            <div style="flex-grow: 0; justify-content: center; background-color: white; padding: 20px"class="field-wrapper-2">
                <svg style="position: absolute; padding-left: 10px; cursor:pointer; " xmlns="http://www.w3.org/2000/svg" height="25" viewBox="0 -960 960 960" width="25"><path fill="#cacaca" d="M796-121 533-384q-30 26-69.959 40.5T378-329q-108.162 0-183.081-75Q120-479 120-585t75-181q75-75 181.5-75t181 75Q632-691 632-584.85 632-542 618-502q-14 40-42 75l264 262-44 44ZM377-389q81.25 0 138.125-57.5T572-585q0-81-56.875-138.5T377-781q-82.083 0-139.542 57.5Q180-666 180-585t57.458 138.5Q294.917-389 377-389Z"/></svg>
                <input style="padding-left: 35px" class="search-field smaller-text dark" type="text" placeholder="Search">
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
        <div style="position: absolute; margin: 20px auto; left: 50%; transform: translate(-50%, 0); width: max-content; background-color: black; border-radius: 50%;">
            <div style="margin: 5px;" id="loader_messages-content" class="load-more"></div>
        </div>
        <div id="chat_content" class="chat_item content">
            <div style="background-color: white; padding-bottom: 15px" id="content" class="content-wrapper-2"></div>
        </div>
        <div class="chat_item profile">
            <!--iframe></iframe-->
        </div>
    </div>
    <script>
        //script for loading contacts and messages
        var pagenumber = 0;
        var page_number = 0;
        var pagesize = 1;
        var page_size = 3;
        var chat_id = null;
        window.onload = loadContacts();
        function loadContacts(){
            $("#contacts_loader").addClass("active");
            $("#contacts_loader").css('pointer-events', 'none');
            if(document.getElementById("contacts")){
                var newElement = null;
                $.get("/chat/api/contacts?pagenumber="+pagenumber+"&pagesize="+pagesize, function(html){
                    newElement = document.createElement('div');
                    newElement.innerHTML = html;
                    while(newElement.getElementsByClassName('contact').length > 0 ){//must not use for loop. as the newElement length keeps changing when prepending elements
                        $("#contacts").append(newElement.getElementsByClassName('contact')[0]);
                        //subscribeToUser();
                        alert(newElement.getElementsByClassName('contact')[0].querySelector('#username').innerHTML);
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
        function loadMessages(){
            $("#messages_loader").addClass("active");
            $("#messages_loader").css('pointer-events', 'none');
            if(document.getElementById("messages")){
                var newElement = null;
                $.get("/chat/api/messages?id="+chat_id+"&pagenumber="+page_number+"&pagesize="+page_size, function(html){
                    newElement = document.createElement('div');
                    newElement.innerHTML = html;
                    var count = 0;
                    var size = newElement.getElementsByClassName('message-wrapper').length; //initial or before prepend
                    var sender_wrapper_count = 0;
                    var recipient_wrapper_count = 0;
                    var msg_status = null;
                    while(newElement.getElementsByClassName('message-wrapper').length > 0 ){//must not use for loop. as the newElement length keeps changing when prepending elements
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
                            else{
                                console.log("no match")
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
                    $("#messages_loader").css('pointer-events', '');//set with css
                    newElement.remove();
                });
            }
        }
        
        function loadContent(element){
            if(mobileMediaQuery.matches){
                document.getElementById("chat_contacts").style.display = "none";
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
                    if(mobileMediaQuery.matches){
                        document.getElementById("chat_content").style.display = "flex";
                    }
                    loadMessages();
                },
                error: function(){
                    document.getElementById("loader_messages-content").style.display = "none";
                    alert("could not load content");
                }
            });
        }
        
    </script>
    <script>
        //basic script
        var repliedMsg = null;
        var repliedMsgId = null;
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
        console.log("timezone: "+timezone);
          var stompClient = null;
          var privateStompClient = null;
          var stompClientGroup = null;
  
          var headerName = "${_csrf.headerName}";
          var parameterName = "${_csrf.parameterName}";
          var token = "${_csrf.token}";
  
          var headers = {};
          headers[headerName] = token;
  
          var socket = null;
          function connect(){
              socket = new SockJS('/ws');
              privateStompClient = Stomp.over(socket);
              privateStompClient.connect(headers, function(frame) {
                  privateStompClient.subscribe('/user/queue/reply', function(result) {
                      show(JSON.parse(result.body));
                  });
              });
              socket = new SockJS('/ws');
              stompClientGroup = Stomp.over(socket);
              stompClientGroup.connect(headers, function(frame) {
                  stompClientGroup.subscribe('/topic/friend/Anda', function(result) {
                      show(JSON.parse(result.body));
                  });
              });
          }
          connect();
          window.addEventListener('visibilitychange', () => {
              /*Problem !!!
                  Page visibilty only detects tab focus/when switching tabs, and not background/foreground status of the broswer.
                  When app/browser is pushed to the background, websocket is closed. 
                  And so, we cannot detect when user push app/browser to the backdround to perform unsubscribe and disconnect events.
                  The Solution for now is - onclose websocket -blur event must be forced to trigger.
              */
              if (socket.readyState === 2 | socket.readyState === 3) {
                  connect();
              }
          });
          window.addEventListener('visibilitychange', () => {
              /*Problem !!!
                  Page visibilty only detects tab focus/when switching tabs, and not background/foreground status of the broswer.
                  When app/browser is pushed to the background, websocket is closed. 
                  And so, we cannot detect when user push app/browser to the backdround to perform unsubscribe and disconnect events.
                  The Solution for now is - onclose websocket -blur event must be forced to trigger.
              */
              if (socket.readyState === 2 | socket.readyState === 3) {
                  connect();
              }
          });
          window.addEventListener('resume', () => {
              alert("resumimg!!!");
          });
          
          socket.onclose =function(event){
              console.log("websocket closed");
              stompClient.unsubscribe();
              privateStompClient.unsubscribe();
              stompClientGroup.unsubscribe();
              stompClient.disconnect();
              privateStompClient.disconnect();
              stompClientGroup.disconnect();
              window.trigger("blur"); /*
              this forces visibilty change to be triggered when browser push to background.
              when the user clicks back or comes back to the window, the focus event will be force to trigger
              whenever the user start interacting with the app*/
          }
  
          function sendMessage() {
              if (socket.readyState === 2 | socket.readyState === 3) {
                  connect();
              }
              var text = document.getElementById('text').value;
              stompClient.send("/app/all", {}, JSON.stringify({'text':text}));
          }
          /*$.ajaxSetup({//for Ajax & $.post
              beforeSend: function(xhr){
                  xhr.setRequestHeader(headerName,token);
              }
          });*/
          function sendPrivateMessage() {
              if (socket.readyState === 2 | socket.readyState === 3) {
                  connect();
              }
              var text = document.getElementById('privateText').value;
              var to = document.getElementById('to').value;
              $.ajax({
                  url: "/chat/sendmessage",
                  data: {'text':text, 'to':to, 'timezone': timezone},
                  type: "POST", 
                  beforeSend: function(xhr){
                      xhr.setRequestHeader(headerName,token);
                  },
                  success: function(html){
                      alert(html);
                  },
                  error: function(error, xhr){
                      alert("Could not send message due to an error:");
                  }
              });
          }
          /*
          function sendPrivateMessage() {
              if (socket.readyState === 2 | socket.readyState === 3) {
                  connect();
              }
              var text = document.getElementById('privateText').value;
              var to = document.getElementById('to').value;
              stompClient.send("/app/specific", {}, JSON.stringify({'text':text, 'to':to, 'timezone': timezone}));
          }*/
          function show(message) {
              var response = document.getElementById('messages');
              var p = document.createElement('p');
              p.innerHTML= "message: "  + message.text;
              console.log(message.text);
              response.appendChild(p);
          }
      </script>
</body>
</html>