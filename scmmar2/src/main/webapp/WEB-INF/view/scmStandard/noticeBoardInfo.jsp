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
<title>Job Korea :: 공지사항</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

// 공지사항 페이징 설정
var pageSizeNtcCod = 5;
var pageBlockSizeNoticeCod = 5;

/** OnLoad event */ 
$(function() {
	
	// 공지사항 목록 조회
	fListNoticeCod();
	
	// 버튼 이벤트 등록
	fRegisterButtonClickEvent();
});


// 버튼 이벤트 함수
function fRegisterButtonClickEvent() {
	$('a[name=btn]').click(function(e) {
		e.preventDefault();

		var btnId = $(this).attr('id');

		switch (btnId) {
			case 'insertNotcieCod' :
				fSaveNoticeCod();
				break;
			case 'deleteNoticeCod' :
				fDeleteNoticeCod();
				break;
			case 'btnSearchNTCcod':
				notice_search();
				break;
			case 'closeCod' :
				popup_close();
				break;
		}
	});
}

// 팝업 취소 버튼
function popup_close(currentPage) {
	
	currentPage = currentPage || 1;
	
	gfCloseModal();
	
	fListNoticeCod(currentPage);
}

// 공지사항 검색
function notice_search(currentPage) {
	
	currentPage = currentPage || 1;
	
	var searchword = $('#searchword').val();
	var searchKey = $('#searchKey').val();
	var timeline1 = $('#timeline1').val();
	var timeline2 = $('#timeline2').val();
	
	var param = {
				searchword : searchword
			,	searchKey : searchKey
			,	timeline1 : timeline1
			,	timeline2 : timeline2
			,	currentPage : currentPage
			,	pageSize : pageSizeNtcCod
	}
	
	var resultCallback = function(data) {
		fListNoticeCodResult(data, currentPage); 
    };
    
    callAjax("/scmStandard/noticeBoardlist.do", "post", "text", true, param, resultCallback);
}

// 공지사항 목록 조회
function fListNoticeCod(currentPage) {
	
	currentPage = currentPage || 1;
	
	var searchword = $('#searchword').val();
	var searchKey = $('#searchKey').val();
	
	var param = {
				searchword : searchword
			,	searchKey : searchKey
			,	currentPage : currentPage
			,	pageSize : pageSizeNtcCod
	}
	
	var resultCallback = function(data) {
		fListNoticeCodResult(data, currentPage);
	};
	
	//Ajax실행 방식
	//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
	callAjax("/scmStandard/noticeBoardlist.do", "post", "text", true, param, resultCallback);
}

// 공지사항 목록 조회 콜백
function fListNoticeCodResult(data, currentPage) {
	
	// 기존 목록 삭제
	$('#noticeBoardlist').empty();
	
	// 신규 목록 생성
	$("#noticeBoardlist").append(data);
	
	// 총 개수 추출
	var totalNoticeCod = $("#totalNoticeCod").val();
	
	// 페이지 네비게이션 생성
	var paginationHtml = getPaginationHtml(currentPage, totalNoticeCod, pageSizeNtcCod, pageBlockSizeNoticeCod, 'fListNoticeCod');

	$("#productCodPagination").empty().append( paginationHtml );
	
	// 현재 페이지 설정
	$("#currentPageNTCCod").val(currentPage);
}

// 공지사항 단건 조회
function fListNoticeDtCod(ntc_no) {
	
	var param = { 
			ntc_no : ntc_no
	};
	
	var resultCallback = function(data) {
		fListNoticeDtCodResult(data);
	};
	
	callAjax("/scmStandard/selectNoticeCod.do", "post", "json", true, param, resultCallback);
}

// 공지사항 단건 조회 콜백 함수
function fListNoticeDtCodResult(data) {
	
	if (data.result == "SUCCESS") {

		gfModalPop("#layer1");
		
		// 폼 데이터 설정
		fInitFormNTCCod(data.noticeBoardModel);
		
	} else {
		swal(data.resultMsg);
	}	
}

// 공지사항 초기화 및 데이터 뿌리기
function fInitFormNTCCod(object) {
	
	//var session = ${sessionScope.loginId};
	// 이 코드 쌍팔년도라고 하셨음
	// 보안상 컨트롤러에서 넘겨 주는 걸 추천
	var userId = '<%=(String)session.getAttribute("loginId")%>';
	var userTy = '<%=(String)session.getAttribute("userType")%>';
	var userNm = '<%=(String)session.getAttribute("userNm")%>';
	
	var regdate = new Date().toISOString().substr(0, 10).replace('T', '');
	
	$('input[name=loginID]').attr('value', userId);
	
	if (object == "" || object == null || object == undefined) {
		
		$("#deleteNoticeCod").hide();
		$("#filedowndiv").hide();
		
	 	$('form').each(function() {
			this.reset();
		});
	 	
	 	if (userTy == 'A') {
	 		$('input[name=name]').attr('value', userNm);
	 		$('input[name=ntc_regdate]').attr('value', regdate);
	 	}
		
	} else {

		$("#deleteNoticeCod").show();
		
		$("#filedowndiv").show();
		
		$('input[name=ntc_no]').attr('value', object.ntc_no);
		$('input[name=ntc_title]').attr('value', object.ntc_title);
		$('input[name=name]').attr('value', userNm);
		$('input[name=ntc_regdate]').attr('value', object.ntc_regdate);
		$('input[name=ntc_readcnt]').attr('value', object.ntc_readcnt);
		$('textarea#ntc_content').val(object.ntc_content);
		$('input[name=action]').attr('value', "U");
		
		if(object != "NOT") {			          
			$("#filedown").empty().append("<a href='javascript:filedown("+ object.ntc_no + ")'>" + object.file_ofname + "</a>");				                                 
		}
	}
}

// 첨부파일 다운로드
function filedown(ntc_no){
 	 	var params = "";
		params += "<input type='hidden' name='ntc_no' value='"+ ntc_no +"' />"; 	
		jQuery("<form action='/scmStandard/fileDown.do' method='post'>"+params+"</form>").appendTo('body').submit().remove(); 			
}

//공지사항 신규 등록 모달 또는 수정 모달
function fPopModalNoticeCod(ntc_no) {
	
	ntc_no = ntc_no || $("#ntc_no").val();
	
	// 신규
	if (ntc_no == null || ntc_no == "") {
		$("#action").val("I");
		
		// 초기화
		fInitFormNTCCod();
		
		gfModalPop("#layer1");
		
	// 수정
	} else {
		$("#action").val("U");
		
		// 공지사항 단건 조회
		fListNoticeDtCod(ntc_no);
	}
}

// 공지사항 신규 등록
function fSaveNoticeCod() {

	// validation check
	if (!fValidateNTCCod()) {
		return;
	}
	
	var resultCallback = function(data) {
		fSaveNoticeResult(data);
	};
	
	if ($("#action").val() == "I") {
		$("#action").val("I"); // insert
	} else if ($("#action").val() == "U") {
		$("#action").val("U"); // update
	}
	var frm = document.getElementById("myForm");
	var dataWithFile = new FormData(frm);	
	
	callAjaxFileUploadSetFormData("/scmStandard/saveNoticeCod.do", "post", "json", true, dataWithFile, resultCallback);
}

// 공지사항 신규 등록 콜백 함수
function fSaveNoticeResult(data) {
	
	// 목록 조회 페이지 번호
	var currentPage = "1";
	
	if ($("#action").val() != "I") {
		currentPage = $("#currentPageNTCCod").val();
	}
	
	if (data.result == "SUCCESS") {
		// 응답 메시지 출력
		swal(data.resultMsg);
		alert("저장 되었습니다.");
		
	} else {
		// 오류 응답 메시지 출력
		swal(data.resultMsg);
	}
	
	// 모달 닫기
	gfCloseModal();
	
	// 목록 조회
	fListNoticeCod(currentPage);
	
	// 폼 초기화
	fInitFormNTCCod();
}

//validation check
function fValidateNTCCod() {
	
	var chk = checkNotEmpty(
			[
				[ "ntc_title", "제목을 입력해 주세요." ]
			,	[ "ntc_content", "내용을 입력해 주세요" ]
			]
	);
	
	if (!chk) {
		return;
	}

	return true;
}

// 공지사항 삭제
function fDeleteNoticeCod() {
	
	swal("정말 삭제하겠습니까? \n삭제 시 복구가 불가능합니다.", {
		  buttons:{
			  yes : "예",
			  no : "아니오"
		  }
		}).then((value) => {  /* 이건 이클립스가 게을러서 뜨는 에러!  */
			switch(value){
			case "yes":
				
				var resultCallback = function(data) {
				fDeleteNoticeCodResult(data);
				};
			
				callAjax("/scmStandard/deleteNoticeCod.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
			
				break;
			case "no": 
				break;
			}
		});
}

// 공지사항 삭제 콜백
function fDeleteNoticeCodResult(data) {
	
	var currentPage = $("#currentPageNTCCod").val();
	
	if (data.result == "SUCCESS") {
		
		// 응답 메시지 출력
		swal(data.resultMsg);
		
		// 모달 닫기
		gfCloseModal();
		
		// 공지사항 목록 조회
		fListNoticeCod(currentPage);
		
	} else {
		swal(data.resultMsg);
	}	
	
}

</script>

</head>
<body>
<form id="myForm" action=""  method="" enctype="multipart/form-data">
	<input type="hidden" id="currentPageNTCCod" value="1">
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">공지사항</span> <span class="btn_nav bold">공지사항</span>
							<a href="../scmStandard/noticeMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>공지사항</span> <span class="fr"> 
							<a class="btnType blue" href="javascript:fPopModalNoticeCod();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
						
					<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1" align="left">
						<tr style="border: 0px; border-color: blue">
							<td width="50" height="25" style="font-size: 100%; text-align: left; padding: 20px 120px;">
							<select id="searchKey" name="searchKey" style="width: 90px;">
								<option value="all_ntc" >전체</option>
								<option value="title" >제목</option>
								<option value="writer" >작성자</option>
							</select> 
							<input type="text" style="width: 300px; height: 28px;" id="searchword" name="searchword">                    
							<input type="date" id="timeline1" name="timeline1" style="line-height: 26px;"/><span>-</span>
							<input type="date" id="timeline2" name="timeline2" style="line-height: 26px;"/>
							<a href="" class="btnType blue" id="btnSearchNTCcod" name="btn"><span>검  색</span></a>
						  </td>
						</tr>
                     </table>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="14%">
									<col width="27%">
									<col width="20%">
									<col width="15%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">글 번호</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">조회수</th>
										<th scope="col">작성일</th>
									</tr>
								</thead>
								<tbody id="noticeBoardlist"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="productCodPagination"> </div>
                     
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div> <!-- wrap_area -->
	
	<div id="modalDiv"> <!-- 모달 시작 -->
		<div id="layer1" class="layerPop layerType2" style="width: 800px;">
			<jsp:include page="/WEB-INF/view/scmStandard/noticeBoardPopUp.jsp"></jsp:include>
	  	</div>
	</div>
	
	
</form>
</body>
</html>