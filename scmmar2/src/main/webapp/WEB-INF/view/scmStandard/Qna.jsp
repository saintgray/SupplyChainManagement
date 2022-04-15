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
<title>1:1문의</title>
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


// 그룹코드 페이징 설정
var pageSizeComnGrpCod = 5;
var pageBlockSizeComnGrpCod = 5;

// 상세코드 페이징 설정
var pageSizeComnDtlCod = 5;
var pageBlockSizeComnDtlCod = 10;



/** OnLoad event */ 
$(function() {
	// 그룹코드 조회
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
			case 'btnSaveqna' :
				SaveqnaList();
				break;
			case 'btnDeleteGrpCod' :
				fDeleteGrpCod();
				break;
			case 'btnAnswer' :
				Answer();
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
			case 'cancle':
				gfCloseModal();
				break;
			case 'btnCloseGrpCod' :
			case 'btnCloseDtlCod' :
				location.reload();
				gfCloseModal();
				break;
		}
	});
}

function Answer(){
	 $("#Answer").css("visibility","visible");
	 $("#btnAnswer").css("visibility","hidden");
	 $("#btnCloseDtlCod").css("visibility","hidden");
	 $("#btnSaveqna").css("visibility","visible");
	 $("#cancle").css("visibility","visible"); 
	 $("#tit").css("visibility","visible"); 
} 


function fPopModalComnGrpCod() {
	
	gfModalPop("#layer1");

}

/** 1:1문의 저장 validation */
function fValidateGrpCod() {

	var chk = checkNotEmpty(
			[
					[ "qna_atitle", "제목을 적어주세요." ]
				,	[ "qna_acontent", "내용을 적어주세요" ]
				
			]
	);

	if (!chk) {
		return;
	}

	return true;
}

/** 1:1문의 저장 */
function SaveqnaList() {

	// vaildation 체크
	if ( ! fValidateGrpCod() ) {
		return;
	}
	
	var param = {
			qna_ano:$("#qna_ano").val(),
			qna_atitle:$("#qna_atitle").val(),
			qna_acontent:$("#qna_acontent").val()
	};
	
	
	var resultCallback = function(data) {
		SaveqnaListResult(data);
	};
	
	callAjax("/scmStandard/qnaSave.do", "post", "json", true, param, resultCallback);
}

/** 그룹코드 저장 콜백 함수 */
function SaveqnaListResult(data) {
	
	console.log("SaveqnaListResult"+data);
	
	// 목록 조회 페이지 번호
	var currentPage = "1";
	
	
	if (data.result == "SUCCESS") {
		
		// 응답 메시지 출력
		swal(data.resultMsg);
		
		// 모달 닫기
		gfCloseModal();
		
		// 목록 조회
		board_search(currentPage);
		
	} else {
		// 오류 응답 메시지 출력
		swal(data.resultMsg);
	}
	
}

//검색기능 + 목록
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
   	qnaListResult(data, currentPage); 
   };
   
   callAjax("/scmStandard/qnaList.do", "post", "text", true, param, resultCallback);
   
}  

/** 1:1문의  조회 */
   /* function fListComnGrpCod(currentPage) {
	
	currentPage = currentPage || 1;
	
	
	
	console.log("currentPage : " + currentPage);
	
	var param = {	
				currentPage : currentPage
			,	pageSize : pageSizeComnGrpCod
	}
	
	var resultCallback = function(data) {
		qnaListResult(data, currentPage);
	};
	//Ajax실행 방식
	//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
	callAjax("/scmStandard/qnaList.do", "post", "text", true, param, resultCallback);
}  */


/** 1:1문의 조회 콜백 함수 */
function qnaListResult(data, currentPage) {
	
	//swal(data);
	console.log(data);
	
	// 기존 목록 삭제
	$('#qnaList').empty();
	
	// 신규 목록 생성
	$("#qnaList").append(data);
	
	// 총 개수 추출
	var totalqnaCount = $("#totalqnaCount").val();
	
	
	
	//swal(totalCntComnGrpCod);
	
	// 페이지 네비게이션 생성
	
	var paginationHtml = getPaginationHtml(currentPage, totalqnaCount, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'board_search');
	console.log("paginationHtml : " + paginationHtml);
	//swal(paginationHtml);
	$("#qnaListPagination").empty().append( paginationHtml );
	
	// 현재 페이지 설정
	$("#currentPageComnGrpCod").val(currentPage);
}




/** 그룹코드 폼 초기화 */
function fInitFormGrpCod(object) {
	 	$("#qna_no").focus(); 
	 	
	 	if(object.qna_astate>0){
	 		$("#Answer").css("visibility","visible");
	 		$("#btnAnswer").css("visibility","hidden");
	 		$("#btnCloseDtlCod").css("visibility","hidden");
	 		$("#btnSaveqna").css("visibility","visible");
	 		$("#cancle").css("visibility","visible");
	 		$("#tit").css("visibility","visible"); 
	 		$("#loginid").val(object.loginid);
			$("#qna_title").val(object.qna_title);
			$("#qna_content").val(object.qna_content);
			$("#qna_ano").val(object.qna_no);
			$("#qna_atitle").val(object.qna_atitle);
			$("#qna_acontent").val(object.qna_acontent);
			
	 	}else{
	 		$("#loginid").val(object.loginid);
			$("#qna_title").val(object.qna_title);
			$("#qna_content").val(object.qna_content);
			$("#qna_ano").val(object.qna_no);
			
			$("#tit").css("visibility","hidden"); 
			$("#Answer").css("visibility","hidden");
			$("#btnAnswer").css("visibility","visible");
			$("#btnCloseDtlCod").css("visibility","visible");
			$("#btnSaveqna").css("visibility","hidden");
			$("#cancle").css("visibility","hidden");
	 	}
	 	
		
		
		

}






/** 그룹코드 단건 조회 */
function qnaDetail(qna_no) {
	
	// 초기화
	$("#qna_atitle").val("");
	$("#qna_acontent").val("");
	$("#qna_ano").val("");

	
	
	
	var param = { qna_no : qna_no };
	
	var resultCallback = function(data) {
		qnaDetailResult(data);
	};
	
	callAjax("/scmStandard/qnaSelect.do", "post", "json", true, param, resultCallback);
}


/** 그룹코드 단건 조회 콜백 함수*/
function qnaDetailResult(data) {

	if (data.result == "SUCCESS") {
		
		// 모달 팝업
		
		
		gfModalPop("#layer1");
		
		
		
		// 그룹코드 폼 데이터 설정
		fInitFormGrpCod(data.qnaModel);
		
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
	<input type="hidden" id="qnano" value="">
	<input type="hidden" id="qnatitle" value="">
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
								</span> <a href="../scmStandard/qna.do" class="btn_set refresh">새로고침</a>
						</p>
					
						<p class="conTitle">
							<span>1:1 문의</span> 
						</p>
						
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"align="left" style="collapse; border: 1px #50bcdf;">
	                        <tr style="border: 0px; border-color: blue">
	                           <td width="80" height="25" style="font-size: 120%;"></td>
	                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
	     	                      <select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
										<option value="qna_title" >제목</option>
										<option value="qna_content" >내용</option>
								  </select> 
								  
	     	                       <input type="text" style="width: 200px; height: 25px;" id="sname" name="sname">
	     	                         
	     	                       <input type="text"  style="width: 100px; height: 25px;"  id="sdate" name="sdate"  >~
								  <input type="text"  style="width: 100px; height: 25px;"  id="edate" name="edate"  >
	     	                                         
		                           <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
	                           </td> 
	                           
	                        </tr>
                         </table> 
                         
                         
                         
                     
                    
                     
                     	<!-- <p>
	                         <div class="fr">
	                         <a class="btnType blue" href="javascript:fPopModalComnGrpCod()" name="modal"><span>글쓰기</span></a>
	                         </div>
                         </p> -->
                         
                         <div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="4%">
									<col width="20%">
									<col width="20%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">작성일</th>
										<th scope="col">작성자</th>
									</tr>
								</thead>
								<tbody id="qnaList"></tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="qnaListPagination"> </div>
					</div>
					
					
					
				</li>

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	 <div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>1:1 상세정보</strong>
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
							<th scope="row">로그인아이디 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="loginid" id="loginid" readonly></td>
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="qna_title" id="qna_title" readonly></td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan="3"><textarea name="qna_content" id="qna_content"  readonly></textarea></td>
						</tr>

					</tbody>
					
				</table>
				
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnAnswer" name="btn" ><span>답변 버튼</span></a>
					<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>취소</span></a>
				</div>
				
				
				<table class="row" id="Answer" style="visibility:hidden">
				<tbody id="qnaAnswer" class="qnaAnswer">
						<dt id ="tit" style="visibility:hidden">
							<strong>1:1문의 답변</strong>
						</dt>
						<colgroup>
							<col width="300px">
							<col width="*px">
						</colgroup>
						<tr>
							<th scope="row">답변제목 <span class="font_red">*</span></th>
							<td colspan="3">
								<input type="hidden" name="qna_ano" id="qna_ano" />
								<input type="text" class="inputTxt p100"  name="qna_atitle" id="qna_atitle" >
							</td>
						</tr>
						<tr>
							<th scope="row">답변 내용 <span class="font_red">*</span></th>
							<td colspan="3"><textarea class="inputTxt p100" name="qna_acontent" id="qna_acontent" ></textarea>
						</tr>
				</tbody>
				</table>
				
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveqna" name="btn" style="visibility:hidden" ><span>저장</span></a>
					<a href="" class="btnType gray" id="cancle" name="btn" style="visibility:hidden"><span>취소</span></a>
				</div>
				
				
				

				<!-- e : 여기에 내용입력 -->

			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	

	
	

</form>

</body>
</html>