<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>기업임원</title>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">

	//페이징 설정 
	var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
	var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수

	
	/** OnLoad event */ 
	$(function() {
	
		// 승인목록 조회
		fListapplylist();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {

				case 'searchBtn':
					board_search();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	
	function fListapplylist(currentPage) {
		currentPage = currentPage || 1;
		
		$('#saveCurrentPage').val(currentPage);
		
		var title = $('#title').val();
		var fromdate = $('#from_date').val();
		var todate = $('#to_date').val();
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
				         client : title
				    , from_date : fromdate
				    ,   to_date : todate
				    , currentPage : currentPage
				    , pageSize : pageSize
		}
		
		var resultCallback = function(data) {
			//console.log("resultCallback : " + data)
			
			flistApplyResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/ged/salesStatusList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 그룹코드 조회 콜백 함수 */
	function flistApplyResult(data, currentPage) {
		
		//swal(data);
		//console.log(data);
		
		// 기존 목록 삭제
		$('#divSaleStatusList').empty();
		
		// 신규 목록 생성
		$("#divSaleStatusList").append(data);
		
		// 총 개수 추출
		
		var totcnt = $("#totcnt").val();
		
		
		//swal(totalCntComnGrpCod);
		
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totcnt, pageSize, pageBlock, 'fListapplylist');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#pagingnavi").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageappy").val(currentPage);
	}	
	
	function fSalesStatusOneBefore(client){
		$('#fSalesStatusOneInput').val(client);
		fSalesStatusOne(1);
	}
	
	
	/** 발주내역 한건 조회*/
	   function fSalesStatusOne(currentPage) {
			currentPage = currentPage || 1;
		
	      var param = { 
	    		  client : $('#fSalesStatusOneInput').val() 
	    		  , currentPage : currentPage
				    , pageSize : pageSize
	                  };
	      
	      var resultCallback = function(data) {
	    	  
	         fSalesStatusOneResult(data,currentPage); 
	      };
	      callAjax("/ged/salesStatusOne.do", "post", "text", true, param, resultCallback);
	   }
	   
	   /** 발주내역 한건 조회 콜백 */
	   function fSalesStatusOneResult(data, currentPage) {
			
			//swal(data);
			//console.log(data);
			
			// 기존 목록 삭제
			$('#divSaleStatus').empty();
			
			// 신규 목록 생성
			$("#divSaleStatus").append(data);
			
			// 총 개수 추출
			
			var totcnt = $("#totSalesStatusCnt").val();
			
			
			//swal(totalCntComnGrpCod);
			
			// 페이지 네비게이션 생성
			
			var paginationHtml = getPaginationHtml(currentPage, totcnt, pageSize, pageBlock, 'fSalesStatusOne');
			console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			$("#pagingnavi2").empty().append( paginationHtml );
			
			// 현재 페이지 설정
			$("#currentPageappy").val(currentPage);
	         
	      
	   }
	
	// 검색기능
	function board_search() {
        
		$('#title').val($('#titleInput').val());
        //var searchKey = document.getElementById("searchKey");
		//var oname = searchKey.options[searchKey.selectedIndex].value;
		
		$('#from_date').val($('#from_dateInput').val());
		$('#to_date').val($('#to_dateInput').val());
		fListapplylist();
	}

</script>
</head>
<body>

<!-- 모달 배경 -->
<div id="mask"></div>

<div id="wrap_area">

    <input type="hidden" id="currentPageappy" name="currentPageappy" value=""/>
    <input type="hidden" id="fSalesStatusOneInput"  value=""/>
    
	<!-- Header area -->
	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
	
	<!-- Content area -->
	<div id="container">
		
		<ul>
			<li class="lnb">
				<!-- lnb area -->
				<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
			
			</li>
			<li class="contents">
				<div class="content">
				
					<p class="Location">
						<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
						<span class="btn_nav bold">매출현황</span> 
						<span class="btn_nav bold">매출 현황</span> 
						<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
					</p>
<!--검색창  -->
                    <input type="hidden" id="title" value="">
                           <input type="hidden" id="from_date" value="">
                           <input type="hidden" id="to_date" value="">
                           <input type="hidden" id="saveCurrentPage" value="  ">
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>

                           <td width="50" height="25" style="font-size: 100%">기업고객명</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="text" style="width: 120px" id="titleInput" name="title"></td>                     
                           <td width="50" height="25" style="font-size: 100%">작성일</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px" id="from_dateInput" name="from_date"></td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px" id="to_dateInput" name="to_date"></td>
                           <td width="110" height="60" style="font-size: 120%">
                           <a class="btnType blue" id="searchBtn" name="searchBtn" href="javascript:board_search()"><span>검  색</span></a></td> 
                            <!-- <input type="button" value="검  색  " id="searchBtn" name="btn" class="test_btn1" 
                              style="border-collapse: collapse; border: 0px gray solid; background-color: #50bcdf; width: 70px; color: white"/> -->
                        </tr>
                     </table>    
						
						
						<div class="divSaleStatusList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="200px">
						                   <col width="200px">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">기업고객명</th>
							              <th scope="col">매출액</th>
									</tr>
								</thead>
								<tbody id="divSaleStatusList"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
							</div>
											
						</div>
						<br><br><br>
						<div class="divSaleStatus">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="200px">
						                   <col width="200px">
						                   <col width="200px">
						                   <col width="200px">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">기업고객명</th>
							              <th scope="col">제품명</th>
							              <th scope="col">거래가격</th>
							              <th scope="col">거래날짜</th>
									</tr>
								</thead>
								<tbody id="divSaleStatus"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi2">
							</div>
											
						</div>

		
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>