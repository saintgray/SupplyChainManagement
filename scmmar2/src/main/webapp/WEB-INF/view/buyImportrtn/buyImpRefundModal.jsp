<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="buyImpRefundModal" class="layerPop layerType2" style="width: 650px;">
	<dl>
		<dt>
			<strong>반품지시서 작성</strong>
		</dt>
		
		<dd class="content">
			<table class="col">
				<caption>caption</caption>
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">반품회사</th>
						<th scope="col">제품번호</th>
						<th scope="col">제품이름</th>
						<th scope="col">반품수량</th>							
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<input type="hidden" name="rtnio"/><!-- 일련번호 -->
							<input type="hidden" name="brtrtio"/><!-- 주문번호 -->
							<input type="hidden" name="pdmdno"/>
							<input type="hidden" name="pdcode"/>
							<input type="hidden" name="comp_id"/>
							<input type="hidden" name="pdmdprice"/>
							<input type="text" class="inputTxt p100" id="rclient" name="rclient" value="" disabled="disabled"/>
						</td>
						<td><input type="text" class="inputTxt p100" id="rpdmdno" name="rpdmdno" value="" disabled="disabled"/></td>
						<td><input type="text" class="inputTxt p100" id="rpdmdnm" name="rpdmdnm" value="" disabled="disabled"/></td>
						<td><input type="text" class="inputTxt p100" id="brtncnt" name="brtncnt" value="" disabled="disabled"/></td>
					</tr>
				</tbody>
			</table>
			<div class="btn_areaC mt30">
				<a onclick="fReturnInsert(this)" class="btnType blue" id="btnReturn"><span>회수·반품</span></a>
				<a href="" class="btnType blue" id="btnRtRedo" name="btn"><span>취소</span></a>
			</div>
		</dd>
	</dl>
	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>