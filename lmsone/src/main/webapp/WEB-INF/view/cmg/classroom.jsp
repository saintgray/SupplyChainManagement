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
<title>강의실 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	// 강의실 목록 페이징 설정
	var pageSizeClassroom = 5;
	var pageBlockSizeClassroom = 5;
	
	// 장비코드 목록 페이징 설정
	var pageSizeEquipment = 5;
	var pageBlockSizeEquipment = 10;

	
	/** OnLoad event */ 
	$(function() {
		
		// 강의실 목록 조회
		fListClassroom();
		
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
			case 'btnSearchClassroom':	//검색 버튼 
				  fListClassroom();
				  break;
				
			case 'btnSaveRoom':			//강의실 저장 버튼
				  fSaveClassRoom();
			      break;
			      
			case 'btnDeleteRoom':		//강의실 삭제 버튼
				  fDeleteClassRoom();
				  break;
				  
			case  'btnSaveEquipment' :	//장비 저장 버튼
				   fSaveEquipment();
				   break;
				  
			case 'btnDeleteEquipment': 	//장비 삭제 버튼
				  fDeleteEquipment();
				  break;
				  
			case 'btnCloseRoom':		//취소 버튼
			case 'btnCloseEquipmen':
				  gfCloseModal();		
			  break;
			}
		});
	}

	
	/**폼 초기화 */
	function fInitFormCmgRoom(object) {
		
		if( object == "" || object == null || object == undefined) {
						
			//$("#rNo").val("");
			$("#rName").val("");
			$("#rSize").val("");
			$("#rSit").val("");
			$("#rContent").val("");
			$("#btnDeleteRoom").hide();
			
			$("#rName").focus();
		} else {
			
			//$("#rNo").val(object.roomNo);
			$("#rName").val(object.roomNm);
			$("#rSize").val(object.roomArea);
			$("#rSit").val(object.roomSize);
			$("#rContent").val(object.roomEtc);
			$("#btnDeleteRoom").show();			
			$("#roomNo").val(object.roomNo);
			
			$("#rName").focus();
				
			if(object.classnum>0){
				$("#btnDeleteRoom").hide();
			}else{
				$("#btnDeleteRoom").show();	
			}
		}
	}	
	
	
	/**강의실관리 모달창**/
	function fPopModalCmgRoomCod(roomno) {
		//신규등록 버튼을 누르면 매개변수로 넘어오는 것이 없음
		if (roomno == null || roomno == "") {
			//swal("여기도 찍어봅세  ");			
			// Tranjection type
			$("#action").val("I");

			//  폼 초기화하는 이유가 머였지?
			fInitFormCmgRoom();

			// layer1 모달창을 실행
			gfModalPop("#layer1");
		
		} else {
			// Tranjection type 설정
			$("#action").val("U");

			//  한건 조회
			fSelectCmgRoom(roomno);
		}
	}
	
	
	/**강의실 관리: 한건 조회**/
	//수정버튼 클릭시 한 목록만 조회되는 것.
	function fSelectCmgRoom(roomno) {
		$("#roomNo").val(roomno);
		
		var param = { roomno : roomno };
		
		//data는 컨트롤러의 리턴값이다.
		var resultCallback = function(data) {
			fSelectRoomResult(data);
		};
		
		callAjax("/cmg/selectRoomOne.do", "post", "json", true, param, resultCallback);
	}
	
	/**강의실 관리: 한건 조회 콜백 함수*/
	function fSelectRoomResult(data) {

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");
			
			// 그룹코드 폼 데이터 설정
			fInitFormCmgRoom(data.classroomModel);
			
		} else {
			swal(data.resultMsg);
		}	
	}
	
	
	/**강의실 목록 조회**/
	//오 이해했다아아아ㅏ
	function fListClassroom(currentPage) {
		//매개변수로 넘어오는 currentPage(현재페이지)가 없으면 1이된다.
		currentPage = currentPage || 1;
		
		//아이디로 값 가져오고(검색)
		var sname = $('#sname').val();
		var searchKey = $('#searchKey').val();
		/* var searchKey = document.getElementById("searchKey");
		var oname = searchKey.options[searchKey.selectedIndex].value; */

		console.log("currentPage : " + currentPage);
		
		//param에 값들 저장(나중에 컨트롤러에 보냄)
		var param = {
			sname : sname,
			oname : searchKey,
			currentPage : currentPage,		//현재페이지
			pageSize : pageSizeClassroom	//페이지 크기
		}
		
		//변수를 하나 만들어서 함수를 저장만 해뒀다.(함수 실행은 밑에있는 callAjax에서!!)
		//data는 컨트롤러의 리턴값이다.??
		var resultCallback = function(data) {
			flistClassroomResult(data, currentPage);
		};
		
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//cmg/lectureroomList.do
		callAjax("/cmg/lectureroomList.do", "post", "text", true, param,
				resultCallback); //resultCallback에 저장되있는 함수가 실행된다.
	}

	/** 강의실 조회 콜백 함수 */
	function flistClassroomResult(data, currentPage) {

		//swal(data);
		console.log(data);

		// 기존 목록 삭제
		$('#listClassroom').empty();

		// 신규 목록 생성 
		$("#listClassroom").append(data);

		// 총 개수 추출
		var totalCntClassroom = $("#totalCntClassroom").val();

		//swal(totalCntClassroom);

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntClassroom,
				pageSizeClassroom, pageBlockSizeClassroom, 'fListClassroom');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#classroomPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageClassroom").val(currentPage);
	}
	
	
	
	/** 강의실 관리 저장 validation**/
	function fValidateClassRoom() {

		var chk = checkNotEmpty(
				[
						[ "rName", "강의실명을 입력해 주세요" ],
						[ "rSize", "강의크기을 입력해 주세요" ],
						[ "rSit", "자리수을 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	
	/** 강의실 관리 저장**/
	function fSaveClassRoom() {

		// vaildation 체크
 		if ( ! fValidateClassRoom() ) {
			return;
		} 
		
		var resultCallback = function(data) {
			fSaveClassRoomResult(data);
		};
		
		callAjax("/cmg/saveRoom.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
	}
	
	
	/** 강의실관리 저장 콜백 함수 */
	function fSaveClassRoomResult(data) {
		
		console.log("data : " + JSON.stringify(data)   );
		
		
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageClassroom").val();
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 목록 조회
			fListClassroom(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
		
		// 입력폼 초기화
		fInitFormCmgRoom();
	}
	
	
	/** 강의실 관리 삭제 */
	function fDeleteClassRoom() {
		var roomNo = $('#roomNo').val();
		
		swal("정말 삭제하겠습니까? \n삭제시 복구불가합니다.", {
			  buttons:{
				  yes : "예",
				  no : "아니오"
			  }
			}).then((value) => {  /* 이건 이클립스가 게을러서 뜨는 에러!  */
				switch(value){
				case "yes":
					
					var param = { roomno : roomNo };
					
					var resultCallback = function(data) {
					fDeleteClassRoomResult(data);
					};
				
					callAjax("/cmg/deleteRoom.do", "post", "json", true, param, resultCallback);
				
					break;
				case "no": 
					break;
				}
			});
	}
	
	/** 강의실 관리 삭제 콜백 함수 */
	function fDeleteClassRoomResult(data) {
		
		var currentPage = $("#currentPageClassroom").val();
		var roomno = $('#tmpRoomNo').val("");
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 그룹코드 목록 조회
			fListClassroom(currentPage);
			
		} else {
			swal(data.resultMsg);
		}	
	}
	
	
	
	/** 장비목록 초기화 */
	function fInitFormCmgEqui(data) {
		var r_no = $("#r_no").val();

		if (data == "" || data == null || data == undefined) {

			$("#r_no").val(r_no);
			$("#e_no").val("");
			$("#e_name").val("");
			$("#e_cnt").val("");
			$("#e_etc").val("");
			$("#r_no").attr("readonly", true);
			$("#r_no").css("background", "#F5F5F5");
			$("#e_no").attr("readonly", false);
			$("#e_no").css("background", "#FFFFFF");
			$("#btnDeleteEquipment").hide();			

		} else {

			$("#r_no").val(data.room_No);
			$("#e_no").val(data.equi_No);
			$("#e_name").val(data.equi_Nm);
			$("#e_cnt").val(data.equi_Cnt);
			$("#e_etc").val(data.equi_Etc);
			$("#r_no").attr("readonly", true);
			$("#r_no").css("background", "#F5F5F5");
			$("#e_no").attr("readonly", true);
			$("#e_no").css("background", "#FFFFFF");
			$("#btnDeleteEquipment").show();
		}
	}
	
	
	/** 장비 목록 조회 */
	function fListEquipment(currentPage,r_no) {
		
		currentPage = currentPage || 1;
		
		//#r_no에 r_no를 넣어줌
		$("#r_no").val(r_no);
		
		var param = {
				r_no : r_no,
				currentPage : currentPage,
				pageSize : pageSizeEquipment
		}
		
		var resultCallback = function(data) {
			flistEquipmentResult(data, currentPage);
		};
		
		callAjax("/cmg/EquipmentList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 장비 목록 조회 콜백 함수 */
	function flistEquipmentResult(data, currentPage) {
	
		console.log("flistEquipmentResult : " + data);
		
		// 기존 목록 삭제
		$('#listEquipment').empty();

		// 신규 목록 생성
		$("#listEquipment").append(data);

		// 총 개수 추출
		var totalCntEquipment = $("#totalCntEquipment").val();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntEquipment,
				pageSizeEquipment, pageBlockSizeEquipment, 'fListEquipment');
		//console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#equipmentPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageEquipment").val(currentPage);
	}
	
	/** 장비 단건 조회 */
	function fSelectCmgEqui(r_no, e_no) {

		var param = {
					r_no : r_no
				,	e_no : e_no
		};
		
		var resultCallback = function(data) {
			fSelectEquiResult(data);
		};
		
		callAjax("/cmg/selectCmgEqui.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 장비 단건 조회 콜백 함수*/
	function fSelectEquiResult(data) {

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer2");
			
			// 그룹코드 폼 데이터 설정
			fInitFormCmgEqui(data.equipmentModel);
			
		} else {
			swal(data.resultMsg);
		}	
	}	
	
	/** 장비 모달 실행 */
	function fPopModalCmgEqui(r_no, e_no) {
		
		// 신규 저장
		if (e_no == null || e_no=="") {
		
			if ($("#r_no").val() == "") {
				swal("강의실 번호를 선택해 주세요.");
				return;
			}
			
			$("#action").val("I");		// Tranjection type 설정
			fInitFormCmgEqui();			// 상세코드 폼 초기화
			gfModalPop("#layer2");		// 모달 팝업
		// 수정 저장
		} else {
			// Tranjection type 설정
			$("#action").val("U");
			// 장비목록 단건 조회
			fSelectCmgEqui(r_no, e_no);
		}
	}
	
	
	/** 장비 저장 validation */
	function fValidateEquipment() {

		var chk = checkNotEmpty(
				[
						[ "r_no", "강의실 번호를 입력해 주세요" ]
					,	[ "e_no", "장비 번호를 입력해 주세요." ]
					,	[ "e_name", "장비명을 입력해 주세요" ]
					,	[ "e_cnt", "장비 갯수를 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	
	/** 장비 저장 */
	function fSaveEquipment() {
		

		// vaildation 체크
		if ( ! fValidateEquipment() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fSaveEquipmentResult(data);
		};
		
		
		callAjax("/cmg/saveEqui.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
		
	}
	
	
	/** 장비 저장 콜백 함수 */
	function fSaveEquipmentResult(data) {
		var r_no = $('#r_no').val();
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageEquipment").val();
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 목록 조회
			//var classroom_no = $("#tmpCmgCod").val();	
			fListEquipment(currentPage,r_no);
			
		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
		
		// 입력폼 초기화
		fInitFormCmgEqui();
	}
	
	
	/** 장비 삭제 */
	function fDeleteEquipment() {
		
		var resultCallback = function(data) {
			fDeleteEquipmentResult(data);
		};
		
		callAjax("/cmg/deleteEquipment.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
	}
	
	
	/** 장ㅂ 삭제 콜백 함수 */
	function fDeleteEquipmentResult(data) {
		var r_no = $('#r_no').val();
		
		var currentPage = $("#currentPageEquipment").val();
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			fListEquipment(currentPage,r_no);
			
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
	<input type="hidden" id="currentPageClassroom" value="1">
	<input type="hidden" id="currentPageEquipment" value="1">
	<input type="hidden" id="tmpCmgCod" value="">
	<input type="hidden" id="tmpCmgCodNm" name="aaaaaa" value="">
	<input type="hidden" id="roomNo" name="roomno" value="">
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
								<span class="btn_nav bold">물품 관리</span> 
								<span class="btn_nav bold">강의실 관리</span> 
								<a href="../cmg/lectureroomMgt.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
							<span>강의실 관리</span> 
							<span class="fr"> 
							<a class="btnType blue" href="javascript:fPopModalCmgRoomCod();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
						
						
						<!--검색창 부분  -->
						<div class="divClassroomList">
							<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1" align="left"  style="collapse; border: 1px #50bcdf;">
		                        <tr style="border: 0px; border-color: blue">
		                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
		                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
		     	                      <select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
											<option value="classroom_no" >강의실 번호</option>
											<option value="classroom_nm" >강의실명</option>
									</select> 
		     	                       <input type="text" style="width: 300px; height: 25px;" id="sname" name="sname">                    
			                           <a href="" class="btnType blue" id="btnSearchClassroom" name="btn"><span>검  색</span></a>
		                           </td> 
		                          </tr>
	                         </table> 						
						
						<br><br><br>
						
						<!--강의실 관리 목록 조회창 부분  -->
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="8%">
									<col width="20%">
									<col width="10%">
									<col width="10%">
									<col width="5%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">일련번호</th>
										<th scope="col">강의실 번호</th>
										<th scope="col">강의실 명</th>
										<th scope="col">크기</th>
										<th scope="col">자리수</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="listClassroom"></tbody>
							</table>
						</div>
						
						<!--페이지 번호  -->
						<div class="paging_area"  id="classroomPagination"> </div>
						
						
						<p class="conTitle mt50">
							<span>장비 관리</span> 
							<span class="fr"> 
							<a class="btnType blue"  href="javascript:fPopModalCmgEqui();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
	
	
						<!--장비 관리 목록 조회창 부분  -->
						<div class="EquipmentList">
						
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="5%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의실 번호</th>
										<th scope="col">장비번호</th>
										<th scope="col">장비명</th>
										<th scope="col">갯수</th>
										<th scope="col">비고</th>
										<th scope="col">수정</th>
									</tr>
								</thead>
								<tbody id="listEquipment">
									<tr>
										<td colspan="12">강의실번호를 선택해 주세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="equipmentPagination"> </div>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 강의실 관리 모달창 화면 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>강의실 관리</strong>
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
								<th scope="row">강의실명<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" maxlength="30" class="inputTxt p100" name="rName" id="rName" /></td>
							</tr>
							<tr>
								<th scope="row">크기 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="rSize" id="rSize" /></td>
								<th scope="row">자리수<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="rSit" id="rSit" /></td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3"><textarea class="inputTxt p100" name="rContent" id="rContent"></textarea></td>
							</tr>
						</tbody>
					</table>
					

				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveRoom" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteRoom" name="btn"><span>삭제</span></a> 
					<a href="" class="btnType gray" id="btnCloseRoom" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>


	<!--장비관리 모달창 화면 -->
	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>장비 관리</strong>
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
							<th scope="row">강의실 번호 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="r_no" name="r_no" /></td>
							<th scope="row">장비번호 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="e_no" name="e_no" /></td>
						</tr>
						<tr>
							<th scope="row">장비명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="e_name" name="e_name" /></td>
							<th scope="row">갯수 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="e_cnt" name="e_cnt" /></td>
						</tr>
						
						<tr>
							<th scope="row">비고</th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="e_etc" name="e_etc" /></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:fSaveEquipment();" class="btnType blue" id="btnSaveEquipment" ><span>저장</span></a>
					<a href="" class="btnType blue" id="btnDeleteEquipment" name="btn"><span>삭제</span></a>  
					<a href="" class="btnType gray" id="btnCloseEquipmen" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 모달팝업 -->
</form>
</body>
</html>