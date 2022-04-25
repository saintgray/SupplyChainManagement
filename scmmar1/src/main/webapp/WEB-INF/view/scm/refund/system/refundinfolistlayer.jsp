<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
		<form id="refdata" action="">
		<dl >
			<dt class="mt30" style="text-align:center;">
				<strong>반품 신청 내역</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row" style="margin:0 auto;">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<c:if test="${empty onereinfo.returnDir.returnId}">
							<col width="*">
						</c:if>
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">반품 제품명<span class="font_red"></span></th>
							<td><input name="sales_nm" value='${onereinfo.purchaseInfo.sales.salesName}' readonly style="border: none;"></td>
						</tr>
						<tr>
							<th scope="row">반품 신청 날짜<span class="font_red"></span></th>
							<td ><input name="wanted_date" value='${onereinfo.regDate}' readonly style="border: none;"></td>
						</tr>
						<tr>
							<th scope="row">반품 수량<span class="font_red"></span></th>
						<td ><input name="return_cnt" value='${onereinfo.returnCnt}' readonly style="border: none;"></td>
						</tr>
						<tr>
							<th scope="row">예금주<span class="font_red"></span></th>
						<td ><input name="ac-name" value='${onereinfo.accountHolder}' readonly style="border: none;"></td>
						</tr>
						<tr>
							<th scope="row">계좌번호<span class="font_red"></span></th>
						<td ><input name="ac-num" value='${onereinfo.accountNumber}'readonly style="border: none;"></td>
						</tr>
						<c:if test="${not empty onereinfo.returnDir.returnId}">
							<tr>
								<th scope="row">승인여부
								</th>
								<td>
									<c:if test="${onereinfo.returnDir.confirmYN eq 'Y'}">
										<span style="color:green">승인</span>
									</c:if>
									<c:if test="${empty onereinfo.returnDir.confirmYN}">
										<span style="color:grey">미승인</span>
									</c:if>
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<div class="btn_areaC mt30 bts">
					
				    <input type="hidden" id="idx" 
				    		
				    		value='<c:if test="${empty onereinfo.returnDir.returnId}">${onereinfo.refundInfoId}</c:if>
				    		<c:if test="${not empty onereinfo.returnDir.returnId}">${onereinfo.returnDir.returnId}</c:if>'>
				    <c:choose>
				    	<c:when test="${empty onereinfo.returnDir}">
				    		<input type="button" value="반품지시서 작성" id="writeReturnDir" class="btn btn-primary dirBtn">
				    	</c:when>
				    	<c:when test="${not empty onereinfo.returnDir.returnId}">
				    		<input type="button" value="배송지시서 작성" id="writeDelivDir" class="btn btn-primary dirBtn">
				    	</c:when>
				    </c:choose>
				</div>
			</dd>
		</dl>
		</form>
		
