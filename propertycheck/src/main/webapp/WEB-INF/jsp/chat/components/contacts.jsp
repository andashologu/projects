<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.time.temporal.ChronoUnit"%>
<c:forEach var="contact" items="${contacts}">
    <div id="${contact.getRecipient().getId()}" onclick="loadContent(this)" class="contact row small-margin">
        <div class="profile_pic"></div>
        <div class="field-wrapper-2">
            <c:if test = "${contact.getSender().getUsername() != username}">
                <div class="label-field medium-text dark bold-text">${contact.getSender().getUsername()}</div><!--label tag does not inherit cursor-->
                <input type="hidden" id="contact_id" value="${contact.getSender().getId()}"/>
            </c:if>
            <c:if test = "${contact.getRecipient().getUsername() != username}">
                <div class="label-field medium-text dark bold-text short-text">${contact.getRecipient().getUsername()}</div><!--label tag does not inherit cursor-->
                <input type="hidden" id="contact_id" value="${contact.getRecipient().getId()}"/>
            </c:if>
            <div style="justify-content: space-between;" class="field-wrapper-2 small-margin">
                <p class="small-text light short-text">${contact.getMessage()}</p>
                <c:choose>
                    <c:when test = "${contact.getDatetime().isAfter(today) || contact.getDatetime().equals(today)}">
                        <label style="text-align: right;" class="label-field small-text light">${contact.getDatetime().toLocalTime().truncatedTo(ChronoUnit.MINUTES)}</label>
                    </c:when>
                    <c:when test = "${contact.getDatetime().isBefore(today) && contact.getDatetime().isAfter(yesterday)}">
                        <label style="text-align: right;" class="label-field small-text light">yesterday</label>
                    </c:when>
                    <c:otherwise>
                        <label style="text-align: right;" class="label-field small-text light">${contact.getDatetime().toLocalDate()}</label>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="horozontalline"></div>
        </div>
    </div>
</c:forEach>
<script>
    hasNextContacts = "${hasNextContacts}";
</script>