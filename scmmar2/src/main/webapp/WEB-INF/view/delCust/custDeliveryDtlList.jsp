<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
	

	<c:if test="${totalCntDelivery eq 0 }">
		<tr>
			<td colspan="2">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${totalCntDelivery > 0 }">
		<c:set var="nRow" value="${pageSize*(currentPageDelivery-1)}" />
		<c:forEach items="${listCustDeliveryModel}" var="list">
			<tr>
				<td>${list.pdnm}</td>
				<td>${list.oddtcnt}</td>
			</tr>
			<c:set var="nRow" value="${nRow + 1}" />
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="totalCntDelivery" name="totalCntDelivery" value ="${totalCntDelivery}"/>
					
