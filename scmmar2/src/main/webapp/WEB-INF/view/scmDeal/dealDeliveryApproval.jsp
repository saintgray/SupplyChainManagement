<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="deliveryApproval" class="layerPop layerType2" style="width: 800px;">
	
	<dl>
		<dt>
			<strong>배송지시서 작성</strong>
		</dt>
		
		<dd class="content">
			<div class="slide-wrap" style="width: 740px; overflow: hidden;">
				<div class="slide-container">
					<div class="slide-box">
						<p class="conTitle" style="text-align: center;">
							<span>배송담당직원 선택</span>
						</p>
						<table class="col">
							<caption>caption</caption>
							<colgroup>
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">주문번호</th>
									<th scope="col">고객기업</th>
									<th scope="col">입금여부</th>
									<th scope="col">주문제품</th>
									<th scope="col">주문일자</th>
									<th scope="col">주문수량</th>
									<th scope="col">배송담당</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="text" id="oddtno" name="oddtno" value="" class="inputTxt p100" readonly/></td>
									<td><input type="text" id="client" name="client" value="" class="inputTxt p100" readonly/></td>
									<td><input type="text" id="orderpayynStr" name="orderpayynStr" value="" class="inputTxt p100" readonly/></td>
									<td><input type="text" id="pdmdnm" name="pdmdnm" value="" class="inputTxt p100" readonly/></td>
									<td><input type="text" id="orderdate" name="orderdate" value="" class="inputTxt p100" readonly/></td>
									<td><input type="text" id="oddtcnt" name="oddtcnt" value="" class="inputTxt p100" readonly/></td>
									<td>
										<select id="employeeList" name="employeeList" style="width:84px">
											<c:forEach items="${employees }" var="employee">
												<option value="${employee.loginID}">${employee.loginID }</option>
											</c:forEach>
										</select>									
									</td>
								</tr>
							</tbody>
						</table>
						<span class="chkStrMsg"></span>
						<div class="btn_areaC mt30">
							<!-- <a class="btnType blue" name="btn"><span>저장</span></a> -->
							<a class="btnType blue btnMove" id="btnNext"><span>다음</span></a>
						</div>
					</div><!--// .slide-box  -->
					<div class = "slide-box">
						<p class="conTitle" style="text-align: center">
							<span>창고별 출고 선택</span>
						</p>
						<table class="col">
							<caption>caption</caption>
							<colgroup>
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="80px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">창고명</th>
									<th scope="col">취급품목</th>
									<th scope="col">재고수량</th>
									<th scope="col">출고수량</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody id="deliverInfoTbody">
								<tr class="tr">
									<td>
										<select class="warehouses" name="warehouse" style="width:150px">
											<c:forEach items="${warehouses }" var="wh">
												<option value="${wh.whcode }">${wh.whnm }</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<select class="productnm" name="pdmdno" style="width:150px"></select>
									</td>
									<td>
										<input type="text" name="stCntforModal" class="inputTxt p100 stCntforModal" value="" readonly />
									</td>
									<td><input type="text" name="oddtdelcnt" class="inputTxt p100 checkNum" maxlength="6" value="" /></td>
									<td>
										<a class="addTr"><span>추가</span></a>
									</td>
								</tr>							
							</tbody>
						</table>
						<span class="chkStrMsg"></span>
						<div class="btn_areaC mt30">
							<a class="btnType blue btnMove" id="btnPrev"><span>이전</span></a>
							<a href="javascript:fDeliverySubmit()" class="btnType blue" id="btnDelAppr"><span>배송지시</span></a>
							<a href="" class="btnType blue" id="btnCancle"><span>닫기</span></a>
						</div>
					</div><!--// .slide-box -->
				</div><!--// .slide-container -->
			</div><!--// .slide-wrap -->
		</dd>
	</dl>
	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>