<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>장바구니</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<style>
input[name=hopedate].datetype {
	padding: 4px 2px 5px 25px;
	width: 95px;
	border: 1px solid #CACACA;
	font-size: 11px;
	color: #666;
	background:
		url('http://cfile23.uf.tistory.com/image/26100D4F5864C76827F535')
		no-repeat 2px 2px;
	background-size: 15px
}

.totalInfo {
	width: 100%;
	display: flex;
	justify-content: flex-end;
	margin-top: 30px;
}

.thtitle {
	border-bottom: 1px solid;
	font-size: 20px;
	width: 200px;
	text-align: right;
	padding: 10px;
}

.totalInfotbl td {
	width: 200px;
	text-align: right;
	padding: 20px;
}

.totalinfo {
	font-size: 20px;
}

#ordercnt {
	width: 30px;
}

.btnDeleteCart {
	display: inline-block;
	padding-left: 10px;
	background: url(/images/admin/comm/set_btnBg.png) 0 0px no-repeat;
}

.btnDeleteCart span {
	display: inline-block;
	padding-right: 10px;
	min-width: 30px;
	height: 28px;
	line-height: 31px;
	font-family: '나눔바른고딕', NanumBarunGothic;
	font-size: 15px;
	color: #fff;
	text-align: center;
	font-weight: 400;
	background: url(/images/admin/comm/set_btnBg.png) 100% 0px no-repeat;
}

.btnDeleteCart.blue {
	background-position: 0px -41px;
}

.btnDeleteCart.blue span {
	background-position: 100% -41px;
}
</style>

<script type="text/javascript">


		$(function(){
						
			//버튼 이벤트 등록
			fRegisterButtonClickEvent();
			
			//장바구니 리스트
			fCartList();
			
		});
		
		
	//장바구니 리스트
	function fCartList(){
		//장바구니 콜백
		var resultCallback = function(data){
			fCartListResult(data);
		};
		callAjax("/crt/ShoppingCartList.do","post","text",true,"",resultCallback);
	}
	
	//제품리스트 조회 콜백 함수
	function fCartListResult(data){
		
		//신규 목록 생성
		$("#listproduct").empty();
		
		//신규 목록 생성
		$("#listproduct").append(data);
		
	}
		
	
	//버튼 이벤트 함수
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnOrderSave':
					fOrderSave();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnOrderSaveEnd' :
					fOrderSaveEnd();
					break;
				
			}
		});
	}
	
	// 날짜 변환 함수  
 	function getFormatDate(date){
	    var year = date.getFullYear();              //yyyy
	    var month = (1 + date.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = date.getDate();                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
 	} 
	
 	// DatePicker
 	/* function fDatePicker(){
 	    $.datepicker.setDefaults($.datepicker.regional['ko']); 
 	    $("[name=oddthopedate]").datepicker({
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
 	         minDate:0,
 	      });
 	} */
 	
 	
 	//주문 수량 변경 시 총 금액 변경 함수
 	function changeAmount(e){
		
 		
 		var ordercnt = $(e).val();
 		var pdmdprice = $(e).parent().prev().children().val();
 		$(e).parent().next().html(ordercnt*pdmdprice);
 		
 		$(e).parent().find("#orderamount").val(ordercnt*pdmdprice);
 		var orderamount = $(e).parent().find("#orderamount").val();
 		
 		$("[name=oddtcnt]").val(ordercnt);
 		
 		//체크박스 선택 후 장바구니 총액 변경 
 		var tot = 0 ;
 		$("[name=choicepd]:checked").each(function(e){ 			
 			var val = $(this).parent().parent().parent().find("[name=orderamountTr]").find("#orderamount").val();
 			tot += Number(val);		    
 		});
 		$("#totPrice").html(tot);
 		
 		
 	}
 	
 	//입금 버튼 실행 함수
 	//수주 등록
 	function fOrderSave(){
 		if($("[name=choicepd]:checked").length == 0){
 			gfModalPop("#layer2");
 		}else{
 			gfModalPop("#layer1");	
 		}
 	}
 
 	function fOrderSaveEnd(){
 		var orderamount = 0 ; //전체 주문 총금액
 		var ordercnt = 0; //전체 주문 개수
 		$("[name=choicepd]:checked").each(function(e){ 			
 			//수주 정보 테이블 총 금액
 			var orderamountVal = $(this).parent().parent().parent().find("[name=orderamountTr]").find("#orderamount").val();
 			orderamount += Number(orderamountVal);	
 			
 			//수주 정보 테이블 총 주문 개수
 			var ordercntVal = $(this).parent().parent().parent().find("[name=orderamountTr]").find("#ordercnt").val();
 			ordercnt += Number(ordercntVal);
 						
 		});
 		
 		var param = {ordercnt:ordercnt
 					,orderamount:orderamount}
 		
 		var resultCallback = function(data){
			fSaveOrderDetail(data);
		}
 		
 		callAjax("/crt/saveCartOrder.do","post", "text", true, param, resultCallback)
 	}
 	
 	/* //주수 상세 정보 등록
 	function fSaveOrderDetail(data){
 		
 		var cnt = 0;
 		 		 		
 		if(data =='SUCCESS'){
 			$("[name=choicepd]:checked").each(function(i,e){ 			
 				
 				var ordercnt = $(e).parent().parent().parent().find("#ordercnt").val();
 				
 				var form = $(e).parent();
 				var date = form.parent().parent().find("[name=carthopedateTr]").find("#carthopedate").val();
 				form.find("[name=oddthopedate]").val(date);
 				form.find("[name=oddtcnt]").val(ordercnt);
 			
 				var resultCallback = function(data){
 					if(data.successMsg =='SUCCESS')
 					cnt++;
 					
 					if(cnt == (i+1)){
 	 					fSaveOrderDetailEnd(data);
 	 				}
 				} 	
 				callAjax("/crt/saveCartOrderDetail.do","post", "json", false, form.serialize(),resultCallback);
 	 		});
 			
 		}
 	}
 	 */
 	
	function fSaveOrderDetailEnd(data){
 		if(data.successMsg =='SUCCESS'){
 			gfCloseModal();
 			swal(data.resultMsg);
 			fCartList();
 		}else{
 			gfCloseModal();
 			swal(data.resultMsg);
 		}
 	}
 	
	function fSaveOrderDetail(data){
 		if(data =='SUCCESS'){
 			var cartArr = [];
 			var param = {};
 			var paramResult= {};
 			
 			$("[name=choicepd]:checked").each(function(i,e){ 

 				var form = $(e).parent();
 				var ordercnt = $(e).parent().parent().parent().find("#ordercnt").val();
 				var date = form.parent().parent().find("[name=carthopedateTr]").find("[name=carthopedate]").val();
 				form.find("[name=oddthopedate]").val(date);
 				form.find("[name=oddtcnt]").val(ordercnt);
 				
 				param = {
 						oddthopedate:form.find("[name=oddthopedate]").val(),
 						oddtcnt:ordercnt,
 						pdcode:form.find("[name=pdcode]").val(),
 						pdmdno:form.find("[name=pdmdno]").val(),
 						pdno:form.find("[name=pdno]").val(),
 						cartno:form.find("[name=cartno]").val()
 				};
 				cartArr.push(param);
 				
 			});

 			var resultCallback = function(data){
 				fSaveOrderDetailEnd(data);
 			}
 			
 			 $.ajax({
 				  url: "/crt/saveCartOrderDetail.do",
 				  type: "POST",
 				  dataType:"JSON",
				  traditional : true, //필수
 				  data: {param:JSON.stringify(cartArr)},
 				  success: function(data) {
 					 resultCallback(data);
 				}
 			}); 
 		}
 	}
	
	
	 function fDeleteCartEnd(data){
		if (data.successMsg == "SUCCESS") {
			gfCloseModal();
 			swal(data.resultMsg);
 			fCartList();
		} else {
			gfCloseModal();
 			swal(data.resultMsg);
 			fCartList();
		}	
	} 
	
 	//장바구니에서 상품 삭제
	function fDeleteCart(cartno){

		var param = {cartno:cartno};
		
		var resultCallback = function(data) {
			fDeleteCartEnd(data);
		}; 
		
		callAjax("/crt/deleteCart.do", "post", "json", true, param, resultCallback); 
	}
 	
	

</script>


</head>
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
								class="btn_nav bold">주문</span> <span class="btn_nav bold">장바구니 목록</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<div class="divprodcuctList">
						
							<table class="col">
								<colgroup>
									<col width="7%">
									<col width="10%">
									<col width="13%">
									<col width="13%">
									<col width="5%">
									<col width="13%">
									<col width="13%">
									<col width="13%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">선택</th>
										<th scope="col">사진</th>
										<th scope="col">모델명</th>
										<th scope="col">가격</th>
										<th scope="col">수량</th>
										<th scope="col">총 금액</th>
										<th scope="col">납품 희망일자</th>
										<th scope="col">삭제</th>
									</tr>
								</thead>
								
						<tbody id="listproduct"></tbody>
						</table>
						</div>
						
						<div class="totalInfo">
							<div>
						    <table class="totalInfotbl">
									<tbody>
									 <tr>
									    <th class="thtitle" colspan="2">장바구니 총액</th>
									  </tr>
									  <tr>
									    <td class="totalinfo">합계 금액</td>
									    <td class="totalinfo" id="orderamountView">
									    	<input type="hidden" value="" name="" id=""/>
									    	<span id="totPrice"></span> 원 </td>
									  </tr>
									  <tr>
									    <td class="totalbtncont" colspan="2">
									    	<a href="" class="btnType blue" id="btnOrderSave" name="btn"><span>입금하기</span></a> 
									    </td>
									  </tr>
									
									</tbody>
								</table>
							</div>
					    </div>
					</div> <!--// content -->
  				
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
		
	<div id="layer1" class="layerPop layerType2" style="width: 300px;">
		<dl>
			<dd class="content">
					<div style="text-align: center; font-size: 17px">입금하시겠습니까?</div>
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnOrderSaveEnd" name="btn"><span>확인</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<div id="layer2" class="layerPop layerType2" style="width: 300px;">
		<dl>
			<dd class="content">
					<div style="text-align: center; font-size: 17px">상품을 선택해 주세요</div>
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>확인</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</body>
</html>