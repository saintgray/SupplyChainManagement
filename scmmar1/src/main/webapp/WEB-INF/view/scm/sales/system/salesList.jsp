<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div id="salesListArea" class="bts">
	<fmt:setLocale value="ko-KR"/>
	

	<div class="bts mt30">
		<input type="hidden" value="${page.totalCount}" id="totalCount">
		
		<table class="col" id="salesListTable">
			<thead>
				<tr>
					<th scope="col">모델 번호</th>
					<th scope="col">모델명</th>
					<th scope="col">제품번호</th>
					<th scope="col">제품명</th>
					<th scope="col">제조사</th>
					<th scope="col">판매가</th>
				</tr>
			</thead>
			
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
						<td class="sales_id">${s.sales_id}</td>
						<td>${s.sales_nm}</td>
						<td>${s.mfcomp}</td>
						<td>
							<fmt:formatNumber type="currency">${s.price}</fmt:formatNumber>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			
		</table>	
	</div>
</div>