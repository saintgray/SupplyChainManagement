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
<title>Job Korea :: 시험 문제 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	// 저장 버튼 dupChk flag
	var saveFlag = true;
	
	// 강의 목록 페이징 설정
	var pageSizeClass = 5;
	var pageBlockSizeClass = 5;
	
	// 시험 문제 페이징 설정
	var pageSizeExam = 10;
	var pageBlockSizeExam = 10;

	/** OnLoad event */ 
	$(function() {
		// 강의 목록 출력
		flistClass();
		
		// 시험 목록 콤보박스 disabled로 초기화
		$("#searchKey").attr("disabled", true);
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearchClass' :
					flistClass();
					break;
				case 'btnSaveQuestion' :
					fSaveQuestion();
					break;
				case 'btnDeleteQuestion' :
					if(!confirm("삭제한 문제는 복구할 수 없습니다.\n정말 삭제합니까? 'ㅁ'?")) {
						return;
					} else {
						fDeleteQuestion();
					}
					break;
				case 'btnCloseQuestion' :
					gfCloseModal();
					$("#tmpQno").val("");
					$("#dupChk").empty().append("");
					break;
			}
		});
	}
	
	/** 강의 목록 출력 */
	function flistClass(currentPage) {
		
		currentPage = currentPage || 1;
		
		var classname = $('#classname').val();
		
		console.log("currentPage : " + currentPage);
		console.log("classname : " + classname);
		
		var param = {	
					classname : classname
				,	currentPage : currentPage
				,	pageSize : pageSizeClass
		}
		
		var resultCallback = function(data) {
			flistClassResult(data, currentPage);
		};
		callAjax("/mng/listClass.do", "post", "text", true, param, resultCallback);
	}	
	
	/** 강의 목록 출력 CALLBACK */
	function flistClassResult(data, currentPage) {
		$("#listClass").empty();		// 기존 강의 목록 삭제
		$("#listClass").append(data);	// 강의 목록 출력
		
		// 총 개수 출력
		var classCnt = $("#classCnt").val();
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, classCnt, pageSizeClass, pageBlockSizeClass, 'flistClass');
		console.log("paginationHtml : " + paginationHtml);
		$("#classPagination").empty().append( paginationHtml );	
		$("#currentPageClass").val(currentPage);					// 현재 페이지 설정
	}

	/** 시험 문제 목록 출력 */
	function flistExam(currentPage, classNo, type) {
		// 콤보박스 disabled 해제 및 초기화
		if ($("#searchKey").is(":disabled")) {
			$("#searchKey").attr("disabled", false);
		}
		
		// 강의 리스트에서 선택 시 문제 유형 'A'로 초기화
		if (type == "init") {
			$("#searchKey").val("type_a");
		}
		type = $("#searchKey").val();
		
		currentPage = currentPage || 1;
		// 선택한 강의 정보 설정
		$("#tmpClassNo").val(classNo);
		
		console.log("currentPage : " + currentPage);
		console.log("classNo : " + classNo);
		console.log("type : " + type);
		
		var param = {
					classNo : classNo
				,	type : type	
				,	currentPage : currentPage
				,	pageSize : pageSizeExam
		}
		
		var resultCallback = function(data) {
			flistExamResult(data, currentPage);
		};
		
		callAjax("/mng/listExam.do", "post", "text", true, param, resultCallback);
	}
	
	/** 시험 문제 목록 출력 CALLBACK */
	function flistExamResult(data, currentPage) {
		$('#listExam').empty();	// 기존 시험 문제 목록 삭제
		var $data = $( $(data).html() );
		
		var $listExam = $data.find("#listExam");	// 시험 문제 목록 출력	
		$("#listExam").append($listExam.children());
		
		// 시험 문제 총 개수 추출
		var $examCnt = $data.find("#examCnt");	
		var examCnt = $examCnt.text(); 
		var $examMaxqNo = $data.find("#examMaxqNo");	
		var examMaxqNo = $examMaxqNo.text();
		$("#cntQuestion").empty().append("<strong>문항 수</strong> : " + examCnt);
		$("#cntMaxQno").empty().append("<strong>마지막 문제 번호</strong> : " + examMaxqNo);
		if (examCnt != examMaxqNo) {
			$("#cntWarn").empty().append("<span class='font_red'><strong>누락된 문항을 확인해 주세요!!</strong></span>");
		} else {
			$("#cntWarn").empty().append("");
		} 
		
		// 페이지 네비게이션 생성
		var classNo = $("#tmpClassNo").val();
		var paginationHtml = getPaginationHtml(currentPage, examCnt, pageSizeExam, pageBlockSizeExam, 'flistExam', [classNo]);
		$("#examPagination").empty().append( paginationHtml );	
		$("#currentPageExam").val(currentPage);	// 현재 페이지 설정
	}
	
	/** 시험 문제 목록의 문제 유형 변경 */
	function changeQuestionType() {
		var selectClassNo = $("#tmpClassNo").val();
		flistExam(1, selectClassNo, "combo");
	}
	
	/** 해당 시험 응시자 있는지 체크 */
	function chkMemberCnt(classNo, qNo, qType) {
		if (qNo == null || qNo == "") {
			classNo = $("#tmpClassNo").val();
			qNo = "noVal";
			qType = "noVal";	
			var chkLoc = "INSERT";
		} else {
			var chkLoc = "UPDATE";
		}
		
		var param = { 
					chkLoc : chkLoc
				,	classNo : classNo
				,	qNo : qNo
				,	qType : qType
		}
		
		var resultCallback = function(data) {
			chkMemberCntResult(data);
		};
		callAjax("/mng/chkMemberCnt.do", "post", "json", true, param, resultCallback);
	}
	
	/** 해당 시험 응시자 있는지 체크 CALLBACK */
	function chkMemberCntResult(object) {
		var classNo = object.classNo;
		var memberCnt = object.memberCnt;
		var action = object.action;
		var qNo = "";
		var qType = "";
		
		if (action == "UPDATE") {
			var qNo = object.qNo;
			var qType = object.qType;
		}
		
		console.log("classNo : " + classNo);
		console.log("memberCnt : " + memberCnt);
		console.log("action : " + action);
		console.log("qNo : " + qNo);
		console.log("qType : " + qType);
		
		if (memberCnt > 0 && action == "INSERT") {
			swal("이미 응시자가 있어 문항을 추가할 수 없습니다. 'ㅁ'!!");
			return;
		} else if (memberCnt > 0 && action == "UPDATE") {
			swal("이미 응시자가 있어 문항을 수정할 수 없습니다. 'ㅁ'!!");
			return;
		} else if (memberCnt == 0) {
			fPopModalQuestion(classNo, qNo, qType);
		}
	}
	
	/** 시험 문제 INSERT or UPDATE */
	function fPopModalQuestion(classNo, qNo, qType) {
		if (qNo == null || qNo == "") {		// 문항 INSERT 시
			if ($("#tmpClassNo").val() == "") {
				swal("문항을 출제할 강의를 선택하세요. -ㅁ-;;");
				return;
			}
			
			$("#action").val("I");	// INSERT인지 UPDATE인지 구분할 action값 지정
			fInitFormQuestion();	// 문항 관리 모달 초기화		
			gfModalPop("#layer2");	// 모달 팝업

		} else {	// 문항 UPDATE 시
			$("#action").val("U");					// INSERT인지 UPDATE인지 구분할 action값 지정	
			fSelectQuestion(classNo, qNo, qType);	// 문항 정보 조회
		}
	}
	
	/** 문항 관리 모달 초기화 */
	function fInitFormQuestion(object) {
		if(object == "" || object == null || object == undefined) {
			
			saveFlag = true;
			$("#dupChk").empty().append("");
			$("input:radio[name='setQtype']:input[value='A']").attr("checked", true);
			$("#setQno").val("");
			$("#setQcontent").val("");
			$("#setOne").val("");
			$("#setTwo").val("");
			$("#setThree").val("");
			$("#setFour").val("");
			$("#setQsolution").val("1");
			
			$("#setQno").focus();
			$("#btnDeleteQuestion").hide();
		
		} else {

			$("input:radio[name='setQtype']:input[value='" + object.qType + "']").attr("checked", true);
			$("#setQno").val(object.qNo);
			$("#setQcontent").val(object.qContent);
			$("#setOne").val(object.qOne);
			$("#setTwo").val(object.qTwo);
			$("#setThree").val(object.qThree);
			$("#setFour").val(object.qFour);
			$("#setQsolution").val(object.qSolution);
			
			$("#setQno").focus();
			$("#btnDeleteQuestion").show();
		}
	}
	
	/** 문항 관리 모달 유효성 검사 */
	function fValidateExam() {

		var chk = checkNotEmpty(
				[
						[ "setQno", "문제 번호를 입력하세요." ]
					,	[ "setQcontent", "문제 내용을 입력하세요." ]
					,	[ "setOne", "1번 선택지 내용을 입력하세요." ]
					,	[ "setTwo", "2번 선택지 내용을 입력하세요." ]
					,	[ "setThree", "3번 선택지 내용을 입력하세요." ]
					,	[ "setFour", "4번 선택지 내용을 입력하세요." ]
				]
		);

		if (!chk) {
			return;
		}
		
		if ($("#setQno").val() == 0) {
			swal("문제 번호는 0이 될 수 없습니다. -_-;;");
			$("#setQno").val($("#tmpQno").val());
			return;
		}
		
		return true;
	}
	
	/** 문항 상세 조회 */
	function fSelectQuestion(classNo, qNo, qType) {
		$("#tmpQno").val(qNo);
		$("#tmpClassNo").val(classNo);
		$("#tmpQtype").val(qType);
		
		console.log(":::fSelectQuestion(classNo, qNo, qType):::");
		console.log("$('#tmpQno').val() : " + $("#tmpQno").val());
		console.log("$('#tmpClassNo').val() : " + $("#tmpClassNo").val());
		console.log("$('#tmpQtype').val() : " + $("#tmpQtype").val());
		console.log("::::::::::::::::::::::::::::::::::::::::::");
		
		var param = {
					classNo : classNo
				,	qNo : qNo
				,	qType : qType				
		};
		
		var resultCallback = function(data) {
			fSelectQuestionResult(data);
		};
		
		callAjax("/mng/selectQuestion.do", "post", "json", true, param, resultCallback);
	}
	
	/** 문항 상세 조회 CALLBACK */
	function fSelectQuestionResult(data) {
		console.log(data);
		if (data.result == "SUCCESS") {
			
			// 모달 팝업
			gfModalPop("#layer2");
			
			// 문항 관리 폼 데이터 설정
			fInitFormQuestion(data);
			
			swal(data.resultMsg);
		} else {
			swal(data.resultMsg);
		}	
	}
	
	/** 문항 INSERT & UPDATE */
	function fSaveQuestion() {
		// 유효성 검사
		if ( ! fValidateExam() ) {
			return;
		}
		
		if (!saveFlag) {
			swal("중복되는 문제 번호는 사용할 수 없습니다. ㅠ_ㅠ");
			return;
		}
		
		var resultCallback = function(data) {
			fSaveQuestionResult(data);
		};
		
		callAjax("/mng/saveQuestion.do", "post", "json", true, $("#examMgtForm").serialize(), resultCallback);
	}
	
	/** 문항 INSERT & UPDATE CALLBACK */
	function fSaveQuestionResult(data) {
		
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageExam").val();
		}
		
		if (data.result != "FALSE") {
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			$("#tmpQno").val("");
			
			// 목록 조회
			var classNo = $("#tmpClassNo").val();
			flistExam(currentPage, classNo, "SAVE");
			
		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
		
		// 입력 폼 초기화
		fInitFormQuestion();
	}
	
	/** 문항 관리 폼 문제 번호 중복 검사 */
	function fDuplicationChk() {
		var classNo = $("#tmpClassNo").val();
		var oldQno = $("#tmpQno").val();
		var newQno = $("#setQno").val();
		var qType = $("input[name='setQtype']:checked").val();
		
		console.log(":::::fDuplicationChk():::::");
		console.log("classNo : " + classNo);
		console.log("oldQno : " + oldQno);
		console.log("newQno : " + newQno);
		console.log("qType : " + qType);
		console.log(":::::::::::::::::::::::::::::::::::::");
		
		if (oldQno != newQno) {
			if (newQno != null || newQno != "") {
				var param = {
						classNo : classNo
					,	qNo : newQno
					,	qType : qType				
				};
			
				var resultCallback = function(data) {
					fDuplicationChkResult(data);
				};
			
				callAjax("/mng/qNoDuplicationChk.do", "post", "json", true, param, resultCallback);	
			}
		}
	}
	
	/** 문항 관리 폼 문제 번호 중복 검사 CALLBACK */
	function fDuplicationChkResult(data) {
		// return 값 0 : 중복 번호 없음. | return 값 1 : 중복 번호 있음.
		console.log(":::::fDuplicationChkResult(data):::::");
		console.log("data : " + data);
		console.log(":::::::::::::::::::::::::::::::::::::");
		if (data == 0) {
			$("#dupChk").empty().append("");
			saveFlag = true;
		} else {
			$("#dupChk").empty().append("<span class='font_red'><strong>문제 번호가 중복됩니다.</strong></span>");
			saveFlag = false;
		}
	}
	
	/** 문항 DELETE */
	function fDeleteQuestion() {
		var oldQno = $("#tmpQno").val();
		var tmpClassNo = $("#tmpClassNo").val();
		var oldQtype = $("#tmpQtype").val();
		
		console.log(":::fDeleteQuestion():::");
		console.log("oldQno : " + oldQno);
		console.log("tmpClassNo : " + tmpClassNo);
		console.log("oldQtype : " + oldQtype);
		console.log(":::::::::::::::::::::::");
		
		var param = {
					classNo : tmpClassNo
				,	qNo : oldQno
				,	qType : oldQtype				
		};
		
		var resultCallback = function(data) {
			fDeleteQuestionResult(data);
		};

		callAjax("/mng/deleteQuestion.do", "post", "json", true, param, resultCallback);
	}
	
	/** 문항 DELETE CALLBACK */
	function fDeleteQuestionResult(data) {
		var currentPage = $("#currentPageExam").val();
		
		if (data.result == "SUCCESS") {
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 문항 목록 조회
			var classNo = $("#tmpClassNo").val();
			flistExam(currentPage, classNo, "DELETE");
			
		} else {
			swal(data.resultMsg);
		}	
		
	}
	
</script>

</head>
<body>
<form id="examMgtForm" action=""  method="">
	<input type="hidden" id="currentPageClass" value="1">
	<input type="hidden" id="currentPageExam" value="1">
	<input type="hidden" id="tmpClassNo" name="tmpClassNo" value="">
	<input type="hidden" id="tmpQno" name="tmpQno" value="">
	<input type="hidden" id="tmpQtype" name="tmpQtype" value="">
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">시험문제관리</span> <a href="../mng/questionMgt.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<!-- 강의 목록 START -->
						<p class="conTitle">
							<span>강의 목록</span><span class="fr"></span>
						</p>
						            
						<div class="divClassList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="7%">
									<col width="60%">
									<col width="*%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">강의번호</th>
										<th scope="col">과정명</th>
										<th scope="col">기간</th>
									</tr>
								</thead>
								<tbody id="listClass"></tbody>
							</table>
						</div>
	
						<div class="paging_area" id="classPagination"> </div>
						
						<table style="margin:15px 0 10px 0;" width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="collapse; border: 1px #50bcdf;">
		                   	<tr style="border:0px; border-color:blue;">
		                      	<td width="150" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
		               			<td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
		     	      			<input type="text" style="width: 300px; height: 25px;" id="classname" name="classname" placeholder="과정명을 입력하세요.">                    
				             	<a href="" class="btnType blue" id="btnSearchClass" name="btn"><span>검  색</span></a>
		                        </td> 
		             		</tr>
		               	</table>

						<!-- 강의 목록 END -->
						
						<!-- 유형별 문항 구성 START -->
						<p class="conTitle" style="margin-top:70px;">
							<span>유형별 문항 구성</span><span class="fr">
								<a class="btnType blue" href="javascript:chkMemberCnt();" name="modal"><span>문항 추가</span></a>
							</span>
						</p>
						
						<table style="margin-top:12px; margin-bottom:12px;" width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="collapse; border: 1px #50bcdf;">
                        <tr style="border:0px; border-color:blue">
                        	<td width="60" height="25" style="font-size:100%; text-align:left; padding-right:25px;">
                        		<select id="searchKey" name="searchKey" style="width:50px;" v-model="searchKey" onchange="changeQuestionType()">
									<option value="type_a" >A형</option>
									<option value="type_b" >B형</option>
									<option value="type_c" >C형</option>
								</select> 
								&nbsp;&nbsp;<span id="cntQuestion">&nbsp;</span>&nbsp;&nbsp;<span id="cntMaxQno">&nbsp;</span>&nbsp;&nbsp;<span id="cntWarn">&nbsp;</span>
								</td>
                        	<td width="60" height="25" style="font-size:100%;"></td>
            				<td width="15" height="25">&nbsp;&nbsp;</td>
                        </tr>
                     	</table>
	
						<div class="examList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="8%">
									<col width="*%">
									<col width="5%">
									<col width="14%">
									<col width="14%">
									<col width="14%">
									<col width="14%">
									<col width="8%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">문제 번호</th>
										<th scope="col">문제</th>
										<th scope="col">정답</th>
										<th scope="col">①</th>
										<th scope="col">②</th>
										<th scope="col">③</th>
										<th scope="col">④</th>
										<th scope="col">수정</th>
									</tr>
								</thead>
								<tbody id="listExam">
									<tr>
										<td colspan="8">강의를 선택하세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="paging_area" id="examPagination"></div>
						
						<!-- 유형별 문항 구성 END -->
					
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<div id="layer2" class="layerPop layerType2" style="width:600px;">
		<dl>
			<dt>
				<strong>문항 관리</strong>
			</dt>
			<dd class="content">

				<!-- s : 여기에 내용입력 -->

				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">문제 유형 <span class="font_red">*</span></th>
							<td>
								<input type="radio" id="type_a" value="A" name="setQtype" onchange="fDuplicationChk()" /><label for="type_a">A형</label>&nbsp;
								<input type="radio" id="type_b" value="B" name="setQtype" onchange="fDuplicationChk()" /><label for="type_b">B형</label>&nbsp;
								<input type="radio" id="type_c" value="C" name="setQtype" onchange="fDuplicationChk()" /><label for="type_c">C형</label>
							</td>
							<th scope="row">문제 번호 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="setQno" name="setQno" onkeydown="fFilterNumber(event);" onkeyup="fDuplicationChk()" /></td>
						</tr>
						<tr>
							<th scope="row">문제 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="setQcontent" name="setQcontent" /></td>
						</tr>
						
						<tr>
							<th scope="row">선택지 ① <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="setOne" name="setOne" /></td>
						</tr>
						
						<tr>
							<th scope="row">선택지 ② <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="setTwo" name="setTwo" /></td>
						</tr>
					
						<tr>
							<th scope="row">선택지 ③ <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="setThree" name="setThree" /></td>
						</tr>
						
						<tr>
							<th scope="row">선택지 ④ <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="setFour" name="setFour" /></td>
						</tr>
						
						<tr>
							<th scope="row">정답 <span class="font_red">*</span></th>
							<td colspan="3">
								<select id="setQsolution" name="setQsolution" style="width:50px;">
									<option value="1" >&nbsp;①&nbsp;</option>
									<option value="2" >&nbsp;②&nbsp;</option>
									<option value="3" >&nbsp;③&nbsp;</option>
									<option value="4" >&nbsp;④&nbsp;</option>
								</select> 
								&nbsp;&nbsp;
								<span id="dupChk"></span>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveQuestion" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue" id="btnDeleteQuestion" name="btn"><span>삭제</span></a>  
					<a href="" class="btnType gray" id="btnCloseQuestion" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 모달팝업 -->

</form>
</body>
</html>