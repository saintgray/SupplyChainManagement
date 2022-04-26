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
			<tbody v-if='salesList.length==0'>
				<tr>
					<td rowspan="6" class="text-right">상품이 없습니다</td>
				</tr>
			</tbody>
			<tbody v-for='(items,index) in salesList' v-else>
				<tr @click='getinfo(item.sales_id,"INFO")'>
							<td>${item.model_code}</td>
							<td>${item.model_nm}</td>
							<td>${item.sales_id}</td>
							<td>${item.sales_nm}</td>
							<td>${item.mfcomp}</td>
							<td>
								<fmt:formatNumber type="currency">${item.price}</fmt:formatNumber>
							</td>
				</tr>
			</tbody>
			
		</table>	
	</div>
</div>