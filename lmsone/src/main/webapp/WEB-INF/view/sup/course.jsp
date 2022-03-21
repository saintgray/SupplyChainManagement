<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<title>과정공지 및 일정</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 과정 목록 페이징 설정
	var pageSizeCourseList = 5;
	var pageBlockSizeCourseList = 5;

	/** OnLoad event */
	$(function() {

		// 과정 목록 조회
		fListCourseList();

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();

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
		callAjax("/sup/listCourse.do", "post", "text", true, param,
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
		$("#currentPage").val(currentPage);
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

			case 'btnInsertCourse':
				fInsertCourse();
				break;

			case 'btnDownload':
				fDownloadFile();
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

		callAjax("/sup/listCourse.do", "post", "text", true, param,
				resultCallback);

	}

	/** 수강 상세 조회 */
	function fSelectCourse(class_no) {

		var param = {
			class_no : class_no
		};

		var resultCallback = function(data) {
			fSelectCourseResult(data);
		};

		callAjax("/sup/deatilCourse.do", "post", "json", true, param,
				resultCallback);
	}

	/** 수강 상세 조회 콜백 함수 */
	function fSelectCourseResult(data) {

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#courseDetail");

			// 그룹코드 폼 데이터 설정
			fInitFormDtlCourse(data.courseModel);

		} else {
			swal(data.resultMsg);
		}
	}

	/** 수강 상세 모달 폼 초기화 */
	function fInitFormDtlCourse(object) {

		$("#class_no").val(object.class_no);
		$("#class_nm").val(object.class_nm);
		$("#class_startdate").val(object.class_startdate)
		$("#class_enddate").val(object.class_enddate);
		$("#class_plan").val(object.class_plan);

	}

	/** 수강신청 */
	function fInsertCourse() {

		var resultCallback = function(data) {
			fInsertCourseResult(data);
		};

		callAjax("/sup/insertCourse.do", "post", "json", true, $("#course")
				.serialize(), resultCallback);

	}

	/** 수강신청 콜백 함수 */
	function fInsertCourseResult(data) {

		// 목록 조회 페이지 번호
		var currentPage = "1";

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			swal(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 목록 조회
			fListCourseList(currentPage);

		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
	}

</script>

</head>

<body>

	<form id="course" action="" method="">

		<input type="hidden" id="currentPage" value="1">

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
						<h3 class="hidden">contents 영역</h3> 
						
						<div class="content">

							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <a href="#" class="btn_nav bold">학습지원</a> <a onClick="window.location.reload()" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>수강신청 </span> <span class="fr"> <c:set var="nullNum" value=""></c:set></span>
							</p>

							<!-- 검색창 -->
							<table style="margin-bottom: 10px" width="100%" cellpadding="5" cellspacing="0" border="1" align="left">
								<tr style="border: 0px; border-color: blue">
									<td width="50" height="25" style="font-size: 100%; text-align: left; padding-right: 25px;">
										<select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
											<option value="name">작성자</option>
											<option value="class_nm">제목</option>
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
											<th scope="col">제목</th>
											<th scope="col">강의기간</th>
											<th scope="col">작성자</th>
										</tr>
									</thead>
									<tbody id="courseList"></tbody>
								</table>

								<!-- 페이징 처리  -->
								<div class="paging_area" id="pagingnavi"></div>

							</div>

						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!-- 모달팝업 -->
		<div id="courseDetail" class="layerPop layerType2" style="width: 50%;">

			<dl>
				<dt>
					<strong>과정 상세</strong>
				</dt>
				<dd class="content">

					<table class="row">
						<caption>caption</caption>

						<tbody>
							<tr style="display: none">
								<th scope="row">강의번호</th>
								<td>
									<input type="text" class="inputTxt p100" id="class_no" name="class_no" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row">강의명</th>
								<td>
									<input type="text" class="inputTxt p100" id="class_nm" name="class_nm" readonly />
								</td>
								<th scope="row">강의기간</th>
								<td>
									<input type="text" class="inputTxt p45" name="class_startdate" id="class_startdate" readonly />
									~
									<input type="text" class="inputTxt p45" name="class_enddate" id="class_enddate" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row">강의계획</th>
								<td colspan="3">
									<textarea class="inputTxt p100" id="class_plan" name="class_plan" readonly></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnInsertCourse" name="btn"><span>수강신청</span></a> <a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>

			</dl>
		</div>

	</form>

</body>
</html>
