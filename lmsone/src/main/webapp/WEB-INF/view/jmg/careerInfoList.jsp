<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${totalCount eq 0}"> 
	<tr>
		<td colspan="6">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCount > 0 }">
<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
	<c:forEach items="${listCareerInfoMap}" var="list">
		<tr>
			<td>${totalCount - nRow}</td>
			<td><a href="javascript:flistHistory(${list.loginID});">${list.name}</a></td>
			<td>${list.join_date}</td>
			<td>${list.resign_date}</td>
			<td>${list.corp}</td>
			<td>${list.join_yn}</td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
	</c:if>
	
	<input type="hidden" id="listCount" name="listCount" value="${totalCount}" />