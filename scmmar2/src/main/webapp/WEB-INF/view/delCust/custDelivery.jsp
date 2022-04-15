<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType ne 'B'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배송 담당자 :: 배송 지시서</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
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
<script type="text/javascript">
	//페이징 설정
	var pageSizeDelivery = 5;
	var pageBlockSizeDelivery = 5;
	
	$(function() {
		fBtnEvt();
		datePicker();
		fListCustDelivery();
	});
	
	
	/** 버튼 이벤트 등록 */
	function fBtnEvt() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
			
			var btnId = $(this).attr('id');
			
			switch (btnId) {
				case 'btnSearch' :
					search();
					break;
				case 'btnCancle' : 
					gfCloseModal();
					break;
				case 'btnDel' : 
					confirmDel();
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
	
	
	/** 모달 실행 */
	
	function fPopModalCustDelivery(delno) {
		
		gfModalPop("#layer1");
		fSelectCustDelivery(delno);

	}
	
	
	/** 목록 조회 */
	function fListCustDelivery(currentPage) {
		
		currentPage = currentPage || 1;
		
		var sname = $('#sname');
        var searchKey = document.getElementById("searchKey");
 //       var oname = searchKey.options[searchKey.selectedIndex].value;
        
		console.log("currentPage : " + currentPage);
		
		var param = {	
					sname : sname.val()
 //  			   ,	oname : oname
				,	currentPage : currentPage
				,	pageSize : pageSizeDelivery
				,   startDate : $("#startDate").val()
				,   endDate : $("#endDate").val()
		}
		
		var resultCallback = function(data) {
			fListCustDeliveryResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/delCust/listCustDelivery.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 조회 콜백 함수 */
	function fListCustDeliveryResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listCustDelivery').empty();
		
		// 신규 목록 생성
		$("#listCustDelivery").append(data);
		
		// 총 개수 추출
		var totalCntDelivery = $("#totalCntDelivery").val();
		console.log("totalCntDelivery : " + totalCntDelivery);
		
		//swal(totalCntDelivery);
		
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntDelivery, pageSizeDelivery, pageBlockSizeDelivery, 'fListCustDelivery');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#deliveryPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageDelivery").val(currentPage);
	}
	
	
	// 검색기능
	function search(currentPage) {
        
        var sname = $('#sname');
   //      var searchKey = document.getElementById("searchKey");
	//	var oname = searchKey.options[searchKey.selectedIndex].value;
		
		var oname = $('#searchkey').val();
		
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage);     
		
        var param = {
        		  sname : sname.val()
        	  ,	  oname : oname
              ,   currentPage : currentPage
              ,   pageSize : pageSizeDelivery
        }
        //swal(JSON.stringify(param));
        var resultCallback = function(data) {
        	fListCustDeliveryResult(data, currentPage); 
        };
        
        callAjax("/delCust/listCustDelivery.do", "post", "text", true, param, resultCallback);
        
  } 
	
	
	/** 단건 조회 */
	function fSelectCustDelivery(delno) {
		
		var param = { 
				delno : delno
		};
		
		var resultCallback = function(data) {
			fSelectCustDeliveryResult(data);
		};
		
		callAjax("/delCust/selectCustDelivery.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 단건 조회 콜백 함수*/
	function fSelectCustDeliveryResult(data) {
		
		console.log(data);

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");
			
			$("#delno").html(data.custDeliveryModel["delno"]);
			$("#pdnm").html(data.custDeliveryModel["pdnm"]);
			$("#oddtcnt").html(data.custDeliveryModel["oddtcnt"]);
			$("#delstate").html(data.custDeliveryModel["delstate"]);
			
		} else {
			swal(data.resultMsg);
		}	
	}
	
	
	function confirmDel() {
		var chkDel = confirm("배송완료 처리 하시겠습니까?");
		if(chkDel) {
			alert("배송완료 처리하였습니다.");
			gfCloseModal();
		} else {
			alert("배송완료 처리를 취소하였습니다.");
		}
	}

</script>	
</head>

<body>
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
								class="btn_nav bold">기업 고객</span> <span class="btn_nav bold">배송 지시서</span> <a href="../delCust/deliveryBuyer.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle">
							<span>배송 지시서 목록</span> 
							<span class="fr">
								<select id="searchKey" style="width: 115px; height: 30.5px">
						            <option value="">전체</option>
						            <option value="1">배송번호</option>
						            <option value="2">배송담당자</option>
						            <option value="3">배송중</option>
						            <option value="4">배송완료</option>
							    </select>&nbsp;
							    <input type="text" style="width: 170px; height: 28.5px;" id="sname" name="sname" value="" />  
								<input id="startDate" class="calendar" name="date" style="width: 118px; height: 28.5px;" readonly/>
								<input id="endDate" class="calendar" name="date" style="width: 118px; height: 28.5px;" readonly/>  
		                        <a href="javascript:listCustDelivery()" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
						<div class="divCustDeliveryList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="110px">
									<col width="150px">
									<col width="350px">
									<col width="*">
									<col width="110px">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">배송ID</th>
										<th scope="col">배송 담당자</th>
										<th scope="col">출발 창고지</th>
										<th scope="col">목적지</th>
										<th scope="col">배송 결과</th>
									</tr>
								</thead>
								
								<tbody id="listCustDelivery">
								</tbody>
								
							</table>
						</div><!-- // table div -->
						
					<div class="paging_area"  id="deliveryPagination"> </div>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
				
			</ul>
		</div>
	</div>
		
<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt style="font-family: 맑은고딕;">
				<strong>배송정보 상세</strong>
			</dt>
			<dd class="content">
			<b>(배송ID : <span id="delno"></span>) 배송건입니다</b><br />
			
				<!-- s : 여기에 내용입력 -->
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="50%">
						<col width="*">
					</colgroup>

					<thead>
						<tr>
							<th scope="col">제품명</th>
							<th scope="col">제품수량</th>
						</tr>
					</thead>
					
					<tbody id="selectCustDelivery">
					</tbody>
				</table>
			
				<div class="btn_areaC mt30">
				<!--
					<c:if test="${list.delstate eq '1'}">
						<a href="" class="btnType blue" id="btnDel" name="btn"><span>배송중</span></a>
					</c:if>
					<c:if test="${list.delstate eq '2'}">
						<span class="btnType grey" name="btn">배송완료</span></a>
					</c:if>
					-->
					<a href="" class="btnType blue" id="btnCancle" name="btn"><span>취소</span></a>
				</div>
				<div class="paging_area"  id="deliveryPagination"> </div>
				</dd>
			</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</body>
</html>