<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>나의 문의 내역</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	//1:1문의 페이징 설정
	var pageSizeQna = 5;
	var pageBlockSizeQna = 5;

	$(function(){
					
		//버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		//1:1 문의 리스트 
		fSelectQnAlist();
		
	});
	
	//버튼 이벤트 함수
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btninsertQnA':
					fPopupInsertQnA();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnQnaDeleteEnd':
					fDeleteQna();
					break;
			}
		});
	}
	
	//1:1 문의 리스트
	function fSelectQnAlist(currentPage){
		
		currentPage = currentPage || 1;
		var param = {	
				currentPage : currentPage
			,	pageSize : pageSizeQna
		}
		
		var resultCallback = function(data) {
			flistQnaResult(data, currentPage);
		};
		
		callAjax("/crt/selectQnAlist.do", "post", "text", true, param, resultCallback);
	}
		
	/** 그룹코드 조회 콜백 함수 */
	function flistQnaResult(data, currentPage) {
		
		
		// 기존 목록 삭제
		$('#qnalist').empty();
		
		// 신규 목록 생성
		$("#qnalist").append(data);
		
		// 총 개수 추출
		
		var totalCntqnalist = $("#totalCntqnalist").val();
		
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntqnalist, pageSizeQna, pageBlockSizeQna, 'fSelectQnAlist');
		$("#qnalistPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageQnaList").val(currentPage);
		
	}
	
	
	
	
	//1:1 문의 등록 팝업
	function fPopupInsertQnA(){
		gfModalPop("#layer1");
		$("#layer1").find("[name=updatePopBtn]").hide();
		$("#layer1").find("[name=answer]").hide();
		$("#layer1").find("#popQnaTitle").html("1:1문의등록");
		$("#layer1").css("height","500");
		$("#layer1").find("[name=insertBtnTr]").show();
		//등록 폼 초기화 
		fInitFormInsertQnA();
	}
	
		
	//1:1 문의 등록/수정버튼
	
	function fsaveQuestion(flag){
		if(flag == "I"){
			fInsertNewQuestion();
		}else if(flag =="U"){
			fUpdateQna();
		}else if(flag =="D"){
			gfModalPop("#layer2");
		}
		
	}
	
	//1:1 문의 등록
	function fInsertNewQuestion(){
		// vaildation 체크
		if ( ! fValidateNewQuestion() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fInsertNewQuestionResult(data);
		};
		
		param = {
				qna_title:$("#layer1").find("[name=qna_title]").val(),
				qna_content:$("#layer1").find("[name=qna_content]").val(),
				qna_category:$("#layer1").find("[name=qna_category]").val()
		};		
		
		callAjax("/crt/insertNewQuestion.do", "post", "json", true, param, resultCallback);
	}
	
	//1:1 문의 유효성
	function fValidateNewQuestion() {

		var chk = checkNotEmpty(
				[
						[ "qna_title", "제목을 입력해 주세요." ]
					,	[ "qna_content", "내용을 입력해 주세요" ]
					,	[ "qna_category", "카테고리를 선택해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	//1:1문의 콜백함수
	function fInsertNewQuestionResult(data){
		
		if (data.successMsg == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 목록 조회
			fSelectQnAlist();
			
		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
		
		// 입력폼 초기화
		fInitFormInsertQnA();
	}
	
	//입력폼 초기화 함수
	function fInitFormInsertQnA(){
		$("#layer1").find("[name=qna_title]").val("");
		$("#layer1").find("[name=qna_content]").val("");
		$("#layer1").find("[name=qna_category]").val("");
		$("#layer1").find("#qna_acontent").html("");
	}	
	
	//1:1문의 상세보기
	function fPopQnaDtl(qna_no){
		
		var resultCallback = function(data) {
			fPopQnaDtlResult(data);
		};
		
		param = {qna_no:qna_no};		
		
		callAjax("/crt/selectQnaOne.do", "post", "json", true, param, resultCallback);
		
	}
	
	//1:1문의상세보기 콜백함수
	function fPopQnaDtlResult(data){
		
		console.log(data);
		
		//폼 초기화
		fInitFormInsertQnA();
		
		//모달 실행
		gfModalPop("#layer1");
	
		$("#layer1").find("[name=updatePopBtn]").show();
		$("#layer1").find("[name=answer]").show();
		$("#layer1").find("#popQnaTitle").html("상세 내용");
		$("#layer1").find("[name=insertBtnTr]").hide();
		$("#layer1").css("height","800");

		//내용 넣기
		$("#layer1").find("[name=qna_no]").val(data["crtCsModel"]["qna_no"]);
		$("#layer1").find("[name=qna_title]").val(data["crtCsModel"]["qna_title"]);
		$("#layer1").find("[name=qna_content]").val(data["crtCsModel"]["qna_content"]);
		$("#layer1").find("[name=qna_category]").val(data["crtCsModel"]["qna_category"]);
		$("#layer1").find("#qna_acontent").html(data["crtCsModel"]["qna_acontent"]);

		
		if(data["crtCsModel"]["qna_astate"] != 0){
			$("#layer1").find("[name=qna_title]").attr("readonly",true);
			$("#layer1").find("[name=qna_content]").attr("readonly",true);
			$("#layer1").find("[name=qna_category]").attr("disabled","disabled");
			$("#updateBtn").removeAttr('onclick');
			$("#deleteBtn").removeAttr('onclick');
		}else{
			$("#layer1").find("[name=qna_title]").attr("readonly",false);
			$("#layer1").find("[name=qna_content]").attr("readonly",false);
			$("#layer1").find("[name=qna_category]").removeAttr("disabled");
			$("#updateBtn").attr('onclick',"fsaveQuestion('U');");
			$("#deleteBtn").attr('onclick',"fsaveQuestion('D');");
		}
			
	}
	
	
	//1:1문의 수정 함수
	function fUpdateQna(){
		
		if ( ! fValidateNewQuestion() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fUpdateQnaResult(data);
		};
		
		param = {
				qna_no:$("#layer1").find("[name=qna_no]").val(),
				qna_title:$("#layer1").find("[name=qna_title]").val(),
				qna_content:$("#layer1").find("[name=qna_content]").val(),
				qna_category:$("#layer1").find("[name=qna_category]").val()
		};		
		
		callAjax("/crt/updateQna.do", "post", "json", true, param, resultCallback);
		
	}
	
	//1:1문의 수정 콜백함수
	function fUpdateQnaResult(data){
		
		if (data.successMsg == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 목록 조회
			fSelectQnAlist();
			
		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
		
		// 입력폼 초기화
		fInitFormInsertQnA();
	}
	
	//1:1문의 삭제 함수
	function fDeleteQna(){
		
		var resultCallback = function(data) {
			fDeleteQnaResult(data);
		};
		
		param = {
				qna_no:$("#layer1").find("[name=qna_no]").val(),
		};		
		
		callAjax("/crt/deleteQna.do", "post", "json", true, param, resultCallback);
		
	}
	
	//1:1문의 삭제 콜백 함수
	function fDeleteQnaResult(data){
		
		if (data.successMsg == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 목록 조회
			fSelectQnAlist();
			
		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
		
		// 입력폼 초기화
		fInitFormInsertQnA();
	}
	
</script>


</head>
<body>
	<input type="hidden" id="currentPageQnaList" value="1"/>
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
					<div class="content">
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">문의</span> <span class="btn_nav bold">나의 문의 내역</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<div style="text-align: right; margin-bottom: 15px; margin-top: 15px;">
							<a href="" class="btnType blue" id="btninsertQnA" name="btn"><span>등록</span></a>
						</div>
						
						<div class="divprodcuctList">
						
							<table class="col">
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">카테고리</th>
										<th scope="col">제목</th>
										<th scope="col">문의일</th>
										<th scope="col">답변상태</th>
									</tr>
								</thead>
								
						<tbody id="qnalist"></tbody>
						</table>
						</div>
						<div class="paging_area"  id="qnalistPagination"> </div>
	
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong id="popQnaTitle"></strong>
			</dt>
			<dd class="content">

				<!-- s : 여기에 내용입력 -->

				<table class="row">
					<tbody>
						<tr>
							<td>
							<input type="hidden" id="qna_no" name="qna_no" value=""/>
							<input type="text" id="qna_title" name="qna_title" id="qna_title" placeholder="제목" style="width: 200px; height: 28px;"/>
							<select name="qna_category" id="qna_category">
								<option value="">카테고리</option>
								<option value="이용문의">이용문의</option>
								<option value="구매">구매</option>
								<option value="반품">반품</option>
								<option value="제품">제품</option>
								<option value="개인정보">개인정보</option>
								<option value="기타">기타</option>
							</select>
							</td>
						</tr>
						<tr>
							<td>
								<textarea cols="20" id="qna_content" id="qna_content" name="qna_content" style="resize:none; height: 300px;" placeholder="문의내용"></textarea>
							</td>
						</tr>
						<tr name="updatePopBtn">
							<td style="text-align: right;">
								<a onclick="fsaveQuestion('U');" class="btnType blue" id="updateBtn" name="btn"><span>수정</span></a>
								<a onclick="fsaveQuestion('D');" class="btnType blue" id="deleteBtn" name="btn"><span>삭제</span></a>
							</td>
						</tr>
						<tr name="answer">
							<td>
								<textarea id="qna_acontent" cols="20" style="resize:none; height: 300px;" readonly="readonly"></textarea>
							</td>
						</tr>
						<tr name="insertBtnTr">
							<td style="text-align: right;">
								<a onclick="fsaveQuestion('I');" href="" class="btnType blue"  name="btn"><span>저장</span></a>
							</td>
						</tr>
					</tbody>
				</table>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		
		<div id="layer2" class="layerPop layerType2" style="width: 300px; height: 110px;">
		<dl>
			<dd class="content">
					<div style="text-align: center; font-size: 17px">삭제하시겠습니까?</div>
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnQnaDeleteEnd" name="btn"><span>확인</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	
	
					</div> <!--// content -->
  				
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>