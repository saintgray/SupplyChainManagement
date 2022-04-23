<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
		<form id="refdata" action="">
		<dl >
			<dt>
				<strong>반품 지시서</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">반품 제품명<span class="font_red"></span></th>
							<td><input name="sales_nm" value='${onereinfo.sales_nm}' readonly style="border: none;"></td>
						</tr>
						<tr>
							<th scope="row">반품 신청 날짜<span class="font_red"></span></th>
							<td ><input name="wanted_date" value='${onereinfo.wanted_date }'readonly style="border: none;"></td>
						</tr>
						<tr>
							<th scope="row">반품 수량<span class="font_red"></span></th>
						<td ><input name="return_cnt" value='${onereinfo.return_cnt }'readonly style="border: none;"></td>
						</tr>
						<tr>
							<th scope="row">반품 금액<span class="font_red"></span></th>
							<td ><input name="avg" value='${onereinfo.avg }'readonly style="border: none;"></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_areaC mt30">
				    <input type="hidden" name="Action" id="Action" value="">
				    <input type="hidden" name="return_id"value='${onereinfo.return_id }'>
				    <c:choose>
				    	<c:when test="${onereinfo.confirm_requestYN !='1' }">
							<a class="btnType blue" id="btnSaveGrpCod" name="btn" onclick="com()"><span style="cursor: pointer;">승인요청</span></a> 
				    	</c:when>
				    </c:choose>
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
					
				</div>
			</dd>
		</dl>
		</form>
		
