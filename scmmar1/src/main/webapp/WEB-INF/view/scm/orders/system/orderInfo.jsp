<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<dl>
	<dt>
		<strong>구매 내역</strong>
	</dt>
	<dd class="content">
	
		
		
		<table class="col" id="orderinfo">
			<thead>
				<tr>
					<th scope="col">상세번호</th>
					<th scope="col">상품명</th>
					<th scope="col">주문개수</th>
					<th scope="col">총 금액</th>
				</tr>
			</thead>
			
				<c:if test="${not empty infoList}">
				
				
					<c:forEach items="${infoList}" var="item">
					
					<tr>
						<td class="targetIdx">${item.purinf_id}</td>
						<td>${item.sales_nm}</td>
						<td>${item.pur_cnt}</td>
						<td>
							<fmt:formatNumber type="currency"  value="${item.price_sum}"/>
						</td>
					</tr>
					
					</c:forEach>
					
			</c:if>
			
			<c:if test="${empty infoList}">
				<td colspan="4">주문내역이 비었습니다 오류인 것 같습니다</td>
			</c:if>
				
		</table>
		
		<div id="dirRadioArea" class="mt10">  
		
			
			<div>
				<input type="radio" name="sel" id="shippingDir" value='${pur_id}'/>
				<span id="sel5">배송지시서</span>
			</div>
			<div>
				<input type="radio" name="sel" id="orderDir" value='${pur_id}'/>
				<span id="sel6">발주지시서</span>
			</div>
	
		</div>
		
		<!-- 지시서 작성을 위한 area -->
		<div id="dirArea">
		</div>
		
	</dd>
</dl>