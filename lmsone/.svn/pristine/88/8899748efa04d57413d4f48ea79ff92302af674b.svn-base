<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType eq 'D'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 시험 응시</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	// 수강 중인 강의의 시험 목록 페이징 설정
	var pageSizeTexam = 5;
	var pageBlockSizeTexam = 5;

	/** OnLoad event */ 
	$(function() {
		// 수강 중인 강의의 시험 목록 출력
		flistTexam();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

 			switch (btnId) {
				case 'btnSearchTexam' :
					flistTexam();
					break;
			} 
		});
	}
	
	/** 강의 목록 출력 */
	function flistTexam(currentPage) {
		
		currentPage = currentPage || 1;
		
		var texamname = $('#texamname').val();
		var sKey = $('#sKey').val();
		
		console.log("currentPage : " + currentPage);
		console.log("texamname : " + texamname);
		console.log("sKey : " + sKey);
		
		var param = {	
					sKey : sKey
				,	texamname : texamname
				,	currentPage : currentPage
				,	pageSize : pageSizeTexam
		}
		
		var resultCallback = function(data) {
			flistTexamResult(data, currentPage);
		};
		callAjax("/mng/listTexam.do", "post", "text", true, param, resultCallback);
	}	
	
	/** 강의 목록 출력 CALLBACK */
	function flistTexamResult(data, currentPage) {
		$("#listTexam").empty();		// 기존 강의 목록 삭제
		$("#listTexam").append(data);	// 강의 목록 출력
		
		// 총 개수 출력
		var texamCnt = $("#texamCnt").val();
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, texamCnt, pageSizeTexam, pageBlockSizeTexam, 'flistTexam');
		console.log("paginationHtml : " + paginationHtml);
		$("#texamPagination").empty().append( paginationHtml );	
		$("#currentPageTexam").val(currentPage);					// 현재 페이지 설정
	}
	
	/** 응시했는지 확인 */
	function ftakeExamChk(classNo) {
		console.log("classNo : " + classNo);
		
		var param = { classNo : classNo }
		
		var resultCallback = function(data) {
			ftakeExamChkResult(data);
		};
		callAjax("/mng/takeExamChk.do", "post", "json", true, param, resultCallback);
	}	
	
	/** 응시했는지 확인 CALLBACK */
	function ftakeExamChkResult(object) {
		
		var classNo = object.classNo;
		var isTake = object.isTake;
		
		if (isTake) {
			swal("이미 응시한 시험입니다.");
			return;
		} else {
			if (!confirm("시험을 응시하면 재응시가 불가능합니다.\n지금 응시하시겠습니까? 'ㅁ'?")) {
				return;
			} else {
				ftakeExam(classNo);
			}
		}
		
	}
	
	/** 시험 응시 */
	function ftakeExam(classNo) {
		$("#popupClassNo").val(classNo);
		var targetTitle = "new_win";
		var popupWidth = 600;
		var popupHeight = 680;
		
		var popupX = (screen.availWidth - popupWidth) / 2;
		
		if (window.screenLeft < 0) {
			popupX += window.screen.width * -1;
		} else if (window.screenLeft > window.screen.width) {
			popupX += window.screen.width;
		}
		
		var popupY= (screen.availHeight - popupHeight) / 2 - 10;
		
		var settings = "resizable=no,left=' + popupX + ',top=' + popupY +', width=' + popupWidth+ ',height=' + popupHeight +',menubar=no, status=no, toolbar=no, location=no, scrollbars=yes";
		
		var popupWindow = window.open("takeExamForm.do", "exam", "settings");
		
		popupWindow.addEventListener ("unload", function() {
			var finType = $("#finExamType").val();
			
			if (finType == "quit") {	
				alert("타냐?");
				var qType = $("#popupQtype").val();
				var qlistCnt = $("#popupQcnt").val();
				var answer = "";
				
				for (var i = 0; i < qlistCnt; i++) {
					answer += ",0";
				}
				
				answer = answer.substring(1);
				
				console.log("answer : " + answer + "\nqType : " + qType + "\nqlistCnt : " + qlistCnt);
				
				var qNo = "NO";
				
				var param = {
						classNo : classNo
					,	qlistCnt : qlistCnt
					,	qNo : qNo
					,	qType : qType
					,	answer : answer
				};
					
				var resultCallback = function(data) {
					quitPenaltyResult(data);
				};
				
				callAjax("/mng/submitExam.do", "post", "json", true, param, resultCallback);
				
			} 
			$("#finExamType").val(""); 
		});
		
	}
	
	/** 시험 종료 방식 'quit'일 시 필요한 임시 변수 설정 */
	function finExamType(type, qType, qCnt) {
		$("#finExamType").val(type);
		$("#popupQtype").val(qType);
		$("#popupQcnt").val(qCnt);
	}
	
	/** 시험 중도 종료 시 CALLBACK */
	function quitPenaltyResult(data) {
		var resultCnt = data.resultCnt;
		
		if (resultCnt > 0) {
			alert("시험을 중도에 중단하여 모두 오답 처리되었습니다.");
			var setFinExamType = "fin";
			$("#exit").val("");
			$("#popupQtype").val("");
			$("#popupQcnt").val("");
		} else {
			alert("알 수 없는 오류가 발생했습니다.\n다시 시도해 주세요. -ㅁ-;");
			return;
		}
	}
	
</script>

</head>
<body>
<form id="takeExamForm" action=""  method="">
	<input type="hidden" id="currentPageTexam" value="1">
	<input type="hidden" id="popupClassNo" value="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" id="finExamType" value="" />
	<input type="hidden" id="popupQtype" value="" />
	<input type="hidden" id="popupQcnt" value="" />
	
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">시험응시</span> <a href="../mng/exam.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<!-- 시험 목록 START -->
						<p class="conTitle">
							<span>시험 목록</span><span class="fr"></span>
						</p>
						            
						<div class="divTexamList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="7%">
									<col width="43%">
									<col width="*%">
									<col width="7%">
									<col width="7%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">강의번호</th>
										<th scope="col">과정명</th>
										<th scope="col">응시 가능 기간</th>
										<th scope="col">상태</th>
										<th scope="col">응시하기</th>
									</tr>
								</thead>
								<tbody id="listTexam"></tbody>
							</table>
						</div>
	
						<div class="paging_area" id="texamPagination"> </div>
						
						<table style="margin:15px 0 10px 0;" width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="collapse; border: 1px #50bcdf;">
		                   	<tr style="border:0px; border-color:blue;">
		                      	<td width="150" height="25" style="font-size:100%; text-align:right;">
		                      	<select id="sKey" name="sKey" style="width:80px; margin-right:10px;" v-model="sKey">
									<option value="key_all" >전체</option>
									<option value="key_pro" >진행중</option>
									<option value="key_end" >종료</option>
								</select> 
		                      	</td>
		               			<td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
		     	      			<input type="text" style="width: 300px; height: 25px;" id="texamname" name="texamname" placeholder="과정명을 입력하세요.">                    
				             	<a href="" class="btnType blue" id="btnSearchTexam" name="btn"><span>검  색</span></a>
		                        </td> 
		             		</tr>
		               	</table>

						<!-- 시험 목록 END -->
						
					
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