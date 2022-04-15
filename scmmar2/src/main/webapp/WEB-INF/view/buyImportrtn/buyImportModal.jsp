<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="buyImportModal" class="layerPop layerType2" style="width: 650px;">
	<dl>
		<dt>
			<strong>발주서 작성</strong>
		</dt>
		
		<dd class="content">
			<table class="col">
				<caption>caption</caption>
				<colgroup>
					<col width="90px">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">발주번호</th>
						<th scope="col">발주회사</th>
						<th scope="col">제품번호</th>
						<th scope="col">제품이름</th>
						<th scope="col">발주수량</th>							
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="inputTxt p100" id="impordno" name="impordno" value="" disabled="disabled"/></td>
						<td><input type="text" class="inputTxt p100" id="client" name="client" value="" disabled="disabled"/></td>
						<td><input type="text" class="inputTxt p100" id="pdmdno" name="pdmdno" value="" disabled="disabled"/></td>
						<td><input type="text" class="inputTxt p100" id="pdmdnm" name="pdmdnm" value="" disabled="disabled"/></td>
						<td><input type="text" class="inputTxt p100" id="impdtcnt" name="impdtcnt" value="" disabled="disabled"/></td>
					</tr>
				</tbody>
			</table>
			<div class="btn_areaC mt30">
				<a href="" class="btnType blue" id="btnOrder2" name="btn"><span>발주요청</span></a>
				<a class="btnType blue" id="btnCancle4" name="btn"><span>취소</span></a>
			</div>
		</dd>
	</dl>
	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>

<script>
function fBtnEvt() {
	$("a[name=btn]").click(function(e) {
		e.preventDefault();
		var btnId = $(this).attr('id');
		switch (btnId) {
		case "btnCancle4" : gfCloseModal();
			break;
		case "btnOrder2" : confirmOrder();
			break;
		}
	});
}

function gfCloseModal() {
	
	$('#mask').hide();
	$('.layerPop').hide();
	$('#wrap_pop .scroll').scrollTop(0);
}
</script>