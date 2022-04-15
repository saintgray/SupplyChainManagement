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
		fDatePicker();
		getRefundList();
	});
	
	function fBtnEvt() {
		$("a[name=btn]").click(function(e) {
			e.preventDefault();
			var btnId = $(this).attr('id');
			switch (btnId) {
			case "btnRtRedo" : gfCloseModal();
				break;
			}
		});
	}
	
	function fDatePicker() {
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
		// 이 안에다 getRefundList 함수를 선언하여 에러
	}
	
	function getRefundList(currentPage) {
		currentPage = currentPage || 1;
		var param = { currentPage : currentPage
					, pageSize : pageSize
					, searchType : $("#searchType").val()
					, searchWord : $("#searchWord").val()
					, startDate : $("#startDate").val()
					, endDate : $("#endDate").val() }
		var callback = function(data) { getListRslt(data, currentPage) }
		callAjax("/buyImport/getRefundList.do", "post", "text", true, param, callback);
	}
   
	function getListRslt(data, currentPage) {
		$("#listReturn").empty().append(data);
		var pageinationHTML = getPaginationHtml(currentPage, $("#RefundTotal").val(), pageSize, pageBlock, 'getRefundList');
		$("#refundPagination").empty().append(pageinationHTML);
		$("#setCurrentPage").val(currentPage);
	}
	
	function getOneModal(rtnno, pdno) {		
		if (isNaN(rtnno)) {
			swal("알 수 없는 오류입니다. 시스템 관리자에게 문의해주세요.");
			return;
		};
		if (isNaN(rtnno) == false) {
			var param = { rtnno : rtnno, pdno : pdno }
			callAjax("/buyImport/getRefundOne.do", "post", "json", true, param, getOneModalRslt);
		};
	}
	
	function getOneModalRslt(data) {
		$("#rtnno").val(data.item.rtnno);
		$("#rclient").val(data.item.client);
		$("#rpdmdno").val(data.item.pdno);
		$("#rpdmdnm").val(data.item.pdnm);
		$("#brtncnt").val(data.item.brtncnt);
		gfModalPop("#buyImpRefundModal");
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
							<span class="btn_nav bold">반품 지시서 목록</span>
							<a href="../buyImportrtn/returnPurchase.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle">
							<span>반품 지시서 목록</span> 
							<span class="fr">
								<select id="searchType" style="width: 115px; height: 30.5px">
						            <option value="">전체</option>
						            <option value="1">업체명</option>
						            <option value="2">제품명</option>
						            <option value="3">입금완료</option>
						            <option value="4">입금미완료</option>
							    </select>&nbsp;
							    <input type="text" style="width: 170px; height: 28.5px;" id="searchWord" name="searchWord" value="" />  
								<input id="startDate" class="calendar" name="date" style="width: 118px; height: 28.5px;" readonly/>
								<input id="endDate" class="calendar" name="date" style="width: 118px; height: 28.5px;" readonly/>  
		                        <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn" onclick="javascript:getRefundList();"><span>검  색</span></a>
							</span>
						</p>
						
						<div class="divComDtlCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="70px">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">반품번호</th>
										<th scope="col">반품회사</th>
										<th scope="col">반품제품</th>
										<th scope="col">반품수량</th>
										<th scope="col">반품신청일자</th>
										<th scope="col">반품완료일자</th>
										<th scope="col">입금확인</th>
									</tr>
								</thead>
								
								<tbody id="listReturn">
																	
								</tbody>
								
							</table>
						</div><!-- // table div -->
						<div class="paging_area" id="refundPagination"></div>
						
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