<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>발주/반품지시서</title>
<script src='CTX_PATH/js/sweetalert/sweetalert.min.js'></script>
<script src='/js/lib/twLib.js?v=20220428'></script>
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

	var pageSize = 10;
	var navicnt = 10;
	var divComGrpCodList;
	var layer1;

	
	
	
	//	레디 start
	$(document).ready(function(){
		//초기 실행 함수
		init();
		//발주,반품 목록 조회 함수
		flistDeliOrder();	
	});//	레디 end
	
	
	function init() {
	       
	       divComGrpCodList = new Vue({
	                                    el : "#divComGrpCodList" ,
	                                 data : {
	                                            searchlist : [],
	                                            cal1  : "",
	                        				 	cal2  : "",
	                        				 	sname : "",
	                        				 	oname : "",
	                        				 	radio_cal : "all",
	                        				 	radioshow : false,
	                        				 	searchKey : "all",
	                        				 	statusDiv : "",
	                        				 	viewText : "order",
	                        				 	action : "",
	                                 },
	                                 methods : {
	                                    rchange : function(itype){
	                                    	if(this.radio_cal == "all") {
	                                    		this.radioshow = false;   
	                                    		this.cal1=  '';
	                                    		this.cal2=  '';
	                        		        } else{
	                                    		this.radioshow = true;   
	                                    		this.cal1=  '';
	                                    		this.cal2=  '';		                        		        	
	                        		        }	                                    	
	                                    }, numFormmat : function(num) {
	                                    	return numFormmat(num);
	                                    }, printDate : function(date) {
	                                    	return dateFormatter(date);
	                                    }, viewChange : function(val) {
	                                    	var text = this.viewText;
	                                    	if(text == "order") {
	                                    		this.statusDiv = "발주";
	                                    	} else {
	                                    		this.statusDiv = "반품";
	                                    	}
	                                    	search();
	                                    }, searchData : function() {
	                                    	search();
	                                    }, detailClick : function(orderid) {
	                                    	fPopModalPurchase(orderid);
	                                    }
	                                    
	                                 }
       		});
	       
	       layer1 = new Vue({
               el : "#layer1",
            data : {
         	   		orderId : "",
   	   		  		sales_nm : "",
         	   		name : "",
         	   		deliverStatus : "",
         	   		dl_status : "",
         	   		delverStatus : "",
         	   	    order_cnt : "",
	         	   	price : "",
	         	  	totalPrice : "",
	         	  	status : "",
            },methods : {
            }
});
	}
	
	//검색 버튼
	function search() {
		flistDeliOrder();
	};
	

	/** 발주 반품 목록 조회 */
	function flistDeliOrder(currentPage) {
		
		currentPage = currentPage || 1;
		var cal1 = divComGrpCodList.cal1;
		var cal2 = divComGrpCodList.cal2;
		var sname = divComGrpCodList.sname;
		var oname = divComGrpCodList.oname;
		var radioChk = divComGrpCodList.radioChk;
		
		var viewText = divComGrpCodList.viewText;
		
		if(viewText == "order") { //발주 반품 구분
			divComGrpCodList.statusDiv = "발주";
    	} else {
    		divComGrpCodList.statusDiv = "반품";
    	}
		
		var param = {	
					sname : sname
				,	oname : oname
				,	currentPage : currentPage
				,	pageSize : pageSize
				,	cal1 : cal1
				, 	cal2 : cal2
				,	radioChk : radioChk
				, 	viewText : viewText
 		}
		
		var resultCallback = function(data) {
			displatylist(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		axiosFnc("/dlm/listPurchaseorder.do", "post", param, "p",resultCallback);
		//callAjax("/dlm/listPurchaseorder.do", "post", "text", true, param, resultCallback);
	}

	//가져온 데이터 테이블에 뿌려주기
	 function displatylist(resultdata, currpage) {
		divComGrpCodList.searchlist = resultdata.data.ListPurchaseOrder;
		var  totalCntListDeliOrder = resultdata.data.totalCntListDeliOrder;
		var paginationHtml = getPaginationHtml(currpage, totalCntListDeliOrder, pageSize, navicnt, 'flistDeliOrder');
	      //console.log("paginationHtml : " + paginationHtml);
	      $("#comnGrpCodPagination").empty().append( paginationHtml );
  }	

	
	
	/** 발주/반품지시서 단건 상세 조회 모달 실행 */
	function fPopModalPurchase(orderid) {	//deliverStatus : 발주/반품완료 버튼 없앨려고 만든 파라미터
		// 신규 저장			(사실 만들필요가 없지만...)
		if (orderid == null || orderid == "") {
			// Transaction type 설정
			divComGrpCodList.action = "I"
			
			// 그룹코드 폼 초기화??????????????????????
			//fInitFormGrpCod();
			
			// 모달 팝업
			gfModalPop("#layer1");

		// 수정 저장
		} else {
			// Transaction type 설정
			divComGrpCodList.action = "U"
			// 그룹코드 단건 조회
			fSelectDeliOrder(orderid);
		}
	}
	
	
	/** 발주/반품지시서 단건 상세 조회 */
	function fSelectDeliOrder(orderid) {
		var viewText = divComGrpCodList.viewText;
		var param = { 
						orderid : orderid,
						viewText : viewText
					};
		
		
		
		var resultCallback = function(data) {
			fSelectDeliOrderResult(data);
		};
		axiosFnc("/dlm/selectPurchaseOrder.do", "post", param, "p", resultCallback); //f 폼데이터  ,p객체
		//callAjax("/dlm/selectPurchaseOrder.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 발주/반품지시서 단건 상세 조회 콜백 함수*/
	function fSelectDeliOrderResult(resultData) {
		var data = resultData.data;
		console.log(JSON.stringify(data));
		//console.log("fSelectDeliOrderResult(data) : " + JSON.stringify(data));	//파라미터 확인
		if (data.result == "SUCCESS") {
			// 모달 팝업
			gfModalPop("#layer1");
			// 그룹코드 폼 데이터 설정
			fInitFormDeliOrder(data.purchaseorderModel);
		} else {
			swal(data.resultMsg);
		}	
	}
	
	
	/** 발주/반품지시서 폼 데이터 설정 */
	function fInitFormDeliOrder(data){
		//console.log("---------------------------------------------------")
		//console.log(" data.wh_id_ship = " + data.wh_id);
		//console.log("fInitFormDeliOrder(data) : " + JSON.stringify(data));
		layer1.orderId = data.orderid;
		layer1.sales_nm = data.sales_nm;
		layer1.name = data.name;
		layer1.order_cnt = data.order_cnt;
		layer1.price = numFormmat(data.price)+"원";
		
		var totalPrice = (data.price * data.order_cnt);
		layer1.totalPrice = numFormmat(totalPrice) + "원"; //넘버 포멧 함수
		var ortext = divComGrpCodList.viewText == "order" ? "발주" : "반품";
		layer1.status = ortext;
	}
		
	
	
	/** 발주/반품지시서 발주/반품상태 저장 */
	function fSaveDeliOrder() {
		//console.log("fSaveDeliOrder")
		var resultCallback = function(data) {
			fSaveDeliOrderResult(data);
		};
		//console.log("$('#myForm').serialize() : "+$("#myForm").serialize().replace(/%/g, '%25'));
		var msgConfirm = confirm('발주/반품시작을 처리하시겠습니까?')
		if(msgConfirm){
			console.log("myForm == " + $("#myForm").serialize());
			callAjax("/dlm/saveDeliOrder.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
		}
	}
	
	/** 발주/반품지시서 발주/반품상태 저장 콜백 함수 */
	function fSaveDeliOrderResult(data) {
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {	//액션이 "I"값이 아니라면?
			currentPage = $("#currentPageListDeliOrder").val();	//	현재페이지 번호를 변수로 담아라
		}
		
		//console.log("data.result ===== " +  JSON.stringify(data));
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
				<div class="content" id="divComGrpCodList">
					<!-- 상단 네비게이션 -->			
					<p class="Location">
						<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 					
					    <span class="btn_nav bold">기업고객</span> 
						<span class="btn_nav bold">발주/반품 지시서</span>						
						<a href="../dlm/deliveryBuyer.do" class="btn_set refresh">새로고침</a>
					</p>
					<!-- // 상단 네비게이션 -->	
					
					
					
					<!-- 목록 영역 -->	
					<div class="shippingList_area"  >
					
                    	<!--검색 바 테이블 -->
                        <table style="margin-top:10px; margin-bottom:20px;" width="100%" cellpadding="5"
                           cellspacing="0" border="1" align="left"
                           style="collapse; border: 1px #50bcdf;">
                           <tr style="border: 0px; border-color: blue">
                           		<td width="40" height="25" style="font-size: 120%;">&nbsp;</td>
                              	<td width="*" height="25" style="font-size: 100%; text-align: center;">
	                           		<input type="radio" name="radio_chk" id="radio_order" value="order" v-model="viewText" @change="viewChange">
	                           		<label for="radio_order">발주</label> 
	                                <input type="radio" name="radio_chk" id="radio_refund" value="refund" v-model="viewText" @change = "viewChange">
	                                <label for="radio_refund">반품</label>
                           		</td>
                           </tr>
                           <tr style="border: 0px; border-color: blue">
                              <td width="40" height="25" style="font-size: 120%;">&nbsp;</td>
                              <td width="*" height="25" style="font-size: 100%; text-align: center;">
                                 <!-- select option -->
                                 <select id="searchKey" name="searchKey" style="width: 80px; height: 27px;" v-model="searchKey">
                                    <option value="all">전체</option>
                                    <option value="U">발주/반품준비</option>
                                    <option value="O">발주/반품시작</option>
                                    <option value="E">발주/반품완료</option>
                                 </select>                                 
                                 <!-- search name -->
                                 <input type="text" style="width: 150px; height: 25px;" v-model="sname" placeholder="제품명 입력"  onkeypress="if( event.keyCode==13 ){flistDeliOrder();}"> &nbsp;&nbsp;&nbsp;
                                 <!-- calendar date -->
                                 <input type="radio" value="all" v-model="radio_cal" @change="rchange"><label for="radio_cal1">전체</label> 
                                 <input type="radio" value="choice" v-model="radio_cal" @change="rchange">
                                	<label for="radio_cal2">선택</label> 
                                 <input type="date" v-model="cal1" style="height: 25px;" v-show="radioshow" />
								 <input type="date" v-model="cal2" style="height: 25px;" v-show="radioshow" />
                         		 <!-- button -->
                                 <a href="#!" class="btnType blue" @click="searchData" name="btn"><span>검색</span></a>&nbsp;
                              <td width="40" height="25" style="font-size: 120%;">&nbsp;</td>
                           </tr>
                        </table>
                        <!--//검색 바 테이블 -->
                        
                        <!-- 리스트 테이블 영역 -->
                        <table class="col">
                        
                           <caption>caption</caption>
                           
                           <colgroup>
                          	  <col width="6%">
                              <col width="*%">
                              <col width="7%">
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
                                 <th scope="col">제품명</th>
                                 <th scope="col">고객명</th>
                                 <th scope="col">구분</th>
                                 <th scope="col">수량</th>
                                 <th scope="col">총액</th>
<!--                                  <th scope="col">출발창고지</th> -->
<!--                                  <th scope="col">목적지</th> -->
                                 <th scope="col">등록일</th>
                                 <th scope="col">처리일자</th>
<!--                                  <th scope="col">삭제일</th> -->
                              </tr>
                           </thead>
                           
                           
                           <!-- tbody에 리스트 출력 -->
                           <tbody id="tbodyList" v-for="(v, i) in searchlist">
                           		<tr class="hover_row" @click="detailClick(v.orderid)">
									<td style="color: black; font-weight: bold;">
										{{ i + 1 }}
									</td>
									<td>{{ v.sales_nm }}</td>
									<td>{{ v.name }}</td> 
									<td> {{ statusDiv }}</td>
									<td>{{ v.order_cnt }}</td>
									<td>{{ numFormmat(v.order_cnt * v.price) }} 원</td>
									<td>{{ printDate(v.regdate) }}</td>
									<td>{{ printDate(v.editdate) }}</td>
<%-- 								<td><fmt:formatDate value="${list.deldate}" pattern="yyyy-MM-dd" /></td>	 --%>
								</tr>                          
                           </tbody>
                        </table>
                        <!--// 테이블 영역 -->
                     </div>
                     
                     <!-- 페이징 영역 -->
                     <div class="paging_area"  id="comnGrpCodPagination"> </div>
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
				<strong>발주/반품지시서 상세</strong>
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
							<th scope="row">
								발주/반품 번호 <span class="font_red">*</span>
							</th>
							<td colspan="3">
								<input type="text" class="inputTxt p100" v-model="orderId" readonly="readonly"/>
								</td>		
						</tr>
						<tr>
							<th scope="row">
								제품명 <span class="font_red">*</span>
							</th>
							<td colspan="3">
								<input type="text" class="inputTxt p100" v-model="sales_nm" readonly="readonly"/>
							</td>							
						</tr>
						<tr>
							<th scope="row">
								고객명 <span class="font_red">*</span>
							</th>
							<td>
								<input type="text" class="inputTxt p100" v-model="name" readonly="readonly"/>
							</td>
							<th scope="row">
								발주/반품상태 <span class="font_red">*</span>
							</th>
							<td>
								<input type="text" class="inputTxt p100" v-model="deliverStatus" readonly="readonly"/>
								<input type="hidden" class="inputTxt p100" v-model="dl_status"  readonly="readonly" />
							</td>
						</tr>
						<tr>
							<th scope="row">
								수량 <span class="font_red">*</span>
							</th>
							<td colspan="3">
								<input type="text" class="inputTxt p100" v-model="order_cnt" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<th scope="row">
								금액 <span class="font_red">*</span>
							</th>
							<td colspan="3">
								<input type="text" class="inputTxt p100" v-model="price" readonly="readonly"/>
							</td>
						</tr>
						<tr>					
							<th scope="row">
								총액 <span class="font_red">*</span>
							</th>
							<td colspan="3">
								<input type="text" class="inputTxt p100" v-model="totalPrice" readonly="readonly" />
							</td>
						</tr>
						<tr>					
							<th scope="row">
								구분 <span class="font_red">*</span>
							</th>
							<td colspan="3">
								<input type="text" class="inputTxt p100" v-model="status" readonly="readonly" />
							</td>
						</tr>
<!-- 						<tr> -->
<!-- 							<th scope="row">발주/반품상태 수정<span class="font_red">*</span></th> -->
<!-- 							<td colspan="3"> -->
<!-- 								<input type="radio" id="radio1-1" name="deliverStatus" id="deliverStatus_1" value='U' style="margin-left: 10px;"/> <label for="radio1-1" >발주/반품준비</label> -->
<!-- 								<input type="radio" id="radio1-2" name="deliverStatus" id="deliverStatus_2" value="O" style="margin-left: 10px;"/> <label for="radio1-2" >발주/반품시작</label> -->
<!-- 								<input type="radio" id="radio1-3" name="deliverStatus" id="deliverStatus_3" value="E" style="margin-left: 10px;"/> <label for="radio1-3" >발주/반품완료</label>			 -->
<!-- 							</td> -->
<!-- 						</tr> -->
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" @click="statusUpdate()" ><span>발주/반품완료</span></a> 
					<a href="" class="btnType gray" @click="getModalclose()"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!-- // 모달팝업 -->
</form>	
</body>
</html>