<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<title>수강 상담 이력</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 과정 목록 페이징 설정
	var pageSizeCourseList = 5;
	var pageBlockSizeCourseList = 5;

	// 수강 학생 목록 페이징 설정
	var pageSizeUserList = 5;
	var pageBlockSizeUserList = 5;

	// 상담 목록 페이징 설정
	var pageSizeAdviceList = 5;
	var pageBlockSizeAdviceList = 5;

	/** OnLoad event */
	$(function() {

		// 과정 목록 조회
		fListCourseList();

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();

		// datepicker 공통 옵션 설정
		$.datepicker
				.setDefaults({
					dateFormat : 'yy-mm-dd' //Input Display Format 변경
					,
					showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
					,
					showMonthAfterYear : true //년도 먼저 나오고, 뒤에 월 표시
					,
					changeYear : true //콤보박스에서 년 선택 가능
					,
					changeMonth : true //콤보박스에서 월 선택 가능
					,
					showOn : "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
					,
					buttonImage : "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
					,
					buttonImageOnly : true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
					,
					buttonText : "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트
					,
					yearSuffix : "년" //달력의 년도 부분 뒤에 붙는 텍스트
					,
					monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8',
							'9', '10', '11', '12' ] //달력의 월 부분 텍스트
					,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
							'8월', '9월', '10월', '11월', '12월' ] //달력의 월 부분 Tooltip 텍스트
					,
					dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ] //달력의 요일 부분 텍스트
					,
					dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일',
							'토요일' ]
				});

		//input을 datepicker로 선언
		$("#consult_date").datepicker();

		//From의 초기값을 오늘 날짜로 설정
		$('#consult_date').datepicker('setDate', '-1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

	});

	/** 과정 목록 조회 */
	function fListCourseList(currentPage) {

		currentPage = currentPage || 1;

		var param = {
			sname : $('#sname').val()
		 ,  oname : $('#searchKey').val()
		 ,  currentPage : currentPage
		 ,  pageSize : pageSizeCourseList
		}

		var resultCallback = function(data) {
			flistCourseResult(data, currentPage);
		};

		// callAjax(url, type, return, async or sync, 데이터, Callback 함수)
		callAjax("/sup/adviceListCourse.do", "post", "text", true, param,
				resultCallback);
	}

	/** 과정 목록 조회 콜백 함수 */
	function flistCourseResult(data, currentPage) {

		// 기존 목록 삭제
		$('#courseList').empty();

		// 신규 목록 생성
		$("#courseList").append(data);

		// 총 개수 추출
		var totalCntCourse = $("#totalCntCourse").val();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntCourse,
				pageSizeCourseList, pageBlockSizeCourseList, 'fListCourseList');
		
		//swal(paginationHtml);
		$("#pagingnavi").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageCourseList").val(currentPage);
	}

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSearchCourse':
				fSearchCourse();
				break;

			case 'btnClose':
				gfCloseModal();
				break;

			case 'btnSaveConsult':
				fSaveConsult();
				break;

			}
		});
	}

	/** 과정 검색 */
	function fSearchCourse(currentPage) {

		currentPage = currentPage || 1;

		var param = {
				 sname : $('#sname').val()
			 ,  oname : $('#searchKey').val()
			 ,  currentPage : currentPage
			 ,  pageSize : pageSizeCourseList
		}

		var resultCallback = function(data) {
			flistCourseResult(data, currentPage);
		};

		callAjax("/sup/adviceListCourse.do", "post", "text", true, param,
				resultCallback);

	}

	/** 수강 학생 조회 */
	function fSelectUserList(currentPage, class_no) {

		currentPage = currentPage || 1;

		$("#class_no").val(class_no);

		var param = {
				 class_no : class_no
			,  currentPage : currentPage
			,  pageSize : pageSizeUserList
		};

		var resultCallback = function(data) {
			fSelectUserListResult(data, currentPage);
		};

		callAjax("/sup/listUser.do", "post", "text", true, param,
				resultCallback);
	}

	/** 수강 학생 조회 콜백 함수 */
	function fSelectUserListResult(data, currentPage) {

		// 기존 목록 삭제
		$('#userList').empty();
		$('#adviceList').empty();

		var $data = $($(data).html());

		// 신규 목록 생성
		var $userList = $data.find("#userList");
		$("#userList").append($userList.children());

		// 총 개수 추출
		var $totalCntUser = $data.find("#totalCntUser");
		var totalCntUser = $totalCntUser.text();

		// 페이지 네비게이션 생성
		var class_no = $("#class_no").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCntUser,
				pageSizeUserList, pageBlockSizeUserList, 'fSelectUserList',
				[ class_no ]);

		//swal(paginationHtml);
		$("#userListPagingnavi").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageUserList").val(currentPage);

	}

	/** 상담 목록 조회 */
	function fSelectAdviceList(currentPage, loginID) {

		currentPage = currentPage || 1;

		$("#loginID").val(loginID);

		var param = {
				 loginID : loginID
			,  currentPage : currentPage
			,  pageSize : pageSizeUserList
			,  class_no : $("#class_no").val()
		};

		var resultCallback = function(data) {
			fSelectAdviceListResult(data, currentPage);
		};

		callAjax("/sup/listAdvice.do", "post", "text", true, param,
				resultCallback);
	}

	/** 상담 목록 조회 콜백 함수 */
	function fSelectAdviceListResult(data, currentPage) {

		// 기존 목록 삭제
		$('#adviceList').empty();

		var $data = $($(data).html());

		// 신규 목록 생성
		var $adviceList = $data.find("#adviceList");
		$("#adviceList").append($adviceList.children());

		// 총 개수 추출
		var $totalCntAdvice = $data.find("#totalCntAdvice");
		var totalCntAdvice = $totalCntAdvice.text();

		// 페이지 네비게이션 생성
		var loginID = $("#loginID").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCntAdvice,
				pageSizeAdviceList, pageBlockSizeAdviceList,
				'fSelectAdviceList', [ loginID ]);

		//swal(paginationHtml);
		$("#adviceListPagingnavi").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageAdviceList").val(currentPage);

	}

	/** 상담 목록 단건 조회 */
	function fSelectAdvice(consult_no) {

		$("#consult_no").val(consult_no)
		var param = {
			consult_no : consult_no
		};

		var resultCallback = function(data) {
			fSelectAdviceResult(data);
		};

		callAjax("/sup/selectConsult.do", "post", "json", true, param,
				resultCallback);
	}

	/** 그룹코드 단건 조회 콜백 함수*/
	function fSelectAdviceResult(data) {

		if (data.result == "SUCCESS") {

			$("#action").val("U");

			// 모달 팝업
			gfModalPop("#layer1");

			// 그룹코드 폼 데이터 설정
			fInitFormAdvice(data.adviceMgtModel);

		} else {
			swal(data.resultMsg);
		}
	}

	/** 상담 등록 모달 실행 */
	function fPopModalAdvice(loginID) {

		// 신규 저장
		if (loginID == null || loginID == "") {

			if ($("#loginID").val() == "") {
				swal("학생명을 선택해 주세요.");
				return;
			}

			// Tranjection type 설정
			$("#action").val("I");

			// 상세코드 폼 초기화
			fInitFormAdvice();

			// 모달 팝업
			gfModalPop("#layer1");

			// 수정 저장
		} else {

			// Tranjection type 설정
			$("#action").val("U");

			// 상세코드 단건 조회
			fSelectAdvice(loginID);
		}
	}

	/** 상담 모달 폼 초기화 */
	function fInitFormAdvice(object) {

		if (object == "" || object == null || object == undefined) {

			$("#consult_date").val("");
			$("#consult_place").val("");
			$("#consult_content").val("");

		} else {

			$("#consult_date").val(object.consult_date);
			$("#consult_place").val(object.consult_place);
			$("#consult_content").val(object.consult_content);
		}
	}

	/** 상담 등록 */
	function fSaveConsult() {

		var resultCallback = function(data) {
			fSaveConsultResult(data);
		};

		callAjax("/sup/saveConsult.do", "post", "json", true, $("#consult")
				.serialize(), resultCallback);

	}

	/** 상담 등록 콜백 함수 */
	function fSaveConsultResult(data) {

		// 목록 조회 페이지 번호
		var currentPage = "1";

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			swal(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 목록 조회
			fSelectAdviceList(currentPage, $("#loginID").val());

		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
	}
</script>

</head>

<body>

	<form id="consult" action="" method="">

		<input type="hidden" id="currentPageCourseList" value="1">
		<input type="hidden" id="currentPageUserList" value="1">
		<input type="hidden" id="currentPageAdviceList" value="1">
		<input type="hidden" name="action" id="action" value="">
		<input type="hidden" name="consult_no" id="consult_no" value="">
		<input type="hidden" name="class_no" id="class_no" value="">
		<input type="hidden" name="loginID" id="loginID" value="">

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
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <a href="#" class="btn_nav bold">학습지원</a> <a onClick="window.location.reload()" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>수강 상담 이력 </span> <span class="fr"> <c:set var="nullNum" value=""></c:set></span>
							</p>

							<!-- 검색창 -->
							<table style="margin-bottom: 10px; width: 100%; cellpadding: 5; cellspacing: 0; border: 1; align: left">
								<tr style="border: 0px; border-color: blue">
									<td width="50" height="25" style="font-size: 100%; text-align: left; padding-right: 25px;">
										<select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
											<option value="class_nm">과정명</option>
										</select>
										<input type="text" style="width: 300px; height: 25px;" id="sname" name="sname">
										<a href="" class="btnType blue" id="btnSearchCourse" name="btn"><span>검색</span></a>
									</td>
								</tr>
							</table>

							<div class="divCourseList">
								<table class="col">
									<caption>caption</caption>

									<colgroup>
										<col width="50px">
										<col width="60px">
										<col width="50px">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">과정명</th>
											<th scope="col">강의기간</th>
											<th scope="col">작성자</th>
										</tr>
									</thead>
									<tbody id="courseList"></tbody>
								</table>

								<!-- 페이징 처리  -->
								<div class="paging_area" id="pagingnavi"></div>

								<!-- 학생목록 -->
								<p class="conTitle mt50">
									<span>수강 학생</span>
								</p>

								<div class="divUserList">
									<table class="col">
										<caption>caption</caption>
										<colgroup>
											<col width="50%">
											<col width="50%">
										</colgroup>

										<thead>
											<tr>
												<th scope="col">학생명</th>
												<th scope="col">시험 최종 점수</th>
											</tr>
										</thead>
										<tbody id="userList">
											<tr>
												<td colspan="12">과정을 선택해 주세요.</td>
											</tr>
										</tbody>
									</table>
								</div>

								<!-- 페이징 처리  -->
								<div class="paging_area" id="userListPagingnavi"></div>

								<!-- 상담 이력 -->
								<p class="conTitle mt50">
									<span>상담 이력</span> <span class="fr"> <a class="btnType blue" href="javascript:fPopModalAdvice();" name="modal"><span>등록</span></a>
									</span>
								</p>

								<div class="divAdviceList">
									<table class="col">
										<caption>caption</caption>
										<colgroup>
											<col width="35%">
											<col width="35%">
											<col width="30%">
										</colgroup>

										<thead>
											<tr>
												<th scope="col">상담일자</th>
												<th scope="col">상담장소</th>
												<th scope="col">상담자</th>
											</tr>
										</thead>
										<tbody id="adviceList">
											<tr>
												<td colspan="12">학생명을 선택해 주세요.</td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- 페이징 처리  -->
								<div class="paging_area" id="adviceListPagingnavi"></div>

							</div>
							<!-- divCourseList -->

						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 50%;">

			<dl>
				<dt>
					<strong>상담 등록</strong>
				</dt>
				<dd class="content">

					<table class="row">
						<caption>caption</caption>

						<tbody>
							<tr>
								<th scope="row">상담일자</th>
								<td>
									<input type="text" class="inputTxt p90" id="consult_date" name="consult_date" style="width: 80%; margin-right: 5px;" />
								</td>
								<th scope="row">상담장소</th>
								<td>
									<input type="text" class="inputTxt p100" name="consult_place" id="consult_place" />
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3">
									<textarea class="inputTxt p100" id="consult_content" name="consult_content"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveConsult" name="btn"><span>저장</span></a> <a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>

			</dl>
		</div>

	</form>

</body>
</html>
