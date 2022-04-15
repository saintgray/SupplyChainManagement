<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<c:if test="${totalProductCod > 0 }">
		<c:set var="nRow" value="${pageSize*(currentPagePDCod-1)}" />
		<c:forEach items="${listProductCodModel}" var="list">
			<tr>
				<td><a href="javascript:fListProductDtCod('${list.pdno}')">${list.pdmdno}</a></td>
				<td>${list.pdmdnm}</td>
				<td>${list.pdno}</td>
				<td>${list.pdnm}</td>
				<td>${list.pdmdcop}</td>
				<td>${list.pdmdprice}</td>
				<td><a class="btnType blue" href="javascript:fPopModalProductCod('${list.pdno}');" style="padding: 0px;"><span style="padding: 0px;">수정</span></a></td>
			</tr>
		<c:set var="nRow" value="${nRow + 1}" />
		</c:forEach>
	</c:if>
	
	<c:if test="${totalProductCod eq 0 }">
		<tr>
			<td colspan="9">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<input type="hidden" id="totalProductCod" name="totalProductCod" value ="${totalProductCod}"/>