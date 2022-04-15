<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType ne 'E'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 구매 승인</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	// 그룹코드 페이징 설정
	var pageSizeComnGrpCod = 5;
	var pageBlockSizeComnGrpCod = 5;
	
	// 상세코드 페이징 설정
	var pageSizeComnDtlCod = 5;
	var pageBlockSizeComnDtlCod = 10;
	
	/** OnLoad event */ 
	$(function() {

		
		// 그룹코드 조회
		fListComnGrpCod();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
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
	
	
	/** 발주 목록 폼 초기화 */
	function fInitFormGrpCod(object) {
		$("#impno").focus();
		if( object == "" || object == null || object == undefined) {
			
			$("#impno").val("");
			$("#comp_nm").val("");
			$("#pdnm").val("");
			$("#impcnt").val("");
			$("#impamount").val("");
			$("#impregdate").val("");
			$("#impmgryn").val("");
	 
		} else {
			
			$("#impno").val(object.impno);
			$("#comp_nm").val(object.comp_id);
			$("#pdnm").val(object.pdnm);
			
			$("#impcnt").val(object.impcnt);
			$("#impamount").val(object.impamount);
			$("#impregdate").val(object.impregdate);
			$("#impmgryn").val("object.impmgryn");
		
		}
	}
	
	
	// 검색기능
	function board_search(currentPage) {
        
        var sname = $('#sname');
        var from_date = $('#from_date');
        var to_date = $('#to_date');
    
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage);     
		
        var param = {
        		  sname : sname.val()
              ,   currentPage : currentPage
              ,   pageSize : pageSizeComnGrpCod
              ,   from_date : from_date.val()
              ,   to_date : to_date.val()
        }
        //swal(JSON.stringify(param));
        var resultCallback = function(data) {
        	flistGrpCodResult(data, currentPage); 
//         	flistDtlCodResult(data, currentPage);
        	$('#listDtImpApproval').empty(); 
        	$("#currentPageImpApprvalDt").val(1);
        	$('#totalCntDtImpApproval').val(0);
        	
        	console.log($("#currentPageImpApprvalDt").val());
        	console.log('tot :: '+$('#totalCntDtImpApproval').val());
        };
  
        callAjax("/mgrApproval/listImpApproval.do", "post", "text", true, param, resultCallback);
       
  } 

	
	/** 임원승인 */
	function fPopModalComnGrpCod(e) {
		
		var info = $(e).parent().parent().find(".hiddeninfo");
		
		if (confirm("승인 하시겠습니까?")) {
			
		var param = {	
				impno : info.find("#impno").val(),
				impordno : info.find("#impordno").val(),
				impdtcnt : info.find("#impdtcnt").val(),
				pdcode : info.find("#pdcode").val(),
				pdmdno : info.find("#pdmdno").val(),
				pdno : info.find("#pdno").val()
	   }
		
		console.log(param.impno);
		console.log(param.impordno);
		console.log(param.impdtcnt);
		console.log(param.pdcode);
		console.log(param.pdmdno);
		console.log(param.pdno);
		
			var resultCallback = function(data) {
				fSaveGrpCodResult(data);
			};

			callAjax("/mgrApproval/updateImpMgrYn.do", "post", "json", true, param, resultCallback);
		} else {
			   return;			   
		   } 			
	}
	
	/** 발주 목록 조회 */
	function fListComnGrpCod(currentPage) {
		
		currentPage = currentPage || 1;
		
		var sname = $('#sname');
        var searchKey = document.getElementById("searchKey");
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
					sname : sname.val()
				,	currentPage : currentPage
				,	pageSize : pageSizeComnGrpCod
		}
		
		var resultCallback = function(data) {
			flistGrpCodResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/mgrApproval/listImpApproval.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 발주목록 조회 콜백 함수 */
	function flistGrpCodResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listImpApproval').empty();
		
		// 신규 목록 생성
		$("#listImpApproval").append(data);
		
		// 총 개수 추출
		
		var totalCntImpApproval = $("#totalCntImpApproval").val();
		
		//swal(totalCntImpApproval);
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntImpApproval, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListComnGrpCod');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageImpApproval").val(currentPage);
	}
	
	
	/** 발주 승인여부 수정 */
	function fSaveGrpCod(e) {
		
		console.log("값 : "+$(e).parent().find("#impordno").val());
		
		
		var param = {	
				impno : $(e).parent().find($("#impno")).val(),
				impordno : $(e).parent().find($("#impordno")).val(),
				impdtcnt : $(e).parent().find($("#impdtcnt")).val(),
				pdcode : $(e).parent().find($("#pdcode")).val(),
				pdmdno : $(e).parent().find($("#pdmdno")).val(),
				pdno : $(e).parent().find($("#pdno")).val()
	   }
		
		var resultCallback = function(data) {
			fSaveGrpCodResult(data);
		};

		callAjax("/mgrApproval/updateImpMgrYn.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 발주 목록 수정 콜백 함수 */
	function fSaveGrpCodResult(data) {
		
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "U") {
			currentPage = $("#currentPageImpApproval").val(); 
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 목록 조회
			fListComnGrpCod(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
		
		// 입력폼 초기화
		fInitFormGrpCod();
	}

	/** 발주 상세 목록 조회 */
	function fListComnDtlCod(currentPage, impno) {
		
		console.log("fListComnDtlCod : " + impno);
		
		currentPage = currentPage || 1;
		
		// 발주 상세 목록 정보 설정
		$("#tmpImpNo").val(impno);
		
		var param = {
					impno : impno
				,	currentPage : currentPage
				,	pageSize : pageSizeComnDtlCod
		}
		
		var resultCallback = function(data) {
			flistDtlCodResult(data, currentPage);
		};
		
		callAjax("/mgrApproval/listDtImpApproval.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 발주 상세 목록 조회 콜백 함수 */
	function flistDtlCodResult(data, currentPage) {
		
		// 기존 목록 삭제
		$('#listDtImpApproval').empty(); 
		
		var $data = $( $(data).html() );

		// 신규 목록 생성
		var $listDtImpApproval = $data.find("#listDtImpApproval");		
		$("#listDtImpApproval").append($listDtImpApproval.children());
		
		// 총 개수 추출
		var $totalCntDtImpApproval = $data.find("#totalCntDtImpApproval");
		var totalCntDtImpApproval = $totalCntDtImpApproval.text(); 
		
	
		
		// 페이지 네비게이션 생성
		var impno = $("#tmpImpNo").val();
		//var grp_cod_nm = $("#tmpimpCompnm").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCntDtImpApproval, pageSizeComnDtlCod, pageBlockSizeComnDtlCod, 'fListComnDtlCod', [impno]);
		$("#comnDtlCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageImpApprvalDt").val(currentPage);
	}
	
</script>


</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageImpApproval" value="1">
	<input type="hidden" id="currentPageImpApprvalDt" value="1">
	<input type="hidden" id="tmpImpNo" value="">
	<!--<input type="hidden" id="tmpimpCompnm" value="">  -->
	<input type="hidden" name="action" id="action" value="U">
	
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
							<span class="btn_nav bold">승인</span> <span class="btn_nav bold">구매승인</span> 
							<a href="../mgrApproval/impApproval.do" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle">
							<span>발주 미승인 목록</span> <span class="fr">
							</span>
						</p>
		
						<div class="divComGrpCodList">
							<table style="margin-bottom:20px" width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="collapse; border: 1px #50bcdf;">
		                        <tr style="border: 0px; border-color: blue">
		                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
		                           <td width="40" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
		     	                     제품명 <input type="text" style="width: 200px; height: 25px;" id="sname" name="sname"> 
                           			</td> 
                           			<td width="40" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
		     	                     	구매일자 <td width="50" height="25" style="font-size: 100%">
		                            <input type="date" style="width: 120px; height: 25px;" id="from_date" name="from_date"></td>
		                           <td width="50" height="50" style="font-size: 100%">
		                            <input type="date" style="width: 120px; height: 25px;" id="to_date" name="to_date"></td>
		                           <td width="110" height="50" style="font-size: 120%">
	                          		 <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
                           			</td> 
                      		  </tr>
                  	   </table> 
                     
							<table class="col" style="margin-top:20px">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="10%">
									<col width="15%">
									<col width="21%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">납품업체명</th>
										<th scope="col">제품명</th>
										<th scope="col">수량</th>
										<th scope="col">금액</th>
										<th scope="col">구매일자</th>
										<th scope="col">승인처리</th>
									</tr>	
								</thead>
								<tbody id="listImpApproval">
								</tbody>
							</table>
						</div>
						<div class="paging_area"  id="comnGrpCodPagination"> </div>
						
						<p class="conTitle mt50">
							<span>발주 상세 목록</span> <span class="fr">
							</span>
						</p>
						<div class="divComDtlCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="10%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">납품업체명</th>
										<th scope="col">제품명</th>
										<th scope="col">수량</th>
										<th scope="col">발주단가</th>
										<th scope="col">구매일자</th>
									</tr>
								</thead>
								<tbody id="listDtImpApproval">
									<tr>
										<td colspan="12"> 발주 목록을 선택해 주세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="comnDtlCodPagination"> </div>
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

</form>
</body>
</html>