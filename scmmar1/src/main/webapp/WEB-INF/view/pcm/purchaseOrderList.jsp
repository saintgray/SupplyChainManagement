<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>insert title here</title>

<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	//페이징 설정
	var pageSize = 5;			//페이지당 보여주는 목록 갯수
	var pageBlockSize = 5;	//페이지 번호 갯수
	
	
	/** 설명:OnLoad event : html화면이 실행되자마자 자바스크립트가 OnLoad event 이벤트를 실행시킨다.  */ 
	$(function() {
	
		// 그룹코드 조회 : OnLoad event가 실행되면서 처음에 그룹코드 조회 함수부터 실행되는 것!(여기서부터 시작)
		fPurchaseOrderList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		//a태그의 name이 btn인것을 클릭시 함수 실행
		$('a[name=btn]').click(function(e) {
			//preventDefault(): 브라우저에서 기본적으로 실행되는 이벤트에 대한 기본동작을 실행하지 않도록하는 함수.
			e.preventDefault();
			
			
			//$('a[name=btn]')이 실행된걸 꺼내와서 btnId에 저장 
			var btnId = $(this).attr('id');
	
			switch (btnId) {
			case 'btnSearch':
				fPurchaseOrderList();
				  break;
			case 'btnInitSearch':
				  fInitSearch();
				  break;
			case 'btnCloseModal':
				  gfCloseModal();
				  break;
			case 'btnDelete' :
				fDeleteDtlCod();
				break;	  
			}
		});
	}

	/** 발주내역 폼 초기화 */
	function fInitFormGrpCod(object) {
		$("#orderid").focus();
		if( object == "" || object == null || object == undefined) {
			
			$("#orderid").val("");
			$("#comp_nm").val("");
			$("#orderid_eplti").val("");
			$("#detail_name").val("");
			$("#regdate").val("");
			$("#confirmYN").val("");
			//$("#orderid").attr("readonly", false);
			//$("#grp_cod").css("background", "#FFFFFF");
			//$("#grp_cod").focus();
			//$("#btnDeleteGrpCod").hide();
			
		} else {
			
			$("#orderid").val(object.orderid);
			$("#comp_nm").val(object.comp_nm);
			$("#detail_name").val(object.detail_name);
			
			$("#regdate").val(object.regdate);
			$("#confirmYN").val(object.confirmYN);
/* 			$("input:radio[name=grp_use_poa]:input[value="+object.use_poa+"]").attr("checked", true);
			$("#grp_cod").attr("readonly", true);
			$("#grp_cod").css("background", "#F5F5F5");
		    	$("#grp_cod_nm").focus(); */
			 
		}
	}
	
	
	
	
	/**목록 조회**/
	function fPurchaseOrderList(currentPage) {
		
		//매개변수로 넘어오는 currentPage(현재페이지)가 없으면 1이된다.
		currentPage = currentPage || 1;
		
		//아이디로 값 가져오고(검색)
		var sname = $('#sname').val();
		var searchKey = $('#searchKey').val();
		//var searchKey = document.getElementById("searchKey");
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
			fPurchaseOrderListResult(data, currentPage);
		};
		
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//cmg/lectureroomList.do
		callAjax("/pcm/listPurchaseOrder.do", "post", "text", true, param, resultCallback); //resultCallback에 저장되있는 함수가 실행된다.
	}

	/** 발주목록 조회 콜백 함수 */
	function fPurchaseOrderListResult(data, currentPage) {

		//swal(data);
		console.log(data);

		// 기존 목록 삭제
		$('#listPurchaseOrder').empty();

		// 신규 목록 생성 
		$("#listPurchaseOrder").append(data);

		// 총 개수 추출
		var totalCnt = $("#listCount").val();

		//swal(totalCnt);

		
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCnt,
				pageSize, pageBlockSize, 'fPurchaseOrderList');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#pagingnavi").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage").val(currentPage);
	}	

	/** 발주내역 한건 조회*/
	function fPcmOrderOne(orderid) {
		
		var param = { orderid : orderid };
		
		var resultCallback = function(data) {
			fPcmOrderOneResult(data, currentPage);
		};
		
		callAjax("/pcm/pcmOrderOne.do", "post", "json", true, param, resultCallback);
	}
	
	/** 발주내역 한건 조회 콜백 */
	function fPcmOrderOneResult(data) {
		
		if (data.result == "SUCCESS") {
			//var uName = data.uName;			
			//var outData = data.outData;

			
			// 모달 팝업
			gfModalPop("#layer1");
			
			// 개인 취업정보 이력 조회 데이터 설정
			//$("#uName").empty().append(uName);
			//$("#outData").empty().append(outData);
			fInitFormGrpCod(data.pcmModel);
			
		} else {
			swal(data.resultMsg);
		}	
	}
	
	
</script>

</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value="1"> 
		 <!--form을 대상으로 serialize()메소드를 사용하면 폼의 객체들을 한번에 받을 수 있다.
		 ajax에 data 값을 세팅할 때 사용하면, 해당 form의 모든 값을 쉽게 받을 수 있다.
		 그럼? : 직렬화에서 myForm을 넘길 때 name이 있는 것만 넘어감? 안넘어감? (다시다시)
		 -->
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
						<!-- lnb 영역 --> 
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
						<!--// lnb 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content -->
						<div class="content">

							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
								<span class="btn_nav bold">납품업체</span>
								<span class="btn_nav bold">발주지시서목록</span> 
								<!-- <a href="${CTX_PATH}/pcm/purchaseOrder.do " class="btn_set refresh">새로고침</a> -->
								<a href="../pcm/purchaseOrder.do " class="btn_set refresh">새로고침</a>
							</p>
							
							<div id="thispagecontent">
								<!-- 이 곳에 내 코드를 작성하세요 -->
							
							<div class="purchaseOrderList_area">
							<!--검색창 부분  -->
								<table style="margin-top:10px; margin-bottom:20px;" width="100%" cellpadding="5"
									cellspacing="0" border="1" align="left"
									style="collapse; border: 1px #50bcdf;">
									<tr style="border: 0px; border-color: blue">
										<td width="40" height="25" style="font-size: 120%;">&nbsp;</td>
										<td width="*" height="25" style="font-size: 100%; text-align: center;">
											<select id="searchKey" name="searchKey" style="width: 80px;" v-model="searchKey">
												<option value="purchase_copnm">업체</option>
												<option value="purchase_modelnm">제품</option>
												<option value="purchase_accn">미승인</option>
												<option value="purchase_accy">승인</option>
											</select>
											<input type="text" style="width: 150px; height: 25px;" id="sname" name="sname"> &nbsp;&nbsp;&nbsp;
											<input type="date" id="cal1" name="cal1" /> ~ <input type="date" id="cal2" name="cal2" /> &nbsp;
											<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검색</span></a>&nbsp;
											<!-- <a href="" class="btnType blue" id="btnInitSearch" name="btn"><span>초기화</span></a></td> -->
										<td width="40" height="25" style="font-size: 120%;">&nbsp;</td>
									</tr>
								</table>
								
								
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="15%">
										<col width="*%">
										<col width="15%">
										<col width="10%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">발주번호</th>
											<th scope="col">발주회사</th>
											<th scope="col">발주제품</th>
											<th scope="col">날짜</th>
											<th scope="col">임원승인여부</th>
											<th scope="col">임금확인여부</th>
										</tr>
									</thead>
<!-- 									listPurchaseOrder -->
									<tbody id="listPurchaseOrder"></tbody>
								</table>
							</div>
							<div class="paging_area" id="pagingnavi"></div>
						
						</div>
						<h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
	<dl>
				<dt>
					<strong>발주내역 상세</strong>
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
								<th scope="row">발주 번호 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" id="dtl_grp_cod" name="dtl_grp_cod" />
								</td>
								<th scope="row">발주회사 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" id="dtl_grp_cod_nm" name="dtl_grp_cod_nm" />
								</td>
							</tr>
							<tr>
								<th scope="row">제품명 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" id="dtl_cod" name="dtl_cod" />
								</td>
								<th scope="row">제품번호 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" id="dtl_cod_nm" name="dtl_cod_nm" />
								</td>
							</tr>

							<tr>
								<th scope="row">제품수량</th>
								<td colspan="3">
									<input type="text" class="inputTxt p100" id="dtl_cod_eplti" name="dtl_cod_eplti" />
								</td>
							</tr>

						</tbody>
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