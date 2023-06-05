<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="date" scope="session" value="${null}"/>
<div style="padding: 15px 15px; align-items: center;" class="row">
    <div id="mobile-back-arrow" onclick="showContactsOnly()" class="back-arrow"></div>
    <div class="profile_pic"></div>
    <div class="field-wrapper-2 small-margin">
         <div class="label-field small-text dark bold-text">${chat.get().getUsername()}</div>
        <label class="label-field smaller-text light">Online status</label>
    </div>
</div>
<div class="flexi-content-wrapper">
    <div class="flexi-content messages">
        <div id="messages_loader" class="load-more" onclick="loadMessages()"></div>
        <div style="padding-right: 10px;" id="messages" class="field-wrapper-2"></div><!--there must be no space inside this element in order firstchild to return null if empty-->
    </div>
</div>
<div style="position: relative; flex-grow: 0; background-color: #cacaca05" class="field-wrapper-2">
    <div id="replied_msg" style="display: none;" class="row">
        <p class="small-text light">Re: </p>
        <div class="field-wrapper-2">
            <label class="label-field small-text light">RepliedUsnam</label>
            <p class="small-text light short-text">message replied to. I must make this message as long as possible to make sure 
                that ellipse with hieight of two works, now lets dive in to the code and see if it really works.
            </p>
        </div>
    </div>
    <textarea style="flex: 1;" class="text-field-2 small-text dark" type="text" placeholder="type a message..."></textarea>
    <button style="padding: 8px 0; width: 80px; min-width: auto; right: 10px;" class="button-2 small-text left" type="button">Send</button>
</div>