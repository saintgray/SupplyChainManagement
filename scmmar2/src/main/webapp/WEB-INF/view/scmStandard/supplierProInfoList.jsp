<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:if test="${totalCntSupplierProInfo eq 0 }">
	<tr>
		<td colspan="12">데이터가 없습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCntSupplierProInfo > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPageSupplierProInfo-1)}" />
	<c:forEach items="${supplierInfoModel}" var="supProList">
		<tr>
			<td>${supProList.pdno}</td>
			<td>${supProList.pdnm}</td>
			<td>${supProList.pdmdprice}</td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if> 

<c:forEach items="${supplierInfoModel}" var="supProList">
		<tr>
			<td>${supProList.pdno}</td>
			<td>${supProList.pdnm}</td>
			<td>${supProList.pdmdprice}</td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>

<input type="hidden" id="totalCntSupplierProInfo" name="totalCntSupplierProInfo" value="${totalCntSupplierProInfo}" />