<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messaging</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
    <script type="text/javascript">

        var stompClient = null;
        var privateStompClient = null;

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
                console.log(frame);
                stompClient.subscribe('/topic/messages', function(result) {
                    show(JSON.parse(result.body));
                });
            });
            socket = new SockJS('/ws');
            privateStompClient = Stomp.over(socket);
            privateStompClient.connect(headers, function(frame) {
                //console.log(frame);
                privateStompClient.subscribe('/user/queue/reply', function(result) {
                    console.log("response:"+result.body);
                    show(JSON.parse(result.body));
                });
            });
        }
        window.addEventListener('visibilitychange', () => {
            if(document.visibilityState == 'visible'){
                connect();
            }
            else{
                console.log("user leaves the page");
                stompClient.unsubscribe();
                privateStompClient.unsubscribe();
                stompClient.disconnect();
                privateStompClient.disconnect();
                socket.close();
            }
        });
        connect();
        function sendMessage() {
            var text = document.getElementById('text').value;
            stompClient.send("/app/all", {}, JSON.stringify({'text':text}));
        }
        function sendPrivateMessage() {
            var text = document.getElementById('privateText').value;
            var to = document.getElementById('to').value;
            stompClient.send("/app/specific", {}, JSON.stringify({'text':text, 'to':to}));
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