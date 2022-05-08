<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>배송지시서</title>
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

	
	var pagesize = 10;
    var navicnt = 10;
	var divComGrpCodList;
    var layer1;
    
	
	//	레디 start
	$(document).ready(function(){
		
	    init();
	    
	    fn_listsearch();
		
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
	                                 },
	                                 methods : {
	                                	 detailClick : function (deliv_id,deliverStatus,deliv_wh_id) {
                                		 	fPopModalDeliOrder(deliv_id,deliverStatus,deliv_wh_id);
	                                    },
	                                    printDate : function(date) {
	                                    	return dateFormatter(date);
	                                    },
	                                    statusData : function(datas,key,value) {
	                                    	//let key = 'U,O,E';
	                                    	//let value = '배송준비,배송시작,배송완료';
	                                    	return statusVal(datas,key,value);
	                                    },
	                                    searchData : function() {
	                                    	search();
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
	                            	   		deliv_id : "",
                           	   		  		sales_nm : "",
                            	   			sales_id : "",
	                            	   		pur_cnt : "",
	                            	   		name : "",
	                            	   		hidden_deliverStatus : "",
	                            	   		wh_nm : "",
	                            	   		wh_id : "",
	                            	   		address : "",
	                            	   		dtAddress : "",
	                            	   		deliverStatus : "",
	                            	   		deliverStatusUd : "",
                                            statusBtnshow : false,
                                            statusFinishBtnshow : false
	                               },methods : {
	                            	   statusClick : function() {
	                            		   flistDeliOrder();
	                            	   },
	                                    closeModal : function() {
	                                    	gfCloseModal();
	                                    }
	                               }
	       });
	    }   
	
	//검색 버튼
	function search() {
		fn_listsearch();
	};
	
	//리스트 값 가져오기
	 function fn_listsearch(currpage) {
		
			currpage = currpage || 1;
			var sname = divComGrpCodList.sname;
			var oname = divComGrpCodList.oname;  
			var cal1 = divComGrpCodList.cal1;
			var cal2 = divComGrpCodList.cal2;
			//파일업로드 관련 폼데이터
		 	//const frm = new FormData();
			//var fileTest = divComGrpCodList.fileTest.files[0];
			/*
			var fileTest = document.getElementById('fl').files[0];
			frm.append("currentPage",currpage);
			frm.append("pageSize",pagesize);
			frm.append("sname",sname);
			frm.append("oname",oname);
			frm.append("fileTest",fileTest);
		 	*/
			var param = {
				 		currentPage : currpage      
				 	,	pageSize : pagesize
				 	,	sname : sname
				 	,	oname : oname
				 	,	cal1 : cal1
				 	,	cal2 : cal2
	       };
	       
	       
	       var listcollback = function(resultdata) {
	           displatylist(resultdata, currpage);
	       }
	       
	       axiosFnc("/dlm/listDeliOrder.do", "post", param, "p", listcollback); //f 폼데이터  ,p객체
	       //callAjax("/dlm/listDeliOrder.do", "post", "json", true, param, listcollback);
	    }
	
	//가져온 데이터 테이블에 뿌려주기
	 function displatylist(resultdata, currpage) {
		divComGrpCodList.searchlist = resultdata.data.listShippingModel;
		var  totalCntListDeliOrder = resultdata.data.totalCntListDeliOrder;
		var paginationHtml = getPaginationHtml(currpage, totalCntListDeliOrder, pagesize, navicnt, 'fn_listsearch');
	      //console.log("paginationHtml : " + paginationHtml);
	      $("#comnGrpCodPagination").empty().append( paginationHtml );
   } 
	
	
	
	/** 배송지시서 단건 상세 조회 모달 실행 */
	function fPopModalDeliOrder(deliv_id, deliverStatus,deliv_wh_id) {	//deliverStatus : 배송완료 버튼 없앨려고 만든 파라미터
		// 신규 저장			(사실 만들필요가 없지만...)
		if (deliv_id == null || deliv_id=="") {
			// Transaction type 설정
			//$("#action").val("I");	//INSERT
			layer1.action = "I";
			// 그룹코드 폼 초기화??????????????????????
			//fInitFormGrpCod();
			
			// 모달 팝업
			gfModalPop("#layer1");

		// 수정 저장
		} else {
			// Transaction type 설정
			//$("#action").val("U");	//UPDATE
			layer1.action = "U";
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
		
		if(deliverStatus == "U"){	//배송준비중이면 배송시작 버튼 보이게
			layer1.statusBtnshow = true;
			layer1.statusFinishBtnshow = false;
		} else if(deliverStatus == "O") {
			layer1.statusBtnshow = false;
			layer1.statusFinishBtnshow = true;
		} else{	//배송완료버튼 숨기기
			layer1.statusBtnshow = false;
			layer1.statusFinishBtnshow = false;
		}
		
		
		var resultCallback = function(data) {
			fSelectDeliOrderResult(data);
		};
		
		//callAjax("/dlm/selectDeliOrder.do", "post", "json", true, param, resultCallback);
		axiosFnc("/dlm/selectDeliOrder.do", "post", param,"p", resultCallback);//f 폼데이터  ,p객체
	}
	
	
	/** 배송지시서 단건 상세 조회 콜백 함수*/
	function fSelectDeliOrderResult(resultData) {
		let data = resultData.data;
		console.log("fSelectDeliOrderResult(data) : " + JSON.stringify(data));	//파라미터 확인
		if (data.result == "SUCCESS") {
			// 모달 팝업
			gfModalPop("#layer1");
			// 그룹코드 폼 데이터 설정
			fInitFormDeliOrder(data.shippingModel);
		} else {
			(data.resultMsg);
		}
		
	}
	
	
	
	 
	
	
	
	/** 배송지시서 폼 데이터 설정 */
	function fInitFormDeliOrder(data){
		//console.log("---------------------------------------------------")
		//console.log(" data.wh_id_ship = " + data.wh_id);
		//console.log("fInitFormDeliOrder(data) : " + JSON.stringify(data));
		//console.log(" data.deliverStatus ==  " + data.deliverStatus)
		layer1.deliv_id = data.deliv_id;
		layer1.sales_nm = data.sales_nm;
		layer1.sales_id = data.sales_id;
		layer1.pur_cnt = data.pur_cnt;
		layer1.name = data.name;
		//배송상태
		layer1.hidden_deliverStatus = data.deliverStatus;
		layer1.wh_nm = data.wh_id_ship;
		layer1.wh_id = data.deliv_wh_id;
		layer1.address = data.address;
		layer1.dtAddress = data.dtAddress;
		//배송 시작, 완료 구분
		layer1.deliverStatusUd = layer1.hidden_deliverStatus == "U" ? "O" : "E";
		
		
		if(layer1.hidden_deliverStatus == "U"){
			layer1.deliverStatus = "배송준비";	//name속성 없음
		}else if(layer1.hidden_deliverStatus == "O"){
			layer1.deliverStatus = "배송시작";
		}else if(layer1.hidden_deliverStatus == "E"){
			layer1.deliverStatus = "배송완료";
		}
	}
	
	/** 배송지시서 배송상태 저장 */
	function flistDeliOrder() {
		//console.log("fSaveDeliOrder")
		var resultCallback = function(data) {
			fSaveDeliOrderResult(data);
		};
		var param = {
			"deliv_id" : layer1.deliv_id,
			"dl_status" : layer1.deliverStatusUd,
			"pur_cnt" : layer1.pur_cnt,
			"sales_id" : layer1.sales_id,
			"wh_id" : layer1.wh_id,
			"deliverStatus" : layer1.hidden_deliverStatus,
			"action" : layer1.action
		}
		var confirmText = layer1.hidden_deliverStatus == "U" ? "배송을 시작하시겠습니까?" : "배송을 완료하시겠습니까?"
		var msgConfirm = confirm(confirmText)
		if(msgConfirm){
			//callAjax("/dlm/saveDeliOrder.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
			
			axiosFnc("/dlm/saveDeliOrder.do", "post", param, "p", resultCallback); //url,method,param,callback, pfChk
		}
	}
	
	/** 배송지시서 배송상태 저장 콜백 함수 */
	function fSaveDeliOrderResult(resultData) {
		//console.log("jsonparsing  === " + JSON.stringify(resultData));
		var data = resultData.data;
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if (layer1.action != "I") {	//액션이 "I"값이 아니라면?
			currentPage = $("#currentPageListDeliOrder").val();	//	현재페이지 번호를 변수로 담아라
		}
		//console.log("data.result ===== " +  JSON.stringify(data));
		if (data.result == "SUCCESS") {
			// 응답 메시지 출력
			alert(data.resultMsg);	
			//console.log(data.resultMsg);
			// 모달 닫기
			gfCloseModal();
			// 특정 페이지로 목록 조회
			fn_listsearch(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
		
		// 입력폼 초기화		잘 모르겠음, 필요 없는듯
		//fInitFormGrpCod();
	}
	
	
	
	
	/** 버튼 이벤트 등록
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {	//네임속성으로 id값 지정하기
			e.preventDefault();
			alert()
			//console.log("e : " + e.preventDefault());
			
			var btnId = $(this).attr('id');
			//console.log("btnId : "+btnId);
			
			switch (btnId) {			
				case 'btnSaveDeliOrder' :	//배송준비 버튼
					fSaveDeliOrder();
					break;
				case 'btnSaveDeliOrderFinish' :	//배송시작 버튼
					fSaveDeliOrder();
					break;
				case 'btnCloseDeliOrder' :	//닫기(취소) 버튼
					gfCloseModal();
					break;
			}
		});
	}
	 */
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
<form id="myForm" v-model="" ref="myForm" action=""  method="" onSubmit="return false">
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
					<div class="shippingList_area" id="divComGrpCodList">
					
                    	<!--검색 바 테이블 -->
                        <table style="margin-top:10px; margin-bottom:20px;" width="100%" cellpadding="5"
                           cellspacing="0" border="1" align="left"
                           style="collapse; border: 1px #50bcdf;">
                           <tr style="border: 0px; border-color: blue">
                              <td width="40" height="25" style="font-size: 120%;">&nbsp;</td>
                              <td width="*" height="25" style="font-size: 100%; text-align: center;">
                                 <!-- select option -->
                                 <select id="searchKey" name="searchKey" v-model="oname" style="width: 80px; height: 27px;" >
                                    <option value="" selected>전체</option>
                                    <option value="U">배송준비</option>
                                    <option value="O">배송시작</option>
                                    <option value="E">배송완료</option>
                                 </select>                                 
                                 <!-- search name -->
                                 <input type="text" style="width: 150px; height: 25px;" id="sname" v-model="sname" name="sname" placeholder="제품명 입력"  onkeypress="if( event.keyCode==13 ){flistDeliOrder();}"> &nbsp;&nbsp;&nbsp;
                                 <!-- calendar date -->
                                 <input type="radio" name="radio_cal" id="radio_cal1"  value="all" v-model="radio_cal"  @change="rchange"  ><label for="radio_cal1">전체</label> 
                                 <input type="radio" name="radio_cal" id="radio_cal2" value="choice" v-model="radio_cal" @change="rchange" ><label for="radio_cal2">선택</label> 
                                 <input type="date" name="cal1" id="cal1" v-model="cal1" v-show="radioshow" style="height: 25px;" />
								 <input type="date" name="cal2" id="cal2" v-model="cal2" v-show="radioshow" style="height: 25px;" />
                         		 <!-- button -->
                                 <a href="#" class="btnType blue" id="btnSearch" name="btn" @click="searchData()"><span>검색</span></a>&nbsp;
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
                           <tbody v-for="(item,index) in searchlist">                          
                           <tr @click="detailClick(item.deliv_id,item.deliverStatus,item.deliv_wh_id)">
                           <td>{{ index + 1 }}</td>
                           <td>{{ item.deliv_id}}</td>
                           <td>{{ item.sales_nm}}</td>
                           <td>{{ item.pur_cnt}}</td>
                           <td>{{ item.name}}</td>
                           <td>{{ statusData(item.deliverStatus,'U,O,E','배송준비,배송시작,배송완료') }}</td>
                           <td>{{ printDate(item.regdate) }}</td>
                           <td>{{ printDate(item.editdate)}}</td>   
                        </tr>   
                     </tbody>
                        </table>
                        <!--// 테이블 영역 -->
                     </div>
                     <div class="paging_area"  id="comnGrpCodPagination"> </div>
                     <!-- 페이징 영역 -->
					
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
							<td colspan="3">
								<input type="hidden" name="deliverStatus" v-model="hidden_deliverStatus" id="hidden_deliverStatus">
								<input type="text" class="inputTxt p100" v-model="deliv_id" name="deliv_id" id="deliv_id" readonly="readonly"/>
								</td>		
						</tr>
						<tr>
							<th scope="row">제품명 <span class="font_red">*</span></th>
							<td colspan="3">
								<input type="text" class="inputTxt p100" name="sales_nm" v-model="sales_nm" id="sales_nm" readonly="readonly"/>
								<input type="hidden" class="inputTxt p100" name="sales_id" v-model="sales_id" id="sales_id" readonly="readonly"/>
							</td>							
						</tr>
						<tr>
							<th scope="row">수량 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" v-model="pur_cnt" name="pur_cnt" id="pur_cnt" readonly="readonly"/></td>
						</tr>
						<tr>
							<th scope="row">배송담당자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="name" v-model="name" id="name" readonly="readonly"/></td>
							<th scope="row">배송상태 <span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100" v-model="deliverStatus" id="deliverStatus" readonly="readonly" />
								<input type="hidden" class="inputTxt p100" v-model="dl_status" id="dl_status"  name="dl_status"  readonly="readonly" />
							</td>
						</tr>
						<tr>					
							<th scope="row">출발창고지 <span class="font_red">*</span></th>
							<td colspan="3">
								<input type="text" class="inputTxt p100" v-model="wh_nm" name="wh_nm" id="wh_nm" readonly="readonly" />
								<input type="hidden" class="inputTxt p100" v-model="wh_id" name="wh_id" id="wh_id" readonly="readonly" />
							</td>
						</tr>
						<tr>					
							<th scope="row">주소1 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" v-model="address" name="address" id="address" readonly="readonly" /></td>
						</tr>
						<tr>					
							<th scope="row">주소2 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" v-model="dtAddress" name="dtAddress" id="dtAddress" readonly="readonly" /></td>
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
					<a href="#!" class="btnType blue"  @click="statusClick()" v-if="statusBtnshow" name="btn"><span>배송시작</span></a>
					<a href="#!" class="btnType blue"  @click="statusClick()" v-if="statusFinishBtnshow" name="btn"><span>배송완료</span></a> 
					<a href="#!" class="btnType gray" @click="closeModal()" id="btnCloseDeliOrder" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!-- // 모달팝업 -->
</form>	
</body>
</html>