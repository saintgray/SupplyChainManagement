<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType eq 'C'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 시험 대상자 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	
	// 시험 목록 페이징 설정
	var pageSizeExam = 5;
	var pageBlockSizeExam = 5;
	
	// 응시자 목록 페이징 설정
	var pageSizeExamMember = 10;
	var pageBlockSizeExamMember = 10;
	
	/** OnLoad event */ 
	$(function() {
		
		var pathType = $("#pathType").val();
		
		if (pathType == "EM") {
			// alert("pathType == EM\n시험 대상자 관리");
			$(document).find("title").text("Job Korea :: 시험 대상자 관리")
			$("#examMgtSubTitle").empty().append("시험대상자관리");
		} else if (pathType == "ER") {
			// alert("pathType == EM\n시험 결과 조회");
			$(document).find("title").text("Job Korea :: 시험 결과 조회")
			$("#examMemMgtFlag").empty().append("시험 결과 조회");
			$("#examMgtSubTitle").empty().append("시험결과조회");
		} else {
			alert("경로 출력 실패!! -ㅁ-!!");
		}
		
		// 강의 목록 출력
		flistExam2();
		
		// 시험 목록 콤보박스 '전체'로 초기화
		$("#searchKey").val("key_all");
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		
		
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearchExam' :
					flistExam2();
					break;
			}
		});
	}
	
	/** 시험 목록 출력 */
	function flistExam2(currentPage) {
		
		currentPage = currentPage || 1;
		
		var searchKey = $('#searchKey').val();
		var examname = $('#examname').val();
		
		console.log("currentPage : " + currentPage);
		console.log("examname : " + examname);
		
		var param = {	
					examname : examname
				,	searchKey : searchKey
				,	currentPage : currentPage
				,	pageSize : pageSizeExam
		}
		
		var resultCallback = function(data) {
			flistExam2Result(data, currentPage);
		};
		callAjax("/mng/listExam2.do", "post", "text", true, param, resultCallback);
	}	
	
	/** 시험 목록 출력 CALLBACK */
	function flistExam2Result(data, currentPage) {
		$("#listExam").empty();			// 기존 시험 목록 삭제
		$("#listExam").append(data);	// 시험 목록 출력
		
		// 총 개수 출력
		var examCnt = $("#examCnt").val();
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, examCnt, pageSizeExam, pageBlockSizeExam, 'flistExam2');
		console.log("paginationHtml : " + paginationHtml);
		$("#examPagination").empty().append( paginationHtml );	
		$("#currentPageExam").val(currentPage);					// 현재 페이지 설정
	}
	
	/** 해당 강좌의 모든 유형(A, B, C)가 출제되었는지 검사 */
	function flistExamMemberChk(currentPage, classNo) {
		
		console.log(":::::flistExamMemberChk():::::");
		console.log("currentPage : " + currentPage);
		console.log("classNo : " + classNo);
		console.log("::::::::::::::::::::::::::::::");
		
		var param = {
				classNo : classNo,
				currentPage : currentPage
			};
			var resultCallback = function(data) {
				flistExamMemberChkResult(data);
			};
			callAjax("/mng/typeNullChk.do", "post", "json", true, param, resultCallback);
	}

	/** 해당 강좌의 모든 유형(A, B, C)가 출제되었는지 검사 CALLBACK */
	function flistExamMemberChkResult(data) {
		// result 값 SUCCESS : 모든 유형 출제 완료 | result 값 FAIL : 출제 안 된 유형 있음
		console.log(":::flistExamMemberChkResult(data):::");
		console.log("data : " + data);
		console.log("::::::::::::::::::::::::::::::::::::");
		
		var chkType = data.result;
		
		if (chkType == "FAIL") {
			swal("출제되지 않은 유형이 있습니다.\n\"학습관리 > [시험문제관리]\"\n에서 해당 시험을 확인해 주세요. ㅡ_ㅡ+")
			return;
		} else if (chkType == "SUCCESS") {
			var currentPage = data.currentPage;
			var classNo = data.classNo;
			flistExamMember(currentPage, classNo);
		} else {
			swal("알 수 없는 오류가 발생하였습니다. '_'?")
			return;
		}
	}

	/** 시험 응시자 목록 출력 */
	function flistExamMember(currentPage, classNo) {
		currentPage = currentPage || 1;
		// 선택한 시험 정보 설정
		$("#tmpClassNo").val(classNo);

		console.log("currentPage : " + currentPage);
		console.log("classNo : " + classNo);

		var param = {
			classNo : classNo,
			currentPage : currentPage,
			pageSize : pageSizeExamMember
		}

		var resultCallback = function(data) {
			flistExamMemberResult(data, currentPage);
		};

		callAjax("/mng/listExamMember.do", "post", "text", true, param,
				resultCallback);
	}

	/** 시험 응시자 목록 출력 */
	function flistExamMember(currentPage, classNo) {
		currentPage = currentPage || 1;
		// 선택한 시험 정보 설정
		$("#tmpClassNo").val(classNo);

		console.log("currentPage : " + currentPage);
		console.log("classNo : " + classNo);

		var param = {
			classNo : classNo,
			currentPage : currentPage,
			pageSize : pageSizeExamMember
		}

		var resultCallback = function(data) {
			flistExamMemberResult(data, currentPage);
		};

		callAjax("/mng/listExamMember.do", "post", "text", true, param,
				resultCallback);
	}

	/** 시험 응시자 목록 출력 CALLBACK */
	function flistExamMemberResult(data, currentPage) {
		$("#listExamMember").empty(); // 기존 응시자 목록 삭제
		var $data = $($(data).html());

		var $listExamMember = $data.find("#listExamMember"); // 응시자 목록 출력	
		$("#listExamMember").append($listExamMember.children());

		// 시험 문제 총 개수 추출
		var $examMemCnt = $data.find("#examMemCnt");
		var examMemCnt = $examMemCnt.text();

		// 페이지 네비게이션 생성
		var classNo = $("#tmpClassNo").val();
		var paginationHtml = getPaginationHtml(currentPage, examMemCnt,
				pageSizeExamMember, pageBlockSizeExamMember, 'flistExamMember',
				[ classNo ]);
		$("#examMemberPagination").empty().append(paginationHtml);
		$("#currentPageExamMember").val(currentPage); // 현재 페이지 설정
	}
</script>

</head>
<body>
<form id="examMemberMgtForm" action=""  method="">
	<input type="hidden" id="pathType" value="${pathType}">
	<input type="hidden" id="currentPageExam" value="1">
	<input type="hidden" id="currentPageExamMember" value="1">
	<input type="hidden" id="tmpClassNo" value="">
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold" id="examMgtSubTitle">시험대상자관리</span> <a href="../mng/examMember.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<!-- 시험 목록 START -->
						<p class="conTitle">
							<span>시험 목록</span><span class="fr"></span>
						</p>
						            
						<div class="divExamList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="*%">
									<col width="20%">
									<col width="6%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">과정명</th>
										<th scope="col">기간</th>
										<th scope="col">상태</th>
										<th scope="col">대상자 수</th>
										<th scope="col">응시자 수</th>
										<th scope="col">미응시자 수</th>
									</tr>
								</thead>
								<tbody id="listExam"></tbody>
							</table>
						</div>
	
						<div class="paging_area" id="examPagination"> </div>
						
						
						
						<table style="margin:15px 0 10px 0;" width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="collapse; border: 1px #50bcdf;">
		                   	<tr style="border:0px; border-color:blue;">
		                      	<td width="150" height="25" style="font-size:100%; text-align:right;">
		                      	<select id="searchKey" name="searchKey" style="width:80px; margin-right:10px;" v-model="searchKey">
									<option value="key_all" >전체</option>
									<option value="key_pro" >진행중</option>
									<option value="key_end" >종료</option>
								</select> 
		                      	</td>
		               			<td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
		     	      			<input type="text" style="width: 300px; height: 25px;" id="examname" name="examname" placeholder="과정명을 입력하세요.">                    
				             	<a href="" class="btnType blue" id="btnSearchExam" name="btn"><span>검  색</span></a>
		                        </td> 
		             		</tr>
		               	</table>

						<!-- 시험 목록 END -->
						
						<!-- 응시자 목록 START -->
						<p class="conTitle" style="margin-top:70px;">
							<span>응시자 목록</span>
						</p>
	
						<div class="examMemberList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="*%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">학생명</th>
										<th scope="col">시험 유형</th>
										<th scope="col">점수</th>
										<th scope="col">상태</th>
									</tr>
								</thead>
								<tbody id="listExamMember">
									<tr>
										<td colspan="5">과정을 선택하세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="paging_area" id="examMemberPagination"></div>
						
						<!-- 응시자 목록 END -->
					
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