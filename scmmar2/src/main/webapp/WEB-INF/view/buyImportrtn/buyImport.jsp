<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>구매담당자 | 발주 지시서 목록</title>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
	<style>
		/* input[name=date].datetype, textarea.autosize는 datepicker CSS */
		input[name=date].calendar {
			/* padding:4px 2px 5px 25px; */
			border:1px solid #CACACA;
		    font-size:11px; 
		    color:#666; 
		    background:url('http://cfile23.uf.tistory.com/image/26100D4F5864C76827F535') no-repeat 5px 6.75px; 
		    background-size:15px;
	   	}   
		textarea.autosize { min-height: 50px; }
		input {
			text-align: center;
		}
		.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:first-child a { color: red; }
		.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:last-child a { color: blue; }
		.ui-widget-header {
			border: 1px solid #ddd;
			background: #eee;
		}
	</style>
<script>

	var pageSize = 5;
	var pageBlock = 5;

	$(function() {
		fBtnEvt();
		datePicker();
		getList();
	});
	
	function fBtnEvt() {
		$("a[name=btn]").click(function(e) {
			e.preventDefault();
			var btnId = $(this).attr('id');
			switch (btnId) {
			case "btnCancle444" : gfCloseModal();
				break;
			case "btnOrder2" : confirmOrder();
				break;
			}
		});
	}
	
	function datePicker() {
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$( "#startDate" ).datepicker({
 	        changeMonth: true, 
 	        changeYear: true,
 	        nextText: '다음 달',
 	        prevText: '이전 달', 
 	        dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
 	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
 	        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
 	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
 	        showAnim: "slideDown",
 	        dateFormat: "yy-mm-dd",
 	        maxDate: 0,
 	        onClose: function( selectedDate ) {
 	           $("#endDate").datepicker( "option", "minDate", selectedDate );
 	        }
 	    });
		$( "#endDate" ).datepicker({
	        changeMonth: true, 
	        changeYear: true,
	        nextText: '다음 달',
	        prevText: '이전 달', 
	        dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        showAnim: "slideDown",
	        dateFormat: "yy-mm-dd",
	        maxDate: 0,
	        onClose: function( selectedDate ) {
	            $("#startDate").datepicker( "option", "maxDate", selectedDate );
	        }
	    });
		$("#startDate").datepicker('setDate', '-1M');
 	    $("#endDate").datepicker('setDate', 'today');
	}
	
	function getList(currentPage) {
		currentPage = currentPage || 1;
		var param = { currentPage : currentPage
					, pageSize : pageSize
					, searchType : $("#searchType").val()
					, searchWord : $("#searchWord").val()
					, startDate : $("#startDate").val()
					, endDate : $("#endDate").val() }
		var callback = function(data) { getListRslt(data, currentPage) }
		callAjax("/buyImport/buyImportList.do", "post", "text", true, param, callback);
	}
	
	function getListRslt(data, currentPage) {		
		$("#listBuyOrder").empty().append(data);
		var pageination = getPaginationHtml(currentPage, $("#itemsTotal").val(), pageSize, pageBlock, 'getList');
		$("#buyOrderPagination").empty().append(pageination);
		$("#setCurrentPage").val(currentPage); //짜증나게한다 진짜로?
	}
	
	function getOneModal(orderno) {		
		if (isNaN(orderno)) {
			swal("임원승인과 입금완료인 건에 대해서만 반품이 가능합니다.");
			return;
		};		
		if (isNaN(orderno) == false) {
			console.log("발주번호 : " + orderno);
			var param = { impordno : orderno }
			callAjax("/buyImport/buyImportOne.do", "post", "json", true, param, getOneModalRslt);
		};
	}
	
	function getOneModalRslt(data) {
		
		
		$("#rclient").val(data.item.client);
		$("#rpdmdno").val(data.item.pdno);
		$("#rpdmdnm").val(data.item.pdnm);
		$("#brtncnt").val(data.item.impdtcnt);
		
		$("[name = rtnio]").val(data.item.impno);
		$("[name = brtrtio]").val(data.item.impordno);
		$("[name = pdmdno]").val(data.item.pdmdno);
		$("[name = pdcode]").val(data.item.pdcode);
		$("[name = comp_id]").val(data.item.comp_id);
		$("[name = pdmdprice]").val(data.item.pdmdprice);
		
		gfModalPop("#buyImpRefundModal");
	}
	
	function confirmOrder() {
		var chkOrder = confirm("발주 요청을 하시겠습니까?");
		if (chkOrder) {
			alert("발주 요청을 완료하였습니다.");
			gfCloseModal();
		} else {
			alert("발주를 취소하였습니다.");			
		}
	}
	
	//입금여부 업데이트
	function fUpdatePayY(no) {
		var resultCallback = function(data){
			updatePayYResult(data);
		}
		var param = {impno:no};
		callAjax("/buyImport/updatePayY.do", "post", "json", true, param, resultCallback);
	}
	//입금여부 업데이트 콜백
	function updatePayYResult(data) {
		swal(data.resultMsg);
		gfCloseModal();
		getList();
	}
	
	//반품업데이트
	function fReturnInsert(e) {
		
		var info = $(e).parent().prev();
		
		
		var param = {
				rtnio: info.find("[name = rtnio]").val(),
				brtrtio: info.find("[name = brtrtio]").val(),
				pdmdno: info.find("[name = pdmdno]").val(),
				pdcode: info.find("[name = pdcode]").val(),
				pdno: info.find("[name = rpdmdno]").val(),
				comp_id: info.find("[name = comp_id]").val(),
				brtncnt: info.find("[name = brtncnt]").val(),
				brtnprice: Number(info.find("[name = pdmdprice]").val()) * Number(info.find("[name = brtncnt]").val())
		}
		
		var resultCallback = function(data){
			fReturnInsertResult(data);
		}

		callAjax("/buyImport/returnInsert.do", "post", "json", true, param, resultCallback);
	}
	
	function fReturnInsertResult(data){
		swal(data.resultMsg);
		gfCloseModal();
		getList();
	}
	
	
</script>
</head>
<body>
<form id="myForm" action="" method="">
<input type="hidden" id="setCurrentPage" value="1"/>

	<!-- //모달배경 -->
	<div id="mask"></div>
	<jsp:include page="/WEB-INF/view/buyImportrtn/buyImpRefundModal.jsp" />
	
	<div id="wrap_area">	
		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
		
		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
				</li>
				<li class="contents">
					<h3 class="hidden">contents 영역</h3>
					
					<div class="content">
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">납품업체</span> 
							<span class="btn_nav bold">발주 지시서 목록</span>
							<a href="../buyImportrtn/purchaseOrder.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle">
							<span>발주 지시서 목록</span> 
							<span class="fr">
								<select id="searchType" style="width: 115px; height: 30.5px">
						            <option value="">전체</option>
						            <option value="1">업체명</option>
						            <option value="2">제품명</option>
						            <option value="3">임원승인</option>
						            <option value="4">임원미승인</option>
							    </select>&nbsp;
							    <input type="text" style="width: 170px; height: 28.5px;" id="searchWord" name="searchWord" value="" />  
								<input id="startDate" class="calendar" name="date" style="width: 118px; height: 28.5px;" readonly/>
								<input id="endDate" class="calendar" name="date" style="width: 118px; height: 28.5px;" readonly/>  
		                        <a href="javascript:getList()" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<!-- eq는 STring형 비교 -->
						
						<div class="divComDtlCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="80px">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="110px">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">발주번호</th>
										<th scope="col">발주회사</th>
										<th scope="col">발주제품</th>
										<th scope="col">발주수량</th>
										<th scope="col">발주일자</th>
										<th scope="col">임원승인여부</th>
										<th scope="col">입금확인</th>
									</tr>
								</thead>
								
								<tbody id="listBuyOrder">
								</tbody>
								
							</table>
						</div><!-- // table div -->
						<div class="paging_area" id="buyOrderPagination"></div>
						
					</div><!--// .content -->
					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li><!--// .contents -->
			</ul><!--// ul -->
		</div><!--// #container -->
	</div><!--// #wrap_area -->

</form>
</body>
</html>