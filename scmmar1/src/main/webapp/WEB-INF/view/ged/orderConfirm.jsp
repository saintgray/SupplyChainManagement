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
		
		var title = $('#title').val();
		var fromdate = $('#from_date').val();
		var todate = $('#to_date').val();		
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
				        salesNm : title
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
		callAjax("/ged/orderConfirmList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 그룹코드 조회 콜백 함수 */
	function flistApplyResult(data, currentPage) {
		
		//swal(data);
		//console.log(data);
		
		// 기존 목록 삭제
		$('#divOrderConfirmList').empty();
		
		// 신규 목록 생성
		$("#divOrderConfirmList").append(data);
		
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
	
	
	/** 발주내역 한건 조회*/
	   function fOrderOne(orderid, confirmYN) {
	      
	      var param = { 
	    		         orderid : orderid 
	    		       ,confirmYN : confirmYN
	                  };
	      
	      var resultCallback = function(data) {
	         console.log(data);
	         console.log(fOrderOneResult);
	         fOrderOneResult(data);
	      };
	      
	      callAjax("/ged/OrderOne.do", "post", "json", true, param, resultCallback);
	   }
	   
	   /** 발주내역 한건 조회 콜백 */
	   function fOrderOneResult(data) {
	      
	      if (data.result == "SUCCESS") {
	    	  
	    	 alert(data.resultMsg);
	    	  
	    	 fListapplylist();
	    	  
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
	
	
	
	
	
    function orderConfirm(){
    	var f = document.orderConfirmForm;
    	if(confirm("승인하시겠습니까?")){
    		f.submit();
    	}
    }
	// 검색기능
	function board_search(currentPage) {
        
        var sname2 = $('#sname').val();
        //var searchKey = document.getElementById("searchKey");
		//var oname = searchKey.options[searchKey.selectedIndex].value;
		
		var oname2 = $('#searchKey').val();
		
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage);     
		
        var param = {
        		  sname : sname2
        	  ,	  oname : oname2
              ,   currentPage : currentPage
              ,   pageSize : pageSizeComnGrpCod
        }
        //swal(JSON.stringify(param));
        var resultCallback = function(data) {
        	flistGrpCodResult(data, currentPage); 
        };
        
        callAjax("/ged/orderConfirmList.do", "post", "text", true, param, resultCallback);
        
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
						<span class="btn_nav bold">매출현황</span> 
						<span class="btn_nav bold">매출 현황</span> 
						<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
					</p>
<!--검색창  -->
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>

                           <td width="50" height="25" style="font-size: 100%">제품명</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="text" style="width: 120px" id="title" name="title"></td>                     
                           <td width="50" height="25" style="font-size: 100%">작성일</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px" id="from_date" name="from_date"></td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px" id="to_date" name="to_date"></td>
                           <td width="110" height="60" style="font-size: 120%">
                           <a href="" class="btnType blue" id="searchBtn" name="searchBtn"><span>검  색</span></a></td> 
                            <!-- <input type="button" value="검  색  " id="searchBtn" name="btn" class="test_btn1" 
                              style="border-collapse: collapse; border: 0px gray solid; background-color: #50bcdf; width: 70px; color: white"/> -->
                        </tr>
                     </table>    
						
						
						<div class="divSelesStatusList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="200px">
						                   <col width="200px">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">납품업체명</th>
							              <th scope="col">제품명</th>
							              <th scope="col">수량</th>
							              <th scope="col">금액</th>
							              <th scope="col">구매일자</th>
							              <th scope="col">   </th>
									</tr>
								</thead>
								<tbody id="divOrderConfirmList"></tbody>
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
	
	
	<!-------------------모달 부분!!!! ----------------->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>그룹코드 관리</strong>
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
							<th scope="row">그룹 코드 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="grp_cod" id="grp_cod" /></td>
							<th scope="row">그룹 코드 명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="grp_cod_nm" id="grp_cod_nm" /></td>
						</tr>
						<tr>
							<th scope="row">코드 설명 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="grp_cod_eplti" id="grp_cod_eplti" /></td>
						</tr>
				
						<tr>
							<th scope="row">사용 유무 <span class="font_red">*</span></th>
							<td colspan="3"><input type="radio" id="radio1-1"
								name="grp_use_poa" id="grp_use_poa_1" value='Y' /> <label for="radio1-1">사용</label>
								&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="radio1-2"
								name="grp_use_poa" id="grp_use_poa_2" value="N" /> <label for="radio1-2">미사용</label></td>
						</tr>
					</tbody>
				</table>
		
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

</body>
</html>