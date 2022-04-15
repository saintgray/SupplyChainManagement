<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>주문이력조회</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
	<style>
 		input[name=date].datetype{
 			padding:4px 2px 5px 25px; width:95px; border:1px solid #CACACA;
      		font-size:11px; color:#666; 
      		background:url('http://cfile23.uf.tistory.com/image/26100D4F5864C76827F535') no-repeat 2px 2px; 
      		background-size:15px
    	}   
		.searchBox{
			height: 50px;
			margin: 20px;
			border: 1px solid lightgray;
			display:flex;
			justify-content:center;
			padding-top: 20px;
			text-align: center;
		}
	</style>
<script type="text/javascript">
	
	//주문이력 페이징 설정
	var pageSizeOrderHistory = 5;
	var pageBlockSizeOrderHistory = 5;
	
	//주문이력 상세 페이징 설정
	var pageSizeOrderHistoryDtl = 5;
	var pageBlockSizeOrderHistoryDtl = 5;
	
	$(function(){
		fDatePicker();
		
		//주문이력리스트
		fListOrderHistory();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		fbackComboList();
		
		$(".divDtlOrderHistoryList").hide();
		$("#listOrderHistoryDtlPagination").hide();
		$(".rtnBtn_area").hide();
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'searchBtn' :
					fListOrderHistory();
					break;
				case 'returnBtn' :
					fPopupReturn();
					break;
				case 'btnReturnEnd' :
					fReturnEnd();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
	}
	
	//은행가져오기
	
	function fbackComboList(){
		
		var resultCallback = function(data) {
			fbackComboListResult(data);
		};
		callAjax("/crt/listBankList.do", "post", "json", true, "", resultCallback);
		
	}
	
	//은행 콤보박스 생성 콜백함수
	function fbackComboListResult(data){
		
		
		
		$("#bankCD").find("option").remove();
		$("#bankCD").append("<option value=''>은행 선택</option>");
		
		for(var i=0;i<data.length;i++){
			$("#bankCD").append("<option value='"+data[i].detail_name+"'>"+data[i].detail_name+"</option>");
		}
	}
	
	
	//주문이력 리스트 조회
	function fListOrderHistory(currentPage){
		
		currentPage = currentPage || 1;
		
		var fromDate =  $("#from_date").val();
		var toDate = $("#to_date").val();
		
		var param = {	
				fromdate:fromDate
			,	todate:toDate
			,	currentPage : currentPage
			,	pageSize : pageSizeOrderHistory
		}
	
		var resultCallback = function(data) {
			fListOrderHistoryResult(data, currentPage);
		};
		
		callAjax("/crt/listOrderHistory.do", "post", "text", true, param, resultCallback);
		
	}
	
	
	//주문이력 콜백
	function fListOrderHistoryResult(data, currentPage) {
		
		// 기존 목록 삭제
		$('#listorderhistory').empty();
		
		// 신규 목록 생성
		$("#listorderhistory").append(data);
		
		// 총 개수 추출
		
		var totalCntOrderHistory = $("#totalOrderHistoryCount").val();
		
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntOrderHistory, pageSizeOrderHistory, pageBlockSizeOrderHistory, 'fListOrderHistory');
		
		$("#orderListPagination").empty().append( paginationHtml );
		
	}
	
	
	//주문이력 상세
	function flistOrderHistoryDtl(currentPage,orderno){
		
		currentPage = currentPage || 1;
		
		
		var param = {
					orderno : orderno
				,	currentPage : currentPage
				,	pageSize : pageSizeOrderHistoryDtl
		}
		
		var resultCallback = function(data) {
			flistOrderHistoryDtlResult(data, currentPage, orderno);
		};
		
		callAjax("/crt/orderHistoryDtl.do", "post", "text", true, param, resultCallback);
		
	}
	
	//주문이력 상세 콜백함수
	function flistOrderHistoryDtlResult(data, currentPage){
		
		$(".divDtlOrderHistoryList").show();
		$("#listOrderHistoryDtlPagination").show();
		$(".rtnBtn_area").show();
		
		// 기존 목록 삭제
		$('#listOrderHistoryDtl').empty();
		
		
		// 신규 목록 생성
		$("#listOrderHistoryDtl").append(data);
		
		// 총 개수 추출
		var totalOrderHistoryCountDtl = $("#totalOrderHistoryCountDtl").val();
		var orderno = $("#listOrderHistoryDtl").find("[name=orderno]").val();
		
		
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalOrderHistoryCountDtl, pageSizeOrderHistoryDtl, pageBlockSizeOrderHistoryDtl, 'flistOrderHistoryDtl',[orderno]);
		
		$("#listOrderHistoryDtlPagination").empty().append( paginationHtml );
	}
	

	//반품 신청 팝업
	function fPopupReturn(){
		
		if($("[name=choicepd]:checked").length == 0){
 			gfModalPop("#layer1");
 		}else{
 			gfModalPop("#layer2");	
 		}
	}
	
	function fValidateBankInfo() {

		var chk = checkNotEmpty(
				[
						[ "bankCD", "은행을 선택해 주세요." ]
					,	[ "accno", "계좌번호를 입력해 주세요." ]
					,	[ "accnm", "예금주를 입력해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	function fReturnEnd(){
		var returnArr = [];
		var param = {};
		var rtncnt = 0;
		var rtnamount = 0; 
		var orderno;
		
		// vaildation 체크
		if ( ! fValidateBankInfo() ) {
			return;
		}
		
		$("[name=choicepd]:checked").each(function(i,e){ 
			
			var info = $(e).parent().parent();
			//총반품수량
			rtncnt += Number(info.find("[name = oddtrecnt]").val()); 
			//총반품금액
			rtnamount += (Number(info.find("[name = oddtrecnt]").val()) * Number(info.find("[name = pdmdprice]").val())); 
			orderno = info.find("[name = orderno]").val();
			
			if(info.find("[name=oddtrecnt]").val()== 0){
				alert("반품 가능 수량이 0개 입니다.");
				return;
			}
			
			param = {
					//주문번호
					oddtno : info.find("[name = oddtno]").val(),
					//일련번호
					orderno : info.find("[name = orderno]").val(),
					//장비코드
					pdcode : info.find("[name = pdcode]").val(),
					//제품번호
					pdno : info.find("[name = pdno]").val(),
					//모델번호
					pdmdno : info.find("[name = pdmdno]").val(),
					//주문번호
					oddtno : info.find("[name = oddtno]").val(),
					//은행명
					banknm : $("#bankCD").val(),
					//계좌번호
					accno : $("#accno").val(),
					//예금주
					accnm : $("#accnm").val(),
					//반품건수
					oddtrecnt : info.find("[name = oddtrecnt]").val(),
					//상품금액
					pdmdprice : info.find("[name = pdmdprice]").val()
					
			};
			returnArr.push(param);
		});
		
		
		var resultCallback = function(data){
				fReturnEndResult(data,orderno);
			}
			
			 $.ajax({
				  url: "/crt/saveReturn.do",
				  type: "POST",
				  dataType:"JSON",
			  traditional : true, //필수
				  data: {param:JSON.stringify(returnArr)
					  ,rtncnt:rtncnt
					  ,rtnamount:rtnamount
					  ,orderno:orderno
					  },
				  success: function(data) {
					 resultCallback(data);
				}
			}); 		
	}
	
	function fReturnEndResult(data,orderno){
 		if(data.successMsg =='SUCCESS'){
 			swal(data.resultMsg);
 			flistOrderHistoryDtl(1,orderno);
 			gfCloseModal();
 		}else{
 			swal(data.resultMsg);
 		}
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


<head>
<body>
<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<div class="content">
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">주문</span> <span class="btn_nav bold">주문 현황</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>
						
					<div class="searchBox">
						<div>
							<table>
								<tr>
			                           <td width="150px">
			                           	<span>구매일자</span>
			                           </td>
			                           <td width="200px"><input class="datetype" style="width: 120px" id="from_date" name="date" readonly></td>
			                           <td width="50px">-</td>
			                           <td width="200px"><input class="datetype" style="width: 120px" id="to_date" name="date" readonly></td>
			                           <td width="200px">
			                           <a href="" class="btnType blue" id="searchBtn" name="btn" ><span>검  색</span></a>
			                           </td>
			                        </tr>
			                </table> 
		                </div>
				 </div>
						
						<div class="divprodcuctList">
						
							<table class="col">
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="25%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">일련번호</th>
										<th scope="col">주문수량</th>
										<th scope="col">결제금액</th>
										<th scope="col">구매일자</th>
									</tr>
								</thead>
								
						<tbody id="listorderhistory"></tbody>
						</table>
						</div>
						<div class="paging_area"  id="orderListPagination"> </div>
						
						<br>
						<br>
						<!-- 주문 상세 내역 -->
						<div class="divDtlOrderHistoryList">
							<table class="col">
								<colgroup>
									<col width="6%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="14%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">체크</th>
										<th scope="col">반품가능수량</th>
										<th scope="col">주문번호</th>
										<th scope="col">장비구분</th>
										<th scope="col">모델명</th>
										<th scope="col">제조사</th>
										<th scope="col">판매가격</th>
										<th scope="col">주문수량</th>
										<th scope="col">결제금액</th>
										<th scope="col">배송현황</th>
									</tr>
								</thead>
								 <tbody id="listOrderHistoryDtl"></tbody> 
							</table>
						</div>
						<div class="paging_area"  id="listOrderHistoryDtlPagination"></div>
						<div class="rtnBtn_area" style="text-align: right; margin-top: 20px; margin-bottom: 20px;"><a href="" class="btnType blue" id="returnBtn" name="btn" ><span>반품요청</span></a></div>
						
					</div> <!--// content -->
  				
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
		
		<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>반품 요청</strong>
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
							<th scope="row" rowspan="2">은행 선택 <span class="font_red">*</span></th>
							<td rowspan="2"><select name="banknm" id="bankCD" style="width: 100px;"></select></td>
							<th scope="row">계좌 번호 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="accno" name="accno" /></td>
						</tr>
						<tr>
							<th scope="row">예금주 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="accnm" name="accnm" /></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnReturnEnd" name="btn"><span>반품</span></a>
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
		<div id="layer1" class="layerPop layerType2" style="width: 300px;">
		<dl>
			<dd class="content">
					<div style="text-align: center; font-size: 17px">반품할 상품을 선택해 주세요</div>
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>확인</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
		
	</div>
</body>
</html>