<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<div id="userListArea">

	
	<div class="bts mt30">
	
		<input type="hidden" value="${page.totalCount}" id="totalCount">
		
	
		<table class="row">
	
			<tbody>
			
			<tr>
				<td>아이디</td>
				<td>구분명</td>
				<td>회사명/성명</td>
				<td>담당업무</td>
				<td>담당자명</td>
				<td>연락처</td>
			</tr>
			
			
			<c:forEach items="${page.userlist}" var="user">
			
			
			
				
			<tr>
				<td><span class="userID">${user.loginID}</span></td>
				<td>
					<span>
						<c:if test="${user.user_Type eq 'C'}">
							기업고객
						</c:if>
						<c:if test="${user.user_Type ne 'C'}">
							내부직원
						</c:if>
					</span>
				</td>
				<td>
					<span>
						<c:if test="${user.user_Type eq 'C'}">
							${user.client}
						</c:if>
						<c:if test="${user.user_Type ne 'C'}">
							${user.name}
						</c:if>
					</span>
				</td>
				<td>
					<span>
						<c:choose>
							<c:when test="${user.user_Type eq 'A'}">
								SCM관리자
							</c:when>
							<c:when test="${user.user_Type eq 'B'}">
								배송담당자
							</c:when>
							<c:when test="${user.user_Type eq 'D'}">
								구매담당자
							</c:when>
							<c:when test="${user.user_Type eq 'E'}">
								임원
							</c:when>
							
						</c:choose>
					</span>
				</td>
				<td>
					<span>
						<c:if test="${user.user_Type eq 'C'}">
							${user.name}
						</c:if>
					</span>
				</td>
				<td><span>${user.phone}</span></td>
				
			</tr>
			
			</c:forEach>
	
			</tbody>
		</table>
	</div>

</div>