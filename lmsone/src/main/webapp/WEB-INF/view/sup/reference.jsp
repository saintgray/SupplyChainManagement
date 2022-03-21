<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${sessionScope.userType == 'B'}">
	<c:redirect url="/dashboard/dashboard.do" />
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 공통 코드 관리</title>
<!-- sweet alert import -->

<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="modalReference.jsp"></jsp:include>
<!-- sweet swal import -->


<script type="text/javascript">
	
	var pageSizeReference = 5;
	var pageBlockSizeReference = 5;
	$(function() {
		// 버튼 이벤트 등록

		fListReference();
		fButtonClickEvent_reference();


	});
	function fCloseModal(){
		
		gfCloseModal();
		fListReference();
	}
	function fButtonClickEvent_reference() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault(); // ?? 

			var btnId = $(this).attr('id');

			switch (btnId) {

			case 'btnSearchReference':
				board_searchReference();
				break;
			case 'btnCloseLsmCod':
				gfCloseModal();
				
				break;
				

			}
		});
	}

	/** 학습자료 조회 */
	function fListReference(currentPage) {

		currentPage = currentPage || 1;
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		var referenceSearchKey = $('#referenceSearchKey').val();
		var referenceSearchContent = $('#referenceSearchContent').val();
		console.log("currentEngPage : " + currentPage);

		var param = {
			startDate : startDate,
			endDate : endDate,
			searchKey : referenceSearchKey,
			searchContent : referenceSearchContent,
			currentPage : currentPage,
			pageSize : pageSizeReference
		}
		
		var resultCallback = function(data) {
			flistReferenceResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/sup/listReference.do", "post", "text", true, param,	resultCallback);
	}

	/** 학습자료 조회 콜백 함수 */
	function flistReferenceResult(data, currentPage) {
		console.log(data);

		// 기존 목록 삭제
		$('#listReference').empty();

		// 신규 목록 생성
		$("#listReference").append(data);

		// 총 개수 추출

		var totalCntReference = $("#totalCntReference").val();

		// 페이지 네비게이션 생성

		var paginationHtml = getPaginationHtml(currentPage, totalCntReference, pageSizeReference, pageBlockSizeReference, 'fListReference');
		$("#referencePagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageReference").val(currentPage);
	}
	// 학습자료 검색기능
	function board_searchReference(currentPage) {

		currentPage = currentPage || 1;
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		var referenceSearchKey = $('#referenceSearchKey').val();
		var referenceSearchContent = $('#referenceSearchContent').val();
		console.log("currentEngPage : " + currentPage);
		console.log(param);
		
		var param = {
			startDate : startDate,
			endDate : endDate,
			searchKey : referenceSearchKey,
			searchContent : referenceSearchContent,
			currentPage : currentPage,
			pageSize : pageSizeReference
		}

		var resultCallback = function(data) {
			flistReferenceResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/sup/listReference.do", "post", "text", true, param,	resultCallback);

	}
	


</script>

</head>
<body>

	<form id="myForm" action="" method="">


		<!-- 모달 배경 -->
		<div id="mask"></div>
		<div id="wrap_area">

			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content -->
						<div class="content">

							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span class="btn_nav bold">학습지원</span> <span class="btn_nav bold">학습자료관리</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
							</p>

							<br>
							<p class="conTitle mt50">
								<span>학습자료</span> <span class="fr"> 
									 
									<select name = "referenceSearchKey" id = "referenceSearchKey" style="width: 100px; height: 28px;">
										<option value = "" selected="selected">선택</option>

										<option value = "0">제목</option>
										<option value = "1">강사명</option>
										<option value = "2">내용</option>
									</select>
									<input class="inputTxt" style="width: 200px" type="text" id="referenceSearchContent" name="referenceSearchContent">
									<span class="btn_nav bold">작성일:</span>&emsp;
									<input type="date" name="startDate" id="startDate" style="font-size: 18px" /> ~ 
									<input type="date" name="endDate" id="endDate" style="font-size: 18px" /> &emsp; 
									<a href="" class="btnType blue" id="btnSearchReference" name="btn"><span>검 색</span></a>
								</span>
							</p>
							
							<span class="fr"> 
								<c:if test = "${sessionScope.userType == 'A' ||  sessionScope.userType == 'D'}">
									<a href="javascript:fReferenceRegister();" class="btnType blue" ><span>등  록</span></a>
									
								</c:if>
							</span>
							<div class="divComDtlCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="40%">
										<col width="20%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">제목</th>
											<th scope="col">작성일</th>
											<th scope="col">작성자</th>
										</tr>
									</thead>
									<tbody id="listReference"></tbody>
								</table>
							</div>

							<div class="paging_area" id="referencePagination"></div>

						</div>
					</li>
				</ul>
			</div>

		</div>
	</form>


</body>
</html>