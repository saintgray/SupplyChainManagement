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
<title>반품 신청</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

//달력 
$(document).ready(function(){       
    $( "#sdate,#edate" ).datepicker({
         changeMonth: true,
         changeYear: true,
         showMonthAfterYear: true,
         dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
         dateFormat:'yy-mm-dd',
     });
    
    $('#sdate').datepicker("option", "maxDate", $("#edate").val());
    $('#sdate').datepicker("option", "onClose", function (selectedDate){
        $("#edate").datepicker( "option", "minDate", selectedDate );
        });
    
    $('#edate').datepicker();
    $('#edate').datepicker("option", "minDate", $("#sdate").val());
    $('#edate').datepicker("option", "onClose", function (selectedDate){
        $("#sdate").datepicker( "option", "maxDate", selectedDate );
       });
});


//그룹코드 페이징 설정
var pageSizeComnGrpCod = 5;
var pageBlockSizeComnGrpCod = 5;

// 상세코드 페이징 설정
var pageSizeComnDtlCod = 5;
var pageBlockSizeComnDtlCod = 10;

/** OnLoad event */ 
$(function() {
	// 그룹코드 조회
	board_search();
	
	//창고명
	selectComCombo("wh", "samplewh", "sel"); 	
	
	// 버튼 이벤트 등록
	fRegisterButtonClickEvent();
});


function closee(){
	$("#Returnhide").css("visibility","hidden");
}

function researchgood() {
	$("#samplewh").find("option").remove();
	
	selectGoodComCombo("m",  $("#samplewh").val(), "", "samplewh", "sel");	
}	


/** 버튼 이벤트 등록 */
function fRegisterButtonClickEvent() {
	$('a[name=btn]').click(function(e) {
		e.preventDefault();

		var btnId = $(this).attr('id');

		switch (btnId) {
			case 'btnSearchGrpcod':
				board_search();
				break;
			case 'btnapproval':
				approval();
				break;
			case 'btnCloseGrpCod' :
				gfCloseModal();
				break;
			case 'btnCloseDtlCod' :
				location.reload();
				gfCloseModal();
				break;
		}
	});
}

function approval(){
	
	
	var check = $("#WareKey").val();
	
	if(check == 0){
		swal("창고를 선택 하세요","","")
	}else{
		gfModalPop("#layer1");
	}

}

//검색기능
function board_search(currentPage) {
   
   var sname = $('#sname').val();
	
	var oname = $('#searchKey').val();
	
	var sdate = $('#sdate').val();
	var edate = $('#edate').val();
	
	currentPage = currentPage || 1;
	
	console.log("currentPage : " + currentPage);     
	
   var param = {
   		  sname : sname
   	  ,	  oname : oname
   	  ,   sdate : sdate
   	  ,   edate : edate
      ,   currentPage : currentPage
      ,   pageSize : pageSizeComnGrpCod
   }
   //swal(JSON.stringify(param));
   var resultCallback = function(data) {
	   ReturnListResult(data, currentPage); 
   };
   
   callAjax("/scmDeal/ReturnList.do", "post", "text", true, param, resultCallback);
   
}  



/** 1:1문의 조회 콜백 함수 */
function ReturnListResult(data, currentPage) {
	
	//swal(data);
	console.log(data);
	
	// 기존 목록 삭제
	$("#ReturnList").empty();
	
	// 신규 목록 생성
	$("#ReturnList").append(data);
	
	// 총 개수 추출
	var totalCount = $("#totalCount").val();
	
	
	
	//swal(totalCntComnGrpCod);
	
	// 페이지 네비게이션 생성
	
	var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'board_search');
	console.log("paginationHtml : " + paginationHtml);
	//swal(paginationHtml);
	$("#ReturnListPagination").empty().append( paginationHtml );
	
	// 현재 페이지 설정
	$("#currentPageComnGrpCod").val(currentPage);
}

function fInitFormGrpCod(object) {

	$("#pdnm").val(object.pdnm);
	$("#rtnregdate").val(object.rtnregdate);
	$("#crtncnt").val(object.crtncnt);
	$("#crtnprice").val(object.crtnprice);
	$("#rtnno").val(object.rtnno);
	$("#pdno").val(object.pdno);
	
	
	$("#pdmdno").val(object.pdmdno);
	$("#pdcode").val(object.pdcode);
	
	//주문번호
	$("#crtrtio").val(object.crtrtio);
	//일련번호
	$("#rtnio").val(object.rtnio);
	
	}


function ReturnDetail(rtnno,pdno){
	
	
	$("#Returnhide").css("visibility","visible");
	
	var param ={
			rtnno : rtnno
			,pdno : pdno
	}
	
	var resultCallback = function(data) {
		ReturnDetailResult(data);
	};
	
	callAjax("/scmDeal/ReturnSelect.do", "post", "json", true, param, resultCallback);
	
}

function ReturnDetailResult(data) {

	if (data.result == "SUCCESS") {
		
		console.log(data.ReturnSelectModel);
		
		// 그룹코드 폼 데이터 설정
		fInitFormGrpCod(data.ReturnSelectModel);
		
	} else {
		swal(data.resultMsg);
	}	
}


function ReturnApproval(object){
	
	var whcode = $('#WareKey').val();
	var rtnno = $("#rtnno").val();
	var pdno = $("#pdno").val();
	
	var param = {
			whcode : whcode
		   ,rtnno : rtnno
		   ,pdno : pdno
		   ,deliono: $("#crtrtio").val()
		   ,delio: $("#rtnio").val()
		   ,pdmdno:$("#pdmdno").val()
		   ,pdcode:$("#pdcode").val()
		   ,rtncnt:$("#crtncnt").val()
	}
	
	var resultCallback = function(data) {
		ReturnApprovalResult(data);
	};
	
	callAjax("/scmDeal/ReturnApproval.do", "post", "json", true, param,resultCallback)
	
}

function ReturnApprovalResult(data) {

	if (data.result == "SUCCESS") {

		console.log("ReturnApprovalResult data : " +  JSON.stringify(data)); 
		console.log("ReturnApprovalResult : " +  JSON.stringify(data.ReturnSelectModel)); 
		
		swal("반품 승인 되었습니다.","","");
	
		setTimeout(function(){
			   window.location.reload(1);
			}, 1000); 
		
		closee();	
		
		
	} else {
		swal(data.resultMsg);
	}	
}


</script>

</head>
<body>

<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageComnGrpCod" value="1">
	<input type="hidden" id="currentPageComnDtlCod" value="1">
	<input type="hidden" id="tmpGrpCod" value="">
	<input type="hidden" id="tmpGrpCodNm" value="">
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
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">
						<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
								<span class="btn_nav bold">기준정보</span> <span class="btn_nav bold">공통코드 관리
								</span> <a href="../scmDeal/ReturnApply.do" class="btn_set refresh">새로고침</a>
						</p>
					
						<p class="conTitle">
							<span>반품 신청 목록</span> 
						</p>
						
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"align="left" style="collapse; border: 1px #50bcdf;">
	                        <tr style="border: 0px; border-color: blue">
	                           <td width="80" height="25" style="font-size: 120%;"></td>
	                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
	     	                      <select id="searchKey" name="searchKey" style="width: 150px;" >
										<option value="pdnm" >반품제품명</option>
								  </select> 
								  <input type="text"  style="width: 100px; height: 25px;"  id="sdate" name="sdate"   >~
								  <input type="text"  style="width: 100px; height: 25px;"  id="edate" name="edate"  >
								
	     	                       <input type="text" style="width: 200px; height: 25px;" id="sname" name="sname">                    
		                           <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
	                           </td> 
	                           
	                        </tr>
                         </table> 
                     
                    
                         
                         <div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="17%">
									<col width="6%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">반품 제품명</th>
										<th scope="col">반품 신청날짜</th>
										<th scope="col">반품 수량</th>
										<th scope="col">반품 금액</th>
									</tr>
								</thead>
								<tbody id="ReturnList"></tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="ReturnListPagination"> </div>
					
					
					<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

				
				</table>
				
				<tbody id="ReturnDetail" >
				<div id ="Returnhide" class="divComGrpCodList" style="visibility:hidden;">
						<table class="col">
						<caption>caption</caption>
						<colgroup>
									<col width="5%">
									<col width="17%">
									<col width="17%">
									<col width="17%">
						</colgroup>
						<thead>
							<tr>
								<th>반품 제품명</th>
								<!-- <th id="pdnm" name="pdnm"></th> -->
								<td><input type="text" class="inputTxt p150" id="pdnm" name="pdnm" readonly></td>
								<td align="right">반품 창고 지정</td>
								<td align="center">
									 <!-- 창고<select id="samplewh" name="samplewh" onchange="javascript:researchgood()"></select> --> 
									<select id="WareKey" name="WareKey">
											<option value="0">선택</option>
											<option value="1">A보급</option>
											<option value="2">B보급</option>
											<option value="3">3보급</option>
									</select>
								</td>

							</tr>
							<tr>
								<th>반품 신청날짜</th>
								<td><input type="text" class="inputTxt p150" id="rtnregdate" name="rtnregdate" readonly>
								</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<th>반품 수량</th>
								<td><input type="text" class="inputTxt p150" id="crtncnt" name="crtncnt" readonly></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<th>반품 금액</th>
								<td><input type="text" class="inputTxt p150" id="crtnprice" name="crtnprice" readonly></td>
								<td></td>
								<td>
										<div class="btn_areaC mt30">
											<a href="" class="btnType blue" id="btnapproval" name="btn" ><span>승인요청</span></a>
											<a href="javascript:closee()" class="btnType gray" id="btnCloseGrpCod" name=""><span>닫기</span></a>
										</div>
								</td>
								<input type="hidden" id="rtnno" name="rtnno">
								<input type="hidden" id="pdno" name="pdno">
								<input type="hidden" id="crtrtio" name="crtrtio">
								<input type="hidden" id="rtnio" name="rtnio">
								<input type="hidden" id="pdcode" name="pdcode">
								<input type="hidden" id="pdmdno" name="pdmdno">
							</tr>
						</thead>
						</table>
					</div>
				</tbody>
					</div>
					<tbody id="Returndetail" >
							 <div id="layer1" class="layerPop layerType2" style="width: 400px; height:100px;">
										<dl>
											<dd class="content">
												<h1 align="center">반품승인 요청 하시겠습니까?</h1>
												<div class="btn_areaC mt30">
													<a href="javascript:ReturnApproval()" class="btnType blue" id="" name=""><span>예</span></a> 
													<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>아니오</span></a>
												</div>
											</dd>
										</dl>
									<a href="" class="closePop"><span class="hidden">닫기</span></a>
								</div> 
					</tbody>
				</li>

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	


</form>

</body>
</html>