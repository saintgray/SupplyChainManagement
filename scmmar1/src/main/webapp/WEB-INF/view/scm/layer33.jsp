<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   

		<dl>
			<dt>
				<strong>배송지시서 작성</strong>
			</dt>
			<dd class="content">
				<div style="text-align: left; font-size: 15px; font-weight: bold;">주문정보</div> <br>
				<table class="row">
					<caption>caption</caption>
					<tbody>
						<tr>
							<th style="text-align: center;">주문번호</th>
							<th style="text-align: center;">주문일자</th>
							<th style="text-align: center;">고객기업명</th>
							<th style="text-align: center;">제품명</th>
							<th style="text-align: center;">주문개수</th>
							<th style="text-align: center;">입금여부</th>
						</tr>
						<tr>
							<td style="text-align: center;">${onedata.pur_id }</td>
							<td style="text-align: center;">${onedata.purdate }</td>
							<td style="text-align: center;">${onedata.name }</td>
							<td style="text-align: center;">${onedata.sales_nm }</td>
							<td style="text-align: center;">${onedata.pur_cnt}</td>
						<c:choose>
							<c:when test='${onedata.depositYN eq "Y"}'>
								<td style="text-align: center;">완료</td>
							</c:when>
							<c:otherwise>
								<td style="text-align: center;">미 입금</td>
							</c:otherwise>
						</c:choose>
							
							
						</tr>
					</tbody>
				</table>
				
				<br><br>
				
				
				<div style="text-align: left; font-size: 15px; font-weight: bold;">배송정보 입력</div> 
				<div style="text-align: right;">
					<!-- <a class="btnType blue" id="addrow" name="btn" onclick="addrow()"><span style="cursor: pointer;">행 추가</span></a> --> 
				</div>
					<table class="row">
					<caption>caption</caption>
						<tbody>
							<tr>
								<th>창고별 품목</th>
								<th>총 재고</th>
								<th>주문 개수 입력</th>
								<!-- <th>배송담당자</th> -->
							</tr>
							
							<tr>
					<c:choose>
						<c:when test='${comfp eq "Y" }'>
							<td colspan="3" style="text-align: center;">배송 신청 완료 된 제품 입니다.</td>
						</c:when>
						<c:otherwise>
								<td style="text-align: center;">
									<select id="wasel" onchange="whcnt(this.value)">
											<option value ="" selected="selected" disabled >::창고를 선택해 주세요::</option>
										<c:forEach items="${warehouse}" var="list">
											<option value="${list.wh_id }">${list.wh_nm }</option>
										</c:forEach>
									</select>
								</td>
								
								<td style="text-align: center;">
									<div id="warehcnt">0</div>
								</td>
								<td style="text-align: center;">${onedata.pur_cnt}</td>
								
								
								<!-- 배송담당자 지정 
								<td style="text-align: center;">
									<select id="purchaser"></select>
								</td> -->
								
								<!-- <td style="text-align: center">
									<input type="number" id="warehinput" name="warehinput" onkeyup="t()" min="0">
								</td> -->
						</c:otherwise>
					</c:choose>
							</tr>
							
						</tbody>
					</table>
					

				<div class="btn_areaC mt30">
				    <!-- <input type="hidden" name="Action" id="Action" value="wa"> -->
				 <c:choose>
					<c:when test='${comfp eq "N" }'>
						<a class="btnType blue" id="savesa" name="btn" ><span onclick="send('wa')" style="cursor: pointer;">작성</span></a>
					</c:when>
				</c:choose> 
					<a	class="btnType gray"  id="btnClosewa" name="btn"><span onclick="closemodel()" style="cursor: pointer;">취소</span></a>
				</div>
			</dd>
		</dl>
		
		
