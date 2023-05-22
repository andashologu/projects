<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.time.temporal.ChronoUnit"%>
<c:forEach var="contact" items="${contacts}">
    <div id="${contact.getRecipient().getId()}" onclick="loadContent(this)" class="contact row small-margin">
        <div class="profile_pic"></div>
        <div class="field-wrapper-2">
            <c:if test = "${contact.getSender().getUsername() != username}">
                <div style="justify-content: space-between;"  class="row">
                    <div class="label-field medium-text dark bold-text">${contact.getSender().getUsername()}</div><!--label tag does not inherit cursor-->
                    <input type="hidden" id="contact_id" value="${contact.getSender().getId()}"/>
                </div>
            </c:if>
            <c:if test = "${contact.getRecipient().getUsername() != username}">
                <div style="justify-content: space-between;" class="row">
                    <div class="label-field medium-text dark bold-text short-text">${contact.getRecipient().getUsername()}</div><!--label tag does not inherit cursor-->
                    <input type="hidden" id="contact_id" value="${contact.getRecipient().getId()}"/> 
                </div>
            </c:if>
            <p style="margin-right: 15px;" class="small-text dark short-text">${contact.getMessage()}</p>
            <!--class="horozontalline"></div-->
            <c:choose>
                <c:when test = "${contact.getDatetime().isAfter(today) || contact.getDatetime().equals(today)}">
                    <label class="label-field text small-text light">${contact.getDatetime().toLocalTime().truncatedTo(ChronoUnit.MINUTES)}</label>
                </c:when>
                <c:when test = "${contact.getDatetime().isBefore(today) && (contact.getDatetime().isAfter(yesterday) || contact.getDatetime().equals(yesterday))}">
                    <label class="label-field text small-text light">yesterday</label>
                </c:when>
                <c:otherwise>
                    
                    <c:if test = "${contact.getDatetime().getYear() == today.getYear()}">
                        <label class="label-field text small-text light">${contact.getDatetime().getDayOfWeek()}, ${contact.getDatetime().getDayOfMonth()} ${contact.getDatetime().getMonth()}</label>
                    </c:if>
                    <c:if test = "${contact.getDatetime().getYear() != today.getYear()}">
                        <label class="label-field text small-text light">${contact.getDatetime().getDayOfWeek()}, ${contact.getDatetime().getDayOfMonth()} ${contact.getDatetime().getMonth()} ${contact.getDatetime().getYear()}</label>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</c:forEach>
<script>
    hasNextContacts = "${hasNextContacts}";
</script>