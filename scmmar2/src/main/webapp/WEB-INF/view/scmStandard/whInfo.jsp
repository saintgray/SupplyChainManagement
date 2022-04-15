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
<title>Job Korea :: 창고 정보 관리</title>

<!-- 다음 주소api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- sweet alert import -->
<script src='/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="/js/popFindZipCode.js"></script>
<!-- sweet swal import -->


<script type="text/javascript">


	// 창고정보 페이징 설정
	var pageSizeWarehouseInfo = 5;
	var pageBlockSizeWarehouseInfo = 5;
	
	
	
	/** OnLoad event */ 
	$(function() {
		
		// 창고정보 조회
		fListWarehouseInfo();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				
				case 'btnSaveWarehouseInfo':
					fSaveWarehouseInfo();
					break;
					
				case 'btnListWarehouseInfo':
					fListWarehouseInfo();
					break;
					
				case 'btnDeleteWarehouseInfo' :
					fDeleteWarehouseInfo();
					break;
					
				case 'btnCloseWarehouseInfo' :
					gfCloseModal();
					break;
					
				case 'btnSearchPost' :
					popFindZipCode();
					break;
				
			}
		});
	}
	
	
	/** 창고정보 폼 초기화 */
	function fInitFormWarehouseInfo(object) {
		$("#whcode").focus();
		if( object == "" || object == null || object == undefined) {
			$("#whcode").val("");
			$("#whnm").val("");
			$("#mgrnm").val("");
			$("#email").val("");
			$("#phone").val("");
			$("#whzip").val("");
			$("#whplace").val("");
			$("#whaddr").val("");
			$("#btnDeleteWarehouseInfo").hide();
			comcombo('B', 'mgrnm', 'sel', null, '${CTX_PATH}/scmStandard/mgrnmList.do');
			
			$('#whzip').css({"background-color":"white"});
            $('#whplace').css({"background-color":"white"});
		} else {
			$("#whcode").val(object.whcode);
			$("#whnm").val(object.whnm);
// 			$("#mgrnm").val(object.mgrnm);			
			$("#email").val(object.email);
			$("#phone").val(object.phone);
			$("#whzip").val(object.whzip);
			$("#whplace").val(object.whplace);
			$("#whaddr").val(object.whaddr);
			
			comcombo('B', 'mgrnm', 'sel', object.mgrnm, '${CTX_PATH}/scmStandard/mgrnmList.do');
			
			$('#whzip').css({"background-color":"lightgrey"});
            $('#whplace').css({"background-color":"lightgrey"});
			
// 			console.log($('#mgrnm option'));
			$("#btnDeleteWarehouseInfo").show();
			
		}
		
	}
	
	/** 창고정보 저장 validation */
	function fValidateWarehouseInfo() {

		var chk = checkNotEmpty(
				[
						[ "whcode", "창고코드를 입력해 주세요." ]
					,	[ "whnm", "창고명을 입력해 주세요" ]
					,	[ "mgrnm", "담당자를 입력해 주세요." ]
					,	[ "whzip", "우편번호를 입력해 주세요." ]
					,	[ "whplace", "주소를 입력해 주세요." ]
					,	[ "whaddr", "상세주소를 입력해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	/** 창고정보 모달 실행 */
	function fPopModalWarehouseInfo(whcode) {
		
		
		// 신규 저장
		if (whcode == null || whcode=="") {
			//swal("여기도 찍어봅세  ");
			// Tranjection type 설정
			$("#action").val("I");
			$("#popTitle").html("<strong>창고등록</strong>");
			
			// 창고정보 폼 초기화
			fInitFormWarehouseInfo();
			
			// 모달 팝업
			gfModalPop("#layer1");

		// 수정 저장
		} else {
			
			// Tranjection type 설정
			$("#action").val("U");
			$("#popTitle").html("<strong>창고정보수정</strong>");
			
			// 창고정보 단건 조회
			fSelectWarehouseInfo(whcode);
		}
		console.log('whzipValue :: '+document.getElementById('whzip').value);
		
// 		if($('#whzip').val() == null || $('#whzip').val() == ""){
// 			document.getElementById('whzip').style.backgroundColor = 'white';
// 		   	document.getElementById('whplace').style.backgroundColor = 'white';			
// 		}else{
// 			document.getElementById('whzip').style.backgroundColor = 'lightgrey';
// 	    	document.getElementById('whplace').style.backgroundColor = 'lightgrey';	
// 		}
	}
	
	

	
	
	/** 창고정보 조회 */
	function fListWarehouseInfo(currentPage) {
		
		currentPage = currentPage || 1;
		
		var sname = $('#sname').val();
		
		var oname = $('#searchKey').val();
		var uname = $('#workSearch').val();

		console.log("currentPage : " + currentPage);
		
		
		var param = {	
				sname : sname
			,	oname : oname
			,	uname : uname
			,	currentPage : currentPage
			,	pageSize : pageSizeWarehouseInfo
		}
		
		var resultCallback = function(data) {
			flistWarehouseInfoResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/scmStandard/listWarehouseInfo.do", "post", "text", true, param, resultCallback);
	}
	
	/** 창고정보 조회 콜백 함수 */
	function flistWarehouseInfoResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listWarehouseInfo').empty();
		
		// 신규 목록 생성
		$("#listWarehouseInfo").append(data);
		
		// 총 개수 추출
		
		var totalCntWarehouseInfo = $("#totalCntWarehouseInfo").val();
		
				
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntWarehouseInfo, pageSizeWarehouseInfo, pageBlockSizeWarehouseInfo, 'fListWarehouseInfo');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#warehouseInfoPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageWarehouseInfo").val(currentPage);
	}
	
	/** 창고정보 단건 조회 */
	function fSelectWarehouseInfo(whcode) {
		
		var param = { whcode : whcode };
		
		var resultCallback = function(data) {
			fSelectWarehouseInfoResult(data);
			
		};
		
		callAjax("/scmStandard/selectWarehouseInfo.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 창고정보 단건 조회 콜백 함수*/
	function fSelectWarehouseInfoResult(data) {

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");
			
			// 창고정보 폼 데이터 설정
			fInitFormWarehouseInfo(data.warehouseInfoModel);
			
		} else {
			swal(data.resultMsg);
		}	
	}
	
	
	/** 창고정보 저장 */
	function fSaveWarehouseInfo() {

		// vaildation 체크
		if ( ! fValidateWarehouseInfo() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fSaveWarehouseInfoResult(data);
		};
		
		callAjax("/scmStandard/saveWarehouseInfo.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
	}
	
	
	/** 창고정보 저장 콜백 함수 */
	function fSaveWarehouseInfoResult(data) {
		
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageWarehouseInfo").val();
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 목록 조회
			fListWarehouseInfo(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
		
		// 입력폼 초기화
		fInitFormWarehouseInfo();
	}
	
	
	/** 창고정보 삭제 */
	function fDeleteWarehouseInfo() {
		
		swal("정말 삭제하겠습니까? \n삭제시 복구불가합니다.", {
			  buttons:{
				  yes : "예",
				  no : "아니오"
			  }
			}).then((value) => {  /* 이건 이클립스가 게을러서 뜨는 에러!  */
				switch(value){
				case "yes":
					
					var resultCallback = function(data) {
					fDeleteWarehouseInfoResult(data);
					};
				
					callAjax("/scmStandard/deleteWarehouseInfo.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
				
					break;
				case "no": 
					break;
				}
			});
		
		
	}
	
	
	/** 창고정보 삭제 콜백 함수 */
	function fDeleteWarehouseInfoResult(data) {
		
		var currentPage = $("#currentPageWarehouseInfo").val();
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 창고정보 목록 조회
			fListWarehouseInfo(currentPage);
			
		} else {
			swal(data.resultMsg);
		}	
	}
	
</script>

</head>
<body>

<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageWarehouseInfo" value="1">
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
							<span class="btn_nav bold">창고 정보 관리</span>
							<a href="../scmStandard/warehouseInfo.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>창고 정보 관리</span>							
						</p>
						
						<table style="margin: 10px" width="100%" cellpadding="5" cellspacing="0" border="1" 
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                      <select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
									<option value="whnm" >창고명</option>
									<option value="whplace" >창고 위치</option>
								</select> 
								
	    	                   <input type="text" style="width: 300px; height: 25px;" id="sname" name="sname" onkeypress="if( event.keyCode == 13 ){fListWarehouseInfo();}">                    
	                           <a href="" class="btnType blue" id="btnListWarehouseInfo" name="btn" ><span>검  색</span></a>
                           </td> 
                        </tr>
                     	</table> 
						<div class="divWarehouseInfoList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
									<col width="30%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">창고코드</th>
										<th scope="col">창고명</th>
										<th scope="col">담당자</th>
										<th scope="col">이메일</th>
										<th scope="col">전화번호</th>
										<th scope="col">우편번호</th>
										<th scope="col">창고위치</th>
									</tr>
								</thead>
								<tbody id="listWarehouseInfo"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="warehouseInfoPagination"> </div>
						
						<span class="fr">
						<a style="margin-top: 10px" class="btnType blue"  href="javascript:fPopModalWarehouseInfo();" name="modal"><span>창고등록</span></a>
						
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
				<strong>창고등록</strong>
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
							<th scope="row">창고코드</th>
							<td ><input type="text" class="inputTxt p100" name="whcode" id="whcode" /></td>
						</tr>	
						<tr>		
							<th scope="row">창고명</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="whnm" id="whnm" /></td>
						</tr>
						<tr >		
							<th scope="row">담당자</th>
							<td>
								<select name="mgrnm" id="mgrnm"></select>
							</td>
						</tr>
						<tr>
							<th scope="row">우편번호</th>
							<td ><input type="text" class="inputTxt p100" name="whzip" id="whzip" style="" readonly/></td>
							<td><a href="" class="btnType blue" id="btnSearchPost" name="btn" ><span>주소검색</span></a></td> 
						</tr>
						
						<tr>
							<th scope="row">창고주소</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="whplace" id="whplace" style="" readonly/></td>
						</tr>
						
						<tr>
							<th scope="row">상세주소</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="whaddr" id="whaddr" /></td>
						</tr>					
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveWarehouseInfo" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteWarehouseInfo" name="btn"><span>삭제</span></a>
					<a href=""	class="btnType gray"  id="btnCloseWarehouseInfo" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	
</form>


</body>
</html>