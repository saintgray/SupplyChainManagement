<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
		<c:if test="${totalCntDelivery eq 0 }">
			<tr>
				<td colspan="4">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
		<c:if test="${totalCntDelivery > 0 }">
			<c:set var="nRow" value="${pageSize*(currentPageDelivery-1)}" />
			<c:forEach items="${listDeliveryModel}" var="list">
				<tr>
					<td><a href="javascript:fPopModalDelivery('${list.orderSeq}');">${list.orderSeq}</td>
					<td><fmt:formatDate value="${list.orderDate}" pattern="yyyy-MM-dd" /></td>
					<td>${list.client}</td>
					<td>${list.orderCnt}</td>
				</tr>
				<c:set var="nRow" value="${nRow + 1}" />
			</c:forEach>
		</c:if>
		
		<input type="hidden" id="totalCntDelivery" name="totalCntDelivery" value ="${totalCntDelivery}"/>