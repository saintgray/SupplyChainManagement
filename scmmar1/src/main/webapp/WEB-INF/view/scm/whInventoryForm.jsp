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

<title>창고별 재고 현황</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<script type="text/javascript">
var searchgrouptype = '';
var searchtext = '';
var pageSize = 10;
var pageBlockSize = 10;

// onload list 및 검색조건 함수 불러오기
$(function(){
	
	init();
	
});

function init(currentPage){
	currentPage = currentPage || 1;
	var param = {
			searchgrouptype : searchgrouptype
		,	searchtext : searchtext
		,	currentPage : currentPage
		,	pageSize : pageSize
			};
	var resultCallback = function(data) {
		$("#whlist").empty().append(data);
		var total = $("#total").val();
		// 페이지 네비게이션 생성
		// pageBlockSize 보여지는 페이징 갯수
		 var paginationHtml = getPaginationHtml(currentPage, total,  pageSize, pageBlockSize, 'init');
		console.log("paginationHtml : " + paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml ); 
	};
	
	callAjax("/scm/whInventoryFormlist.do", "post", "text", true, param, resultCallback);
}

function search(){
	searchgrouptype = $("#searchgrouptype").val();
	searchtext = $("#searchtext").val();
	init();
}
	
function test(a,b,c){
	//alert(a);
	//alert(b);
	//$("#sales_id").val(b);	// 제품 번호
	//$("#sales_nm").val(c);	// 제품명
	
	var param = {
			wh_id : a
		,	sales_id : b
			};
	var resultCallback = function(data) {
		//console.log(data.cnt.sales_id);
		
		if(data.cnt == null){
			alert(data.msg);
		}else{
			
			$("#sales_id").val(data.cnt.sales_id);
			$("#sales_nm").val(data.cnt.sales_nm);
			$("#insal").val(data.cnt.in_cnt);
			$("#outsal").val(data.cnt.out_cnt); 
			
			gfModalPop("#layer1");
		}
		
	};
	
	
	
	callAjax("/scm/lay1.do", "post", "json", true, param, resultCallback);
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
								class="btn_nav bold">Sample</span> <span class="btn_nav bold">창고별 재고 현황</span> 
								<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>창고별 재고 현황</span> 
							<span class="fr">
							     <select id="searchgrouptype"  name="searchgrouptype" style="width: 150px;">
							            <option value="" >전체</option>
							    		<option value="0" >창고 명</option>
							    		<option value="1" >제품 명</option>
							     </select> 
							     <input type="text" id="searchtext">
	                              <a class="btnType blue" id="btnSearchGrpcod" name="btn" style="cursor: pointer;"><span onclick="search()" >검  색</span></a>
	                              <a href= ""class="btnType blue" id="btnSearchGrpcod" name="btn" style="cursor: pointer;"><span >초기화</span></a>
	                             
							</span>
    
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="8%">
									<col width="14%">
									<col width="8%">
									<col width="23%">
									<col width="8%">
									<col width="14%">
									<col width="23%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">창고 코드</th>
										<th scope="col">창고명</th>
										<th scope="col">제품 번호</th>
										<th scope="col">제품명</th>
										<th scope="col">재고 수량</th>
										<th scope="col">지역</th>
										<th scope="col">상세 위치</th>
									</tr>
								</thead>
								<tbody id="whlist"></tbody>
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

<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 800px;">

		<dl>
			<dt>
				<strong>제고 입/출 내역</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					
					<tbody>
						<tr>
							<th >제품 번호</th>
							<th >제품 명</th>
							<th >입고 량</th>
							<th >출고 량</th>
						</tr>
						<tr>
							<td><input type="text" id="sales_id" readonly="readonly" style="text-align: center; border: none;"></td>
							<td><input type="text" id="sales_nm" readonly="readonly" style="text-align: center; border: none;"></td>
							<td><input type="text" id="insal" readonly="readonly" style="text-align: center; border: none;"></td>
							<td><input type="text" id="outsal" readonly="readonly" style="text-align: center; border: none;"></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span >취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	
</form>
</body>
</html>