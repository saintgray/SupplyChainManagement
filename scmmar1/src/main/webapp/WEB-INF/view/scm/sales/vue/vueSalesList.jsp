<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div id="salesListArea" class="bts">
	
	<div class="bts mt10">
		<div class="salesMngBtnArea text-right">
			<button type="button" class="btn btn-primary" id="btnNewSales" @click='getInfo("NEW")'>제품 등록</button>
		</div>
	</div>
	

	<div class="bts mt30">
	
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
			<tbody v-if='salesList==null || salesList.length==0'>
				<tr>
					<td colspan="6" class="text-center">일치하는 상품이 없습니다</td>
				</tr>
			</tbody>
			<tbody v-for='(item,index) in salesList' v-else>
					<tr @click='getInfo("INFO",item.sales_id)'>
							<td>{{item.model_code}}</td>
							<td>{{item.model_nm}}</td>
							<td>{{item.sales_id}}</td>
							<td>{{item.sales_nm}}</td>
							<td>{{item.mfcomp}}</td>
							<td>{{item.price}}</td>
					</tr>
			</tbody>
			
		</table>	
	</div>
</div>