<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${totalCntWarehouseInfo eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCntWarehouseInfo > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPageWarehouseInfo-1)}" />
	<c:forEach items="${listWarehouseInfoModel}" var="list">

		<tr style="cursor:pointer;" onClick="fPopModalWarehouseInfo('${list.whcode}')">

			<td>${list.whcode}</td>
			<td>${list.whnm}</td>
			<td>${list.mgrnm }</td>
			<td>${list.email}</td>
			<td>${list.phone}</td>
			<td>${list.whzip}</td>
			<td>${list.whplace}, ${list.whaddr}</td>

		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="totalCntWarehouseInfo" name="totalCntWarehouseInfo" value="${totalCntWarehouseInfo}" />