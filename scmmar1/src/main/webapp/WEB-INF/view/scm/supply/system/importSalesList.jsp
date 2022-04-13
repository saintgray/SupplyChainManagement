<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="impSalesListArea" class="bts">
<fmt:setLocale value="ko_KR"/>
	

	<div class="bts mt30">
		
		<table class="col" id="impSalesListTable">
			<thead>
				
				<tr>
					<th scope="col">제품번호</th>
					<th scope="col">제품명</th>
					<th scope="col">납품단가</th>
				</tr>
				
			</thead>
			
			<c:if test="${empty impSales}">
				<tr>
					<td colspan="3" class="text-center">납품 상품이 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${not empty impSales}">
				<c:forEach items="${impSales}" var="s">
					<tr>
						<td>${s.sales_id}</td>
						<td>${s.sales_nm}</td>
						<td>
							<fmt:formatNumber type="currency">
								${s.unitprice}	
							</fmt:formatNumber>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			
		</table>	
	</div>
</div>