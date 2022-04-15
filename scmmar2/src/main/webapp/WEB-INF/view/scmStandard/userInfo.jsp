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
<title>Job Korea :: 기업고객/직원정보 관리</title>

<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->


<script type="text/javascript">

	// 사용자정보 페이징 설정
	var pageSizeUserInfo = 10;
	var pageBlockSizeUserInfo = 5;

	
	
	/** OnLoad event */ 
	$(function() {
	
		// 사용자정보 조회
		fListUserInfo();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				
				case 'btnSaveUserInfo':
					fSaveUserInfo();
					break;
					
				case 'btnListUserInfo':
					fListUserInfo();
					break;
					
				case 'btnDeleteUserInfo' :
					fDeleteUserInfo();
					break;
					
				case 'btnCloseUserInfo' :
					gfCloseModal();
					break;
				
			}
		});
	}
	
	
	/** 사용자정보 폼 초기화 */
	function fInitFormUserInfo(object) {
		$("#loginID").focus();
		if( object == "" || object == null || object == undefined) {
			
			$("#loginID").val("");
			$("#password").val("");
			$("#client").val("");
			$("#clientnm").val("");
			$("#user_Type").val("");
			$("#mgrnm").val("");
			$("#phone").val("");
			$("#email").val("");
			$("#zipCode").val("");
			$("#address").val("");
			$("#dtAddress").val("");
			$("#workSearchInsert").val("C");
			$("#workSearch").val("C");
			$("#loginID").attr("readonly", false);
			$("#loginID").css("background", "#FFFFFF");
			$("#loginID").focus();
			$("#btnDeleteUserInfo").hide();
			
		} else {
			
			$("#loginID").val(object.loginID);
			$("#password").val(object.password);
			$("#client").val(object.client);			
			$("#clientnm").val(object.clientnm);
			$("#user_Type").val(object.user_Type);
			$("#workSearchInsert").val(object.user_Type);
			$("#workSearch").val(object.user_Type);
			$("#mgrnm").val(object.mgrnm);
			$("#phone").val(object.phone);
			$("#email").val(object.email);
			$("#zipCode").val(object.zipCode);
			$("#address").val(object.address);
			$("#dtAddress").val(object.dtAddress);
			$("#loginID").attr("readonly", true);
			$("#loginID").css("background", "#F5F5F5");
			$("#btnDeleteUserInfo").show();

			
		}
// 		console.log($('#workSearchInsert').val());
		
		//팝업내 기업고객 / 내부직원 확인
		var partSelect = document.getElementById("popPart");
		
		if($('#workSearchInsert').val() == 'C'){
			partSelect.value = 'Cust';
		}else{
			partSelect.value = 'Staff';
		}
		
		partView(partSelect.value);
	}
	
	/** 사용자정보 저장 validation */
	function fValidateUserInfo() {

		var chk = checkNotEmpty(
				[
						[ "loginID", "아이디를 입력해 주세요." ]
					,	[ "password", "비밀번호를 입력해 주세요" ]
					,	[ "phone", "전화번호를 입력해 주세요." ]
					,	[ "email", "이메일을 입력해 주세요." ]
					,	[ "zipCode", "우편번호를 입력해 주세요." ]
					,	[ "address", "주소를 입력해 주세요." ]
					,	[ "dtAddress", "상세주소를 입력해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	/** 사용자정보 모달 실행 */
	function fPopModalUserInfo(loginID) {
		
		var workSelect = document.getElementById("workSearch");
		var partSelect = document.getElementById("popPart");
		
		// 신규 저장
		if (loginID == null || loginID=="") {
			//swal("여기도 찍어봅세  ");
			// Tranjection type 설정
			$("#action").val("I");
			$("#popTitle").html("<strong>신규등록</strong>");
			
			// 사용자정보 폼 초기화
			fInitFormUserInfo();
			
			// 모달 팝업
			gfModalPop("#layer1");

		// 수정 저장
		} else {
			
			// Tranjection type 설정
			$("#action").val("U");
			$("#loginID").attr("readonly",true);
			$("#popTitle").html("<strong>정보수정</strong>");
			
			// 사용자정보 단건 조회
			fSelectUserInfo(loginID);
		}
// 			console.log($('#workSearchInsert').val());
			
	}
	
	

	
	
	/** 사용자정보 조회 */
	function fListUserInfo(currentPage) {
		
		currentPage = currentPage || 1;
		
		var sname = $('#sname').val();
       // var searchKey = document.getElementById("searchKey");
		//var oname = searchKey.options[searchKey.selectedIndex].value;
		
		var oname = $('#searchKey').val();
		var uname = $('#workSearch').val();

		console.log("currentPage : " + currentPage);
		
		if(oname == 'user_Type'){
			var param = {	
					sname : 'dd'
				,	oname : oname
				,	uname : uname
				,	currentPage : currentPage
				,	pageSize : pageSizeUserInfo
			}
		}
		
		else{
			var param = {	
						sname : sname
					,	oname : oname
					,	uname : uname
					,	currentPage : currentPage
					,	pageSize : pageSizeUserInfo
			}			
		}
		
		
		var resultCallback = function(data) {
			flistUserInfoResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/scmStandard/listUserInfo.do", "post", "text", true, param, resultCallback);
	}
	
	/** 사용자정보 조회 콜백 함수 */
	function flistUserInfoResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listUserInfo').empty();
		
		// 신규 목록 생성
		$("#listUserInfo").append(data);
		
		// 총 개수 추출
		
		var totalCntUserInfo = $("#totalCntUserInfo").val();
		
				
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntUserInfo, pageSizeUserInfo, pageBlockSizeUserInfo, 'fListUserInfo');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#userInfoPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageUserInfo").val(currentPage);
	}
	
	/** 사용자정보 단건 조회 */
	function fSelectUserInfo(loginID) {
		
		var param = { loginID : loginID };
		
		var resultCallback = function(data) {
			fSelectUserInfoResult(data);
		};
		
		callAjax("/scmStandard/selectUserInfo.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 사용자정보 단건 조회 콜백 함수*/
	function fSelectUserInfoResult(data) {

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");
			
			// 사용자정보 폼 데이터 설정
			fInitFormUserInfo(data.userInfoModel);
			
		} else {
			swal(data.resultMsg);
		}	
	}
	
	//담당업무 콤보 검색
	function workType(types){
			var searchType = document.getElementById("sname");
			var userType = document.getElementById("workSearch");
		if(types == 'user_Type'){			
			searchType.type = "hidden";
			userType.style = "width: 150px;";			
		}
		else{
			searchType.type = "text";
			userType.style = "display:none;";
		}
	}
	
	
	//모달팝업 시, 유저구분별 목록정보 바꾸기
	function partView(parttypes){
		var title = document.getElementsByName("clientcharge");
// 		var titleArr = new Array(title);
		var titleArr = ["회사명 / 성명","담당자명","직원명","담당업무"];
		
		var clientId = document.getElementById("client");
		var chargeId = document.getElementById("clientnm");
		var nameId = document.getElementById("mgrnm");
		var workSelect = document.getElementById("workSearchInsert");

		
		if(parttypes == 'Staff'){
			titleArr.splice(0,2);
			chargeId.type = "text";
			workSelect.style = "width: 100px;";
			nameId.type = "hidden";
			clientId.type = "hidden";
			$("#client").val("");
			$("#mgrnm").val("");
			
		}else{
			chargeId.type = "hidden";
			workSelect.style = "display:none;";
			nameId.type = "text";
			clientId.type = "text";
			$("#clientnm").val("");
			$("#workSearchInsert").val("C");
		}
		title[0].innerText = titleArr[0];
		title[1].innerText = titleArr[1];
		
		console.log('clientId :: '+clientId.getAttribute("id"));
		console.log('chargeId :: '+chargeId.getAttribute("id"));

	}
	
	
	
	
	/** 사용자정보 저장 */
	function fSaveUserInfo() {

		// vaildation 체크
		if ( ! fValidateUserInfo() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fSaveUserInfoResult(data);
		};
		
		callAjax("/scmStandard/saveUserInfo.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
	}
	
	
	/** 사용자정보 저장 콜백 함수 */
	function fSaveUserInfoResult(data) {
		
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageUserInfo").val();
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 목록 조회
			fListUserInfo(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
		
		// 입력폼 초기화
		fInitFormUserInfo();
	}
	
	
	/** 사용자정보 삭제 */
	function fDeleteUserInfo() {
		
		swal("정말 삭제하겠습니까? \n삭제시 복구불가합니다.", {
			  buttons:{
				  yes : "예",
				  no : "아니오"
			  }
			}).then((value) => {  /* 이건 이클립스가 게을러서 뜨는 에러!  */
				switch(value){
				case "yes":
					
					var resultCallback = function(data) {
					fDeleteUserInfoResult(data);
					};
				
					callAjax("/scmStandard/deleteUserInfo.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
				
					break;
				case "no": 
					break;
				}
			});
		
		
	}
	
	
	/** 사용자정보 삭제 콜백 함수 */
	function fDeleteUserInfoResult(data) {
		
		var currentPage = $("#currentPageUserInfo").val();
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 사용자정보 목록 조회
			fListUserInfo(currentPage);
			
		} else {
			swal(data.resultMsg);
		}	
	}
	
	
	
</script>

</head>
<body>

<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageUserInfo" value="1">
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
							<span	class="btn_nav bold">기준정보</span>
							<span class="btn_nav bold">기업고객·직원정보 관리</span>
							<a href="../scmStandard/userInfo.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>기업고객 · 직원정보 관리</span>							
						</p>
						
						<table style="margin: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                      <select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey" onchange="workType(this.value)">
									<option value="clientnm" >직원명</option>
									<option value="name" >담당자명</option>
									<option value="user_Type" >담당업무</option>
								</select> 
							
							
								<select id="workSearch" name="workSearch" style="display:none;" v-model="workSearch" >
									<option value='A'>관리자</option>
									<option value='B'>배송</option>
									<option value='D'>구매</option>
									<option value='E'>임원</option>
									<option value='C' style="display: none;"></option>
								</select>							
								
								
								
	    	                    	<input type="text" style="width: 300px; height: 25px;" id="sname" name="sname" onkeypress="if( event.keyCode == 13 ){fListUserInfo();}">                    
								
						
	                           <a href="" class="btnType blue" id="btnListUserInfo" name="btn"><span>검  색</span></a>
                           </td> 
                           
                        </tr>
                     	</table> 
						<div class="divUserInfoList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="10%">
									<col width="20%">
									<col width="30%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">구분</th>
										<th scope="col">회사명 / 성명</th>
										<th scope="col">담당업무</th>
										<th scope="col">담당자명</th>
										<th scope="col">연락처</th>
									</tr>
								</thead>
								<tbody id="listUserInfo"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="userInfoPagination"> </div>
						
						<span class="fr">
						<a style="margin-top: 10px" class="btnType blue"  href="javascript:fPopModalUserInfo();" name="modal"><span>신규등록</span></a>
						
						</span>
                     
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	
	<!-- 신규등록 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt id="popTitle" style="font-family: 맑은고딕;">
				<strong>신규등록</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="500px">
						<col width="300px">
						<col width="1500px">						
					</colgroup>
					

					<tbody>
					
						<tr>
							<td>
								<select id="popPart" name="popPart" style="width: 150px;" v-model="popPart" onchange="partView(this.value)">
									<option value="Cust">기업고객</option>
									<option value="Staff">내부직원</option>
								</select>
							</td>
							<th scope="row">아이디 <span class="font_red">*</span></th>
							<td ><input type="text" class="inputTxt p100" name="loginID" id="loginID" /></td>
							
						<tr>		
							<td><div style="width: 150px;"></div></td>	
							<th scope="row">비밀번호 <span class="font_red" >*</span></th>
							<td colspan="2"><input type="password" class="inputTxt p100" name="password" id="password" /></td>
						</tr>
						<tr >		
							<td><div style="width: 150px;"></div></td>				
							<th scope="row"><a name="clientcharge" >회사명 / 성명 </a> <span class="font_red">*</span></th>
							<td colspan="2">
							<input type="text" class="inputTxt p100" name="client" id="client" />
							<input type="hidden" class="inputTxt p100" name="clientnm" id="clientnm" />
							</td>
						</tr>
							
						<tr >		
							<td><div style="width: 150px;"></div></td>	
							<th scope="row"><a name="clientcharge">담당자명</a> <span class="font_red">*</span></th>
							<td colspan="2">
							<input type="text" class="inputTxt p100" name="mgrnm" id="mgrnm" />
							<select id="workSearchInsert" name="workSearchInsert" style="display:none;" v-model="workSearchInsert" >
									<option value='A'>SCM</option>
									<option value='B'>배송</option>
									<option value='D'>구매</option>
									<option value='E'>임원</option>
									<option value="C" style="display:none"></option>									
							</select>
							</td>
							
						</tr>
						
						<tr>
							<td><div style="width: 150px;"></div></td>					
							<th scope="row">연락처 <span class="font_red">*</span></th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="phone" id="phone" /></td>
						</tr>	
						
						<tr>		
							<td><div style="width: 150px;"></div></td>			
							<th scope="row">이메일 <span class="font_red">*</span></th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="email" id="email" /></td>
						</tr>
				
						<tr>
							<td><div style="width: 150px;"></div></td>		
							<th scope="row">우편번호 <span class="font_red">*</span></th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="zipCode" id="zipCode" /></td>
						</tr>
						
						<tr>
							<td><div style="width: 150px;"></div></td>		
							<th scope="row">주소 <span class="font_red">*</span></th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="address" id="address" /></td>
						</tr>
						
						<tr>
							<td><div style="width: 150px;"></div></td>		
							<th scope="row">상세주소 <span class="font_red">*</span></th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="dtAddress" id="dtAddress" /></td>
						</tr>
					
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveUserInfo" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteUserInfo" name="btn"><span>삭제</span></a>
					<a href=""	class="btnType gray"  id="btnCloseUserInfo" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	
</form>


</body>
</html>