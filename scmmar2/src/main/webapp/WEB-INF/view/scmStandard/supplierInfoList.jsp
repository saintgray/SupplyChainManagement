<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${totalCntSupplierInfo eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCntSupplierInfo > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPageSupplierInfo-1)}" />
	<c:forEach items="${listSupplierInfoModel}" var="suplist">

		<tr style="cursor:pointer;" onClick="fSelectSupplierInfo('${suplist.comp_id}')">
			
			
			<td>${suplist.client}</td>
			
			<td>${suplist.loginID}</td>
			
			<td>${suplist.password}</td>
			
			<td>${suplist.mgrnm}</td>
			
			<td>${suplist.phone}</td>
			
				

		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="totalCntSupplierInfo" name="totalCntSupplierInfo" value="${totalCntSupplierInfo}" />