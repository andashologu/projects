<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messaging - PropertyCheck</title>
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
</head>
<body>
    <div class="container">
        <div style="background-color: #cacaca2a;" class="full_block grid_3">
            <div class="chat_item contacts">
                <input style="margin-left: 4em; margin-right: 15px;" class="search-field small-text dark medium-margin" type="text" placeholder="Search">
                <div style="flex-grow: inherit;" id="contacts" class="field-wrapper-2"></div>
                <input id="contacts_button" onclick="loadContacts()" type="button" value="load contacts"/>
                <div id="loader_contacts" class="loader"></div>
            </div>
            <div class="chat_item content">
                <div id="content" class="container">
                    <div id="loader_messages-content" class="loader"></div>
                </div>
            </div>
            <div class="chat_item profile">
                <!--iframe></iframe-->
            </div>
        </div>
    </div>
    <script>
        var pagenumber = 0;
        var pagenumber_ = 0;
        window.onload = loadContacts();
        function loadContacts(){
            $("#contacts_button").prop('disabled', true);
            document.getElementById("loader_contacts").style.display = "block";
            if(document.getElementById("contacts")){
                var newElement = null;
                $.get("/chat/api/contacts?pagenumber="+pagenumber+"&pagesize=1", function(html){
                    newElement = document.createElement('div');
                    newElement.innerHTML = html;
                    while(newElement.getElementsByClassName('contact').length > 0 ){//must not use for loop. as the newElement length keeps changing when prepending elements
                        $("#contacts").append(newElement.getElementsByClassName('contact')[0]);
                    }
                    $("#contacts").append(newElement);//for script variables; hasNextMessages
                    if(hasNextContacts === 'false'){
                        document.getElementById("contacts_button").remove();
                    };
                    pagenumber++;
                })
                .fail(function(){
                    alert("could not load new contacts");
                })
                .always(function(){
                    document.getElementById("loader_contacts").style.display = "none";
                    $("#contacts_button").prop('disabled', false);
                    newElement.remove();
                });
            }
        }
        function loadMessages(){
            document.getElementById("loader_messages-content").style.display = "block";
            document.getElementById("more_msgz").style.display = "none";
            if(document.getElementById("messages")){
                var chat_id = document.getElementById("messages").querySelector("#chat_id").value;
                var newElement = null;
                $.get("/chat/api/messages?id="+chat_id+"&pagenumber="+pagenumber_+"&pagesize=3", function(html){
                    document.getElementById("more_msgz").style.display = "block";
                    newElement = document.createElement('div');
                    newElement.innerHTML = html;
                    while(newElement.getElementsByClassName('message').length > 0 ){//must not use for loop. as the newElement length keeps changing when prepending elements
                        $("#messages").prepend(newElement.getElementsByClassName('message')[0]);
                    }
                    $("#messages").append(newElement);//for script variables; hasNextMessages
                    if(hasNextMessages === 'false'){
                        document.getElementById("more_msgz").remove();
                    };
                    pagenumber_++;
                })
                .fail(function(){
                    $("#more_msgz").prop('disabled', true);
                    alert("could not load previous messages");
                })
                .always(function(){
                    document.getElementById("loader_messages-content").style.display = "none";
                    newElement.remove();
                });
            }
        }
        function loadContent(element){
            pagenumber_ = 0;
            document.getElementById("loader_messages-content").style.display = "block";
            var contact_id = element.querySelector("#contact_id").value;
            $.ajax({
                url: "/chat/api/content?id="+contact_id,
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
    </script>
    <script>
        const timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;
    </script>
</body>
</html>