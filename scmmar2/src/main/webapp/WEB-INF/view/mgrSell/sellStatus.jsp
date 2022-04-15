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
<title>Job Korea :: 매출 현황</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	// 매출 현황 페이징 설정
	var pageSizeSellStatus = 5;
	var pageBlockSizeSellStatus = 5;
	
	// 매출 상세 현황 페이징 설정
	var pageSizeDtSellStatus = 5;
	var pageBlockSizeDtSellStatus = 10;
	
	/** OnLoad event */ 
	$(function() {
		
		// 매출 현황 목록 조회
		fListSellStauts();
		
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
	
	
	/** 매출 현황 목록 폼 초기화 */
	function fSellStausForm(object) {
		$("#userID").focus();
		if( object == "" || object == null || object == undefined) {
			
			$("#userID").val("");
			$("#name").val("");
			$("#usersell").val("");
		
		} else {
			$("#userID").val(object.userID);
			$("#name").val(object.name);
			$("#usersell").val(usersell.pdnm);
		}
	}
	
	// 검색기능
	function board_search(currentPage) {
        
        var sname = $('#sname');
       
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage);     
		
        var param = {
        		  sname : sname.val()
              ,   currentPage : currentPage
              ,   pageSize : pageSizeSellStatus
        }
        //swal(JSON.stringify(param));
        var resultCallback = function(data) {
        	fListSellStautsResult(data, currentPage); 
        	
        	$('#listDtSellStauts').empty(); 
        	$("#currentPageDtSellSatus").val(1);
        	$('#totalCntDtSellStauts').val(0);
        };
        
        callAjax("/mgrSell/sellStatusList.do", "post", "text", true, param, resultCallback);
        
  } 

	/** 매출 현황 목록 조회 */
	function fListSellStauts(currentPage) {
		
		currentPage = currentPage || 1;
		
		var sname = $('#sname');
        var searchKey = document.getElementById("searchKey");
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
					sname : sname.val()
				,	currentPage : currentPage
				,	pageSize : pageSizeSellStatus
		}
		
		var resultCallback = function(data) {
			fListSellStautsResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/mgrSell/sellStatusList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 매출 현황목록 조회 콜백 함수 */
	function fListSellStautsResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#sellStatusList').empty();
		
		// 신규 목록 생성
		$("#sellStatusList").append(data);
		
		// 총 개수 추출
		
		var totalCntSellStatus = $("#totalCntSellStatus").val();
		
		//swal(totalCntSellStatus);
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntSellStatus, pageSizeSellStatus, pageBlockSizeSellStatus, 'fListSellStauts');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#sellStatusPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageSellStatus").val(currentPage);
	}
	
	
	/** 매출 현황 상세 목록 조회 */
	function fListDtSellStauts(currentPage, userID) {
		
		console.log("fListDtSellStauts-userID : " + userID);
		
		currentPage = currentPage || 1;
		console.log("currentPage : " + currentPage);
		// 매출 현황 상세 목록 정보 설정
		$("#tmpUserID").val(userID);
		
		var param = {
					userID : userID
				,	currentPage : currentPage
				,	pageSize : pageSizeDtSellStatus
		}
		
		var resultCallback = function(data) {
			flistDtSellStautsResult(data, currentPage);
		};
		
		callAjax("/mgrSell/sellStatusDtList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 발주 상세 목록 조회 콜백 함수 */
	function flistDtSellStautsResult(data, currentPage) {
		
		// 기존 목록 삭제
		$('#listDtSellStauts').empty(); 
		
		var $data = $( $(data).html() );

		// 신규 목록 생성
		var $listDtSellStauts = $data.find("#listDtSellStauts");		
		$("#listDtSellStauts").append($listDtSellStauts.children());
		console.log(" $listDtSellStauts : "+JSON.stringify($listDtSellStauts));
		
		// 총 개수 추출
		var $totalCntDtSellStauts = $data.find("#totalCntDtSellStauts");
		var totalCntDtSellStauts = $totalCntDtSellStauts.text(); 
		console.log("$totalCntDtSellStauts : "+JSON.stringify($totalCntDtSellStauts));
		console.log("totalCntDtSellStauts : "+totalCntDtSellStauts);
		
		// 페이지 네비게이션 생성
		var userID = $("#tmpUserID").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCntDtSellStauts, pageSizeDtSellStatus, pageBlockSizeDtSellStatus, 'fListDtSellStauts', [userID]);
		$("#dtSellSatusPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageDtSellSatus").val(currentPage);
	}
	
</script>


</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageSellStatus" value="1">
	<input type="hidden" id="currentPageDtSellSatus" value="1">
	<input type="hidden" id="tmpUserID" value="">
	
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
							<span class="btn_nav bold">매출 현황</span> <span class="btn_nav bold">매출 현황</span> 
							<a href="../mgrSell/sellStatus.do" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle">
							<span>매출 현황</span> <span class="fr">
							</span>
						</p>
		
						<div class="divSellStatusList">
							<table style="margin-bottom:20px" width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="collapse; border: 1px #50bcdf;">
		                        <tr style="border: 0px; border-color: blue">
		                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
		                           <td width="40" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
		     	                      <select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
									<option value="name" >기업고객명</option>
									</select> 
									<input type="text" style="width: 200px; height: 25px;" id="sname" name="sname"> 
		     	                     	<a href="" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
                           			</td> 
                      		  </tr>
                  	   </table> 
                     
							<table class="col" style="margin-top:20px">
								<caption>caption</caption>
								<colgroup>
									<col width="50%">
									<col width="50%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">기업고객명</th>
										<th scope="col">매출액</th>
									</tr>	
								</thead>
								<tbody id="sellStatusList">
								</tbody>
							</table>
						</div>
						<div class="paging_area"  id="sellStatusPagination"> </div>
						
						<p class="conTitle mt50">
							<span>기업고객별 상세 매출 현황</span> <span class="fr">
							</span>
						</p>
						<div class="divDtSellStatus">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="20%">
									<col width="30%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">기업고객명</th>
										<th scope="col">제품명</th>
										<th scope="col">거래가격</th>
										<th scope="col">거래일자</th>
									</tr>
								</thead>
								<tbody id="listDtSellStauts">
									<tr>
										<td colspan="12"> 기업고객명을 선택해 주세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="dtSellSatusPagination"> </div>
						
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