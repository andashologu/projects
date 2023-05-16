<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.time.temporal.ChronoUnit"%>
<c:forEach var="message" items="${messages}">
    <c:if test = "${date == null}">
        <c:set var="date" scope="session" value="${message.getDatetime().toLocalDate()}"/>
    </c:if>
    <c:if test = "${message.getDatetime().toLocalDate().isBefore(date)}">
        <label class=" message label-field medium-text dark bold-text">${date}</label>
        <c:set var="date" scope="session" value="${message.getDatetime().toLocalDate()}"/>
    </c:if>
    <div class="message field-wrapper-2 small-margin">
        <div class="row">
            <c:choose>
                <c:when test = "${message.getSender().getUsername() != username && message.getRecipient().getUsername() != username}">
                    <label class="label-field medium-text dark bold-text">${message.getSender().getUsername()}</label>
                </c:when>
                <c:when test = "${message.getRecipient().getUsername() != username && message.getRecipient().getUsername() != username}">
                    <label class="label-field medium-text dark bold-text">${message.getRecipient().getUsername()}</label>
                </c:when>
                <c:otherwise>
                    <label class="label-field medium-text dark bold-text">You</label>
                </c:otherwise>
            </c:choose>
            <label class="label-field small-text light">${message.getDatetime().toLocalTime().truncatedTo(ChronoUnit.MINUTES)}</label>
        </div>
        <p class="medium-text dark">${message.getMessage()}</p>
        <label class="label-field small-text light">${message.getStatus()}</label>
    </div>
</c:forEach>
<c:if test = "${!hasNextMessages}">
    <label class=" message label-field medium-text dark bold-text">${date}</label>
</c:if>
<script>
    hasNextMessages = "${hasNextMessages}";
</script>