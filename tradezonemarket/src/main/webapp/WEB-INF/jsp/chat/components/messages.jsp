<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.time.temporal.ChronoUnit"%>
<c:forEach var="message" items="${messages}">
    <c:if test = "${date == null}">
        <c:set var="date" scope="session" value="${message.getDatetime().toLocalDate()}"/>
    </c:if>
    <c:if test = "${message.getDatetime().toLocalDate().isBefore(date)}">
        <jsp:include page="date.jsp">
            <jsp:param name="style" value="message-wrapper smaller-text dark"/>
        </jsp:include>
        <c:set var="date" scope="session" value="${message.getDatetime().toLocalDate()}"/>
    </c:if>
    <c:choose>
        <c:when test = "${message.getSender().getUsername() == username}">
            <div class="message-wrapper sender small-margin">
        </c:when>
        <c:otherwise>
            <div class="message-wrapper recipient small-margin">
        </c:otherwise>
    </c:choose><!--open of message-wrapper-->
        <div class="row">
            <div style="flex-grow: 0;" class="field-wrapper-2">
                <c:choose>
                    <c:when test = "${message.getSender().getUsername() == username}">
                        <div class="message sender field-wrapper-2">
                    </c:when>
                    <c:otherwise>
                        <div class="message recipient field-wrapper-2">
                    </c:otherwise>
                </c:choose><!--open of message-->
                    <c:if test = "${message.getReplied() != null}">
                        <div style="cursor: pointer; padding: 8px;" id="replied_${message.getReplied().getId()}" onclick="navigateToMessage(this)" class="field-wrapper-2">
                            <div class="row">
                                <label class="smaller-text light">Re: </label>
                                <label class="label-field smaller-text light">${message.getReplied().getSender().getUsername()}</label>
                                <c:set var="date" scope="request" value="${message.getReplied().getDatetime()}"/><!--note the difference between scope session and request-->
                                <jsp:include page="date.jsp">
                                    <jsp:param name="style" value="smaller-text light"/>
                                </jsp:include>
                                <label style="text-decoration: underline;" class="label-field smaller-text light italic">@${contact.getDatetime().toLocalTime().truncatedTo(ChronoUnit.MINUTES)}</label>
                            </div>
                            <p class="smaller-text light short-text">${message.getReplied().getMessage()}</p>
                        </div>
                    </c:if>
                    <p id="msg_${message.getId()}" class="smaller-text dark">${message.getMessage()}</p>
                    <label class="label-field time smallest-text light">${message.getDatetime().toLocalTime().truncatedTo(ChronoUnit.MINUTES)}</label>
                </div><!--close of message-->
                <c:if test="${message.getSender().getUsername() == username}">
                    <label class="label-field msg-status smaller-text light">${message.getStatus()}</label>
                </c:if>
            </div>
            <div id="reply_${message.getId()}" onclick="openReply(this)" class="reply-icon"><svg xmlns="http://www.w3.org/2000/svg" height="18" viewBox="0 -960 960 960" width="18"><path d="M780-200v-174q0-54-38-92t-92-38H234l154 154-42 42-226-226 226-226 42 42-154 154h416q78 0 134 55.5T840-374v174h-60Z"/></svg></div>
        </div>
    </div> <!--close of message-wrapper-->
</c:forEach>
<c:if test = "${!hasNextMessages}">
    <jsp:include page="date.jsp">
        <jsp:param name="style" value="message-wrapper smaller-text dark"/>
    </jsp:include>
</c:if>
<script>
    hasNextMessages = "${hasNextMessages}";
</script>