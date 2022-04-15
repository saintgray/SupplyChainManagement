<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>제품 목록</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<style>
	input[name=hopedate].datetype{
 	  padding:4px 2px 5px 25px;
 	  width:95px; 
 	  border:1px solid #CACACA;
      font-size:11px;
      color:#666; 
      background:url('http://cfile23.uf.tistory.com/image/26100D4F5864C76827F535') no-repeat 2px 2px; 
      background-size:15px
    }   

</style>
<script type="text/javascript">

	//제품 리스트 페이징 설정
	var pageSizeProList = 5;
	var pageBlockSizeProList = 5;

	$(function(){
		
		//제품 리스트 조회
		fProductList();
		
		//콤보박스 리스트 생성
		fCategoryBoxList();
		
		//버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		//datePicker
		fDatePicker();
		
		//제조사 리스트 생성
		$("#category").change(function(){
			
			var category = $("#category").val();
			$("#pdmdcop").find("option").remove();
			
			$.ajax({
				url:"/crt/pdmdcopBoxList.do",
				type:"post",
				data:{category:category},
				dataType:"json",
				success:function(data){
					$("#pdmdcop").append("<option value=''>제조사 선택</option>");
					$("#pdmdcop").append("<option value=''>전체</option>");
					for(var i=0;i<data.length;i++){
							$("#pdmdcop").append("<option value='"+data[i].pdmdcop+"'>"+data[i].pdmdcop+"</option>");
							}
					}
			});	
			
			
		});
		
		
	});
	
	//버튼 이벤트 함수
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearchProduct':
					fProductList();
					break;
				case 'btnSaveCart':
					fInputProduct("C");
					break;
				case 'btnOrder':
					fInputProduct("O");
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
	}
	
	//제품리스트 조회
	function fProductList(currentPage){
		
		currentPage = currentPage || 1;
		
		var category = $("#category").val();
		var pdmdcop = $("#pdmdcop").val();
	
		var param = {
			category:category,
			pdmdcop:pdmdcop,
			currentPage : currentPage,
			pageSize : pageSizeProList
		}
		
		//제품리스트 콜백
		var resultCallback = function(data){
			fproductListResult(data,currentPage);
		};
		
		callAjax("/crt/listProduct.do","post","text",true,param,resultCallback);
		
	}
	
	//제품리스트 조회 콜백 함수
	function fproductListResult(data,currentPage){
		
		//기존 목록 초기화
		$("#listproduct").empty();
		
		//신규 목록 생성
		$("#listproduct").append(data);
		
		//총 개수 추출
		var totalCntProduct = $("#totalCntProduct").val();
		
	// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntProduct, pageSizeProList, pageBlockSizeProList, 'fProductList');
		console.log("paginationHtml : " + paginationHtml);
		$("#listproductPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#listproductPagination").val(currentPage);
		
	}
	
	//카테고리 콤보박스 리스트 생성
	function fCategoryBoxList(){
		
		$("#category").find("option").remove();
		$("#pdmdcop").find("option").remove();
		
		$.ajax({
			url:"/crt/categoryBoxList.do",
			type:"post",
			dataType:"json",
			success:function(data){
				$("#category").append("<option value=''>장비구분 선택</option>");
				$("#category").append("<option value=''>전체</option>");
			
				for(var i=0;i<data.length;i++){
					if( i == 0){
						$("#category").append("<option value='"+data[i].pdcodenm+"'>"+data[i].pdcodenm+"</option>");
					}else{
						for(var j=i-1;j<i;j++){
							if(data[i].pdcodenm != data[j].pdcodenm){
								$("#category").append("<option value='"+data[i].pdcodenm+"'>"+data[i].pdcodenm+"</option>");
							}
						}
					}
				}
			}
		});		
	}
	
	//제품 상세정보 팝업
	function fPopProductDtl(pdno){
		
		var param = {pdno:pdno}
		
		var resultCallback = function(data){
			fSelectProductResult(data);
		}
		
		callAjax("/crt/selectProductOne.do", "post", "json", true, param, resultCallback);
	}
	
	//제품 상세정보 콜백 함수
	
	function fSelectProductResult(data) {
		if (data.result == "SUCCESS") {
			
			// 모달 팝업
			gfModalPop("#layer1");
			
			// 그룹코드 폼 데이터 설정
			fInitFormProductDtl(data.crtOrderModel);
			
		} else {
			swal(data.resultMsg);
		}	
	}
	
	//제품 상세정보 폼 
	function fInitFormProductDtl(object) {
		
		
		if( object == "" || object == null || object == undefined){
			$("#pd_code").val("");
			$("#pd_codenm").val("");
			$("#pd_mdno").val("");
			$("#pd_mdcop").val("");
			$("#pd_mdprice").val("");
			$("#pd_info").val("");
			$("#pd_no").val("");
			
			$("#pdcodeSpan").html("");
			$("#pdcodenmSpan").html("");
			$("#pdmdno_td").html("");
			$("#pdmdcop_td").html("");
			$("#pdmdprice_td").html("");
			$("#pdinfo_td").html("");
			$("#f-photo-image").html("");
			
			//주문수량, 납품 희망 일자 초기화
			var thisDate = new Date();
	        var thisYear = thisDate.getFullYear();        //해당 연
	        var thisMonth = thisDate.getMonth() + 1;    //해당 월
	        $('#hopedate').datepicker('setDate', thisYear+'-'+thisMonth+'-01');
			$("#ordercnt").val(1);
		}else{
			$("#pd_code").val(object.pdcode);
			$("#pd_codenm").val(object.pdcodenm);
			$("#pd_mdno").val(object.pdmdno);
			$("#pd_mdcop").val(object.pdmdcop);
			$("#pd_mdprice").val(object.pdmdprice);
			$("#pd_info").val(object.pdinfo);
			$("#pd_no").val(object.pdno);
			
			$("#pdcodeSpan").html(object.pdcode);
			$("#pdcodenmSpan").html(object.pdcodenm);
			$("#pdmdno_td").html(object.pdmdno);
			$("#pdmdcop_td").html(object.pdmdcop);
			$("#pdmdprice_td").html(object.pdmdprice);
			$("#pdinfo_td").html(object.pdinfo);
			$("#f-photo-image").attr("src",object.file_server_path);
			
			//주문수량, 납품 희망 일자 초기화
			var thisDate = new Date();
	        var thisYear = thisDate.getFullYear();        //해당 연
	        var thisMonth = thisDate.getMonth() + 1;    //해당 월
	        $('#hopedate').datepicker('setDate', thisYear+'-'+thisMonth+'-01');
			$("#ordercnt").val(1);
		}
		
	}
	// 날짜 변환 함수  
 	function getFormatDate(date){
	    var year = date.getFullYear();              //yyyy
	    var month = (1 + date.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = date.getDate();                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
 	} 
	
 	// DatePicker
 	function fDatePicker(){
 	    $.datepicker.setDefaults($.datepicker.regional['ko']); 
 	    $("#hopedate").datepicker({
 	         changeMonth: true, 
 	         changeYear: true,
 	         nextText: '다음 달',
 	         prevText: '이전 달', 
 	         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
 	         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
 	         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
 	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
 	         showAnim: "slide", //애니메이션을 적용한다.
 	         dateFormat: "yy-mm-dd",
 	         minDate:0,
 	      });
 	}
 	
 	//장바구니에 담기 함수
 	function fInputProduct(flag){
 		
 		if(flag == "C"){
 			$("#action").val("C");
 			$("#hopedate").attr("name","carthopedate");
 	 		$("#ordercnt").attr("name","cartcnt");	
 		}else{
 			$("#action").val("O");
 			$("#hopedate").attr("name","oddthopedate");
 	 		$("#ordercnt").attr("name","ordercnt");	
 		}
 		
		var resultCallback = function(data) {
			fInputProductResult(data);
		};
		
		callAjax("/crt/inputProduct.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
		
 	}
 	
 	function fInputProductResult(data){
 		if(data.result == "SUCCESS"){
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
 		}else{
 			swal(data.resultMsg);
 		}
 		
 		//초기화
 		fInitFormProductDtl();
 		
 	}
</script>




</head>
<body>

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
					<div class="content">
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">주문</span> <span class="btn_nav bold">제품 목록</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>
					
						<div class="selectBox">
								<table style="margin-top: 10px; margin-bottom: 25px;" width="100%" cellpadding="5" cellspacing="0" border="1" align="left"
							               style="collapse; border: 1px #50bcdf;">
				               <tr style="border: 0px; border-color: blue">
				                  <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
				                  <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
				                  	<select id="category" name="category" style="width: 150px;"></select> 
									<select id="pdmdcop" name="pdmdcop" style="width: 150px;"></select>
				                 	<a href="" class="btnType blue" id="btnSearchProduct" name="btn"><span>검  색</span></a>
				                  </td> 
				               </tr>
								 </table> 
						</div>
						
						<div class="divprodcuctList">
							<table class="col">
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="13%">
									<col width="13%">
									<col width="13%">
									<col width="13%">
									<col width="13%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">장비번호</th>
										<th scope="col">장비구분</th>
										<th scope="col">모델번호</th>
										<th scope="col">모델명</th>
										<th scope="col">제품명</th>
										<th scope="col">제조사</th>
										<th scope="col">판매가격</th>
									</tr>
								</thead>
								<tbody id="listproduct"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="listproductPagination"> </div>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	<!-- 모달팝업 -->
	<form id="myForm" action=""  method="">
	
	<input type="hidden" name="pdcode" id="pd_code" value=""> 
	<input type="hidden" name="pdcodenm" id="pd_codenm" value="">
	<input type="hidden" name="pdmdno" id="pd_mdno" value="">
	<input type="hidden" name="pdmdcop" id="pd_mdcop" value="">
	<input type="hidden" name="pdmdprice" id="pd_mdprice" value="">
	<input type="hidden" name="pdinfo" id="pd_info" value="">
	<input type="hidden" name="pdno" id="pd_no" value="">
	<input type="hidden" name="action" id="action" value="">
	
	<div id="layer1" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>제품 상세보기</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row" border="1">
					<tbody>
						<tr>
							<td colspan="5" style='text-align: right;'>
							<span id="pdcodeSpan"></span>|<span id="pdcodenmSpan"></span>  
							</td>
						</tr>
						<tr>
							<td rowspan="3">
								<img style="width: 180px; height: 180px;" id="f-photo-image" src="">
							</td>
							<td>모델번호</td>
							<td id="pdmdno_td"></td>
							<td>주문수량</td>
							<td>
								<input type="number" min="1" value="1" name="ordercnt" id="ordercnt">							
							</td>
						</tr>
						<tr>
							<td>제조사</td>
							<td id="pdmdcop_td"></td>
							<td>납품희망일자</td>
							<td><input class="datetype" style="width: 120px" id="hopedate" name="hopedate" readonly></td>
						</tr>
						<tr>
							<td>판매가격</td>
							<td id="pdmdprice_td" colspan="3"></td>
						</tr>
						<tr>
							<td colspan="5">상세정보</td>
						</tr>
						<tr>
							<td rowspan="3" colspan="5" id="pdinfo_td">
							
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveCart" name="btn"><span>장바구니에 담기</span></a> 
					<a href="" class="btnType blue" id="btnOrder" name="btn"><span>주문</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	</form>

</body>
</html>