<%@ page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- warehouse list key = whList -->
<div id="v-warehouse">
	<!--  test print -->
	<c:forEach items="${list}" var="map">
		<div>
			<div class="text-left">
				<strong>${map.key}</strong>
			</div>
				<table class="col">
					<thead>
						<tr>
							<th scope="col">선택</th>
							<th scope="col">창고</th>
							<th scope="col">총 재고</th>
							<th scope="col">출고예정</th>
							<th scope="col">유효재고</th>
						</tr>
					</thead>
				
				
					<c:forEach items="${map.value}" var="info">
						<tr>
							<td><input type="checkbox" class="shippingTarget" value='${info.wh_id},${info.sales_id}'></td>
							<td>${info.wh_nm}</td>
							<td>${info.st_cnt}</td>
							<td>${info.export_cnt}</td>
							<td>${info.valid_cnt}</td>
						</tr>
					</c:forEach>
				</table>
		</div>
	</c:forEach>
	
		<div class="btn_areaC mt30">
			<input type="hidden" name="action" id="action" value="">
			<button type="button" class="btn btn-primary" id="writeBtn">작성</button> 
			<button type="button" class="btn" id="btnClose" onclick="closemodel()">취소</button>
		</div>
	
</div>
