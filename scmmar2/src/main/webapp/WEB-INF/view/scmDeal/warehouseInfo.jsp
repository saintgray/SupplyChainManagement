<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>SCM시스템 | 창고별 재고 현황</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
	<script>

		var pagePostNum = 5;
		var pageBlock = 5;
		
		window.onload = function() {
			fGetList();
			fBtnEvent();
		}
		
		function fBtnEvent() {
			$("a[name=btn]").click(function(e) {
				e.preventDefault();
				
				var btnId = $(this).attr("id");
				
				switch (btnId) {
				case 'btnSearchGrpcod': fGetList();
					break;
				}
			});
		}
		
		function fGetList(currentPage) {
			// var searchKeyId = document.getElementById("searchKey");
			// var searchKeyValue = searchKey.options[searchKey.selectedIndex].value;
			currentPage = currentPage || 1;
			var searchType = $("#searchKey").val();
			var searchWord = $("#searchWord").val();
			var param = { currentPage : currentPage
						, searchType : searchType
						, searchWord : searchWord
						, pagePostNum : pagePostNum }
			var callback = function(data) { fGetListRslt(data, currentPage); }
			callAjax("/scmDeal/getWHList.do", "post", "text", true, param, callback);
		}
		
		function fGetListRslt(data, currentPage) {
			$("#listwarehouse").empty();
			$("#listwarehouse").append(data);
			var paginationHTML = getPaginationHtml(currentPage, $("#totalCount").val(), pagePostNum, pageBlock, 'fGetList');
			$("#wHListPagination").empty().append(paginationHTML);
			$("#setCurrentPage").val(currentPage); //현재페이지설정
		}
		
		function fGetListDetail(currentPage, whcode, whnm) {
			currentPage = currentPage || 1;
			
			//2페이지, 3페이지등 whcode가 안 넘어감 따라서 아래와 같이 세팅
			whcode = whcode || $("#whcode").val();
			whnm = whnm || $("#whnm").val();
						
			if(whcode != "" || whcode != null || whcode != undifined) {
				//whcode이 빈값이 아니거나 null이 아니면 hidden을 백업
				//처음 넘어올 때는 그 값을 가지고 세팅
				$("#whcode").val(whcode);
				$("#whnm").val(whnm);
			}
			
			var param = { currentPage : currentPage
						, whcode : whcode
						, pagePostNum : pagePostNum }
			var callback = function(data) { fGetListDetailRslt(data, currentPage) }
			callAjax("/scmDeal/getWHdetail.do", "post", "text", true, param, callback);
		}
		
		function fGetListDetailRslt(data, currentPage) {
			console.log("currentPage : " + currentPage);
			$("#listComnDtlCod").empty(); 
			$("#listComnDtlCod").append(data);
			//console.log(data.detailTotal); 이 형태는 json형태로 text형태에서 받을 수 없다
			var paginationDetailHTML = getPaginationHtml(currentPage, $("#detailTotal").val(), pagePostNum, pageBlock, 'fGetListDetail');
			$("#comnDtlCodPagination").empty().append(paginationDetailHTML);
			$("#setCurrentPage").val(currentPage); //현재페이지 설정
		}
		
	</script>
</head>
<body>
<form id="myForm" action="" method="">
<input id="setCurrentPage" type="hidden" value="1" />
<input id="whcode" type="hidden" name="whcode" value="" />
<input id="whnm" type="hidden" name="whnm" value="" />

	<div id="wrap_area">	
		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
		
		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
				</li>
				<li class="contents">
					<h3 class="hidden">contents 영역</h3>
					<div class="content">
					
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">거래정보</span> 
							<span class="btn_nav bold">창고별 재고 현황</span>
							<a href="../scmDeal/whInventoryForm.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle">
							<span>창고 현황</span>
						</p>
						
						<table style="margin-top: 10px; margin-bottom: 20px;" 
							   width="100%" 
							   cellpadding="5" 
							   cellspacing="0" 
							   border="1"
                      		   align="left"
                       		   style="collapse; border: 1px #50bcdf;">
	                        <tr style="border: 0px; border-color: blue">
	                        	<td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
	                        	<td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
		                        	<select id="searchKey" name="searchKey" style="width: 150px;">
										<option value="whnm" >창고명</option>
										<option value="pdno" >제품명</option>
									</select>
	     	                      	<input type="text" style="width: 300px; height: 25px;" id="searchWord" name="searchWord" value="">                    
		                          	<a href="" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
	                        	</td>
	                        </tr>
                    	</table>
						
						<div class="divComDtlCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
								</colgroup>
									
								<thead>
									<tr>
										<th scope="col">창고번호</th>
										<th scope="col">창고명</th>
										<th scope="col">창고주소</th>
										<th scope="col">상세주소</th>
										<th scope="col">우편번호</th>
										<th scope="col">보유제품</th>
										<th scope="col">총물품보유량</th>
									</tr>
								</thead>
								<tbody id="listwarehouse">
									<!-- warehouseData.jsp -->
								</tbody>
							</table>
						</div><!-- // table div -->
						<div class="paging_area" id="wHListPagination"></div>
						
						<p class="conTitle mt50">
							<span>입·출고 내역</span>
						</p>
						
						<div class="divComDtlCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">창고번호</th>
										<th scope="col">제품번호</th>
										<th scope="col">제품명</th>
										<th scope="col">입고량</th>
										<th scope="col">입고일시</th>
										<th scope="col">출고량</th>
										<th scope="col">출고일시</th>
									</tr>
								</thead>
								<tbody id="listComnDtlCod">
									<tr>
										<td colspan="7">창고를 선택해주세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="paging_area"  id="comnDtlCodPagination"> </div>
						
					</div><!--// .content -->
					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li><!--// .contents -->
			</ul><!--// ul -->
		</div><!--// #container -->
	
	</div><!--// #wrap_area -->
</form>
</body>
</html>