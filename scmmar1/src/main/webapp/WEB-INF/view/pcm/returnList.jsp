<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${totalCnt eq 0}"> 
	<tr>
		<td colspan="6">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>


<c:if test="${totalCnt > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
	<c:forEach items="${listPurchaseReturnModel}" var="list">
		<tr>
			<td><c:out value="${nRow+1}"></c:out></td>			
			<td>${list.return_id}</td>
			<td>${list.comp_nm}</td>
			<td>${list.sales_nm}</td>
			<td>${list.return_cnt}</td>
			<!-- jstl은 jstl 주석으로 처리안하면 오류 생긴다. ★html보다 jstl이 먼저 실행된다. -->
			<td><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd" /></td>
			<td>
				<c:choose>
					<c:when test="${list.confirmYN=='Y'}">승인</c:when>
					<c:when test="${list.confirmYN=='N'}">미승인</c:when>
					<c:otherwise>-</c:otherwise>
				</c:choose>
			</td>
			
<%-- 			<td>
			<a class="btnType3 color1" href="javascript:fPcmReturnOne('${list.return_id}');"><span >조회</span></a>
			</td> --%>
			
			<td>
				<c:if test="${list.confirmYN=='Y'}">
					<button type="button" class="btn btn-primary" onclick="fPcmReturnOne('${list.return_id}')">조회</button>
					<%-- <a class="btnType3 color1" href="javascript:fPcmOrderOne('${list.orderid}');"><span >발주</span></a> --%>
				</c:if>
				<c:if test="${list.confirmYN!='Y'}">
					<button type="button" class="btn btn-primary" disabled="disabled">조회</button>					
				</c:if>
			</td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
	</c:if>
	
	<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />