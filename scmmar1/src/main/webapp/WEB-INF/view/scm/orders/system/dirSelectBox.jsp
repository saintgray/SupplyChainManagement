<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					



<div id="v-orderAndReturn" class="bts">
	<!-- list 가 담은 정보 : 해당 주문 및 반품 정보에 있는 상품 번호와 상품이름 정보 -->
	<c:forEach items="${listOfSalesInfoList}" var="siList" varStatus="state">
		<div class="text-left">
			
			<div>
				<c:forEach items="${siList}" var="ele" varStatus="instate">
					<c:if test="${instate.index == 0}">
						<input type="hidden" value="${ele}">
					</c:if>
					<c:if test="${instate.index == 1}">
						<strong style="padding-right:20px;">${ele}</strong>
					</c:if>
				</c:forEach>
				<img src="/images/treeview/minus.gif" class="remove">
			</div>
			<select id="sb${state.index}" class="sb form-control">
			</select>
		</div>
	</c:forEach>
	
	<div class="btn_areaC mt30">
		<input type="hidden" name="action" id="action" value="">
		<button type="button" class="btn btn-primary" id="writeDir">작성</button>
		<button type="button" class="btn" onclick="closemodel()">취소</button> 
				
	</div>
</div>
	
