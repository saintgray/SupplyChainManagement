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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Job Korea :: 배송 지시서</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	// 페이징 설정
	var pageSizeDelivery = 5;
	var pageBlockSizeDelivery = 5;
	
	
	/** OnLoad event */ 
	$(function() {
	
		// 목록 조회
		fListDelivery();
		
	});

	
	/** 모달 실행 */
	
	function fPopModalDelivery(orderSeq) {
		
		gfModalPop("#layer1");
		fSelectDelivery(orderSeq);

	}
	
	
	/** 목록 조회 */
	function fListDelivery(currentPage) {
		
		currentPage = currentPage || 1;
		console.log("currentPage : " + currentPage);
		
		var param = {	
					currentPage : currentPage
				,	pageSize : pageSizeDelivery
		}
		
		var resultCallback = function(data) {
			fListDeliveryResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/scmTask/listDelivery.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 조회 콜백 함수 */
	function fListDeliveryResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listDelivery').empty();
		
		// 신규 목록 생성
		$("#listDelivery").append(data);
		
		// 총 개수 추출
		var totalCntDelivery = $("#totalCntDelivery").val();
		console.log("totalCntDelivery : " + totalCntDelivery);
		
		//swal(totalCntDelivery);
		
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntDelivery, pageSizeDelivery, pageBlockSizeDelivery, 'fListDelivery');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#deliveryPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageDelivery").val(currentPage);
	}
	
	
	/** 상세 단건 조회 */
	function fSelectDelivery(orderSeq) {

		var param = {
					orderSeq : orderSeq
		};
		
		var resultCallback = function(data) {
			fSelectDeliveryResult(data);
		};
		
		callAjax("/scmTask/selectDelivery.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 상세 단건 조회 콜백 함수*/
	function fSelectDeliveryResult(data) {

		console.log(data);
		
		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");
			
			$("#orderSeq").html(data.deliveryModel["orderSeq"]);
			$("#orderDate").html(data.deliveryModel["orderDate"]);
			$("#client").html(data.deliveryModel["client"]);
			$("#product").html(data.deliveryModel["product"]);
			$("#orderCnt").html(data.deliveryModel["orderCnt"]);
			$("#name").html(data.deliveryModel["name"]);
			$("#payyn").html(data.deliveryModel["payyn"]);

		} else {
			swal(data.resultMsg);
		}	
	}
	
</script>	
</head>

<body>

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
								class="btn_nav bold">작업지시서</span> <span class="btn_nav bold">배송 지시서</span> <a href="../scmTask/shippingDirection.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>배송 지시서</span>
						</p>
						
						<div class="divDeliveryList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="30%">
									<col width="30%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">주문 번호</th>
										<th scope="col">주문일자</th>
										<th scope="col">고객기업명</th>
										<th scope="col">주문개수</th>
									</tr>
								</thead>
								<tbody id="listDelivery"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="deliveryPagination"> </div>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
				
			</ul>
		</div>
	</div>

<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 700px;">
		<dl>
			<dt style="font-family: 맑은고딕;">
				<strong>상세 페이지</strong>
			</dt>
			<dd class="content">
				<b>(주문번호 : <span id="orderSeq"></span>) 주문건입니다</b><br />
				<!-- s : 여기에 내용입력 -->
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="20%">
						<col width="20%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
					</colgroup>

					<thead>
						<tr>
							<th scope="col">주문일자</th>
							<th scope="col">고객기업명</th>
							<th scope="col">제품명</th>
							<th scope="col">주문개수</th>
							<th scope="col">배송담당자</th>
							<th scope="col">입금여부</th>
						</tr>
					</thead>
					
					<tbody id="selectDelivery">
						<tr>
							<td id="orderDate"></td>
							<td id="client"></td>
							<td id="product"></td>
							<td id="orderCnt"></td>
							<td id="name"></td>
							<td id="payyn"></td>
						</tr>
					</tbody>
				</table>
				<!-- e : 여기에 내용입력 -->

			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

</body>
</html>