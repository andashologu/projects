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
        var stompClient = null;
        var privateStompClient = null;
        var stompClientGroup = null;

        var headerName = "${_csrf}";
        var token = "${_csrf.token}";
        console.log("token...:"+token)

        var headers = {};
        headers[headerName] = token;

        var socket = null;
        function connect(){
            socket = new SockJS('/ws');
            stompClient = Stomp.over(socket);
            stompClient.connect(headers, function(frame) {
                stompClient.subscribe('/topic/messages', function(result) {
                    show(JSON.parse(result.body));
                });
            });
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
                stompClientGroup.subscribe('/topic/onlinestatus/Anda', function(result) {
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
        function sendPrivateMessage() {
            if (socket.readyState === 2 | socket.readyState === 3) {
                connect();
            }
            var text = document.getElementById('privateText').value;
            var to = document.getElementById('to').value;
            stompClient.send("/app/specific", {}, JSON.stringify({'text':text, 'to':to, 'timezone': timezone}));
        }
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