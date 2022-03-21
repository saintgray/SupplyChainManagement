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
<title>취업정보 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	// 취업 정보 목록 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	/** OnLoad event */ 
	$(function() {
		
		// 강의실 목록 조회
		fListCareerInfo();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		//이게 먼 코드일까용.
		$('a[name=btn]').click(function(e) {
			//e.preventDefault():이벤트를 취소 시킴?, 이벤트에 대한 기본동작을 실행하지 않도록 함?
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
			case 'btnSearch':
				  fListCareerInfo();
				  break;
			case 'btnInitSearch':
				  fInitSearch();
				  break;
			case 'btnCloseModal':
				  gfCloseModal();
				  break;
				  
			}
		});
	}	
	
	/* 검색 조건 초기화 */	
	function fInitSearch() {
		$("#searchKey").val("career_corp");
		$("#sname").val("");
		$("#cal1").val("");
		$("#cal2").val("");
		fListCareerInfo();
	}
	
	/**취업정보 목록 조회**/
	function fListCareerInfo(currentPage) {
		//매개변수로 넘어오는 currentPage(현재페이지)가 없으면 1이된다.
		currentPage = currentPage || 1;
		
		//아이디로 값 가져오고(검색)
		var sname = $('#sname').val();
		var searchKey = $('#searchKey').val();
		var cal1 = $('#cal1').val();
		var cal2 = $('#cal2').val();
	
		console.log("currentPage : " + currentPage);
		console.log("sname : " + sname);
		console.log("searchKey : " + searchKey);
		console.log("cal1 : " + cal1);
		console.log("cal2 : " + cal2);
		
		//param에 값들 저장(나중에 컨트롤러에 보냄)
		var param = {
			sname : sname,
			oname : searchKey,
			currentPage : currentPage,		//현재페이지
			cal1 : cal1,
			cal2 : cal2,
			pageSize : pageSize			//페이지 크기
		}
		
		//변수를 하나 만들어서 함수를 저장만 해뒀다.(함수 실행은 밑에있는 callAjax에서!!)
		//data는 컨트롤러의 리턴값이다.??
		var resultCallback = function(data) {
			fListCareerInfoResult(data, currentPage);
		};
		
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//cmg/lectureroomList.do
		callAjax("/jmg/listCareerInfo.do", "post", "text", true, param, resultCallback); //resultCallback에 저장되있는 함수가 실행된다.
	}
	
	/** 취업정보 조회 콜백 함수 */
	function fListCareerInfoResult(data, currentPage) {
	
		//swal(data);
		console.log(data);
	
		// 기존 목록 삭제
		$('#careerInfoList').empty();
	
		// 신규 목록 생성 
		$("#careerInfoList").append(data);
	
		// 총 개수 추출
		var totalCnt = $("#listCount").val();
	
		//swal(totalCnt);
	
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCnt,
				pageSize, pageBlockSize, 'fListCareerInfo');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#pagingnavi").empty().append(paginationHtml);
	
		// 현재 페이지 설정
		$("#currentPageCareer").val(currentPage);
	}
	
	/** 개인 취업정보 이력 조회 **/
	function flistHistory(uid) {

		var param = { uid : uid };
		
		var resultCallback = function(data) {
			flistHistoryResult(data);
		};
		
		callAjax("/jmg/careerDetail.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 개인 취업정보 이력 조회 콜백 */
	function flistHistoryResult(data) {
		
		if (data.result == "SUCCESS") {
			var uName = data.uName;			
			var outData = data.outData;

			// 모달 팝업
			gfModalPop("#layer2");
			
			// 개인 취업정보 이력 조회 데이터 설정
			$("#uName").empty().append(uName);
			$("#outData").empty().append(outData);
			
		} else {
			swal(data.resultMsg);
		}	
	}


</script>
</head>
<body>
<form id="myForm" action=""  method="">
<!--input type="hidden" : 사용자에게는 보이지 않는 숨겨진 입력 필드, 업데이트 되어야 하는 데이터베이스의 레코드를 저장하거나, 고유한 보안 토큰 등을 서버로 보낼 때 주로 사용  -->
	<!--얘네 왜있는거냐아아아..-->
	<input type="hidden" id="currentPageCareer" value="1">
<!-- 	<input type="hidden" id="tmpCmgCod" value="">
	<input type="hidden" id="roomNo" name="roomno" value=""> -->
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
								<span class="btn_nav bold">취업관리</span> 
								<span class="btn_nav bold">취업정보</span> 
								<a href="../jmg/careerInfo.do" class="btn_set refresh">새로고침</a>
							</p>
							
							<p class="conTitle">
							<span>취업정보</span> <span class="fr"> 
							</span>
						</p>


						<!--검색창 부분  -->
							<div class="divCareerInfoList">
								<table style="margin-top:10px; margin-bottom:20px;" width="100%" cellpadding="5"
									cellspacing="0" border="1" align="left"
									style="collapse; border: 1px #50bcdf;">
									<tr style="border: 0px; border-color: blue">
										<td width="40" height="25" style="font-size: 120%;">&nbsp;</td>
										<td width="*" height="25" style="font-size: 100%; text-align: center;">
											<select id="searchKey" name="searchKey" style="width: 80px;" v-model="searchKey">
												<option value="career_corp">회사명</option>
												<option value="career_name">학생명</option>
											</select>
											<input type="text" style="width: 150px; height: 25px;" id="sname" name="sname"> &nbsp;&nbsp;&nbsp;
											<input type="date" id="cal1" name="cal1" /> ~ <input type="date" id="cal2" name="cal2" /> &nbsp;
											<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검색</span></a>&nbsp;
											<a href="" class="btnType blue" id="btnInitSearch" name="btn"><span>초기화</span></a></td>
										<td width="40" height="25" style="font-size: 120%;">&nbsp;</td>
									</tr>
								</table>

								<!-------------------취업정보 목록창----------------------->
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="7%">
										<col width="*%">
										<col width="15%">
										<col width="15%">
										<col width="25%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">학생명</th>
											<th scope="col">입사일</th>
											<th scope="col">퇴사일</th>
											<th scope="col">업체명</th>
											<th scope="col">재직여부</th>
										</tr>
									</thead>
									<tbody id="careerInfoList"></tbody>
								</table>
							</div>

							<!--페이지 번호  -->
						<div class="paging_area"  id="pagingnavi"> </div>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 경력 정보 모달창 화면 -->
	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>경력 정보</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="150px">
						<col width="150px">
						<col width="150px">
						<col width="150px">
					</colgroup>

						<tbody>
							<tr>
								<th scope="row">이름</th>
								<td colspan="3"><span id="uName"></span></td>
							</tr>
							<tr>
								<th scope="row" colspan="2">업체명 </th>
								<th scope="row" colspan="2">근무 기간</th>
							</tr>
						</tbody>
							<tbody id="outData"></tbody>
							
					</table>
					

				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="btnCloseModal" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</form>
</body>
</html>