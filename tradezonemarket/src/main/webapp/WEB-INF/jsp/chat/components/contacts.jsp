<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.temporal.ChronoUnit"%>
<c:forEach var="contact" items="${contacts}">
    <c:if test = "${contact.getSender().getUsername() != username}">
        <div id="ct_${contact.getSender().getId()}" data-id="${contact.getSender().getUsername()}" onclick="loadContent(this)" class="contact row small-margin">
    </c:if>
    <c:if test = "${contact.getRecipient().getUsername() != username}">
        <div id="ct_${contact.getRecipient().getId()}" data-id="${contact.getRecipient().getUsername()}" onclick="loadContent(this)" class="contact row small-margin">
    </c:if>
        <div class="profile_pic"></div>
        <div class="field-wrapper-2">
            <div class="row">
                <c:choose>
                    <c:when test = "${contact.getSender().getUsername() != username}">
                        <div class="label-field smaller-text light bold-text">${contact.getSender().getUsername()}</div><!--label tag does not inherit cursor-->
                    </c:when>
                    <c:otherwise>
                        <div class="label-field smaller-text light bold-text">${contact.getRecipient().getUsername()}</div><!--label tag does not inherit cursor-->
                    </c:otherwise>
                </c:choose>
                <div class="smaller-text light">&#x2022;</div>
                <c:set var="date" scope="request" value="${contact.getDatetime()}"/>
                <!--goes after the above scope for date the following page/component-->
                <jsp:include page="date.jsp">
                    <jsp:param name="style" value="message-wrapper smaller-text light italic"/>
                </jsp:include>
                <label style="text-decoration: underline;" class="label-field smaller-text light italic">@${contact.getDatetime().toLocalTime().truncatedTo(ChronoUnit.MINUTES)}</label>
            </div>
            <p style="margin-right: 15px;" class="smaller-text dark short-text">${contact.getMessage()}</p>
        </div>
    </div>
</c:forEach>
<script>
    hasNextContacts = "${hasNextContacts}";
</script>