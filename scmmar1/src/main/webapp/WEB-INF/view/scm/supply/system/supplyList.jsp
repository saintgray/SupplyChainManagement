<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div id="supplyListArea" class="bts">

	

	<div class="bts mt30">
		<input type="hidden" value="${page.totalCount}" id="totalCount">
		
		<table class="col" id="supplyListTable">
			<thead>
				<tr>
					<th scope="col">업체코드</th>
					<th scope="col">납품업체명</th>
					<th scope="col">아이디</th>
					<th scope="col">패스워드</th>
					<th scope="col">담당자명</th>
					<th scope="col">연락처</th>
					
				</tr>
			</thead>
			
			<c:if test="${empty page.suppliers}">
				<tr>
					<td colspan="6" class="text-center">납품회사 정보가 업습니다</td>
				</tr>
			</c:if>
			<c:if test="${not empty page.suppliers}">
				<c:forEach items="${page.suppliers}" var="s">
					<tr>
						<td class="comp_id">${s.comp_id}</td>
						<td>${s.comp_nm}</td>
						<td>${s.loginID}</td>
						<td>${s.password}</td>
						<td>${s.name}</td>
						<td>${s.phone}</td>
						
					</tr>
				</c:forEach>
			</c:if>
			
		</table>	
	</div>
</div>