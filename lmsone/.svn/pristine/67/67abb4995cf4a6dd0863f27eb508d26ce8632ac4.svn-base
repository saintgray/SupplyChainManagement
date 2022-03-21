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
<jsp:include page="../login/modalRegister.jsp"></jsp:include>
<!-- sweet swal import -->


<script type="text/javascript">
	// 강사 페이징 설정
	var pageSizeTeacher = 5;
	var pageBlockSizeTeacher = 10;
	$(function() {
		// 버튼 이벤트 등록

		fListTeacher();
		fButtonClickEvent_teacher();


	});

	function fButtonClickEvent_teacher() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault(); // ?? 

			var btnId = $(this).attr('id');

			switch (btnId) {

			case 'btnSearchTeahcer':
				board_searchTeacher();
				break;
			case 'btnCloseLsmCod':
				gfCloseModal();
				break;
				
			case 'btnTeacherDel':
				fDeleteTeacher();
				break;
			}
		});
	}

	/** 강사 조회 */
	function fListTeacher(currentPage) {

		currentPage = currentPage || 1;
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		var teacherName = $('#teacherName').val();

		console.log("currentEngPage : " + currentPage);

		var param = {
			startDate : startDate,
			endDate : endDate,
			teacherName : teacherName,
			currentPage : currentPage,
			pageSize : pageSizeTeacher
		}

		var resultCallback = function(data) {
			flistTeacherResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/tmg/listTeacher.do", "post", "text", true, param,	resultCallback);
	}

	/** 강사 조회 콜백 함수 */
	function flistTeacherResult(data, currentPage) {
		console.log(data);

		// 기존 목록 삭제
		$('#listTeacher').empty();

		// 신규 목록 생성
		$("#listTeacher").append(data);

		// 총 개수 추출

		var totalCntTeacher = $("#totalCntTeacher").val();

		// 페이지 네비게이션 생성

		var paginationHtml = getPaginationHtml(currentPage, totalCntTeacher, pageSizeTeacher, pageBlockSizeTeacher, 'fListTeacher');
		$("#teacherPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageTeacher").val(currentPage);
	}
	// 강사 검색기능
	function board_searchTeacher(currentPage) {
		
		currentPage = currentPage || 1;
		var startDate = $('#startDate').val();
		
		var endDate = $('#endDate').val();
		var teacherName = $('#teacherName').val();
		console.log("teacherName : " + teacherName);
		console.log("currentEngPage : " + currentPage);

		var param = {
			startDate : startDate,
			endDate : endDate,
			teacherName : teacherName,
			currentPage : currentPage,
			pageSize : pageSizeTeacher
		}

		var resultCallback = function(data) {
			flistTeacherResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/tmg/listTeacher.do", "post", "text", true, param,	resultCallback);

	}
	function fDeleteTeacher(){
		 var delList = [];
		 $("input[name^=tmg_]:checked").each(function(){
			 delList.push($(this).val());
		 })
		 if(delList.length == 0){
			 alert('삭제할 메시지를 선택해주세요');
			 return ;
		 }
		 var param = {
				 delList : delList	 
		 }
		 
		 var resultCallback = function(data) {
			 
			 if(data.result == "1") {
				 swal("현재 강의가 진행중인 강사가 있습니다.");
				 return;
			 }
			 fListTeacher();
			 
		 }
		 callAjax("/deleteMember.do", "post", "json", true, param, resultCallback);
		 
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
								<span>강사</span> <span class="fr"> 
									<span class="btn_nav bold">가입날짜:</span>&emsp; 
									<input type="date" name="startDate" id="startDate" style="font-size: 18px" /> ~ 
									<input type="date" name="endDate" id="endDate" style="font-size: 18px" /> &emsp; 
									<span class="btn_nav bold">강사명:</span>&emsp; 
									<input class="inputTxt" style="width: 118px" type="text" id="teacherName" name="teacherName"> 
									<a href="" class="btnType blue" id="btnSearchTeahcer" name="btn"><span>검 색</span></a>
								</span>
							</p>
							<span class="fr"> 
								<a href="javascript:fMemberRegister('D','I');" class="btnType blue" ><span>신규등록</span></a> 
								<a href="" class="btnType gray" id="btnTeacherDel" name="btn"><span>삭제</span></a>
							</span>
							<div class="divComDtlCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="7%">
										<col width="7%">
										<col width="10%">
										<col width="10%">
										<col width="15%">
										<col width="20%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th></th>
											<th scope="col">강사명</th>
											<th scope="col">회원ID</th>
											<th scope="col">비밀번호</th>
											<th scope="col">휴대전화</th>
											<th scope="col">가입날짜</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody id="listTeacher"></tbody>
								</table>
							</div>

							<div class="paging_area" id="teacherPagination"></div>

						</div>
					</li>
				</ul>
			</div>

		</div>
	</form>


</body>
</html>