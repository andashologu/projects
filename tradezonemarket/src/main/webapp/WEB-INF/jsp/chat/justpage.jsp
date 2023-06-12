<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messaging</title>
    <script src="https://code.jquery.com/jquery-latest.min.js" type="text/javascript" ></script>
    <script src="https://cdn.jsdelivr.net/gh/manuelmhtr/countries-and-timezones@latest/dist/index.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
    <script type="text/javascript">
      const timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;
      console.log("timezone: "+timezone);

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
                stomp.subscribe('/topic/messages/test', function(result) {
                    show(JSON.parse(result.body));
                });
                stomp.subscribe('/user/queue/reply/test', function(result) {
                    show(JSON.parse(result.body));
                });
            });
        }
        function subscribeToUser(user){
            stomp.subscribe('/topic/friend/test' + user, function(result) {
                show(JSON.parse(result.body));
            },
            {id: user});
        }
        function unsubscribeFromUser(user){
            stomp.unsubscribe(user);
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
        
        socket.onclose =function(event){
            console.log("websocket closed");
            stomp.unsubscribe();
            socket.disconnect();
        }

        function sendMessage() {
            if (socket.readyState === 2 | socket.readyState === 3) {
                connect();
            }
            var text = document.getElementById('text').value;
            stompClient.send("/app/all/test", {}, JSON.stringify({'text':text}));
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
                url: "/chat/sendmessage/test",
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
            stompClient.send("/app/specific/test", {}, JSON.stringify({'text':text, 'to':to, 'timezone': timezone}));
        }*/
        function show(message) {
            var response = document.getElementById('messages');
            var p = document.createElement('p');
            p.innerHTML= "message: "  + message.text;
            console.log(message.text);
            response.appendChild(p);
        }
    </script>
</head>
<body>
    <div>
        <button onclick="subscribeToUser('Anda');">subscribe to Anda</button>
        <button onclick="unsubscribeFromUser('Anda');">unsubscribe from Anda</button>
        <div>
            <button id="sendMessage" onclick="sendMessage();">Send</button>
            <input type="text" id="text" placeholder="Text"/>
        </div>
        <br />
        <div>
            <button id="sendPrivateMessage" onclick="sendPrivateMessage();">Send Private</button>
            <input type="text" id="privateText" placeholder="Private Message"/>
            <input type="text" id="to" placeholder="to"/>
        </div>
        <br />
        <br />
        <br />
        <div id="messages"></div>
    </div>
</body>
</html>