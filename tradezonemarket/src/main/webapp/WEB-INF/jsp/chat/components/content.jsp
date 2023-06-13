<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="date" scope="session" value="${null}"/>
<div style="padding: 15px 15px; align-items: center;" class="row">
    <div id="mobile-back-arrow" onclick="showContactsOnly()" class="back-arrow">
        <svg xmlns="http://www.w3.org/2000/svg" height="25" viewBox="0 -960 960 960" width="25"><path fill="#cacaca" d="M384-96 33-447q-7-7-10.5-15.5T19-480q0-9 3.5-17.5T33-513l351-351q16-16 40-16.5t40 15.5q17 17 17 41t-17 41L161-480l303 303q17 17 17 40.5T465-97q-17 17-41 17t-40-16Z"/></svg>
    </div>
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
        <svg xmlns="http://www.w3.org/2000/svg" height="25" viewBox="0 -960 960 960" width="25"><path fill="grey" d="M185-95q-40.212 0-67.606-27.1Q90-149.2 90-189v-582q0-40.213 27.394-67.606Q144.788-866 185-866h329q19.75 0 33.375 14.263t13.625 34Q561-798 547.375-784.5 533.75-771 514-771H185v582h582v-329q0-19.75 13.675-33.375Q794.351-565 814.175-565 834-565 847.5-551.375 861-537.75 861-518v329q0 39.8-27.625 66.9Q805.75-95 767-95H185Zm522-615h-56.018q-15.732 0-25.857-10.4Q615-730.801 615-746.175q0-16.225 9.925-26.025Q634.85-782 651-782h56v-56.614q0-15.136 9.975-25.761Q726.951-875 743.175-875q15.375 0 25.6 10.494Q779-854.013 779-838.5v56.5h56.018q14.882 0 25.432 9.975 10.55 9.976 10.55 25.7 0 15.725-9.925 26.025Q851.15-710 835-710h-56v56.018q0 14.882-10.4 25.432Q758.199-618 742.825-618q-16.225 0-26.025-9.925Q707-637.85 707-654v-56ZM445-307l-76-98q-7-10-18.5-10T332-405l-67 85q-9 13-2.75 25.5T284-282h384q15 0 21.5-12.625T687-320l-97-128q-7-10-18.5-10T553-448L445-307Zm31-173Z"/></svg>
        <div class="field-wrapper-2">
            <textarea rows="1" id="privateText" class="text-field small-text dark" type="text" placeholder="type a message..."></textarea>
            <div class="horozontalline"></div>
        </div>
        <button type="button" onclick="sendPrivateMessage()" style="max-height: 35px; border-radius: 50%; padding: 5px; margin:auto" class="button small-text">   
            <svg xmlns="http://www.w3.org/2000/svg" height="25" viewBox="0 -960 960 960" width="25"><path fill="white" d="M807-436 163-165q-24 10-45-3.5T97-207v-546q0-25 21-38.5t45-4.5l644 272q29 12 29 44t-29 44ZM180-264l516-216-516-219v146l253 73-253 71v145Zm0 0v-435 435Z"/></svg>
        </button>
    </div>
</div>