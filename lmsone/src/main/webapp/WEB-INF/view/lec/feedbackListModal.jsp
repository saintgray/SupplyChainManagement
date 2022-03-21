<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
    
<style>
*:disabled {
	background: #FFD9EC;
}
}
</style>

<script type="text/javascript">

// 페이징 설정
var pageSize = 5;
var pageBlockSize = 5;

console.log("세션 아이디: " +'${loginId}');
console.log("세션 유저타입: " +'${userType}');
console.log("세션 유저이름: " +'${userNm}');

var s_loginID ='${loginId}';
var s_userType = '${userType}';
var s_userNm = '${userNm}'

/** OnLoad event */ 
$(function() {
	console.log("location: " + location.href);
	
	$("#search_startdate").datepicker();
	$("#search_enddate").datepicker();
	$("#start_enddate").datepicker();
	
	feedbackList();
});

/* 상세모달 실행 */
function feedbackModal() {
	gfModalPop("#feedbackModal");
}

/* 모달창 취소 버튼 */
function fcancleModal() {
	gfCloseModal();
}

/* 프로젝트 목록 조회 */
function feedbackList(currentPage) {
		
	currentPage = currentPage || 1;

	var sname = $("#sname").val();
	var oname = $("#searchkey").val();
	var search_startdate = $("#search_startdate").val();
	var search_enddate = $("#search_enddate").val();
	
	if (search_enddate == null || search_enddate == '' || search_enddate == undefined){
		search_enddate = '2099-12-31';
	};
	
	var param = {
		currentPage : currentPage,
		pageSize : pageSize,
		sname : sname,
		oname : oname,
		search_startdate : search_startdate,
		search_enddate : search_enddate
	};

	var resultCallback = function(data) {
		listAppend(data, currentPage);
	};

	callAjax("/lec/feedbackList.do", "post", "text", true, param,
			resultCallback);
}

/* 리스트 붙이기 */
function listAppend(data, currentPage) {
	
	$('#feedbackList').empty();
	$("#feedbackList").append(data);

	var listCount = $("#listCount").val();

	// 페이지 네비게이션 생성
	var paginationHtml = getPaginationHtml(currentPage, listCount, pageSize, pageBlockSize, "feedbackList");
	$("#pagingnavi").empty().append( paginationHtml );
}

/* 모달창 데이터 주입 */
function feedbackFormInit(data){
	
		$("#FBinsbtn").hide();
		$("#FBdelbtn").show();
		
		$('#feedbackModal *').attr("disabled", true);
		
		$("#class_no").val(data.surveyInfo.class_no);
		$("#class_nm").val(data.surveyInfo.class_nm);
		$("#class_startdate").val(data.surveyInfo.class_startdate);
		$("#class_enddate").val(data.surveyInfo.class_enddate);
		$("#t_name").val(data.surveyInfo.t_name);
		$("#s_name").val(data.surveyInfo.s_name);
		$("#room_nm").val(data.surveyInfo.room_nm);
		$("#appraisal_content").val(data.surveyInfo.appraisal_content);
		
		$('input[name="appraisal_score"]:radio[value="'+ data.surveyInfo.appraisal_score + '"]').prop('checked', true);
		
}

/* 상세 모달 */
function FBModal_popup(appraisal_no) {

	FBselectDetail(appraisal_no);
	
	gfModalPop("#feedbackModal");

}

/* 단건 조회 */
function FBselectDetail(appraisal_no) {
	
	var param = {
		appraisal_no : appraisal_no
	}
	
	
	var FBselectDetailCallback = function(data) {

		FBselectinfo(data);
	}

	callAjax("/lec/FBselectDetail.do", "post", "json", true, param,
			FBselectDetailCallback);
}

/* 단건 조회 콜백 */
function FBselectinfo(data) {

	console.log("FBselectinfo : " + JSON.stringify(data));
	
	
	if (data.result == "SUCCESS") {
		feedbackFormInit(data);
			// 조회 후 모달의 hidden 값으로 no를 넣어줌.
		$('#appraisal_no').val(data.surveyInfo.appraisal_no);
	} else {
		alert("조회 실패")
	}
}
	
function FBdelete(){
	
	if(confirm("정말 삭제하시겠습니까?") == true){
	
		var no = $("#appraisal_no").val();
		
		var param = {
			appraisal_no : no	
		}
		
		var FBdeleteCallback = function(data) {
			
			FBdelOK(data);
		}
		
		callAjax("/lec/FBdelete.do", "post", "json", true, param,
				FBdeleteCallback);
	}
}

function FBdelOK(data){
	
	if (data.result == "SUCCESS") {
		swal("삭제 성공");			
	} else {
		alert("삭제 실패")
	}
	
	
	fcancleModal()
	feedbackList();
}

	
</script>

<!-- 모달팝업 -->
<div id="feedbackModal" class="layerPosition layerPop layerType2" style="width: 800px; padding: 15px">
    <form id="RegisterFBForm" action="" method="post">
        <input type="hidden" name="action" id="action" value="">
        <input type="hidden" id="c_loginID" name="c_loginID" value="${sessionScope.loginId}" /> 
        <input type="hidden" id="appraisal_no" name="appraisal_no" value="" /> 
       
		<br>
        <h1 style="font-size:120%">강의 평가 상세</h1>
		<br>
		
		<table style="background-color: #F3F3F3; width: 600px; display : ;" id="tb_selectFB">

			<tr>
				<th style="padding-top: 1em; width:10%;">강의번호</th>
				<td style="padding-top: 1em;"><input type="text" name="class_no" id="class_no" size="70px" /></td>
			</tr>
			
			<tr>
				<th style="padding-top: 1em; width:10%;">강의명</th>
				<td style="padding-top: 1em;"><input type="text" name="class_nm" id="class_nm" size="70px" /></td>
			</tr>
			
			<tr>
				<th style="padding-top: 1em; width:10%;">강사명</th>
				<td style="padding-top: 1em;"><input type="text" name="t_name" id="t_name" size="70px" /></td>
			</tr>
			
			<tr>
				<th style="padding-top: 1em; width:10%;">강의시작일</th>
				<td style="padding-top: 1em;"><input type="text" name="class_startdate" id="class_startdate" size="70px" /></td>
			</tr>
			
			<tr>
				<th style="padding-top: 1em; width:10%;">강의종료일</th>
				<td style="padding-top: 1em;"><input type="text" name="class_enddate" id="class_enddate" size="70px" /></td>
			</tr>
			
			<tr>
				<th style="padding-top: 1em; width:10%;">강의실</th>
				<td style="padding-top: 1em;"><input type="text" name="room_nm" id="room_nm" size="70px" /></td>
			</tr>
			
			<tr>
				<th style="padding-top: 1em; width:10%;">학생명</th>
				<td style="padding-top: 1em;"><input type="text" name="s_name" id="s_name" size="70px" /></td>
			</tr>
		</table>

        <table style="background-color: #F3F3F3; width: 600px;" id="score_radio">
        	<tr>
        		<th style="padding-top: 1em; width:10%;">점수</th>
        		<td style="padding-top: 1em;">
        			<input type="radio" id="appraisal_score" name="appraisal_score" value="1">1점
        			<input type="radio" id="appraisal_score" name="appraisal_score" value="2">2점
        			<input type="radio" id="appraisal_score" name="appraisal_score" value="3">3점
        			<input type="radio" id="appraisal_score" name="appraisal_score" value="4">4점
        			<input type="radio" id="appraisal_score" name="appraisal_score" value="5">5점
        		</td>
        	</tr>
        </table>
        
        <table style="background-color: #F3F3F3; width: 600px;" id="tb_content">
        	<tr>
        		<th style="padding-top: 1em; width:10%;">평가내용</th>
        		<td style="padding-top: 1em;">
        			<textarea rows="20" cols="20" name="appraisal_content" id="appraisal_content"></textarea>
        		</td>
        	</tr>
        </table>
        
        <div class="btn_areaC mt30">
			<a href="javascript:FBinsert();" class="btnType blue" id="FBinsbtn"> <span>등록</span></a>
			<a href="javascript:FBdelete();" class="btnType blue" id="FBdelbtn"> <span>삭제</span></a>
			<a href="javascript:fcancleModal()" class="btnType gray" id="btnCloseLsmCod"><span>닫기</span></a>
		</div>
    </form>
</div>