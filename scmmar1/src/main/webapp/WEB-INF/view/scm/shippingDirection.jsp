<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<title>일별수주내역</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<script type="text/javascript">
var pageSize = 10;
var pageBlockSize = 10;


// onload list 및 검색조건 함수 불러오기
$(function(){
	
	init();
	
});

function init(currentPage){
	
	currentPage = currentPage || 1;
	
	var param = {	
			currentPage : currentPage
		,	pageSize : pageSize	
	}
	var resultCallback = function(data){
		
		$("#dlist").empty().append(data);
		var total = $("#total").val();
		
		var paginationHtml = getPaginationHtml(currentPage, total,  pageSize, pageBlockSize, 'init');
		console.log("paginationHtml : " + paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml ); 
	}
	
	callAjax("/scm/listshippingDirection.do", "post", "text", true, param, resultCallback);
}
	
function ship(a){
	
	var param = {
			deliv_id : a	// 주문번호
		}
	var resultCallback = function(data){
		
		if(data.msg){
			alert(data.msg);
		}else{
			var today = data.onesip.regdate;
			var date = today.substring(0,10);
			$("#regdate").val(date);
			$("#client").val(data.onesip.client);
			$("#sales_nm").val(data.onesip.sales_nm);
			$("#pur_cnt").val(data.onesip.pur_cnt);
			var YN = (data.onesip.depositYN =='Y' ? "입금완료" : "입금대기");
			$("#depositYN").val(YN);
			gfModalPop("#layer1");
		}
	}
	callAjax("/scm/oneshippingDirection.do", "post", "json", true, param, resultCallback);
}
	
function closemodel(){
	gfCloseModal();
}	
	
	
</script>

<style type="text/css">
	
	input[type=text]{
		border: none;
		text-align: center;
	}
</style>

</head>
<body>
<form id="myForm" action=""  method="">
    <input type="hidden" name="selfrpcd" id="selfrpcd" value="">
    <input type="hidden" name="selfrpnm" id="selfrpnm" value="">
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">Sample</span> <span class="btn_nav bold">배송 지시서</span> 
								<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>배송 지시서</span> 
    
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="25%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">주문 번호</th>
										<th scope="col">주문일자</th>
										<th scope="col">고객기업명</th>
										<th scope="col">주문개수</th>
									</tr>
								</thead>
								<tbody id="dlist"></tbody>
							</table>
							<div class="paging_area"  id="comnGrpCodPagination"> </div>
						</div>
	
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: auto;">

		<dl>
			<dt>
				<strong>배송 지시서</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					
					<tbody>
						<tr>
							<th >주문일자</th>
							<th >고객기업명</th>
							<th >제품명</th>
							<th >주문개수</th>
							<th >입금여부</th>
						</tr>
						<tr>
							<td><input type="text" id="regdate" name="sales_id" readonly="readonly"></td>
							<td><input type="text" id="client" readonly="readonly"></td>
							<td><input type="text" id="sales_nm" readonly="readonly"></td>
							<td><input type="text" id="pur_cnt" readonly="readonly"></td>
							<td><input type="text" id="depositYN" readonly="readonly"></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_areaC mt30">
					<a class="btnType gray"  id="btnCloseGrpCod" name="btn"><span onclick="closemodel()" style="cursor: pointer;">취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	
</form>
</body>
</html>
