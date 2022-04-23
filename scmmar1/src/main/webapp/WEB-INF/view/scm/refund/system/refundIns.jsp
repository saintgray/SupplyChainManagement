<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<title>반품 지시서</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<script type="text/javascript">

var pageSize = 10;
var pageBlockSize = 10;
var searchinput = '';
var datesearch1 = '';
var datesearch2 = '';
today = new Date();
today = today.toISOString().slice(0, 10);

// onload list 및 검색조건 함수 불러오기
$(function(){
	$('#serchdate2').val(today);
	init();
});

function init(currentPage){
	
	currentPage = currentPage || 1;
	
	var param = {	
			currentPage : currentPage
		,	pageSize : pageSize
		,	searchinput : searchinput
		,	datesearch1 : datesearch1
		,	datesearch2 : datesearch2
			}
	
	var resultCallback = function(data) {
		
		 // list tbody에 넣는 내용
		 $("#relist").empty().append(data);
		var total = $("#total").val();
		
		// 페이지 네비게이션 생성
		// pageBlockSize 보여지는 페이징 갯수
		var paginationHtml = getPaginationHtml(currentPage, total,  pageSize, pageBlockSize, 'init');
		console.log("paginationHtml : " + paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml ); 
	};
	
	
	
	callAjax("/scm/refundInslist.do", "post", "text", true, param, resultCallback);
}

 function search(){
	searchinput = $("#searchinput").val();
	datesearch1 = $("#serchdate1").val();
	datesearch2 = $("#serchdate2").val();
	var testdate ='';
	
	if(datesearch1 < datesearch2){
		datesearch1 = datesearch1;
		datesearch2 = datesearch2
		
		
	}else{
		testdate = datesearch2;
		datesearch2 = datesearch1;
		datesearch1 = testdate;
		
		$('#serchdate1').val(datesearch1);
		$('#serchdate2').val(datesearch2);
		
		
	}
	init();
	
} 
	
	
</script>


</head>
<body>
<form id="myForm" action=""  method="">
    <input type="hidden" name="selfrpcd" id="selfrpcd" value="">
    <input type="hidden" name="selfrpnm" id="selfrpnm" value="">
	
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">Sample</span> <span class="btn_nav bold">반품 지시서/span> 
								<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>반품 지시서</span> 
							<span class="fr">
								
							     <span style="font-size: large; font-weight: bold;">기업 고객명   </span> &nbsp;
							     <input type = "text" id="searchinput">
							     <input type = "date" id="serchdate1" name="serchdate1"> ~
							     <input type = "date" id="serchdate2" name="serchdate2">
	                              <a class="btnType blue" id="btnSearchGrpcod" name="btn" style="cursor: pointer;"><span onclick="search()" >검  색</span></a>
	                              <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn" style="cursor: pointer;"><span>초기화</span></a>
	                             
							</span>
    
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="4%">
									<col width="6%">
									<col width="6%">
									<col width="10%">
									<col width="6%">
									<col width="6%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">반품일</th>
										<th scope="col">제품명</th>
										<th scope="col">기업 고객명</th>
										<th scope="col">반품 개수</th>
										<th scope="col">반품 금액</th>
										<th scope="col">승인 여부</th>
									</tr>
								</thead>
								<tbody id="relist"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="comnGrpCodPagination"> </div>
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<div id="layer" class="layerPop layerType2" style="width: 600px;"></div>
</form>
</body>
</html>