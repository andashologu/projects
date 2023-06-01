<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.temporal.ChronoUnit"%>
<c:forEach var="contact" items="${contacts}">
    <c:if test = "${contact.getSender().getUsername() != username}">
        <div id="ct_${contact.getSender().getId()}" onclick="loadContent(this)" class="contact row small-margin">
    </c:if>
    <c:if test = "${contact.getRecipient().getUsername() != username}">
        <div id="ct_${contact.getRecipient().getId()}" onclick="loadContent(this)" class="contact row small-margin">
    </c:if>
        <div class="profile_pic"></div>
        <div class="field-wrapper-2">
            <div style="column-gap: 0.3em;" class="row">
                <c:if test = "${contact.getSender().getUsername() != username}">
                    <div class="label-field smaller-text light">${contact.getSender().getUsername()}</div><!--label tag does not inherit cursor-->
                </c:if>
                <c:if test = "${contact.getRecipient().getUsername() != username}">
                    <div class="label-field smaller-text light">${contact.getRecipient().getUsername()}</div><!--label tag does not inherit cursor-->
                </c:if>
                <c:set var="date" scope="request" value="${contact.getDatetime()}"/>
                <!--goes after the c tag above the following jsp-->
                <jsp:include page="date.jsp">
                    <jsp:param name="style" value="smaller-text light"/>
                </jsp:include>
            </div>
            <p style="margin-right: 15px;" class="small-text dark short-text">${contact.getMessage()}</p>
        </div>
    </div>
</c:forEach>
<script>
    hasNextContacts = "${hasNextContacts}";
</script>