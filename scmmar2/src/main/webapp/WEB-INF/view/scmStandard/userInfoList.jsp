<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<c:if test="${totalCntUserInfo eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCntUserInfo > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPageUserInfo-1)}" />
	<c:forEach items="${listUserInfoModel}" var="list">

		<tr style="cursor:pointer;" onClick="fPopModalUserInfo('${list.loginID}')">

			<td>
				<c:choose>
					<c:when test="${list.user_Type == 'A'}">
						<c:out value="관리자"></c:out>
					</c:when>
				
				
					<c:when test="${list.user_Type == 'C'}">
						<c:out value="기업고객"></c:out>
					</c:when>
				
				
					<c:otherwise>
						<c:out value="내부직원"></c:out>
					</c:otherwise>
				</c:choose>		
			</td>
			
			<td>
				<c:choose>
					<c:when test="${list.user_Type == 'C'}">
						<c:out value="${list.client}"></c:out>
					</c:when>
				
					<c:otherwise>
						<c:out value="${list.clientnm}"></c:out>
					</c:otherwise>
				</c:choose>				
			</td>
			
			<td>
				<c:choose>
					<c:when test="${list.user_Type == 'A'}">
						<c:out value="SCM"></c:out>
					</c:when>
				</c:choose>
				
				<c:choose>
					<c:when test="${list.user_Type == 'B'}">
						<c:out value="배송"></c:out>
					</c:when>
				</c:choose>			
				
				<c:choose>
					<c:when test="${list.user_Type == 'D'}">
						<c:out value="구매"></c:out>
					</c:when>
				</c:choose>
				
				<c:choose>
					<c:when test="${list.user_Type == 'E'}">
						<c:out value="임원"></c:out>
					</c:when>
				</c:choose>
				
				<c:choose>
					<c:when test="${list.user_Type == 'C'}">
						<c:out value=""></c:out>
					</c:when>
				</c:choose>
			
			</td>
			
			<td>
				<c:choose>
					<c:when test="${list.user_Type == 'C'}">
						<c:out value="${list.mgrnm}"></c:out>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${list.user_Type != 'C'}">
						<c:out value=""></c:out>
					</c:when>
				</c:choose>
			</td>
			
			<td>${list.phone}</td>

		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="totalCntUserInfo" name="totalCntUserInfo" value="${totalCntUserInfo}" />