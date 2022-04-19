<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<dl>
	<dt>
		<strong>구매 내역</strong>
	</dt>
	<dd class="content">
		
		
		<table class="col">
			<thead>
				<tr>
					<th scope="col">상세번호</th>
					<th scope="col">상품명</th>
					<th scope="col">주문개수</th>
					<c:if test="${flagReturnYN eq 'Y'}">
						<th scope="col">반품요청</th>
						<th scope="col">반품갯수</th>
						<th scope="col">임원승인</th>
					</c:if>
					<th scope="col">총 금액</th>
				</tr>
			</thead>
				<c:forEach items="${infoList}" var="item">
				
				<tr>
					<td>${item.purinf_id}</td>
					<td>${item.sales_nm}</td>
					<td>${item.pur_cnt}</td>
					<c:if test="${flagReturnYN eq 'Y'}">
						<td>
							<c:if test="${not empty item.returnYN}">
								반품요청
							</c:if>
							<c:if test="${empty item.returnYN}">
								-
							</c:if>
						</td>
						<td>
							<c:if test="${not empty item.returnYN}">
								${item.return_cnt}
							</c:if>
							<c:if test="${empty item.returnYN}">
								-
							</c:if>
						</td>
						<td>
							<c:if test="${empty item.confirmYN}"><strong>미승인</strong></c:if>
							<c:if test="${item.confirmYN eq 'Y'}"><strong style="color:blue;">승인</strong></c:if>
							<c:if test="${item.confirmYN eq 'N'}"><strong style="color:red;">반려</strong></c:if>
						</td>
					</c:if>
					<td>
						<fmt:formatNumber type="currency"  value="${item.price_sum}"/>
					</td>
				</tr>
				
				</c:forEach>
			
		</table>
		
		<div id="dirBtnArea" class="mt10">
		
			<!-- 주문했고 배송을 시작하지 않았을 때만(반품 플래그가 없을 때) 배송 지시서 작성 가능 -->
			<c:if test="${depositYN eq 'Y' && flagReturnYN eq 'N'}">
				<div>
					<input type="radio" name="sel" id="sel2" value="2" style="cursor: pointer;"/><span id="sel5">배송지시서</span>
				</div>
			</c:if>
			
			<!-- 주문했고 배송완료됐는데 반품을 하는 경우만 반품 지시서 작성 가능 -->
			<c:if test="${depositYN eq 'Y' && flagReturnYN eq 'Y'}">
				<div>
					<input type="radio" name="sel" id="sel1" value='1' style="cursor: pointer;"/><span id="sel4">반품지시서</span>
				</div>
			</c:if>
			
			<!-- 주문했고 배송완료됐고 반품하는 경우에는 발주지시서를 작성할 필요가 없음 -->
			<c:if test="${!(depositYN eq 'Y' && flagReturnYN eq 'Y')}">
				<div>
					<input type="radio" name="sel" id="sel3" value="3" style="cursor: pointer;"/><span id="sel6">발주지시서</span>
				</div>
			</c:if>
		</div>
		
		<div class="btn_areaC mt30">
			<input type="hidden" name="Action" id="Action" value="">
			<a class="btnType blue" id="btnSaveGrpCod" name="btn" onclick="layer1btn()"><span style="cursor: pointer;">작성</span></a> 
			<a	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span onclick="closemodel()" style="cursor: pointer;">취소</span></a>
		</div>
		
		<!-- 지시서 작성을 위한 area -->
		<div id="dirArea">
		</div>
		
	</dd>
</dl>