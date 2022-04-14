<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>배송지시서</title>
<script src='CTX_PATH/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<style type="text/css">
	.hover_row:hover {
		background: #87CEFA;
		transition: all 0.2s;
	}
	table.col tbody tr:nth-child(2n):hover {
    	background: #87CEFA;
		transition: all 0.2s;
	}
</style>

</head>
<body>
<script type="text/javascript">
	// 배송지시서 페이징 설정
	var pageSizeListDeliOrder = 10;		//한 페이지에 나오는 목록 갯수
	var pageBlockSizeListDeliOrder = 5;	//페이지 블록 수
	
	// 상세코드 페이징 설정
	var pageSizeComnDtlCod = 5;
	var pageBlockSizeComnDtlCod = 10;

	
	
	
	//	레디 start
	$(document).ready(function(){
		//배송지시서 목록 조회 함수
		flistDeliOrder();	
		
		//데이트픽커 호출 함수
		fDatePicker();	
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();		
		
		//	날짜 초기화
		$("#cal1").datepicker('setDate', '');
  	    $("#cal2").datepicker('setDate', '');
  	    
  	 	/* 날짜 radio 버튼 초기화 */
		$('#radio_cal1').prop('checked', !$('#radio_cal1').prop('checked'));		
  	 	
		/* 날짜 선택 Checkbox change event */
		$('input[name="radio_cal"]').change(function(){
			var radio_cal1 = $('#radio_cal1').prop('checked');
			var radio_cal2 = $('#radio_cal2').prop('checked');
			
		        if(radio_cal1==true && radio_cal2==false){
		        	$("#cal1").datepicker( "option", "disabled", true );
		        	$("#cal2").datepicker( "option", "disabled", true );
		        	$("#cal1").datepicker('setDate', '');
		      	    $("#cal2").datepicker('setDate', '');
		        } else{
		        	$("#cal1").datepicker( "option", "disabled", false );
		        	$("#cal2").datepicker( "option", "disabled", false );
		        	$("#cal1").datepicker('setDate', '-3M');
		      	    $("#cal2").datepicker('setDate', 'today');
		        }
		});
		
	
		//검색 버튼
		$('#btnSearch').click(function(){
			flistDeliOrder();
		});
			
		
	});//	레디 end
	
	
	
	
	

	/** 배송지시서 목록 조회 */
	function flistDeliOrder(currentPage) {
		
		currentPage = currentPage || 1;
		
		var sname = $('#sname').val();
		var oname = $('#searchKey').val();  
		var cal1 = $('#cal1').val();
		var cal2 = $('#cal2').val();
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
					sname : sname
				,	oname : oname
				,	currentPage : currentPage
				,	pageSize : pageSizeListDeliOrder
				,	cal1 : cal1
				, 	cal2 : cal2
		}
		
		var resultCallback = function(data) {
			flistDeliOrderResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/dlm/listDeliOrder.do", "post", "text", true, param, resultCallback);
	}

	/** 배송지시서 목록 조회 콜백 함수 */
	function flistDeliOrderResult(data, currentPage) {

		console.log("콜백함수에서 파라미터로 받은 data : " + data);
		console.log("콜백함수에서 파라미터로 받은 currentPage : " + currentPage);
		
		// 기존 목록 삭제
		$('#tbodyList').empty();
		
		// 신규 목록 생성
		$("#tbodyList").append(data);
		
 		// 총 개수 추출 - 페이지 네비게이션에서 사용할 변수
 		var totalCntListDeliOrder = $("#totalCntListDeliOrder").val();
 		console.log("totalCntListDeliOrder : " + totalCntListDeliOrder);

 		
 		// 페이지 네비게이션 생성			  (현재 페이지, 	총 개수,		페이지당 목록 개수, 	페이지 블록 개수, 		페이지 번호를 클릭하면 호출할 함수 객체)
 		var paginationHtml = getPaginationHtml(currentPage, totalCntListDeliOrder, pageSizeListDeliOrder, pageBlockSizeListDeliOrder, 'flistDeliOrder');
 		console.log("paginationHtml : " + paginationHtml);

 		// 페이징 영역에 넣기
  		$("#listPagination").empty().append( paginationHtml );
		
  		// 현재 페이지 설정(밸류값 변경)
  		console.log("before currentPageListDeliOrder : "+ $("#currentPageListDeliOrder").val());
  		$("#currentPageListDeliOrder").val(currentPage);
  		console.log("after currentPageListDeliOrder : "+ $("#currentPageListDeliOrder").val());
	}
	

	
	
	/** 배송지시서 단건 상세 조회 모달 실행 */
	function fPopModalDeliOrder(deliv_id, deliverStatus,deliv_wh_id) {	//deliverStatus : 배송완료 버튼 없앨려고 만든 파라미터
		// 신규 저장			(사실 만들필요가 없지만...)
		if (deliv_id == null || deliv_id=="") {
			// Transaction type 설정
			$("#action").val("I");	//INSERT
			
			// 그룹코드 폼 초기화??????????????????????
			//fInitFormGrpCod();
			
			// 모달 팝업
			gfModalPop("#layer1");

		// 수정 저장
		} else {
			// Transaction type 설정
			$("#action").val("U");	//UPDATE
			
			// 그룹코드 단건 조회
			fSelectDeliOrder(deliv_id, deliverStatus,deliv_wh_id);
		}
	}
	
	
	/** 배송지시서 단건 상세 조회 */
	function fSelectDeliOrder(deliv_id, deliverStatus,deliv_wh_id) {
		
		var param = { deliv_id : deliv_id
					, deliverStatus : deliverStatus
					, deliv_wh_id : deliv_wh_id			
					};
		
		console.log("param : "+JSON.stringify(param));	//파라미터 확인
		
		if(deliverStatus=="U"){	//배송준비중이면 배송완료버튼 보이기
			$("#btnSaveDeliOrder").show();
		}else{	//배송완료버튼 숨기기
			$("#btnSaveDeliOrder").hide();
		}
		
		
		var resultCallback = function(data) {
			fSelectDeliOrderResult(data);
		};
		
		callAjax("/dlm/selectDeliOrder.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 배송지시서 단건 상세 조회 콜백 함수*/
	function fSelectDeliOrderResult(data) {
		
		console.log("fSelectDeliOrderResult(data) : " + JSON.stringify(data));	//파라미터 확인
		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");
			// 그룹코드 폼 데이터 설정
			fInitFormDeliOrder(data.shippingModel);
			
		} else {
			swal(data.resultMsg);
		}	
	}
	
	
	/** 배송지시서 폼 데이터 설정 */
	function fInitFormDeliOrder(data){
		console.log("fInitFormDeliOrder(data) : " + JSON.stringify(data));

		$("#deliv_id").val(data.deliv_id);
		$("#sales_nm").val(data.sales_nm);
		$("#pur_cnt").val(data.pur_cnt);
		$("#name").val(data.name);
		$("#hidden_deliverStatus").val(data.deliverStatus);	//name="deliverStatus"
		$("#wh_nm").val(data.wh_id_ship);
		$("#address").val(data.address);
		$("#dtAddress").val(data.dtAddress);
	
		//배송상태
		var deliverStatus = $("#hidden_deliverStatus").val();
		if(deliverStatus=="U"){
			$("#deliverStatus").val("배송준비");	//name속성 없음
		}else if(deliverStatus=="O"){
// 			$("#deliverStatus").val("배송시작");
		}else if(deliverStatus=="E"){
			$("#deliverStatus").val("배송완료");
		}
	}
		
	
	
	/** 배송지시서 배송상태 저장 */
	function fSaveDeliOrder() {
		
		var resultCallback = function(data) {
			fSaveDeliOrderResult(data);
		};
		console.log("$('#myForm').serialize() : "+$("#myForm").serialize().replace(/%/g, '%25'));
		var msgConfirm = confirm('배송완료 처리하시겠습니까?')
		if(msgConfirm){
			callAjax("/dlm/saveDeliOrder.do", "post", "json", true, $("#myForm").serialize(), resultCallback);			
		}
	}
	
	/** 배송지시서 배송상태 저장 콜백 함수 */
	function fSaveDeliOrderResult(data) {
		
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {	//액션이 "I"값이 아니라면?
			currentPage = $("#currentPageListDeliOrder").val();	//	현재페이지 번호를 변수로 담아라
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);		
			// 모달 닫기
			gfCloseModal();	
			// 특정 페이지로 목록 조회
			flistDeliOrder(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
		
		// 입력폼 초기화		잘 모르겠음, 필요 없는듯
		//fInitFormGrpCod();
	}
	
	
	
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {	//네임속성으로 id값 지정하기
			e.preventDefault();

			console.log("e : " + e.preventDefault());
			
			var btnId = $(this).attr('id');
			console.log("btnId : "+btnId);
			
			switch (btnId) {			
				case 'btnSaveDeliOrder' :	//배송완료 버튼
					fSaveDeliOrder();
					break;
				case 'btnCloseDeliOrder' :	//닫기(취소) 버튼
					gfCloseModal();
					break;
			}
		});
	}
	
//	유틸리티 ---------------------------------------------------------------------------------------------------------------------	
	
	// DatePicker
 	function fDatePicker(){
 	    $.datepicker.setDefaults($.datepicker.regional['ko']); //언어설정
 	    $( "#cal1" ).datepicker({	//시작일
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
 	         minDate: new Date('2020-01-01'),
 	         maxDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
 	         onClose: function( selectedDate ) {    
 	              //시작일(startDate) datepicker가 닫힐때
 	              //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
 	             $("#cal2").datepicker( "option", "minDate", selectedDate );
  
 	         }    

 	    });
 	    
 	    $( "#cal2" ).datepicker({	//종료일
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
 	         minDate: new Date('2020-01-01'),
 	         maxDate: 0, 
 	         onClose: function( selectedDate ) {    
 	             // 종료일(endDate) datepicker가 닫힐때
 	             // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
 	             $("#cal1").datepicker( "option", "maxDate", selectedDate );

 	         }    

 	    }); 
 	    
 	    $("#cal1").datepicker('setDate', '-3M');
 	    $("#cal2").datepicker('setDate', 'today');
 	}
//---------------------------------------------------------------------------------------------------------------------------------------	
	
</script>
<form id="myForm" action=""  method="" onSubmit="return false">
	<!-- 이건 왜 있는거? 요소 확인용인가? >>> 업데이트 쿼리 실행시 로드시킬 페이지 인덱스 번호인듯  -->
	<input type="hidden" id="currentPageListDeliOrder" value="1">
	<!-- 모달 액션 -->
	<input type="hidden" name="action" id="action" value="">
	
	
	<!-- 모달 배경 -->
	<div id="mask"></div>
	<!-- wrap_area -->
	<div id="wrap_area">
	
	<div id="container">
		<ul>
			<li class="lnb">
				<!-- lnb 영역 --> 
				<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
				<!--// lnb 영역 -->
			</li>
			
			
			<li class="contents">			
				<!-- content 영역 -->
				<div class="content">
					<!-- 상단 네비게이션 -->			
					<p class="Location">
						<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 					
					    <span class="btn_nav bold">기업고객</span> 
						<span class="btn_nav bold">배송 지시서</span>						
						<a href="../dlm/deliveryBuyer.do" class="btn_set refresh">새로고침</a>
					</p>
					<!-- // 상단 네비게이션 -->	
					
					
					
					<!-- 목록 영역 -->	
					<div class="shippingList_area" >
					
                    	<!--검색 바 테이블 -->
                        <table style="margin-top:10px; margin-bottom:20px;" width="100%" cellpadding="5"
                           cellspacing="0" border="1" align="left"
                           style="collapse; border: 1px #50bcdf;">
                           <tr style="border: 0px; border-color: blue">
                              <td width="40" height="25" style="font-size: 120%;">&nbsp;</td>
                              <td width="*" height="25" style="font-size: 100%; text-align: center;">
                                 <!-- select option -->
                                 <select id="searchKey" name="searchKey" style="width: 80px; height: 27px;" v-model="searchKey">
                                    <option value="">전체</option>
                                    <option value="U">배송준비</option>
                                    <option value="O">배송시작</option>
                                    <option value="E">배송완료</option>
                                 </select>                                 
                                 <!-- search name -->
                                 <input type="text" style="width: 150px; height: 25px;" id="sname" name="sname" placeholder="제품명 입력"  onkeypress="if( event.keyCode==13 ){flistDeliOrder();}"> &nbsp;&nbsp;&nbsp;
                                 <!-- calendar date -->
                                 <input type="radio" name="radio_cal" id="radio_cal1" value="all"><label for="radio_cal1">전체</label> 
                                 <input type="radio" name="radio_cal" id="radio_cal2" value="choice"><label for="radio_cal2">선택</label> 
                                 <input name="cal1" id="cal1" readonly="readonly" disabled="disabled" style="height: 25px;"/>
								 <input name="cal2" id="cal2" readonly="readonly" disabled="disabled" style="height: 25px;"/>
                         		 <!-- button -->
                                 <a href="#" class="btnType blue" id="btnSearch" name="btn"><span>검색</span></a>&nbsp;
                              <td width="40" height="25" style="font-size: 120%;">&nbsp;</td>
                           </tr>
                        </table>
                        <!--//검색 바 테이블 -->
                        
                        <!-- 리스트 테이블 영역 -->
                        <table class="col">
                        
                           <caption>caption</caption>
                           
                           <colgroup>
                          	  <col width="6%">
                              <col width="7%">
                              <col width="*%">
                              <col width="7%">
                              <col width="14%">
                              <col width="10%">
                              <col width="10%">
                              <col width="10%">
<%--                               <col width="10%"> --%>
                           </colgroup>

                           <thead>
                              <tr>
                              	 <th scope="col">순번</th>
                                 <th scope="col">배송번호</th>
                                 <th scope="col">제품명</th>
                                 <th scope="col">수량</th>
                                 <th scope="col">배송담당자</th>
<!--                                  <th scope="col">출발창고지</th> -->
<!--                                  <th scope="col">목적지</th> -->
                                 <th scope="col">배송상태</th>
                                 <th scope="col">등록일</th>
                                 <th scope="col">처리일자</th>
<!--                                  <th scope="col">삭제일</th> -->
                              </tr>
                           </thead>
                           
                           
                           <!-- tbody에 리스트 출력 -->
                           <tbody id="tbodyList">                          
                           </tbody>
                        </table>
                        <!--// 테이블 영역 -->
                     </div>
                     
                     <!-- 페이징 영역 -->
                     <div class="paging_area" id="listPagination"></div>
         			 <!--// 페이징 영역 -->
					
				</div>
				<!-- //content 영역 -->
				

				
				
				
				<h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
			</li>
		</ul>
	</div> 
	
	</div>
	<!-- // wrap_area -->
	
	
	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>배송지시서 상세</strong>
			</dt>
			
			<dd class="content">
			
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
				
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						
						<tr>
							<th scope="row">배송번호 <span class="font_red">*</span></th>
							<td colspan="3"><input type="hidden" name="deliverStatus" id="hidden_deliverStatus"><input type="text" class="inputTxt p100" name="deliv_id" id="deliv_id" readonly="readonly"/></td>		
						</tr>
						<tr>
							<th scope="row">제품명 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="sales_nm" id="sales_nm" readonly="readonly"/></td>							
						</tr>
						<tr>
							<th scope="row">수량 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="pur_cnt" id="pur_cnt" readonly="readonly"/></td>
						</tr>
						<tr>
							<th scope="row">배송담당자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="name" id="name" readonly="readonly"/></td>
							<th scope="row">배송상태 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="deliverStatus" readonly="readonly" /></td>
						</tr>
						<tr>					
							<th scope="row">출발창고지 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="wh_nm" id="wh_nm" readonly="readonly" /></td>
						</tr>
						<tr>					
							<th scope="row">주소1 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="address" id="address" readonly="readonly" /></td>
						</tr>
						<tr>					
							<th scope="row">주소2 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="dtAddress" id="dtAddress" readonly="readonly" /></td>
						</tr>
<!-- 						<tr> -->
<!-- 							<th scope="row">배송상태 수정<span class="font_red">*</span></th> -->
<!-- 							<td colspan="3"> -->
<!-- 								<input type="radio" id="radio1-1" name="deliverStatus" id="deliverStatus_1" value='U' style="margin-left: 10px;"/> <label for="radio1-1" >배송준비</label> -->
<!-- 								<input type="radio" id="radio1-2" name="deliverStatus" id="deliverStatus_2" value="O" style="margin-left: 10px;"/> <label for="radio1-2" >배송시작</label> -->
<!-- 								<input type="radio" id="radio1-3" name="deliverStatus" id="deliverStatus_3" value="E" style="margin-left: 10px;"/> <label for="radio1-3" >배송완료</label>			 -->
<!-- 							</td> -->
<!-- 						</tr> -->
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveDeliOrder" name="btn"><span>배송완료</span></a> 
					<a href="" class="btnType gray" id="btnCloseDeliOrder" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!-- // 모달팝업 -->
</form>	
</body>
</html>