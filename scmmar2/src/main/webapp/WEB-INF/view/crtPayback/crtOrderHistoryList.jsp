<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${totalOrderHistoryCount eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalOrderHistoryCount > 0 }">
	<c:forEach items="${listOrderHistoryModel}" var="list">
		<tr onclick="flistOrderHistoryDtl(1,'${list.orderno}');" style="cursor: pointer">
			<td>${list.orderno}</td>
			<td>${list.ordercnt}</td>
			<td>${list.orderamount}</td>
			<td><fmt:formatDate value="${list.orderdate}"
					pattern="yyyy-MM-dd" /></td>
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="totalOrderHistoryCount"
	name="totalOrderHistoryCount" value="${totalOrderHistoryCount}" />