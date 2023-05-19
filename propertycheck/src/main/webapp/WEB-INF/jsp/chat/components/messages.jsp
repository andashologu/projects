<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.time.temporal.ChronoUnit"%>
<c:forEach var="message" items="${messages}">
    <c:if test = "${date == null}">
        <c:set var="date" scope="session" value="${message.getDatetime().toLocalDate()}"/>
    </c:if>
    <c:if test = "${message.getDatetime().toLocalDate().isBefore(date)}">
        <c:choose>
            <c:when test = "${date.isAfter(today) || date.equals(today)}">
                <label style="text-align: center;" class="message label-field small-text light">Today</label>
            </c:when>
            <c:when test = "${date.isBefore(today) && (date.isAfter(yesterday) || date.equals(yesterday))}">
                <label style="text-align: center;" class="message label-field small-text light">Yesterday</label>
            </c:when>
            <c:otherwise>
                <c:if test = "${date.getYear() == today.getYear()}">
                    <label style="text-align: center;" class="message label-field small-text light">${date.getDayOfWeek()}, ${date.getDayOfMonth()} ${date.getMonth()}</label>
                </c:if>
                <c:if test = "${date.getYear() != today.getYear()}">
                    <label style="text-align: center;" class="message label-field small-text light">${date.getDayOfWeek()}, ${date.getDayOfMonth()} ${date.getMonth()} ${date.getYear()}</label>
                </c:if>
            </c:otherwise>
        </c:choose>
        <c:set var="date" scope="session" value="${message.getDatetime().toLocalDate()}"/>
    </c:if>
    <div class="message field-wrapper-2">
        <div class="row">
            <c:choose>
                <c:when test = "${message.getSender().getUsername() != username && message.getRecipient().getUsername() != username}">
                    <label class="label-field medium-text dark">${message.getSender().getUsername()}</label>
                </c:when>
                <c:when test = "${message.getRecipient().getUsername() != username && message.getRecipient().getUsername() != username}">
                    <label class="label-field medium-text dark">${message.getRecipient().getUsername()}</label>
                </c:when>
                <c:otherwise>
                    <label class="label-field medium-text dark">You</label>
                </c:otherwise>
            </c:choose>
            <label class="label-field small-text light">${message.getDatetime().toLocalTime().truncatedTo(ChronoUnit.MINUTES)}</label>
        </div>
        <p class="small-text dark">${message.getMessage()}</p>
        <c:if test = "${message.getSender().getUsername() != username}">
            <label class="label-field small-text light">${message.getStatus()}</label>
        </c:if>
    </div>
</c:forEach>
<c:if test = "${!hasNextMessages}">
    <c:choose>
        <c:when test = "${date.isAfter(today) || date.equals(today)}">
            <label style="text-align: center;" class="message label-field small-text light">Today</label>
        </c:when>
        <c:when test = "${date.isBefore(today) && (date.isAfter(yesterday) || date.equals(yesterday))}">
            <label style="text-align: center;" class="message label-field small-text light">Yesterday</label>
        </c:when>
        <c:otherwise>
            <c:if test = "${date.getYear() == today.getYear()}">
                <label style="text-align: center;" class="message label-field small-text light">${date.getDayOfWeek()}, ${date.getDayOfMonth()} ${date.getMonth()}</label>
            </c:if>
            <c:if test = "${date.getYear() != today.getYear()}">
                <label style="text-align: center;" class="message label-field small-text light">${date.getDayOfWeek()}, ${date.getDayOfMonth()} ${date.getMonth()} ${date.getYear()}</label>
            </c:if>
        </c:otherwise>
    </c:choose>
</c:if>
<script>
    hasNextMessages = "${hasNextMessages}";
</script>