<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
		<c:if test="${totalCntDelivery eq 0 }">
			<tr>
				<td colspan="5">배송 지시서가 없습니다.</td>
			</tr>
		</c:if>
		
		<c:if test="${totalCntDelivery > 0 }">
			<c:set var="nRow" value="${pageSize*(currentPageDelivery-1)}" />
			<c:forEach items="${listCustDeliveryModel}" var="list">
				<tr style="cursor:pointer;" onClick="fPopModalCustDelivery('${list.delno}');">
					<td>${list.delno}</td>
					<td>${list.clientnm}</td>
					<td>${list.whplace}</td>
					<td>${list.address}</td>
					<td>${list.delstate}</td>
				</tr>
				<c:set var="nRow" value="${nRow + 1}" />
			</c:forEach>
		</c:if>
		
		<input type="hidden" id="totalCntDelivery" name="totalCntDelivery" value ="${totalCntDelivery}"/>