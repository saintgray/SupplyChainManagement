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
<title>Job Korea :: 시험 대상자 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<style>
#wrapTest { width:720px; padding:10px; margin:auto; border-style:solid; border-width:1px; background-color:white; text-align:center; }
.takeExamInfo { width:700px; margin-left:auto; margin-right:auto; }
.takeExamInfo tr, .takeExamList tr { height:30px; }
.takeExamInfo th { background-color:#efefef; border-style:solid; border-color:black; border-width:1px; text-align:center; text-align:center; font-weight:bold; }
.takeExamInfo td { border-style:solid; border-color:black; border-width:1px; text-align:center; }

.takeExamList { width:700px; margin-left:auto; margin-right:auto; margin-top:20px; }
.takeExamList th { background-color:rgb(214,239,252); border-style:solid; border-color:black; border-width:1px; text-align:center; text-align:center; font-weight:bold; }
.takeExamList td { border-style:solid; border-color:black; border-width:1px; text-align:left; padding-left:10px; } */

</style>
<script type="text/javascript">	
	
	/** OnLoad event */
	$(function() {
		// 부모창의 classNo 가져오기
		$("#classNo").val(opener.document.getElementById("popupClassNo").value);
		
		var classNo = $("#classNo").val();
		var userNm = $("#userNm").val();
		
		if(!confirm("[시험 안내]\n1. A, B, C 유형이 무작위로 결정됩니다.\n2. 응시 시간은 문항 1개당 1분으로 적용됩니다.\n3. 시험을 중도에 종료할 시 모두 오답으로 처리됩니다.(절대 창을 임의로 끄거나 새로고침을 하지 마세요!)\n\n본 수험생 " + userNm + "은(는) 안내문을 정독했고 이에 동의합니다.")) {
			window.close();
		} 
		
		// 해당 문제의 문제 유형 및 정보들 뽑아 오기
		initQuestion(classNo);
		
		$(document).keydown(function(e) {
			if (e.which === 116) {
				if (typeof event == "object") {
					event.keyCode = 0;
				}
				return false;
			} else if (e.which === 82 && e.ctrlKey) {
				return false;
			}
		});
		
		window.addEventListener('beforeunload', function(event) {
			var exit = $("#exit").val();
			
			if (exit == 1 || exit == "1") {
				var qtype = $("#qType").val();
				var qlistCnt = $("#qlistCnt").val();
				opener.finExamType("quit", qtype, qlistCnt);
			}
		});
		
	});
	
	/** 응시 시작 후 문제 유형 및 정보들 뽑아 오기 */
	function initQuestion(classNo) {
		console.log("classNo : " + classNo);
		
		var param = { classNo : classNo }
		
		var resultCallback = function(data) {
			initQuestionResult(data);
		};
		callAjax("/mng/initQuestionInfo.do", "post", "json", true, param, resultCallback);
	}	
	
	/** 응시 시작 후 문제 유형 및 정보들 뽑아 오기 */
	function initQuestionResult(object) {
		
		var classNo = object.classNo;
		var examType = object.examType;
		var userName = object.userName;
		var className = object.className;
		var questionCnt = object.questionCnt
		
		$(document).find("title").text("Job Korea :: " + className + " 시험")
		
		$("#tClassNo").empty().append(classNo);
		$("#tClassNm").empty().append(className);
		$("#tQType").empty().append(examType + "형");
		$("#tUserName").empty().append(userName);
		
		$("#qType").val(examType);
		
		// 시험 문항 출력
		callQuestionList(classNo, examType);
			
	}
	
	/** 시험 문항 출력 */
	function callQuestionList(classNo, examType) {
		
		console.log("classNo : " + classNo);
		console.log("examType : " + examType);
		
		var param = {	
					classNo : classNo
				,	examType : examType
		}
		
		var resultCallback = function(data) {
			callQuestionListResult(data);
		};
		callAjax("/mng/callQuestionList.do", "post", "text", true, param, resultCallback);
	}	
	
	/** 시험 문항 출력 CALLBACK */
	function callQuestionListResult(data, currentPage) {
		$("#qlistOut").empty();			// 기존 시험 목록 삭제
		$("#qlistOut").append(data);	// 시험 목록 출력
		
		// 문항 총 개수 출력
		var qlistCnt = $("#qlistCnt").val();
		setTimer(qlistCnt);
	}
	
	/** 타이머 설정 */
	function setTimer(qlistCnt) {
		var time = parseInt(60 * qlistCnt);	// 초기 시간
		var min = "";
		var sec = "";
				
		var x = setInterval(function() {
			min = parseInt(time / 60);
			sec = time % 60;
			
			document.getElementById("timer").innerHTML = "<strong>" + min + "분 " + sec + "초</strong>";
			time--;
			
			if (time < 60) {
				document.getElementById("timer").innerHTML = "<span class='font_red'><strong>" + sec + "초</strong></span>";
			}
			
			if (time < 0) {
				clearInterval(x);
				document.getElementById("timer").innerHTML = "<span class='font_red'><strong>시간 초과</strong></span>";
				swal("시험이 종료되었습니다.");
				finishExam(qlistCnt);
			}
		}, 1000);
	}
	
	/** 답안 제출 */
	function submitExam() {
		var qlistCnt = parseInt($("#qlistCnt").val());
		
		// 문항 라디오 박스 유효성 검사
		for (i = 1; i < qlistCnt + 1; i++) {
			if (!$("input:radio[name='Q" + i + "']").is(":checked")) {
				swal(i + "번 문항을 풀지 않았습니다.");
				$("input:radio[name='Q" + i + "']:eq(0)").focus();
				return;
			}
		}
		
		if(!confirm("제출하시겠습니까? 제출하면 다시 응시할 수 없습니다.")) {
			return;
		} 
		
		finishExam(qlistCnt);
		
	}
	
	/** 답안 DB 전달 */
	function finishExam(qlistCnt) {
		qlistCnt = parseInt(qlistCnt);
		
		var testAnswer = "";
		var testQno = "";
		
		for (i = 1; i < qlistCnt + 1; i++) {
			var answer = $("input:radio[name='Q" + i + "']:checked").val();
			
			if (answer == null || answer == "" || answer == undefined) {	// 시간 초과로 답안 작성을 하지 못한 경우
				answer = 0;	// DB에 0을 INSERT하여 오답 처리
			}
			
			testAnswer += "," + answer;
			testQno += "," + $("#qNo" + i).val();
			
		}
		
		testAnswer = testAnswer.substring(1);
		testQno = testQno.substring(1)
		
		var testClassNo = $("#classNo").val();
		var testQtype = $("#qType").val();
		
		// swal("testClassNo : " + testClassNo + "\ntestQtype : " + testQtype + "\ntestQno : " + testQno + "\ntestAnswer : " + testAnswer);
		
		var param = {
				classNo : testClassNo
			,	qlistCnt : qlistCnt
			,	qNo : testQno
			,	qType : testQtype
			,	answer : testAnswer
		};
			
		var resultCallback = function(data) {
			finishExamResult(data);
		};
		
		callAjax("/mng/submitExam.do", "post", "json", true, param, resultCallback);
		
	}

	/** 답안 DB 전달 CALLBACK */
	function finishExamResult(data) {
		var resultCnt = data.resultCnt;
		var score = data.score;
		var resultMsg = "통과";
		if (score < 60) {
			resultMsg = "과락";
		}
		
		if (resultCnt > 0) {
			alert("답안 제출이 완료되었습니다.\n수고하셨습니다. (__)\n\n점수 : " + score + "\n결과 : " + resultMsg);
			var setFinExamType = "fin";
			$("#exit").val("2");
			opener.finExamType(setFinExamType, "", "");
			window.close();
		} else {
			alert("알 수 없는 오류가 발생했습니다.\n다시 시도해 주세요. -ㅁ-;");
			return;
		}
	}
	
</script>

</head>
<body>
<form id="testExamForm" action=""  method="">
	<input type="hidden" id="classNo" value="" />
	<input type="hidden" id="qType" value="" />
	<input type="hidden" id="userNm" value="${userNm}" />
	<input type="hidden" id="exit" value="1" />
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrapTest">
	<table class="takeExamInfo"> 
	<caption>caption</caption>
	<tr>
		<th scope="col" width="9%" >강의번호</th>
		<td width="6%"><span id="tClassNo"></span></dh>
		<th scope="col" width="9%" >과정명</th>
		<td colspan="3" width="*"><span id="tClassNm"></span></td>
	</tr>
	<tr>
		<th scope="col" width="9%" >문제 유형</th>
		<td width="6%"><span id="tQType"></span></td>
		<th scope="col" width="9%" >학생명</th>
		<td width="*"><span id="tUserName"></span></td>
		<th scope="col" width="9%" >남은 시간</th>
		<td width="20%"><div id=timer></div></td>
	</tr>
	</table>
	<table class="takeExamList"> 
	<caption>caption</caption>
		<tbody id="qlistOut"></tbody>
	</table>	
	</div>

</form>
</body>
</html>