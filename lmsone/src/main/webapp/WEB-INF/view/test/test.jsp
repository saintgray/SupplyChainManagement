<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${sessionScope.userType == 'B'}">
	<c:redirect url="/dashboard/dashboard.do" />
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 공통 코드 관리</title>
<!-- sweet alert import -->

<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<!-- 우편번호 조회 -->

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="../login/modalRegister.jsp"></jsp:include><!-- 해당 인클루드에 #action 으로 설정된 곳이 있어서 14번과 충돌 -->
<!-- sweet swal import -->


<script type="text/javascript">

	/* 그룹코드 페이징 설정 */
	var pageSizeComnGrpCod = 6; //페이지에 보여줄 게시글 수
	var pageBlockSizeComnGrpCod = 3; //페이지 네비게이션 수
	
	/* OnLoad event */
	$(function() {
		// 그룹코드 조회
		fListComnGrpCod();	
		
		//버튼이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	//9. 버튼 이벤트 등록
	//8번까지 완료 후 아무리 저장을 눌러도 값이 넘어오지 않았고, 에러도 발생하지 않음 버튼 이벤트가 없어서 적용조차 안 되었던 것 : 이슈발생
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveGrpCod' :
					fSaveGrpCod();
					break;
				case 'btnDeleteGrpCod' :
					fDeleteGrpCod();
					break;
				case 'btnSaveDtlCod' :
					fSaveDtlCod();
					break;
				case 'btnDeleteDtlCod' :
					fDeleteDtlCod();
					break;
				case 'btnSearchGrpcod':
					board_search();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	/** 2. 그룹코드 폼 초기화 */
	function fInitFormGrpCod(object) {
		$("#grp_cod").focus();
		if( object == "" || object == null || object == undefined) {
			
			$("#grp_cod").val("");
			$("#grp_cod_nm").val("");
			$("#grp_cod_eplti").val("");
			$("#grp_tmp_fld_01").val("");
			$("#grp_tmp_fld_02").val("");
			$("#grp_tmp_fld_03").val("");
			$("input:radio[name=grp_use_poa]:input[value='Y']").attr("checked", true);
			$("#grp_cod").attr("readonly", false);
			$("#grp_cod").css("background", "#FFFFFF");
			$("#grp_cod").focus();
			$("#btnDeleteGrpCod").hide();
			
		} else {
			
			$("#grp_cod").val(object.grp_cod);
			$("#grp_cod_nm").val(object.grp_cod_nm);
			$("#grp_cod_eplti").val(object.grp_cod_eplti);
			
			$("#grp_tmp_fld_01").val(object.tmp_fld_01);
			$("#grp_tmp_fld_02").val(object.tmp_fld_02);
			$("#grp_tmp_fld_03").val(object.tmp_fld_03);
			$("input:radio[name=grp_use_poa]:input[value="+object.use_poa+"]").attr("checked", true);
			$("#grp_cod").attr("readonly", true);
			$("#grp_cod").css("background", "#F5F5F5");
			$("#grp_cod_nm").focus();
			
			if(object.tmp_fld_01>0){
				$("#btnDeleteGrpCod").hide();
			}else{
				$("#btnDeleteGrpCod").show();	
			}//2nd if~else
		}//1st if~else
	}
	
	/** 10. 그룹코드 저장 validation
	9번까지 완료 후 실행해보니 html console의 if( ! fValidateGrpCod() ) { 부분에 에러. 
	해당 함수가 없었기 때문 : 이슈발생 */
	function fValidateGrpCod() {

		var chk = checkNotEmpty(
				[
						[ "grp_cod", "그룹 코드를 입력해 주세요." ]
					,	[ "grp_cod_nm", "그룹 코드 명을 입력해 주세요" ]
					,	[ "grp_cod_eplti", "그룹 코드 설명을 입력해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	/* 그룹코드 조회 */
	function fListComnGrpCod(currentPage) {
		//초기화면 구성을 위해 현재페이지, 페이지네이트, Ajax가 필요
		
		currentPage = currentPage || 1;
		console.log("최근페이지: "+currentPage);
		
		//11. 자바 콘솔에 값이 넘어오지 않음 이슈발생 : 그룹코드 저장을 위한 셀릭트키와 #sname의 밸류 11~13삭제.
		
		//변수 param을 해당 객체로 세팅
		var param = {
			currentPage : currentPage,
			pageSize : pageSizeComnGrpCod
		};
		
		//콜백함수 세팅 후 변수에 대입
		var resultCallback = function(data) { flistGrpCodResult(data, currentPage); };
		
		//Ajax실행(url, 메서드방식, , , Callback함수 이름)
		callAjax("/sampletest/listComnGrpCod.do", "post", "text", true, param, resultCallback);
	}/* Controller 및 jsp 매핑, 4번까지 후 파라미터가 넘어오지 않는 이슈발생: callAjax의 url, 함수 오타 */
	
	/* 그룹코드 조회 콜백 함수 */
	function flistGrpCodResult(data, currentPage) {		
		//data 확인
		//console.log("데이터 확인: "+data);
		
		//기존 tbody의 자식요소들 비우기
		$("#listComnGrpCod").empty();
		
		//비워진 tbody의 자식요소에 data를 채워넣기
		$("#listComnGrpCod").append(data);
		
		//총 개수 추출(input요소 hidden)
		var totalCntComnGrpCod = $("#totalCntComnGrpCod").val();
		/* 총 건수가 넘어오지 않는 이슈발생: .val; 이라고 선언 괄호 주의 */
		//console.log("flistGrpCodResult totalCntComnGrpCod : " + totalCntComnGrpCod);
		
		//페이지 네비게이션 세팅
		var paginationHtml = getPaginationHtml(
				currentPage, 
				totalCntComnGrpCod, 
				pageSizeComnGrpCod, 
				pageBlockSizeComnGrpCod, 
				'fListComnGrpCod');//button
		//console.log(" 페이지네이션html: "+paginationHtml);
		
		//페이지 네비게이션을 div요소에 생성
		$("#comnGrpCodPagination").empty().append(paginationHtml);
		
		//현재 페이지 설정
		$("#currentPageComnGrpCod").val(currentPage);
	}
	
	/* 1. 수정 또는 신규등록 버튼요소를 클릭할 경우 a요소의 href="javascript:fPopModalComnGrpCod();"속성으로 인해 해당 함수가
	자바스크립트를 통해 실행 됨. 이 때, 파라미터값이 없는 경우는 name이 action인 input요소에 I가 들어가고,
	파라미터가 paramMap : {grp_cod=1} 처럼 값이 넘어가는 경우 그룹코드를 가지고 그것에 대한 상세정보를 단건 셀럭트를 뿌림.
	따라서, 이는 수정으로 넘어가는게 맞고 U로 세팅되어 그룹코드 모달이 실행되어 div요소로 되어 있는 팝업을 실행	*/
	//1. 그룹코드 모달실행
	function fPopModalComnGrpCod(grp_cod) {
		
		//신규등록
		if (grp_cod == null || grp_cod=="") {
			
			//alert("그룹코드 값이 넘어오지 않아 if문으로 실행됩니다.");
			
			//input요소에 value값이 I로 세팅
			$("#actionTest").val("I");
			
			//2. 그룹코드 폼 초기화 부분
			fInitFormGrpCod();
			
			//3. 그룹코드모달팝업 부분을 위해서 div 모달 요소를 원본에서 가져옴.
			//4. 모달팝업
			gfModalPop("#layer1");
			
		//수정
		} else {			
			//alert("그룹코드의 값이 "+grp_cod+" 입니다. else문으로 실행됩니다.");
			
			//input요소에 value값이 U로 세팅
			$("#actionTest").val("U");
			
			//5. 그룹코드 단건 조회 부분
			fSelectGrpCod(grp_cod);
			
		}//if~else end
	}
	
	//5. 그룹코드 단건 조회
	function fSelectGrpCod(grp_cod) {
		
		//param에 그룹코드 세팅
		var param = { grp_cod : grp_cod };
		
		//resultCallback이란 변수에 콜백함수를 세팅
		var resultCallback = function(data) { fSelectGrpCodResult(data); };
		
		//6. selectComnGrpCod.do로 매핑된 컨트롤러
		//json형태로 데이터들을 던짐
		callAjax("/sampletest/selectComnGrpCod.do", "post", "json", true, param, resultCallback);
		//url 이슈발생 : system으로 기입했음 sampletest으로 수정
		
	}
	
	//5. 그룹코드 단건 조회 콜백 함수
	function fSelectGrpCodResult(data) {		

		console.log("단건조회콜백data : " + JSON.stringify(data));
		
		if(data.result == "SUCCESS" ) {
			
			//모달팝업
			gfModalPop("#layer1");
			
			//그룹코드 폼 데이터 설정
			fInitFormGrpCod(data.comnGrpCodModel);
			alert("그룹코드 폼 데이터 설정: "+JSON.stringify(data.comnGrpCodModel));
			
		}else {
			swal(data.resultMsg);
		}//if~else
		
	}
	
	
	//7. 현재까지 조회 완료. 그룹코드 저장
	function fSaveGrpCod() {
		//debugger; //디버거
		
		//vaildation체크
		if( ! fValidateGrpCod() ) {
			return;
		}
		
		var resultCallback = function(data) { fSaveGrpCodResult(data); };
		
		var tmp = $("#actionTest").val();		
		confirm("fSaveGrpCod action : " + tmp);
		
		/* .serialize()는 jquery가 가지있는 기능 중 하나로 
		Ajax의 data값을 설정할 경우 form의 모든 값들을 쉽게 받을 수 있다 */		
		//8. saveComnGrpCod.do로 매핑된 컨트롤러
		callAjax("/sampletest/saveComnGrpCod.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
		
	}
	
	//7. 그룹코드 저장 콜백 함수
	function fSaveGrpCodResult(data) {

		//console.log("그룹코드저장콜백data : " + JSON.stringify(data));
		
		//목록 조회 페이지 번호
		var currentPage = "1";		
		if( $("#actionTest").val() != "I" ) {
			currentPage = $("#currentPageComnGrpCod").val();
		}//if end
		
		console.log("그룹코드 저장-콜백함수 data확인: "+JSON.stringify(data));
		
		
		if( data.result == "SUCCESS" ) {
			
			//console.log("data.result : " + JSON.stringify(data.result));
			
			//응답메세지 출력
			alert("그룹코드 저장 콜백함수 if문 : "+data.resultMsg);
			
			//모달 닫기
			gfCloseModal();
			
			//목록 조회로 돌아가기
			fListComnGrpCod(currentPage);
		}else {
			//오류 응답 메세지 출력
			alert("그룹코드 저장 콜백함수 else문 : "+data.resultMsg);
		}//if~else end
		
		//입력폼 초기화
		fInitFormGrpCod();		
	}
	
	//15. 그룹코드 삭제
	function fDeleteGrpCod() {
		
		swal("정말 삭제하겠습니까? \n삭제시 복구불가합니다."
			, { buttons:{yes:"예", no:"아니오"} }
		).then((value) => { //이건 이클립스가 게을러서 뜨는 에러!
				
				switch(value) {				
				case "yes" : var resultCallback = function(data) { fDeleteGrpCodResult(data);	}
				callAjax("/sampletest/deleteComnGrpCod.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
				
				break;
				case "no" : break;
				}//switch end
			}//then() end
		);//swal() end		
	}
	
	//15. 그룹코드 삭제 콜백함수
	function fDeleteGrpCodResult(data) {
		
		var currentPage = $("#currentPageComnGrpCod").val();
		
		if(data.result == "SUCCESS") {
			
			//응답 메세지 출력
			alert(data.resultMsg);
			//모달닫기
			gfCloseModal();
			//그룹코드 목록조회
			fListComnGrpCod(currentPage);
			
		}else {
			swal(data.resultMsg);	
		}//if~else	
	}
	
</script>

</head>
<body>

	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPageComnGrpCod" value="1">
		<input type="hidden" id="currentPageComnDtlCod" value="1">
		<input type="hidden" id="tmpGrpCod" value="">
		<input type="hidden" id="tmpGrpCodNm" value="">
		<input type="hidden" name="action" id="actionTest" value="">
		<!-- name이 action인 input요소에 자바스크립트를 통해 I와, U가 세팅되어 컨트롤러에 전송된다 -->
		<!-- 14. 이슈발생 : 기존 test가 아닌 ("/sampletest/")를 사용하면서 name="action"요소가 중복 처리됨
		따라서 name속성의 속성값을 변경하여 함수에도 일괄 적용.
		오류 내용: 프론트엔드 콘솔창 [DOM] Found 2 elements with non-unique id #action: (More info: https://goo.gl/9p2vKq) <input type=​"hidden" name=​"action" id=​"action" value>​ -->

		<!-- 모달 배경 -->
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
						<h3 class="hidden">test 영역</h3> <!-- content -->
						<div class="content">

							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span class="btn_nav bold">test</span> <span class="btn_nav bold">test</span> <a href="../test/test.do" class="btn_set refresh">새로고침</a>
							</p>
							
							<!-- 시작 -->
							<p class="conTitle">
								<span>그룹 코드</span> <span class="fr"> <a
									class="btnType blue" href="javascript:fPopModalComnGrpCod();" name="modal"><span>신규등록</span></a>
								</span>
							</p><!--// .conTitle  -->
							
							<div class="divComGrpCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="6%">
										<col width="17%">
										<col width="20%">
										<col width="20%">
										<col width="10%">
										<col width="15%">
										<col width="10%">
									</colgroup>
		
									<thead>
										<tr>
											<th scope="col">순번</th>
											<th scope="col">그룹코드</th>
											<th scope="col">그룹코드명</th>
											<th scope="col">그룹코드 설명</th>
											<th scope="col">사용여부</th>
											<th scope="col">등록일</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									
									<tbody id="listComnGrpCod">
									</tbody><!--// #listComnGrpCod  -->									
								</table>
							</div><!--// .divComGrpCodList  -->
							<div class="paging_area"  id="comnGrpCodPagination"></div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		
		<!-- 12. 11번을 완료하고나니 아예 표가 사라짐. 찾아보니 sname이없음 :이슈발생 아무 상관없었음 삭제  -->
		
		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>그룹코드 관리</strong>
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
								<th scope="row">그룹 코드 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="grp_cod" id="grp_cod" /></td>
								<th scope="row">그룹 코드 명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="grp_cod_nm" id="grp_cod_nm" /></td>
							</tr>
							<tr>
								<th scope="row">코드 설명 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="grp_cod_eplti" id="grp_cod_eplti" /></td>
							</tr>
					
							<tr>
								<th scope="row">사용 유무 <span class="font_red">*</span></th>
								<td colspan="3"><input type="radio" id="radio1-1"
									name="grp_use_poa" id="grp_use_poa_1" value='Y' /> <label for="radio1-1">사용</label>
									&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="radio1-2"
									name="grp_use_poa" id="grp_use_poa_2" value="N" /> <label for="radio1-2">미사용</label></td>
							</tr>
						</tbody>
					</table>
	
					<!-- e : 여기에 내용입력 -->
	
					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveGrpCod" name="btn"><span>저장</span></a> 
						<a href="" class="btnType blue" id="btnDeleteGrpCod" name="btn"><span>삭제</span></a> 
						<a href="" class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		
		<!-- 모달2 -->
		<div id="layer2" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>상세코드 관리</strong>
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
								<th scope="row">그룹 코드 ID <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" id="dtl_grp_cod" name="dtl_grp_cod" /></td>
								<th scope="row">그룹 코드 명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" id="dtl_grp_cod_nm" name="dtl_grp_cod_nm" /></td>
							</tr>
							<tr>
								<th scope="row">상세 코드 ID <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" id="dtl_cod" name="dtl_cod" /></td>
								<th scope="row">상세 코드 명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" id="dtl_cod_nm" name="dtl_cod_nm" /></td>
							</tr>
							
							<tr>
								<th scope="row">코드 설명</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									id="dtl_cod_eplti" name="dtl_cod_eplti" /></td>
							</tr>
						
							<tr>
								<th scope="row">사용 유무 <span class="font_red">*</span></th>
								<td colspan="3"><input type="radio" id="dtl_use_poa_1"
									name="dtl_use_poa" value="Y" /> <label for="radio1-1">사용</label>
									&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="dtl_use_poa_2"
									name="dtl_use_poa" value="N" /> <label for="radio1-2">미사용</label></td>
							</tr>
						</tbody>
					</table>
	
					<!-- e : 여기에 내용입력 -->
	
					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveDtlCod" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnDeleteDtlCod" name="btn"><span>삭제</span></a>  
						<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div><!--// 모달팝업 -->
				
		
	</form>
</body>
</html>