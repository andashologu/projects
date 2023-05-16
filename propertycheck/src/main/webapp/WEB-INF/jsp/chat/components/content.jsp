<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="date" scope="session" value="${null}"/>
<div class="row small-margin">
    <div class="profile_pic"></div>
    <div class="field-wrapper-2 small-margin">
        <!--NB, to do.. company name mucst be unique-->
         <label class="label-field medium-text dark bold-text">${chat.get().getUsername()}</label>
        <label class="label-field small-text light">Online status</label>
    </div>
</div>
<div style="width: 90%; margin-left: 5%; margin-right: 5%;" class="horozontalline medium-margin"></div>
<div class="messages">
    <input id="more_msgz" onclick="loadMessages()" type="button" value="load previous messages"/>
    <div style="margin: 0;" id="loader_messages-content" class="loader"></div>
    <div id="messages" class="field-wrapper-2">
        <input type="hidden" id="chat_id" value="${chat.get().getId()}"/>
    </div>
    <div class="field-wrapper-2">
        <input class="text-field-2 small-text dark" type="text" placeholder="type message...">
    </div>
</div>