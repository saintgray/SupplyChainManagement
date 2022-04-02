<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div id="salesListArea" class="bts">

	

	<div class="bts mt30">
		<input type="hidden" value="${page.totalCount}" id="totalCount">
		
		<table class="row" id="salesListTable">
			<tr>
				<td>모델 번호</td>
				<td>모델명</td>
				<td>제품번호</td>
				<td>제품명</td>
				<td>제조사</td>
				<td>판매가</td>
			</tr>
			
			<c:if test="${empty page.salesList}">
				<tr>
					<td rowspan="6" class="text-right">상품이 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${not empty page.salesList}">
				<c:forEach items="${page.salesList}" var="s">
					<tr>
						<td>${s.model_code}</td>
						<td>${s.model_nm}</td>
						<td>${s.sales_id}</td>
						<td>${s.sales_nm}</td>
						<td>${s.mfcomp}</td>
						<td>${s.price}</td>
					</tr>
				</c:forEach>
			</c:if>
			
		</table>	
	</div>
</div>