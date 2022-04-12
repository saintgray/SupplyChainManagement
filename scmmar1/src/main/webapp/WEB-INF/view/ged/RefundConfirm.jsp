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
		fRefundListapplylist();
		
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
	
	
	function fRefundListapplylist(currentPage) {
		
        currentPage = currentPage || 1;
		
		$('#saveCurrentPage').val(currentPage);
		
		var title = $('#title').val();
		var fromdate = $('#from_date').val();
		var todate = $('#to_date').val();		
		
		if($('#checkConfirm').is(":checked")){
			var checkConfirm = 1;
		}else{
			var checkConfirm = 0;
		}
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
				        salesNm : title
				    , from_date : fromdate
				    ,   to_date : todate
				    , checkConfirm : checkConfirm
				    , currentPage : currentPage
				    , pageSize : pageSize
		}
		
		var resultCallback = function(data) {
			//console.log("resultCallback : " + data)
			
			fRefundlistApplyResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/ged/refundConfirmList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 그룹코드 조회 콜백 함수 */
	function fRefundlistApplyResult(data, currentPage) {
		
		//swal(data);
		//console.log(data);
		
		// 기존 목록 삭제
		$('#divRefundConfirmList').empty();
		
		// 신규 목록 생성
		$("#divRefundConfirmList").append(data);
		
		// 총 개수 추출
		
		var totcnt = $("#totcnt").val();
		
		
		//swal(totalCntComnGrpCod);
		
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totcnt, pageSize, pageBlock, 'fRefundListapplylist');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#pagingnavi").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageappy").val(currentPage);
	}	
	
	
	/** 발주내역 한건 조회*/
	   function fRefundOne(returnId, confirmYN, checkConfirm) {
		
		   if(checkConfirm == 'Y'&& confirmYN =='Y'){
			   alert("이미 승인된 요청입니다.");
			   return false;
		   }else if(checkConfirm == 'N'&& confirmYN =='N'){
			   alert("이미 반려된 요청입니다.");
			   return false;
		   }
		   if(checkConfirm.trim()!=''){
			   if(!confirm("요청승인사항을 수정하시겠습니까?")){
				   return false;
			   } 
		   }
	      
	      var param = { 
	    		         returnId : returnId 
	    		       ,confirmYN : confirmYN
	                  };
	      
	      var resultCallback = function(data) {
	    	  
	    	 alert(data.resultMsg);
	    	 
	         console.log(data);
	         console.log(fRefundOneResult);
	         fRefundListapplylist($('#saveCurrentPage').val()); 
	      };
	      
	      callAjax("/ged/RefundOne.do", "post", "json", true, param, resultCallback);
	   }
	   
	   /**  반품내역 한건 조회 콜백 */
	   function fRefundOneResult(data) {
	      
	      if (data.result == "SUCCESS") {
	    	  
	    	 alert(data.resultMsg);
	    	  
	    	 fRefundListapplylist();
	    	  
	         //var uName = data.uName;         
	         //var outData = data.outData;

	         
	         // 모달 팝업
	         //gfModalPop("#layer1");
	         
	         // 개인 취업정보 이력 조회 데이터 설정
	         //$("#uName").empty().append(uName);
	         //$("#outData").empty().append(outData);
	         //fInitFormGrpCod(data.pcmModel);
	         
	      } else {
	         swal(data.resultMsg);
	      }   
	   }

	// 검색기능
		function board_search() {
        
		$('#title').val($('#titleInput').val());
        //var searchKey = document.getElementById("searchKey");
		//var oname = searchKey.options[searchKey.selectedIndex].value;
		
		$('#from_date').val($('#from_dateInput').val());
		$('#to_date').val($('#to_dateInput').val());
		fRefundListapplylist();
	}
	function changeCheckConfirm() {
		fRefundListapplylist(1);
  } 

</script>
</head>
<body>

<!-- 모달 배경 -->
<div id="mask"></div>

<div id="wrap_area">

    <input type="hidden" id="currentPageappy" name="currentPageappy" value=""/>
    
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
						<span class="btn_nav bold">승인</span> 
						<span class="btn_nav bold">반품 승인</span> 
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
                           <td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;<input type="checkbox" id="checkConfirm" onchange="changeCheckConfirm()"> 미승인만 표시</td>

                           <td width="50" height="25" style="font-size: 100%">제품명</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="text" style="width: 120px" id="title" name="title"></td>                     
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
						
						
						<div class="divRefundConfirmList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="100px">
						                   <col width="200px">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">반품고객</th>
							              <th scope="col">제품명</th>
							              <th scope="col">구매일</th>
							              <th scope="col">반품일</th>
							              <th scope="col">구매수량</th>
							              <th scope="col">반품수량</th>
							              <th scope="col">금액</th>
							              <th scope="col">승인여부</th>
							              <th scope="col">   </th>
									</tr>
								</thead>
								<tbody id="divRefundConfirmList"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
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