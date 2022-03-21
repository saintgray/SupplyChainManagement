<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<c:if test="${totalCntReference eq 0 }">
		<tr>
			<td colspan="12">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	<c:set var="nRow" value="${pageSizeReference*(currentPageReference-1)}" />
	<c:if test="${totalCntReference > 0 }">
	
		<c:forEach items="${listReferenceModel}" var="list">
			<tr>
				<td><a href="javascript:fSelectOne('${list.board_no}')">${list.board_nm }</a></td>
				<td>${list.board_date }</td>
				<td>${list.name}</td>
			</tr>
			<c:set var="nRow" value="${nRow + 1}" />
		</c:forEach> 
	</c:if>
	<input type="hidden" id="totalCntReference" name="totalCntReference" value ="${totalCntReference}"/>