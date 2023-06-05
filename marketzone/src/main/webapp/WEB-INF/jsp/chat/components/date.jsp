<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.time.format.DateTimeFormatter"%>
<c:choose>
    <c:when test = "${date.isAfter(today) || date.equals(today)}">
        <label class="message-wrapper label-field date ${param.style}">Today</label>
    </c:when>
    <c:when test = "${date.isBefore(today) && (date.isAfter(yesterday) || date.equals(yesterday))}">
        <label class="message-wrapper label-field date ${param.style}">Yesterday</label>
    </c:when>
    <c:when test = "${date.isBefore(yesterday) && (date.isAfter(thisweek) || date.equals(thisweek))}">
        <label class="message-wrapper label-field date ${param.style}">${date.getDayOfWeek()}</label>
    </c:when>
    <c:otherwise>
        <c:if test = "${date.getYear() == today.getYear()}">
            <label class="message-wrapper label-field date ${param.style}">${date.format(DateTimeFormatter.ofPattern("E, MMM dd"))}</label>
        </c:if>
        <c:if test = "${date.getYear() != today.getYear()}">
            <label class="message-wrapper label-field date ${param.style}">${date.format(DateTimeFormatter.ofPattern("E, MMM dd yyyy"))}</label>
        </c:if>
    </c:otherwise>
</c:choose>