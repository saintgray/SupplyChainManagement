<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 반품지시서</title>

<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->


<style>
	input[name=date].datetype{
 	  padding:4px 2px 5px 25px;
 	  width:95px; 
 	  border:1px solid #CACACA;
      font-size:11px;
      color:#666; 
      background:url('http://cfile23.uf.tistory.com/image/26100D4F5864C76827F535') no-repeat 2px 2px; 
      background-size:15px
    }   

</style>

<script type="text/javascript">

	// 반품지시서 페이징 설정
	var pageSizePaybackOrder = 5;
	var pageBlockSizePaybackOrder = 5;

	
	
	/** OnLoad event */ 
	$(function() {
	
		// 반품지시서 조회
		fListPaybackOrder();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		//datePicker
		fDatePicker();
		
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
									
				case 'btnListPaybackOrder':
					fListPaybackOrder();
					break;
				case 'btnYesPaybackOrder':
					gfModalPop("#layer1");
					break;
					
				
			}
		});
	}
	
	
	
	
	/** 반품지시서 조회 */
	function fListPaybackOrder(currentPage) {
		
		
		currentPage = currentPage || 1;
		
		var sname = $('#sname').val();
		var from_date = $('#from_date').val();
		var	to_date = $('#to_date').val();

		console.log("currentPage : " + currentPage);
		
			var param = {	
						sname : sname
					,	from_date : from_date
					,	to_date : to_date
					,	currentPage : currentPage
					,	pageSize : pageSizePaybackOrder
			}			
		
		
		var resultCallback = function(data) {
			flistPaybackOrderResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/scmTask/listPaybackOrder.do", "post", "text", true, param, resultCallback);
	}
	
	/** 반품지시서 조회 콜백 함수 */
	function flistPaybackOrderResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listPaybackOrder').empty();
		
		// 신규 목록 생성
		$("#listPaybackOrder").append(data);
		
		// 총 개수 추출
		
		var totalCntPaybackOrder = $("#totalCntPaybackOrder").val();
		
				
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntPaybackOrder, pageSizePaybackOrder, pageBlockSizePaybackOrder, 'fListPaybackOrder');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#paybackOrderPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPagePaybackOrder").val(currentPage);
	}
	
	
	
	function fYesPaybackOrder(){
		var rtnno = $('#m-rtnno').val();
		var crtrtio = $('#m-crtrtio').val();
		
		console.log(rtnno);
		console.log(crtrtio);
			
		$.ajax({
			    url: "PaybackOrderYn.do",
			    data: {	
			    		"rtnno" : rtnno,
			    		"crtrtio" : crtrtio
				    	},
			    type: "GET",
			    success : function(result){
			    	if(result != 0){
			    		alert("반품 입금 완료!");
					history.go(0);	  			
					}else{
						alert("실패");
					}
			    }
		 });

	}
	
	function popModal(dom){
		
		var hiddeninfodom= $(dom).parent().parent().siblings('.hiddeninfo');
		var rtnno=$(hiddeninfodom).children('#rtnno').val();
		var crtrtio=$(hiddeninfodom).children('#crtrtio').val();
		
		$('#m-rtnno').val(rtnno);
		$('#m-crtrtio').val(crtrtio);
		
		gfModalPop('#layer1');
	}
	
	
	//날짜 변환 함수  
	function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
} 

// DatePicker
	function fDatePicker(){
	    $.datepicker.setDefaults($.datepicker.regional['ko']); 
	    $( "#from_date" ).datepicker({
	         changeMonth: true, 
	         changeYear: true,
	         nextText: '다음 달',
	         prevText: '이전 달', 
	         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
	         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
	         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         showAnim: "slide", //애니메이션을 적용한다.
	         dateFormat: "yy-mm-dd",
	         maxDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
	         onClose: function( selectedDate ) {    
	              //시작일(startDate) datepicker가 닫힐때
	              //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
	             $("#to_date").datepicker( "option", "minDate", selectedDate );

	         }    

	    });
	    $( "#to_date" ).datepicker({
	         changeMonth: true, 
	         changeYear: true,
	         nextText: '다음 달',
	         prevText: '이전 달', 
	         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
	         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
	         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         showAnim: "slide", //애니메이션을 적용한다.
	         dateFormat: "yy-mm-dd",                    // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
	         onClose: function( selectedDate ) {    
	             // 종료일(endDate) datepicker가 닫힐때
	             // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
	             $("#from_date").datepicker( "option", "maxDate", selectedDate );

	         }    

	    }); 
	    
	    $("#from_date").datepicker('setDate', '-3M');
	    $("#to_date").datepicker('setDate', 'today');
	}
	
	

	
	
	
</script>

</head>
<body>

<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPagePaybackOrder" value="1">
	<input type="hidden" name="action" id="action" value="">
	
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span	class="btn_nav bold">작업지시서</span>
							<span class="btn_nav bold">반품지시서</span>
							<a href="../scmTask/paybackOrder.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>반품지시서</span>							
						</p>
						
						<table style="margin: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="50" height="25" style="font-size: 100%; text-align:center; padding-right:25px;">
     	                      <div><span style="font-size:large; font-weight:bold; margin:10px; ">기업고객명</span>
     	                      <input type="text" style="width: 300px; height: 25px;" id="sname" name="sname" onkeypress="if( event.keyCode == 13 ){fListPaybackOrder();}">                    
	                           <input class="datetype" style="width: 100px; margin-left: 10px;" id="from_date" name="date" readonly> ㅡ <input class="datetype" style="width:100px" id="to_date" name="date" readonly>
	                           <a href="" class="btnType blue" id="btnListPaybackOrder" name="btn" style="margin-left: 20px;"><span>검  색</span></a>
	                          </div>
                           </td> 
                           
                           
                        </tr>
                     	</table> 
						<div class="divPaybackOrderList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="25%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">주문일자</th>
										<th scope="col">제품명</th>
										<th scope="col">반품개수</th>
										<th scope="col">금액</th>
										<th scope="col">반품입금여부</th>
										<th scope="col"></th>
									</tr>
								</thead>
								<tbody id="listPaybackOrder"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="paybackOrderPagination"> </div>
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
	
		<input type="hidden" id='m-rtnno'>
		<input type="hidden" id='m-crtrtio'>
		<div style="text-align: center; margin-top:20px; font-size: 20px; font-family: 맑은고딕;"><strong>입금하시겠습니까?</strong></div>
		<div class="btn_areaC mt30" style="margin-bottom: 10px;">
			<a class="btnType blue" id="btnYesPayback" name="btn" style="cursor:pointer;"><span onclick="fYesPaybackOrder();">확인</span></a> 
			<a class="btnType gray"  id="btnNoPayback" name="btn" style="cursor:pointer;"><span onclick="gfCloseModal();">취소</span></a>
		</div>
	
	</div>
	
	
	
	
	
	
</form>


</body>
</html>