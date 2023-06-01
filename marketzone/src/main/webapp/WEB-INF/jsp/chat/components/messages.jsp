<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.time.temporal.ChronoUnit"%>
<c:forEach var="message" items="${messages}">
    <c:if test = "${date == null}">
        <c:set var="date" scope="session" value="${message.getDatetime().toLocalDate()}"/>
    </c:if>
    <c:if test = "${message.getDatetime().toLocalDate().isBefore(date)}">
        <jsp:include page="date.jsp">
            <jsp:param name="style" value="smaller-text dark"/>
        </jsp:include>
        <c:set var="date" scope="session" value="${message.getDatetime().toLocalDate()}"/>
    </c:if>
    <c:choose>
        <c:when test = "${message.getSender().getUsername() != username && message.getRecipient().getUsername() != username}">
            <div id="msg_${message.getId()}" class="message recipient field-wrapper-2">
        </c:when>
        <c:when test = "${message.getRecipient().getUsername() != username && message.getRecipient().getUsername() != username}">
            <div id="msg_${message.getId()}" class="message recipient field-wrapper-2">
        </c:when>
        <c:otherwise>
            <div id="msg_${message.getId()}" class="message sender field-wrapper-2">
        </c:otherwise>
    </c:choose>
        <!--div class="row">
            <c:choose>
                <c:when test = "${message.getSender().getUsername() != username && message.getRecipient().getUsername() != username}">
                    <label class="label-field small-text light">${message.getSender().getUsername()}</label>
                </c:when>
                <c:when test = "${message.getRecipient().getUsername() != username && message.getRecipient().getUsername() != username}">
                    <label class="label-field small-text light">${message.getRecipient().getUsername()}</label>
                </c:when>
                <c:otherwise>
                    <label class="label-field small-text light">You</label>
                </c:otherwise>
            </c:choose>
            <p class="label-field small-text light">${message.getDatetime().toLocalTime().truncatedTo(ChronoUnit.MINUTES)}</p>
            <c:if test="${message.getSender().getUsername() != username}">
                <label class="label-field small-text light">${message.getStatus()}</label>
            </c:if>
        </div-->
        <c:if test = "${message.getReplied() != null}">
            <div class="row">
                <p class="small-text light">Re: </p>
                <div class="field-wrapper-2">
                    <div>
                        <label class="label-field small-text light">${message.getReplied().getSender().getUsername()}</label>
                        <label class="label-field small-text light">${message.getReplied().getDatetime().toLocalTime().truncatedTo(ChronoUnit.MINUTES)}</label>
                        <c:set var="date" scope="request" value="${message.getReplied().getDatetime()}"/><!--note the difference between scope session and request-->
                        <jsp:include page="date.jsp">
                            <jsp:param name="style" value="smaller-text dark"/>
                        </jsp:include>
                    </div>
                    <p class="smaller-text light short-text medium-margin">${message.getReplied().getMessage()}</p>
                </div>
            </div>
        </c:if>
        <p class="smaller-text dark">${message.getMessage()}</p>
        <!--label id="reply_${message.getId()}" onclick="replyMsg(this)" style="cursor: pointer; margin-right: auto; margin-left: 0;" class="label-field small-text light">Reply</label-->
    </div>
</c:forEach>
<c:if test = "${!hasNextMessages}">
    <jsp:include page="date.jsp">
        <jsp:param name="style" value="smaller-text dark"/>
    </jsp:include>
</c:if>
<script>
    hasNextMessages = "${hasNextMessages}";
</script>