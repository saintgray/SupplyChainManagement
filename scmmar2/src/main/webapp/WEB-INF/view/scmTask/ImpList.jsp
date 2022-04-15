<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${totalCount eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
							
<c:if test="${totalCount > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPageqnaList-1)}" />
	<c:forEach items="${impList}" var="list">
		<tr>
			<td>${list.pdno}</td>
			<td>${list.pdnm}</td>
			<td>${list.client}</td>
			<td>${list.impdtdate}</td>
			<td>${list.impdtcnt}</td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="totalCount" name="totalCount" value ="${totalCount}"/>