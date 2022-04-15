<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType ne 'E'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 반품 승인</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	// 그룹코드 페이징 설정
	var pageSizeComnGrpCod = 5;
	var pageBlockSizeComnGrpCod = 5;
	
	/** OnLoad event */ 
	$(function() {

		
		// 반품 목록 조회
		fListComnGrpCod();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveGrpCod' :
					fSaveGrpCod();
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
	
	
	/** 반품 목록 폼 초기화 */
	function fInitFormGrpCod(object) {
		$("#clientnm").focus();
		if( object == "" || object == null || object == undefined) {
			
			$("#clientnm").val("");
			$("#pdnm").val("");
			$("#oddtdate").val("");
			$("#rtnregdate").val("");
			$("#crtncnt").val("");
			$("#crtnprice").val("");
			
		} else {
			$("#clientnm").val(object.clientnm);
			$("#pdnm").val(object.pdnm);
			
			$("#oddtdate").val(object.oddtdate);
			$("#rtnregdate").val(object.rtnregdate);
			$("#crtncnt").val(object.crtncnt);
			$("#crtnprice").val("object.crtnprice");
		}
	}
	
	// 검색기능
	function board_search(currentPage) {
        
        var sname = $('#sname');
        var from_date = $('#from_date');
        var to_date = $('#to_date');
        
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage);     
		
        var param = {
        		  sname : sname.val()
              ,   currentPage : currentPage
              ,   pageSize : pageSizeComnGrpCod
              ,   from_date : from_date.val()
              ,   to_date : to_date.val()
        }
        //swal(JSON.stringify(param));
        var resultCallback = function(data) {
        	flistGrpCodResult(data, currentPage); 
        };
        
        callAjax("/mgrApproval/rtnApprovalList.do", "post", "text", true, param, resultCallback);
        
  } 

	/** 임원승인 실행 */
	function fPopModalComnGrpCod(crtrtio) {
		console.log ("fPopModalComnGrpCod(crtrtio) : "+crtrtio)
		
		if (confirm("승인 하시겠습니까?")) {
			fSaveGrpCod(crtrtio);
	   } else {
		   return;			   
	   } 					
	}
	
	
	/** 반품 목록 조회 */
	function fListComnGrpCod(currentPage) {
		
		currentPage = currentPage || 1;
		
		var sname = $('#sname');
        var searchKey = document.getElementById("searchKey");
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
					sname : sname.val()
				,	currentPage : currentPage
				,	pageSize : pageSizeComnGrpCod
		}
		
		var resultCallback = function(data) {
			flistGrpCodResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/mgrApproval/rtnApprovalList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 반품 목록 조회 콜백 함수 */
	function flistGrpCodResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listRtnApprval').empty();
		
		// 신규 목록 생성
		$("#listRtnApprval").append(data);
		
		// 총 개수 추출
		var totalCntRtnApproval = $("#totalCntRtnApproval").val();
	
		//swal(totalCntRtnApproval);
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntRtnApproval, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListComnGrpCod');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageRtnApproval").val(currentPage);
	}
	
	
	/** 반품 승인여부 수정 */
	function fSaveGrpCod(crtrtio) {

		var param = {	
				crtrtio : crtrtio
	   }
		
		var resultCallback = function(data) {
			fSaveGrpCodResult(data);
		};
		
		callAjax("/mgrApproval/updateRtnMgrYn.do", "post", "json", true, param, resultCallback);
	}      
	
	
	/** 반품목록 저장 콜백 함수 */
	function fSaveGrpCodResult(data) {
		
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageRtnApproval").val(); 
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 목록 조회
			fListComnGrpCod(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
		
		// 입력폼 초기화
		fInitFormGrpCod();
	}

	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageRtnApproval" value="1">
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
							<span class="btn_nav bold">승인</span> <span class="btn_nav bold">고객반품승인</span> 
							<a href="../mgrApproval/rtnApproval.do" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle">
							<span>고객 반품 미승인 목록</span> <span class="fr">
							</span>
						</p>
						<div class="divComGrpCodList">
							<table style="margin-bottom:20px" width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="collapse; border: 1px #50bcdf;">
		                        <tr style="border: 0px; border-color: blue">
		                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
		                           <td width="40" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
		     	                     제품명 <input type="text" style="width: 200px; height: 25px;" id="sname" name="sname"> 
                           			</td> 
                           			<td width="40" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
		     	                     	반품일자 <td width="50" height="25" style="font-size: 100%">
			                            <input type="date" style="width: 120px; height: 25px;" id="from_date" name="from_date"></td>
			                           <td width="50" height="25" style="font-size: 100%">
			                            <input type="date" style="width: 120px; height: 25px;" id="to_date" name="to_date"></td>
			                           <td width="110" height="60" style="font-size: 120%">
	                          		 <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
                           			</td> 
                      		  </tr>
                  	   </table> 
                     
							<table class="col" style="margin-top:20px">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">반품고객명</th>
										<th scope="col">제품명</th>
										<th scope="col">구매일자</th>
										<th scope="col">반품일자</th>
										<th scope="col">수량</th>
										<th scope="col">금액</th>
										<th scope="col">승인처리</th>
									</tr>	
								</thead>
								<tbody id="listRtnApprval">
									
								</tbody>
								
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
</form>
</body>
</html>