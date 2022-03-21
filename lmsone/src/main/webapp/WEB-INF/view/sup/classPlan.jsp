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
<!-- 우편번호 조회 -->

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="modalClassPlanRegister.jsp"></jsp:include>
<!-- sweet swal import -->


<script type="text/javascript">
	// 강의계획서 페이징 설정
	var pageSizeClassPlan = 5;
	var pageBlockSizeClassPlan = 5;
	$(function() {
		// 버튼 이벤트 등록

		fListClassPlan();
		fButtonClickEvent_classPlan();


	});

	function fButtonClickEvent_classPlan() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault(); // ?? 

			var btnId = $(this).attr('id');

			switch (btnId) {

			case 'btnSearchClassPlan':
				board_searchClassPlan();
				break;
			case 'btnCloseLsmCod':
				gfCloseModal();
				break;
				
			case 'btnClassPlanDel':
				fDeleteClassPlanDel();
				break;
			}
		});
		
		
	}

	/** 강의계획서 조회 */
	function fListClassPlan(currentPage) {

		currentPage = currentPage || 1;
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		var classPlanSearchKey = $('#classPlanSearchKey').val();
		var classPlanSearchContent = $('#classPlanSearchContent').val();
		console.log("currentEngPage : " + currentPage);

		var param = {
			startDate : startDate,
			endDate : endDate,
			searchKey : classPlanSearchKey,
			searchContent : classPlanSearchContent,
			currentPage : currentPage,
			pageSize : pageSizeClassPlan
		}
		
		var resultCallback = function(data) {
			flistClassPlanResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/sup/listClassPlan.do", "post", "text", true, param,	resultCallback);
	}

	/** 강의계획서 조회 콜백 함수 */
	function flistClassPlanResult(data, currentPage) {
		console.log(data);

		// 기존 목록 삭제
		$('#listClassPlan').empty();

		// 신규 목록 생성
		$("#listClassPlan").append(data);

		// 총 개수 추출

		var totalCntClassPlan = $("#totalCntClassPlan").val();

		// 페이지 네비게이션 생성

		var paginationHtml = getPaginationHtml(currentPage, totalCntClassPlan, pageSizeClassPlan, pageBlockSizeClassPlan, 'fListClassPlan');
		$("#classPlanPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageClassPlan").val(currentPage);
	}
	// 강의계획서 검색기능
	function board_searchClassPlan(currentPage) {

		currentPage = currentPage || 1;
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		var classPlanSearchKey = $('#classPlanSearchKey').val();
		var classPlanSearchContent = $('#classPlanSearchContent').val();
		console.log("currentEngPage : " + currentPage);
		console.log(param);
		
		var param = {
			startDate : startDate,
			endDate : endDate,
			searchKey : classPlanSearchKey,
			searchContent : classPlanSearchContent,
			currentPage : currentPage,
			pageSize : pageSizeClassPlan
		}

		var resultCallback = function(data) {
			flistClassPlanResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/sup/listClassPlan.do", "post", "text", true, param,	resultCallback);

	}
	
	/*강의계획서 삭제*/
	function fDeleteClassPlanDel(){
		 var delList = [];
		 $("input[name^=classPlan]:checked").each(function(){
			 delList.push($(this).val());
		 })
		 if(delList.length == 0){
			 alert('삭제할 강의를 선택해주세요');
			 return ;
		 }
		 var param = {
				 delList : delList	 
		 }
		 
		 alert(delList);
		 var resultCallback = function(data) {
			 
			 fListClassPlan();
			 //fListTeacher();
			 
		 }
		 callAjax("/sup/deleteClassPlan.do", "post", "json", true, param, resultCallback);
		 
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
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span class="btn_nav bold">인원관리</span> <span class="btn_nav bold">강사관리</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
							</p>

							<br>
							<p class="conTitle mt50">
								<span>강의계획서</span> <span class="fr"> 
									 
									<select name = "classPlanSearchKey" id = "classPlanSearchKey" style="width: 60px; height: 28px;">
										<option value = "" selected="selected">선택</option>

										<option value = "1">과목</option>
										<option value = "2">강사</option>
									</select>
									<input class="inputTxt" style="width: 200px" type="text" id="classPlanSearchContent" name="classPlanSearchContent">
									<span class="btn_nav bold">강의날짜:</span>&emsp;
									<input type="date" name="startDate" id="startDate" style="font-size: 18px" /> ~ 
									<input type="date" name="endDate" id="endDate" style="font-size: 18px" /> &emsp; 
									<a href="" class="btnType blue" id="btnSearchClassPlan" name="btn"><span>검 색</span></a>
								</span>
							</p>
							
							<span class="fr"> 
								<c:if test = "${sessionScope.userType == 'A' }">
									<a href="javascript:fClassPlanRegister('I');" class="btnType blue" ><span>등  록</span></a>
									<a href="" class="btnType gray" id="btnClassPlanDel" name="btn"><span>삭제</span></a>
								</c:if>
							</span>
							<div class="divComDtlCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="7%">
										<col width="10%">
										<col width="20%">
										<col width="10%">
										<col width="20%">
										<col width="20%">
										<col width="7%">
										<col width="7%">
									</colgroup>

									<thead>
										<tr>
											<th></th>
											<th scope="col">분류</th>
											<th scope="col">과목</th>
											<th scope="col">강사명</th>
											<th scope="col">강의일</th>
											<th scope="col">모집일</th>
											<th scope="col">신청인원</th>
											<th scope="col">총원</th>
										</tr>
									</thead>
									<tbody id="listClassPlan"></tbody>
								</table>
							</div>

							<div class="paging_area" id="classPlanPagination"></div>

						</div>
					</li>
				</ul>
			</div>

		</div>
	</form>


</body>
</html>