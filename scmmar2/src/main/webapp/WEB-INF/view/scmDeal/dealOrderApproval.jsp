<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="orderApproval" class="layerPop layerType2" style="width: 550px;">
	<dl>
		<dt>
			<strong>발주지시서 작성</strong>
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
						<th scope="col">납품회사</th>
						<th scope="col">제품번호</th>
						<th scope="col">발주제품명</th>
						<th scope="col">발주단가</th>
						<th scope="col">발주수량</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<select id="comList" name="comList" style="width:84px">
								<c:forEach items="${comList }" var="com">
									<option value="${com.compId}">${com.compNm }</option>
								</c:forEach>
							</select>
						</td>
						<td><input type="text" class="inputTxt p100" id="orderPdno" name="orderPdno" value="" disabled="disabled"/></td>
						<td><input type="text" class="inputTxt p100" id="orderPdnm" name="orderPdnm" value="" disabled="disabled"/></td>
						<td><input type="text" class="inputTxt p100 chk" id="pdmdprice" name="pdmdprice" value="" disabled="disabled" /></td>
						<td><input type="text" class="inputTxt p100 chk" id="impdtcnt" name="impdtcnt" value="" maxlength='3'/></td>
					</tr>
				</tbody>
			</table>
			<span class="chkStrValid"></span>
			<div class="btn_areaC mt30">
				<a href="javascript:fSaveImport()" class="btnType blue" id="btnOderAppr" name="btnOderAppr"><span>전송</span></a>
				<a href="" class="btnType blue" id="btnRedo" name="btn"><span>취소</span></a>
			</div>
		</dd>
	</dl>
	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>