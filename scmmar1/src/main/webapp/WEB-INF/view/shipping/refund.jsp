<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>반품지시서</title>
<script src='CTX_PATH/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src='/js/lib/twLib.js?v=20220428'></script> <!--  개인 소스  -->
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
	
	
	var pagesize = 10;
	var navicnt = 10;
	var divComGrpCodList;
	var layer1 = "";
	var divComGrpCodList;
	var layer1;
	
	//	레디 start
	$(document).ready(function(){
		//반품지시서 목록 조회 함수
		init();
		flistRefund();	
		
	});//	레디 end
	
	function init() {
	       
	       divComGrpCodList = new Vue({
	                                    el : "#divComGrpCodList" ,
	                                 data : {
	                                            searchlist : [],
	                                            cal1  : "",
	                        				 	cal2  : "",
	                                            sname : "",
	                        				 	radio_cal : "all",
	                        				 	deliverStatus : "",
	                        				 	deliv_id : "",
	                        				 	radioshow : false,
	                        				 	action : ""
	                                 },
	                                 methods : {
	                                	 detailClick : function (return_id) {
                             		 	 	fPopModalDeliOrder(return_id);
	                                    },
	                                    searchData : function() {
	                                    	search();
	                                    },
	                                    
	                                    printDate : function(date) {
	                                    	return dateFormatter(date);
	                                    },
	                                    statusData : function(datas,key,value) {
	                                    	//let key = 'U,O,E';
	                                    	//let value = '배송준비,배송시작,배송완료';
	                                    	return statusVal(datas,key,value);
	                                    },
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
	                                    }
	                                 }
	       });
	       
	       layer1 = new Vue({
	                                  el : "#layer1",
	                               data : {
	                            	   		return_id : "",
                         	   				sales_id : "",
                         	   				sales_nm : "",
	                            	   		client : "",
	                            	   		rfinfo_id : "",
	                            	   		dtAddress : "",
	                            	   		address : "",
	                            	   		wh_nm : "",
	                            	   		wh_id : "",
	                            	   		deliv_id : "",
	                            	   		deliverStatus : "",
	                            	   		name : "",
	                            	   		pur_cnt : 0,
	                            	   		btnSaveDeliOrder : false
	                               },methods : {
	                            	   statusClick : function() {
	                            		   fSaveDeliOrder();
	                            	   },
	                                    closeModal : function() {
	                                    	gfCloseModal();
	                                    }
	                               }
	       });
	      
	    }   
	
	function search() { //검색 내용 출력
		flistRefund();
	}
	
	
	
	

	/** 반품지시서 목록 조회 */
	function flistRefund(currentPage) {
		
		currentPage = currentPage || 1;
		
		var sname = divComGrpCodList.sname;
		var cal1 = divComGrpCodList.cal1;
		var cal2 = divComGrpCodList.cal2;
		
		var param = {	
					sname : sname
				,	currentPage : currentPage
				,	pageSize : pagesize
				,	cal1 : cal1
				, 	cal2 : cal2
		}
		
		var resultCallback = function(data) {
			displatylist(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//callAjax("/dlm/listRefund.do", "post", "text", true, param, resultCallback);
		axiosFnc("/dlm/listRefund.do", "post", param, "p", resultCallback); //f 폼데이터  ,param객체
	}

	
	//가져온 데이터 테이블에 뿌려주기
	 function displatylist(resultdata, currpage) {
		divComGrpCodList.searchlist = resultdata.data.listRefund;
		var  totalCntListRefund = resultdata.data.totalCntListRefund;
		var paginationHtml = getPaginationHtml(currpage, totalCntListRefund, pagesize, navicnt, 'flistRefund');
	      //console.log("paginationHtml : " + paginationHtml);
	      $("#comnGrpCodPagination").empty().append( paginationHtml );
  } 	

	
	
	/** 반품지시서 단건 상세 조회 모달 실행 */
/** 배송지시서 단건 상세 조회 */
	function fPopModalDeliOrder(return_id) {
		var param = { return_id : return_id };
		
		
		var resultCallback = function(data) {
			fSelectDeliOrderResult(data)
		};
		
		axiosFnc("/dlm/detailRefund.do", "post", param, "p", resultCallback); //f 폼데이터  ,param객체
		//callAjax("/dlm/detailRefund.do", "post", "json", true, param, resultCallback);
	}
	
function fSelectDeliOrderResult(resultData) {
		var data = resultData.data;
 		console.log("fSelectDeliOrderResult(data) : " + JSON.stringify(data));	//파라미터 확인
 		if (data.result == "SUCCESS") {

 			// 모달 팝업
 			gfModalPop("#layer1");
// 			// 그룹코드 폼 데이터 설정
 			fInitFormDeliOrder(data.refundModel);
			
 		} else {
 			swal(data.resultMsg);
 		}	
 	}
	
	
	/** 반품지시서 폼 데이터 설정 */
 	function fInitFormDeliOrder(data){
 		//console.log("fInitFormDeliOrder(data) : " + JSON.stringify(data));
			
	 		layer1.return_id = data.return_id;
	 		layer1.sales_id = data.sales_id;
	 		layer1.pur_cnt = data.return_cnt;
	 		layer1.client = data.client;
	 		layer1.rfinfo_id = data.rfinfo_id;
	 		layer1.dtAddress = data.dtAddress;
	 		layer1.address = data.address;
	 		layer1.wh_nm = data.wh_nm;
	 		layer1.wh_id = data.wh_id;
	 		layer1.deliv_id = data.deliv_id;
	 		layer1.sales_nm = data.sales_nm;
	 		var deliverStatus = data.deliverStatus;
	 		layer1.deliverStatusData = data.deliverStatus;
	 		
			var name = '${sessionScope.userNm}';
			layer1.name = name;
	 		//반품상태
	 		if(deliverStatus=="U"){
	 			layer1.deliverStatus = "반품전";	//name속성 없음
	 			layer1.btnSaveDeliOrder = true;
	 		}else if(deliverStatus=="E"){
	 			layer1.deliverStatus = "반품완료";	//name속성 없음
	 			layer1.btnSaveDeliOrder = false;
	 		}
	 		
 		
 		
 	}
		
	
	
	/** 반품지시서 반품상태 저장 */
 	function fSaveDeliOrder() {
		
		var param = {
				"pur_cnt" : layer1.pur_cnt,
				"sales_id" : layer1.sales_id,
				"wh_id" : layer1.wh_id,
				"deliv_id" : layer1.deliv_id,
				"return_id" : layer1.return_id,
				"deliverStatus" : layer1.deliverStatusData
		}
		
 		var resultCallback = function(data) {
 			fSaveDeliOrderResult(data);
 		};
 		
 		var msgConfirm = confirm('반품완료 처리하시겠습니까?')
 		if(msgConfirm){
 			axiosFnc("/dlm/saveDeliReturn.do", "post", param, "p", resultCallback); //url,method,param, pfChk, callback
 			//callAjax("/dlm/saveDeliReturn.do", "post", "json", true, $("#myForm").serialize(), resultCallback);			
 		}
 	}
	
	/** 반품지시서 반품상태 저장 콜백 함수 */
 	function fSaveDeliOrderResult(resultData) {
		console.log("fSaveDeliOrderResult = " + JSON.stringify(resultData));
		var data = resultData.data;
 		// 목록 조회 페이지 번호
 		var currentPages = "1";
 		
 		/*
 		if ($("#action").val() != "I") {	//액션이 "I"값이 아니라면?
 			currentPage = $("#currentPageListDeliOrder").val();	//	현재페이지 번호를 변수로 담아라
 		}
 		*/
		
 		if (data.result == "SUCCESS") {
			
 			// 응답 메시지 출력
 			swal(data.resultMsg);		
 			// 모달 닫기
 			gfCloseModal();	
 			// 특정 페이지로 목록 조회
 			flistRefund(currentPages);
			
 		} else {
 			// 오류 응답 메시지 출력
 			swal(data.resultMsg);
 		}
		
// 		// 입력폼 초기화		잘 모르겠음, 필요 없는듯
// 		//fInitFormGrpCod();
 	}
	
	
	
//---------------------------------------------------------------------------------------------------------------------------------------	
	
</script>
<form id="myForm" action=""  method="" onSubmit="return false">
	<!-- 이건 왜 있는거? 요소 확인용인가? >>> 업데이트 쿼리 실행시 로드시킬 페이지 인덱스 번호인듯  -->
	<input type="hidden" id="currentPageListRefund" value="1">
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
						<span class="btn_nav bold">반품 지시서</span>						
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
                                                            
                                 <!-- search name -->
                                 <label for="sname">업체명</label>
                                 <input type="text" style="width: 150px; height: 25px;" v-model="sname" placeholder="업체명 입력"  onkeypress="if( event.keyCode==13 ){flistRefund();}"> &nbsp;&nbsp;&nbsp;
                                
                                 <!-- calendar date -->
                                 <input type="radio" name="radio_cal" v-model="radio_cal" @change="rchange" value="all"><label for="radio_cal1">전체</label> 
                                 <input type="radio" name="radio_cal" v-model="radio_cal" @change="rchange" value="choice"><label for="radio_cal2">선택</label> 
                                 <input type="date" name="cal1" v-model="cal1" v-show="radioshow" />
								 <input type="date" name="cal2" v-model="cal2" v-show="radioshow" />
                         		
                         		 <!-- button -->
                                 <a href="#!" class="btnType blue" @click="searchData()"><span>검색</span></a>&nbsp;
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
                              <col width="11%">
                              <col width="*%">
                              <col width="8%">
                              <col width="10%">
                              <col width="10%">
                              <col width="16%">
                           </colgroup>

                           <thead>
                              <tr>
                              	 <th scope="col">순번</th>
                                 <th scope="col">반품 번호</th>
                              	 <th scope="col">고객명</th>
                                 <th scope="col">제품명</th>
                                 <th scope="col">반품 개수</th>
                                 <th scope="col">반품 상태</th>
                                 <th scope="col">등록일</th>
                                 <th scope="col">반품 처리일</th>
                                 <th scope="col">배정 창고</th>
                              </tr>
                           </thead>
                           
                           
                           <!-- tbody에 리스트 출력 -->
                           <tbody v-for="(v , i) in searchlist" @click="detailClick(v.return_id)">
                               <td>{{ i + 1 }}</td>
	                           <td>{{ v.return_id}}</td>
	                           <td>{{ v.client}}</td>
	                           <td>{{ v.sales_nm}}</td>
	                           <td>{{ v.return_cnt}}</td>
	                           <td>{{ statusData(v.deliverStatus,'U,E','반품준비,반품완료') }}</td>
	                           <td>{{ printDate(v.regdate) }}</td>
	                           <td>{{ printDate(v.editdate)}}</td>                          
	                           <td>{{ v.wh_nm}}</td>                          
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
				<strong>반품지시서 상세</strong>
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
							<th scope="row">반품번호 <span class="font_red">*</span></th>
							<td colspan="3">
								<input type="hidden" v-model="deliverStatus" >
								<input type="hidden" v-model="deliv_id" >
								<input type="hidden" v-model="wh_id" >
								<input type="text" class="inputTxt p100" v-model="return_id" />
								<%-- 외래키 키  반품 상세 값 --%>
								<input type="hidden" class="inputTxt p100" v-model="rfinfo_id" />
							</td>		
						</tr>
						<tr>
							<th scope="row">제품명 <span class="font_red">*</span></th>
							<td colspan="3">
								<input type="text" class="inputTxt p100" v-model="sales_nm"/>
								<input type="hidden" class="inputTxt p100" v-model="sales_id" />
							</td>							
						</tr>
						<tr>
							<th scope="row">수량 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" v-model="pur_cnt" /></td>
						</tr>
						<tr>
							<th scope="row">고객명 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" v-model="client"/></td>
						</tr>
						<tr>
							<th scope="row">반품담당자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="name" /></td>
							<th scope="row">반품상태 <span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100"
								 	v-model="deliverStatus" />
							</td>
						</tr>
						<tr>					
							<th scope="row">출발창고지 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" v-model="wh_nm"  /></td>
						</tr>
						<tr>					
							<th scope="row">주소1 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" v-model="address"  /></td>
						</tr>
						<tr>					
							<th scope="row">주소2 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" v-model="dtAddress" /></td>
						</tr>
<!-- 						<tr> -->
<!-- 							<th scope="row">반품상태 수정<span class="font_red">*</span></th> -->
<!-- 							<td colspan="3"> -->
<!-- 								<input type="radio" id="radio1-1" name="deliverStatus" id="deliverStatus_1" value='U' style="margin-left: 10px;"/> <label for="radio1-1" >반품준비</label> -->
<!-- 								<input type="radio" id="radio1-2" name="deliverStatus" id="deliverStatus_2" value="O" style="margin-left: 10px;"/> <label for="radio1-2" >반품시작</label> -->
<!-- 								<input type="radio" id="radio1-3" name="deliverStatus" id="deliverStatus_3" value="E" style="margin-left: 10px;"/> <label for="radio1-3" >반품완료</label>			 -->
<!-- 							</td> -->
<!-- 						</tr> -->
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="#!" class="btnType blue" @click="statusClick()" v-show="btnSaveDeliOrder"  ><span>반품완료</span></a> 
					<a href="#!" class="btnType gray" @click="closeModal()"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!-- // 모달팝업 -->
</form>	
</body>
</html>