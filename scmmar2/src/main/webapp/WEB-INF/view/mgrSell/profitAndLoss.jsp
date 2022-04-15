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
<title>Job Korea :: 손익 조회</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	// 손익 목록 페이징 설정
	var pageSizeProfitAndLoss = 5;
	var pageBlockSizeProfitAndLoss = 5;
	
	// 손익 상세 목록 페이징 설정
	var pageSizeDtProfitAndLoss = 5;
	var pageBlockSizeDtProfitAndLoss = 10;
	
	/** OnLoad event */ 
	$(function() {
		
		// 손익 목록 조회
		fListProfitAndLoss();
		
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
	
	
	/** 손익 목록 폼 초기화 */
	function fProfitAndLossForm(object) {
		$("#userID").focus();
		if( object == "" || object == null || object == undefined) {
			
			$("#userID").val("");
			$("#name").val("");
			$("#totalorder").val("");
			$("#totalreturn").val("");
			$("#totalprofit").val("");
		
		} else {
			$("#userID").val(object.userID);
			$("#name").val(object.name);
			$("#totalorder").val(object.totalorder);
			$("#totalreturn").val(object.totalreturn);
			$("#totalprofit").val(object.totalprofit);
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
              ,   pageSize : pageSizeProfitAndLoss
        }
        //swal(JSON.stringify(param));
        var resultCallback = function(data) {
        	fListProfitAndLossResult(data, currentPage); 
        };
        
        callAjax("/mgrSell/profitAndLossList.do", "post", "text", true, param, resultCallback);
        
  } 

	/** 손익 목록 조회 */
	function fListProfitAndLoss(currentPage) {
		
		currentPage = currentPage || 1;
		
		var sname = $('#sname');
        var searchKey = document.getElementById("searchKey");
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
					sname : sname.val()
				,	currentPage : currentPage
				,	pageSize : pageSizeProfitAndLoss
		}
		
		var resultCallback = function(data) {
			fListProfitAndLossResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/mgrSell/profitAndLossList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 손익 목록 조회 콜백 함수 */
	function fListProfitAndLossResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#profitAndLossList').empty();
		
		// 신규 목록 생성
		$("#profitAndLossList").append(data);
		
		// 총 개수 추출
		
		var totalCntProfitAndLoss = $("#totalCntProfitAndLoss").val();
		
		//swal(totalCntProfitAndLoss);
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntProfitAndLoss, pageSizeProfitAndLoss, pageBlockSizeProfitAndLoss, 'fListProfitAndLoss');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#profitAndLossPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageProfitAndLoss").val(currentPage);
	}
	
	
	/** 손익 상세 목록 조회 */
	function fListDtProfitAndLoss(currentPage, userID) {
		
		console.log("fListDtProfitAndLoss-userID : " + userID);
		
		currentPage = currentPage || 1;
		console.log("currentPage : " + currentPage);
		// 손익 상세 목록 정보 설정
		$("#tmpUserID").val(userID);
		
		var param = {
					userID : userID
				,	currentPage : currentPage
				,	pageSize : pageSizeDtProfitAndLoss
		}
		
		var resultCallback = function(data) {
			fListDtProfitAndLossResult(data, currentPage);
		};
		
		callAjax("/mgrSell/profitAndLossDtList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 손익 상세 목록 조회 콜백 함수 */
	function fListDtProfitAndLossResult(data, currentPage) {
		
		// 기존 목록 삭제
		$('#listDtProfitAndLoss').empty(); 
		
		var $data = $( $(data).html() );

		// 신규 목록 생성
		var $listDtProfitAndLoss = $data.find("#listDtProfitAndLoss");		
		$("#listDtProfitAndLoss").append($listDtProfitAndLoss.children());
		console.log(" $listDtProfitAndLoss : "+JSON.stringify($listDtProfitAndLoss));
		
		// 총 개수 추출
		var $totalCntDtProfitAndLoss = $data.find("#totalCntDtProfitAndLoss");
		var totalCntDtProfitAndLoss = $totalCntDtProfitAndLoss.text(); 
		console.log("$totalCntDtProfitAndLoss : "+JSON.stringify($totalCntDtProfitAndLoss));
		
		// 페이지 네비게이션 생성
		var userID = $("#tmpUserID").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCntDtProfitAndLoss, pageSizeDtProfitAndLoss, pageBlockSizeDtProfitAndLoss, 'fListDtProfitAndLoss', [userID]);
		$("#dtSellSatusPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageDtProfitAndLoss").val(currentPage);
	}
	
</script>


</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageProfitAndLoss" value="1">
	<input type="hidden" id="currentPageDtProfitAndLoss" value="1">
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
							<span class="btn_nav bold">매출 현황</span> <span class="btn_nav bold">손익 조회</span> 
							<a href="../mgrSell/profitAndLoss.do" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle">
							<span>손익 조회</span> <span class="fr">
							</span>
						</p>
		
						<div class="divProfitAndLossList">
							<table style="margin-bottom:20px" width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="collapse; border: 1px #50bcdf;">
		                        <tr style="border: 0px; border-color: blue">
		                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
		                           <td width="40" height="25" style="font-size: 100%; text-align:left; ">
		     	                     기업고객명 <input type="text" style="width: 200px; height: 25px;" id="sname" name="sname"> 
		     	                     	<a href="" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
                           			</td> 
                      		  </tr>
                  	   </table> 
                     
							<table class="col" style="margin-top:20px">
								<caption>caption</caption>
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="25%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">기업고객명</th>
										<th scope="col">수익</th>
										<th scope="col">반품</th>
										<th scope="col">총 손익</th>
									</tr>	
								</thead>
								<tbody id="profitAndLossList">
								</tbody>
							</table>
						</div>
						<div class="paging_area"  id="profitAndLossPagination"> </div>
						
						<p class="conTitle mt50">
							<span>기업고객별 손익 상세 조회</span> <span class="fr">
							</span>
						</p>
						<div class="divDtSellStatus">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">기업고객명</th>
										<th scope="col">제품명</th>
										<th scope="col">수익</th>
										<th scope="col">반품</th>
										<th scope="col">거래일자</th>
									</tr>
								</thead>
								<tbody id="listDtProfitAndLoss">
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