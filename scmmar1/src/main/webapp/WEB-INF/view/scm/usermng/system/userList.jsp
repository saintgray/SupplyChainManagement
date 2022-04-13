<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<div id="userListArea">

	
	<div class="bts mt30">
	
		<input type="hidden" value="${page.totalCount}" id="totalCount">
		
	
		<table class="col">
	
			<tbody>
				<thead>
					<tr>
						<th scope="col">아이디</th>
						<th scope="col">구분명</th>
						<th scope="col">회사명/성명</th>
						<th scope="col">담당업무</th>
						<th scope="col">담당자명</th>
						<th scope="col">연락처</th>
					</tr>
				</thead>
			
			
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