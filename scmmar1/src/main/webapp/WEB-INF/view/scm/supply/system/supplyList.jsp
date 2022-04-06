<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div id="supplyListArea" class="bts">

	

	<div class="bts mt30">
		<input type="hidden" value="${page.totalCount}" id="totalCount">
		
		<table class="row" id="supplyListTable">
			<tr>
				<td>업체코드</td>
				<td>납품업체명</td>
				<td>아이디</td>
				<td>패스워드</td>
				<td>담당자명</td>
				<td>연락처</td>
				
			</tr>
			
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