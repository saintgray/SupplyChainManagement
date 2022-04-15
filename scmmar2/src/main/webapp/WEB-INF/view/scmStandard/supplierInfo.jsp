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
<title>Job Korea :: 납품업체정보 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	// 납품업체정보 페이징 설정
	var pageSizeSupplierInfo = 10;
	var pageBlockSizeSupplierInfo = 5;
	
	// 업체별 제품목록 페이징 설정
	var pageSizeSupplierProInfo = 5;
	var pageBlockSizeSupplierProInfo = 5;
	
	
	/** OnLoad event */ 
	$(function() {
		
		// 납품업체정보 조회
		fListSupplierInfo();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			
				case 'btnListSupplierInfo':
					fListSupplierInfo();
					break;
					
				case 'btnCloseModal' :
					gfCloseModal();
					break;
					
			}
		});
	}
	
	
	/** 납품업체정보 조회 */
	function fListSupplierInfo(currentPage) {
		
		currentPage = currentPage || 1;
		
		var sname = $('#sname').val();
		var oname = $('#searchKey').val();
//         var searchKey = document.getElementById("searchKey");
// 		var oname = searchKey.options[searchKey.selectedIndex].value;
		
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
					sname : sname
				,	oname : oname
				,	currentPage : currentPage
				,	pageSize : pageSizeSupplierInfo
		}
		
		var resultCallback = function(data) {
			flistSupplierInfoResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/scmStandard/listSupplierInfo.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 납품업체정보 조회 콜백 함수 */
	function flistSupplierInfoResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listSupplierInfo').empty();
		
		// 신규 목록 생성
		$("#listSupplierInfo").append(data);
		
		// 총 개수 추출
		
		var totalCntSupplierInfo = $("#totalCntSupplierInfo").val();
		
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntSupplierInfo, pageSizeSupplierInfo, pageBlockSizeSupplierInfo, 'fListSupplierInfo');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#SupplierInfoPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageSupplierInfo").val(currentPage);
	}
	
	
	/** 업체별 제품정보 단건 조회 */
	function fSelectSupplierInfo(comp_id) {
		
		var param = { comp_id : comp_id };
		
		var resultCallback = function(data) {
			fSelectSupplierInfoResult(data);
		};
		
		callAjax("/scmStandard/selectSupplierInfo.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 업체별 제품정보 단건 조회 콜백 함수*/
	function fSelectSupplierInfoResult(data) {
			
		console.log(data);
			$("#supplierProInfo").empty();
			$("#supplierProInfo").append(data);

			// 모달 팝업
			gfModalPop("#layer2");
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageSupplierInfo" value="1">
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
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">기준정보</span>
							<span class="btn_nav bold">납품 업체 정보</span>
							<a href="../scmStandard/supplierInfo.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>납품 업체 정보</span> 
						</p>
						
						<table style="margin: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left" style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
						
							<select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
									<option value="client" >납품업체명</option>
									<option value="pdnm" >제품명</option>
							</select> 
						
							<input type="text" style="width: 300px; height: 25px;" id="sname" name="sname" onkeypress="if( event.keyCode == 13 ){fListSupplierInfo();}">                    
	                        <a href="" class="btnType blue" id="btnListSupplierInfo" name="btn"><span>검  색</span></a>
							
							</td>
						</tr>
						</table>
						
						
						<div class="divSupplierInfoList">
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
										<th scope="col">납품업체명</th>
										<th scope="col">LOGIN ID</th>
										<th scope="col">비밀번호</th>
										<th scope="col">담당자명</th>
										<th scope="col">담당자 연락처</th>
									</tr>
								</thead>
								<tbody id="listSupplierInfo"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="SupplierInfoPagination"> </div>
						
                     
						

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	

	<div id="layer2" class="layerPop layerType2" style="width: 600px; overflow: auto; overflow-x:hidden;">
		<dl>
			<dt style="font-family: 맑은고딕;">
				<strong>업체별 제품정보</strong>
			</dt>
				<dd class="content">
						<table class="col">
							<caption>caption</caption>
							<colgroup>
								<col width="30%">
								<col width="40%">
								<col width="30%">
							</colgroup>

							<thead>
								<tr>
									<th scope="col">제품번호</th>
									<th scope="col">제품명</th>
									<th scope="col">납품단가</th>
								</tr>
							</thead>
							<tbody id="supplierProInfo"></tbody>
							
						</table>

				</dd>
			</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
		<div class="paging_area"  id="SupplierProInfoPagination"> </div>
	</div>
	
</form>
</body>
</html>