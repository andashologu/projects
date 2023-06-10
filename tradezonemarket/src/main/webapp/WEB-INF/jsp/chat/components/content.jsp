<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="date" scope="session" value="${null}"/>
<div style="padding: 15px 15px; align-items: center;" class="row">
    <div id="mobile-back-arrow" onclick="showContactsOnly()" class="back-arrow"></div>
    <div class="profile_pic"></div>
    <div class="field-wrapper-2 small-margin">
        <div class="label-field small-text dark bold-text">${chat.get().getUsername()}</div>
        <label class="label-field smaller-text light">Away</label>
        <!--label class="label-field smaller-text light">Available</label-->
    </div>
</div>
<div class="flexi-content-wrapper">
    <div class="flexi-content messages">
        <div style="margin: 20px auto; width: max-content; background-color: black; border-radius: 50%; padding: 5px;">
            <div id="messages_loader" class="load-more" onclick="loadMessages()"></div>
        </div>
        <div style="padding-right: 10px;" id="messages" class="field-wrapper-2"></div><!--there must be no space inside this element in order firstchild to return null if empty-->
    </div>
</div>
<div style="position: relative; flex-grow: 0; background-color: #cacaca05" class="field-wrapper-2">
    <div id="replied_msg" style="display: none;" class="row">
        <div class="horozontalline"></div>
        <div style="cursor: pointer; padding: 8px;" class="row">
            <label style="flex-grow: 0;" class="smaller-text light">Re:</label>
            <p class="smaller-text light short-text"></p>
            <button style="margin-right: 0; margin-left: auto;" type="button" id="close_msg_(id)" class="button dark" onclick="closeReply(this)">
                <svg xmlns="http://www.w3.org/2000/svg" height="25" viewBox="0 -960 960 960" width="25"><path fill="black" d="m249-207-42-42 231-231-231-231 42-42 231 231 231-231 42 42-231 231 231 231-42 42-231-231-231 231Z"/></svg>
            </button>
        </div>
    </div>
    <div style="padding: 0 10px;" class="row">
        <div class="field-wrapper-2">
            <textarea class="text-field small-text dark" type="text" placeholder="type a message..."></textarea>
            <div class="horozontalline"></div>
        </div>
        <div>
            <button style="max-height: 35px; border-radius: 50%; padding: 5px;" class="button small-text" type="button">   
                <svg xmlns="http://www.w3.org/2000/svg" height="25" viewBox="0 -960 960 960" width="25"><path fill="white" d="M120-160v-640l760 320-760 320Zm60-93 544-227-544-230v168l242 62-242 60v167Zm0 0v-457 457Z"/></svg>
            </button>
            <svg xmlns="http://www.w3.org/2000/svg" height="28" viewBox="0 -960 960 960" width="28"><path d="M180-120q-24 0-42-18t-18-42v-600q0-24 18-42t42-18h409v171h81v81h170v408q0 24-18 42t-42 18H180Zm60-162h480L576-474 449-307l-94-124-115 149Zm460-336v-81h-81v-60h81v-81h60v81h81v60h-81v81h-60Z"/></svg>
        </div>
    </div>
</div>