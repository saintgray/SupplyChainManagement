<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<td id="detail" colspan="5">
	<div id="detailArea">
		<table class="col">
			<thead>
				<tr>
					<th scope="col">분류</th>
					<th scope="col">상품명</th>
					<th scope="col">재고량</th>
				</tr>
			</thead>
			<c:forEach items="${detail}" var="sales">
				<tr>
					<td>${sales.sales_type}</td>
					<td>${sales.sales_nm}</td>
					<td>${sales.st_cnt}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</td>