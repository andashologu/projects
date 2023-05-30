<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.temporal.ChronoUnit"%>
<c:forEach var="contact" items="${contacts}">
    <div id="ct_${contact.getRecipient().getId()}" onclick="loadContent(this)" class="contact row small-margin">
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
            <c:set var="date" scope="request" value="${contact.getDatetime()}"/>
            <jsp:include page="date.jsp"/>
        </div>
    </div>
</c:forEach>
<script>
    hasNextContacts = "${hasNextContacts}";
</script>