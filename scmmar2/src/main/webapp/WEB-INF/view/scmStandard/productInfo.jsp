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
<title>Job Korea :: 제품 정보 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

// 제품 정보 페이징 설정
var pageSizeProductCod = 5;
var pageBlockSizeProductCod = 5;

/** OnLoad event */ 
$(function() {
	
	comcombo("proCD", "pdcodebox", "sel");
	
	// 제품 정보 목록 조회
	fListProductCod();
	
	// 버튼 이벤트 등록
	fRegisterButtonClickEvent();
});


// 버튼 이벤트 함수
function fRegisterButtonClickEvent() {
	$('a[name=btn]').click(function(e) {
		e.preventDefault();

		var btnId = $(this).attr('id');

		switch (btnId) {
			case 'insertPDCod' :
				fSavePDCod();
				break;
			case 'deletePDCod' :
				fDeleteProductCod();
				break;
			case 'btnSearchPDcod':
				product_search();
				break;
			case 'btnCloseCod' :
				$("#pdno").val("");
				gfCloseModal();
				break;
		}
	});
}

// 검색 기능
function product_search(currentPage) {
    
	currentPage = currentPage || 1;
	
	var searchword = $('#searchword').val();
	var searchKey = $('#searchKey').val();
	
	var param = {
				searchword : searchword
			,	searchKey : searchKey
			,	currentPage : currentPage
			,	pageSize : pageSizeProductCod
	}

    var resultCallback = function(data) {
    	fListProductCodResult(data, currentPage); 
    };
    
    callAjax("/scmStandard/productInfolist.do", "post", "text", true, param, resultCallback);
} 

// 제품 정보 목록 조회
function fListProductCod(currentPage) {
	
	currentPage = currentPage || 1;
	
	var searchword = $('#searchword').val();
	var searchKey = $('#searchKey').val();
	
	var param = {
				searchword : searchword
			,	searchKey : searchKey
			,	currentPage : currentPage
			,	pageSize : pageSizeProductCod
	}
	
	var resultCallback = function(data) {
		fListProductCodResult(data, currentPage);
	};
	
	//Ajax실행 방식
	//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
	callAjax("/scmStandard/productInfolist.do", "post", "text", true, param, resultCallback);
}


// 제품 정보 목록 조회 콜백
function fListProductCodResult(data, currentPage) {
	
	// 기존 목록 삭제
	$('#listProductCod').empty();
	
	// 신규 목록 생성
	$("#listProductCod").append(data);
	
	// 총 개수 추출
	var totalProductCod = $("#totalProductCod").val();
	
	// 페이지 네비게이션 생성
	var paginationHtml = getPaginationHtml(currentPage, totalProductCod, pageSizeProductCod, pageBlockSizeProductCod, 'fListProductCod');

	$("#productCodPagination").empty().append( paginationHtml );
	
	// 현재 페이지 설정
	$("#currentPagePDCod").val(currentPage);
}


// 제품 정보 단건 조회
function fListProductDtCod(pdno) {
	
	var param = { 
			pdno : pdno
				};
	
	var resultCallback = function(data) {
		fListProductDtCodResult(data);
	};
	
	callAjax("/scmStandard/selectProductCod.do", "post", "json", true, param, resultCallback);
}


//제품 정보 단건 조회 콜백 함수
function fListProductDtCodResult(data) {
	
	if (data.result == "SUCCESS") {

		gfModalPop("#layer123");
		
		// 폼 데이터 설정
		fInitFormPdCod(data.productCodModel, data.selectFile);
		
	} else {
		swal(data.resultMsg);
	}	
}

// 제품 모달 초기화 및 데이터 뿌리기
function fInitFormPdCod(object, file) {
	
	if (object == "" || object == null || object == undefined) {
		
		$("#pdcodebox").show();
		$("#pdmdnobox").hide();
		$("#compbox").hide();
		
		$("#deletePDCod").hide();
		$("#filedowndiv").hide();
	 	
		$('#pdcodebox').val("all_ct");
		$('input[name=pdmdno], input[name=pdmdnm], input[name=pdmdcop], input[name=pdnm], input[name=pdmdprice], textarea[name=pdinfo]').val("");
		
	 	$("#f-photo-image").attr('src', "");
	 	$("#filedown").empty();
	 	
	 	$("#pdno").val("");
		
	} else {
		
		$("#pdcodebox").show();
		$("#pdmdnobox").show();
		$("#pdmdcop").show();
		
		$("#insertPDCod").show();
		$("#deletePDCod").show();
		
		if (file == "" || file == null || file == undefined) {
			$("#filedowndiv").hide();
		} else {
			$("#filedowndiv").show();
			$("#f-photo-image").attr('src', file.file_server_path);
			
			if (file != "NOT") {			          
				$("#filedown").empty().append("<a href='javascript:filedown("+ object.pdno + ")'>" + file.file_ofname + "</a>");				                                 
			}
		}

		$("#pdno").val(object.pdno);
		$('#pdcodebox').val(object.pdcode);
		$('#pdmdnobox').val(object.pdmdno);
		$('#pdmdcop').val(object.pdmdcop);
		$('#pdmdno').val(object.pdmdno);
		
		$('input[name=pdno]').attr('value', object.pdno);
		$('input[name=pdmdnm]').attr('value', object.pdmdnm);
		$('input[name=pdnm02]').attr('value', object.pdnm);
		$('input[name=pdmdprice]').attr('value', object.pdmdprice);
		$('textarea[name=pdinfo]').val(object.pdinfo);
		$('input[name=action]').attr('value', "U");
		
	}
}

//첨부파일 다운로드
function filedown(pdno){
 	 	var params = "";
		params += "<input type='hidden' name='pdno' value='"+ pdno +"' />"; 	
		jQuery("<form action='/scmStandard/fileDownload.do' method='post'>"+params+"</form>").appendTo('body').submit().remove(); 			
}

// 신규 등록 모달 또는 수정 모달
function fPopModalProductCod(pdno) {
	
	// 신규
	if (pdno == null || pdno == "") {
		$("#action").val("I");
		
		// 폼 초기화
		fInitFormPdCod();
		$("#photo").attr("src","https://dummyimage.com/200x200/ffffff/000000.png&text=preview");
		gfModalPop("#layer2");

	// 수정
	} else {
		
		$("#action").val("U");
		
		// 제품 정보 단건 조회
		fListProductDtCod(pdno);
	}
}

// 제품 신규 등록
function fSavePDCod() {
	
	// validation check
	/* if (!fValidatePDCod()) {
		return;
	} */
	
	var resultCallback = function(data) {
		fSavePDCodResult(data);
	};
	
	if ($("#action").val() == "I") {
		$("#action").val("I"); // insert
	} else if ($("#action").val() == "U") {
		$("#action").val("U"); // update
	}
	var frm = document.getElementById("myForm");
	var dataWithFile = new FormData(frm);
	
	callAjaxFileUploadSetFormData("/scmStandard/saveProductCod.do", "post", "json", true, dataWithFile, resultCallback);
}

// 제품 신규 등록 콜백 함수
function fSavePDCodResult(data) {
	
	// 목록 조회 페이지 번호
	var currentPage = "1";
	
	if ($("#action").val() != "I") {
		currentPage = $("#currentPagePDCod").val();
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
	fListProductCod(currentPage);
	
	// 폼 초기화
	fInitFormPdCod();
}

// validation check
function fValidatePDCod() {
	
	var chk = checkNotEmpty(
			[
				[ "pdmdcop", "제조사를 입력해 주세요" ]
			,	[ "pdnm02", "제품명을 입력해 주세요." ]
			]
	);
	
	if (!chk) {
		return;
	}

	return true;
}

// 제품 정보 삭제
function fDeleteProductCod() {
	
	swal("정말 삭제하겠습니까? \n삭제 시 복구가 불가능합니다.", {
		  buttons:{
			  yes : "예",
			  no : "아니오"
		  }
		}).then((value) => {  /* 이건 이클립스가 게을러서 뜨는 에러!  */
			switch(value){
			case "yes":
				
				var resultCallback = function(data) {
				fDeleteProductCodResult(data);
				};
			
				callAjax("/scmStandard/deleteProductCod.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
			
				break;
			case "no": 
				break;
			}
		});
}

// 제품 삭제 콜백
function fDeleteProductCodResult(data) {
	
	var currentPage = $("#currentPagePDCod").val();
	
	if (data.result == "SUCCESS") {
		
		// 응답 메시지 출력
		swal(data.resultMsg);
		
		// 모달 닫기
		gfCloseModal();
		
		// 제품 정보 목록 조회
		fListProductCod(currentPage);
		
	} else {
		swal(data.resultMsg);
	}	
	
	$("#pdno").val("");
	
}

// 제품 카테고리 콤보박스
 function selectpdcd() {
	
	var combopdct = $("#pdcodebox").val();
	
	if (combopdct != null || combopdct != '') {
		$("#pdmdnobox").show();
		comcombo("modelCD", "pdmdnobox", "sel");
	} else {
		$("#pdmdnobox").hide();
	}
	
}

//제품 모델 콤보박스
function selectmdcd() {
	
	var combosel = $("#pdmdnobox").val();
	var modelinput = $("#pdmdno").val();
	
	if(combosel != "all_md" && combosel != null || combosel != '') {
		$('input[name=pdmdno]').prop('readonly', true);
		$('input[name=pdmdno]').val(combosel, true);
		$("#compbox").show();
		selectComCombo("cli", "compbox", "sel");
		
	} else if(combosel == "all_md") {
		$('input[name=pdmdno]').prop('readonly', false);
		$("#pdmdnobox").attr('value', modelinput);
		$("#compbox").hide();
	}
}

</script>

</head>
<body>
<form id="myForm" action=""  method="" enctype="multipart/form-data">
	<input type="hidden" id="currentPagePDCod" value="1">
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
							<span class="btn_nav bold">제품 정보</span> <span class="btn_nav bold">제품 정보 관리</span>
							<a href="../scmStandard/productInfo.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>제품 정보 관리</span> <span class="fr"> 
							<a class="btnType blue" href="javascript:fPopModalProductCod();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
						
					<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1" align="left">
						<tr style="border: 0px; border-color: blue">
							<td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
							<td width="50" height="25" style="font-size: 100%; text-align:left; padding-bottom:20px;">
							<select id="searchKey" name="searchKey" style="width: 150px;">
								<option value="all_pd" >전체</option>
								<option value="pd_nm" >제품명</option>
								<option value="pd_mdnm" >모델명</option>
								<option value="pd_mdcop" >제조사</option>
							</select> 
							<input type="text" style="width: 300px; height: 25px;" id="searchword" name="searchword">                    
							<a href="" class="btnType blue" id="btnSearchPDcod" name="btn"><span>검  색</span></a>
						  </td>
						</tr>
                     </table>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="16%">
									<col width="20%">
									<col width="15%">
									<col width="20%">
									<col width="10%">
									<col width="8%">
									<col width="6%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">모델 번호</th>
										<th scope="col">모델명</th>
										<th scope="col">제품 번호</th>
										<th scope="col">제품명</th>
										<th scope="col">제조사</th>
										<th scope="col">판매가</th>
										<th scope="col"></th>
									</tr>
								</thead>
								<tbody id="listProductCod"></tbody>
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
		<div id="layer123" class="layerPop layerType2" style="width: 800px; background-color: white;">
			<jsp:include page="/WEB-INF/view/scmStandard/productPopUp.jsp"></jsp:include>
	  	</div>
	  	<div id="layer2" class="layerPop layerType2" style="width: 800px; background-color: white;">
			<jsp:include page="/WEB-INF/view/scmStandard/productInsertPopUp.jsp"></jsp:include>
	  	</div>
	</div>
	
</form>
</body>
</html>