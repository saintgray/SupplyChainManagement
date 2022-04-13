<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="whListArea" class="bts">

	<input type="text" class="hidden" value="${page.totalCount}" id="totalCount">
	<input type="text" class="hidden" value="${page.selectPage}" id="selectPage">

	<div class="text-right btnMngWareHouseArea">
		<button type="button" class="btn btn-primary" id="btnRegNew">창고 등록</button>
	</div>

	

	<div class="bts mt30">
		<input type="hidden" value="${page.totalCount}" id="totalCount">
		
		<table class="col" id="salesListTable">
			<thead>
				<tr>
					<th class="wh_id" scope="col">창고 코드</th>
					<th scope="col">창고명</th>
					<th scope="col">담당자</th>
					<th scope="col">이메일</th>
					<th scope="col">전화 번호</th>
					<th scope="col">우편번호</th>
					<th scope="col">창고 위치</th>
				</tr>
			</thead>
			<c:if test="${empty page.whList}">
				<tr>
					<td colspan="7" class="text-center">등록된 창고가 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${not empty page.whList}">
				<c:forEach items="${page.whList}" var="w">
					<tr>
						<td class="wh_id">${w.wh_id}</td>
						<td>${w.wh_nm}</td>
						<td>${w.loginID}</td>
						<td>${w.email}</td>
						<td>${w.phone}</td>
						<td>${w.zipCode}</td>
						<td>${w.wh_loc}</td>
					</tr>
				</c:forEach>
			</c:if>
			
		</table>	
	</div>
</div>