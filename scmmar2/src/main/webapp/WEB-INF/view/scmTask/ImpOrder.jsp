<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>발주지시서</title>
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

	board_search();
	
	// 버튼 이벤트 등록
	fRegisterButtonClickEvent();
});


/** 버튼 이벤트 등록 */
function fRegisterButtonClickEvent() {
	$('a[name=btn]').click(function(e) {
		e.preventDefault();

		var btnId = $(this).attr('id');

		switch (btnId) {
			case 'btnSaveGrpCod' :
				fSaveGrpCod();
				break;
			case 'btnDeleteGrpCod' :
				fDeleteGrpCod();
				break;
			case 'btnSaveDtlCod' :
				fSaveDtlCod();
				break;
			case 'btnDeleteDtlCod' :
				fDeleteDtlCod();
				break;
			case 'btnSearchGrpcod':
				board_search();
				break;
			case 'btnCloseGrpCod' :
			case 'btnCloseDtlCod' :
				gfCloseModal();
				break;
		}
	});
}






//검색기능
function board_search(currentPage) {
    
    var sname = $('#sname').val();
    // var searchKey = document.getElementById("searchKey");
	//var oname = searchKey.options[searchKey.selectedIndex].value;
	
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
    	flistGrpCodResult(data, currentPage); 
    };
    
    callAjax("/scmTask/ImpSearch.do", "post", "text", true, param, resultCallback);
    
} 

function flistGrpCodResult(data, currentPage) {
	
	//swal(data);
	console.log(data);
	
	// 기존 목록 삭제
	$('#ImpList').empty();
	
	// 신규 목록 생성
	$("#ImpList").append(data);
	
	// 총 개수 추출
	
	var totalCount = $("#totalCount").val();
	
	
	//swal(totalCntComnGrpCod);
	
	// 페이지 네비게이션 생성
	
	var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'board_search');
	console.log("paginationHtml : " + paginationHtml);
	//swal(paginationHtml);
	$("#ImpListPagination").empty().append( paginationHtml );
	
	// 현재 페이지 설정
	$("#currentPageComnGrpCod").val(currentPage);
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
								</span> <a href="../scmTask/ImpOrder.do" class="btn_set refresh">새로고침</a>
						</p>
					
						<p class="conTitle">
							<span>발주 지시서</span> 
						</p>
						
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"align="left" style="collapse; border: 1px #50bcdf;">
	                        <tr style="border: 0px; border-color: blue">
	                           <td width="80" height="25" style="font-size: 120%;"></td>
	                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:50px;">
	     	                      <select id="searchKey" name="searchKey" style="width: 150px;" >
										<option value="pdnm" >제품명</option>
										<option value="client" >발주업체</option>
								  </select> 

	     	                       <input type="text" style="width: 100px; height: 25px;" id="sname" name="sname">
	     	                       주문일자
	     	                       <input type="text"  style="width: 100px; height: 25px;"  id="sdate" name="sdate"  >~
								   <input type="text"  style="width: 100px; height: 25px;"  id="edate" name="edate"   value="">
								                       
		                           <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
		                           
		                           
	                           </td> 
	                           
	                        </tr>
                         </table> 
                     
                    
                         
                         <div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="17%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">제품 번호</th>
										<th scope="col">제품명</th>
										<th scope="col">발주업체명</th>
										<th scope="col">날짜</th>
										<th scope="col">개수</th>
									</tr>
								</thead>
								<tbody id="ImpList"></tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="ImpListPagination"> </div>	
					<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

				
				</table>
					
					
					
					
					
					</div>
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