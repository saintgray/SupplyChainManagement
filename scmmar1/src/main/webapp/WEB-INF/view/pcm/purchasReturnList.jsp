<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>반품내역리스트</title>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
	//페이징 설정
	var pageSize = 5;			//페이지당 보여주는 목록 갯수
	var pageBlockSize = 5;	//페이지 번호 갯수
	
	
	/** 설명:OnLoad event : html화면이 실행되자마자 자바스크립트가 OnLoad event 이벤트를 실행시킨다.  */ 
	$(function() {
	
		// 그룹코드 조회 : OnLoad event가 실행되면서 처음에 그룹코드 조회 함수부터 실행되는 것!(여기서부터 시작)
		fPurchaseReturnList();
	
		
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
				search();
				  break;
			case 'btnInitSearch':
				  fInitSearch();
				  break;
			case 'btnCloseModal':
				  gfCloseModal();
				break;
			}
		});
	}

	/** 반품내역 폼 초기화 */
	function fInitPcmReturn(object) {
		//$("#orderid").focus();
		if( object == "" || object == null || object == undefined) {
			
			$("#return_id").val("");
			$("#comp_nm").val("");
			$("#sales_nm").val("");
			$("#return_cnt").val("");
			$("#regdate").val("");
			$("#confirmYN").val("");
			$("#return_id").attr("readonly", false);
			$("#return_id").css("background", "#FFFFFF");
		
			
		} else {
			
			$("#return_id").val(object.return_id);
			$("#comp_nm").val(object.comp_nm);
			$("#sales_nm").val(object.sales_nm);
			$("#return_cnt").val(object.return_cnt);
			$("#regdate").val(object.regdate);
			$("#confirmYN").val(object.confirmYN);
			//$("input:radio[name=grp_use_poa]:input[value="+object.use_poa+"]").attr("checked", true);
			$("#return_id").attr("readonly", true);
			$("#return_id").css("background", "#F5F5F5");
		    	//$("#grp_cod_nm").focus(); 
			 
		}
	}
	
	
	/**반품내역 목록 조회**/
	function fPurchaseReturnList(currentPage) {
		
		//매개변수로 넘어오는 currentPage(현재페이지)가 없으면 1이된다.
		currentPage = currentPage || 1;
		if($('#confirmCheck').is(":checked")){		//체크 박스 사용할때 체크가 된상태인지 아닌지 확인
			var confirmCheck = 1;
		}else{
			var confirmCheck = 0;
		}
		//아이디로 값 가져오고(검색)
		var sname = $('#sname').val();
		var searchKey = $('#searchKey').val();
		//var searchKey = document.getElementById("searchKey");
		//var oname = searchKey.options[searchKey.selectedIndex].value;
		
		var cal1 = $('#cal1').val();
		var cal2 = $('#cal2').val();
		
		console.log("currentPage : " + currentPage);
		console.log("sname : " + sname);
		console.log("searchKey : " + searchKey);
		console.log("cal1 : " + cal1);
		console.log("cal2 : " + cal2);
		
		//param에 값들 저장(나중에 컨트롤러에 보냄)
		var param = {
			confirmCheck : confirmCheck,
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
			fPurchaseReturnListResult(data, currentPage);
		};
		
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//cmg/lectureroomList.do
		callAjax("/pcm/listPurchaseReturn.do", "post", "text", true, param, resultCallback); //resultCallback에 저장되있는 함수가 실행된다.
	}

	 
	/** 반품내역 목록 조회 콜백 함수 */
	function fPurchaseReturnListResult(data, currentPage) {

		//swal(data);
		console.log(data);

		// 기존 목록 삭제
		$('#listPurchaseReturn').empty();

		// 신규 목록 생성 
		$("#listPurchaseReturn").append(data);

		// 총 개수 추출
		var totalCnt = $("#totalCnt").val();

		//swal(totalCnt);

		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCnt,
				pageSize, pageBlockSize, 'fPurchaseReturnList');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#pagingnavi").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage").val(currentPage);
	}	

	
	// 검색기능
	function fPurchase_search(currentPage) {
        //.val(): 값을 가져오는 것
		var sname = $('#sname').val();
        //var searchKey = document.getElementById("searchKey");
      //var oname = searchKey.options[searchKey.selectedIndex].value;
      
      //설명: id searchKey인 option value를 가져온다.
      var oname = $('#searchKey').val();
		
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage);     
		
        var param = {
        		  sname : sname.val()
        	  ,	  oname : oname
              ,   currentPage : currentPage
              ,   pageSize : pageSize
        }
        //swal(JSON.stringify(param));
        var resultCallback = function(data) {
        	fPurchaseReturnListResult(data, currentPage); 
        };
     
        callAjax("/pcm/listPurchaseReturn.do",  //컨트롤러랑 매핑되있는 주소
        		"post", 					    //어떤 타입으로 보낼지 (get/post)
        		"text", 					    //컨트롤러로 보내는 파라미터 타입인가?
        		true, 
        		param, 						    //여기서 컨트롤러로 이동??(param에 저장된 값을 가지고)
        		resultCallback				    //컨트롤러에서 받은(응답)데이터 (컨트롤러에서 return값)
        		);
        
  } 
	
	function search() {
		$('#searchKey').val($('#searchKeyInput').val());
		$('#sname').val($('#snameInput').val());
		$('#cal1').val($('#cal1Input').val());
		$('#cal2').val($('#cal2Input').val());
		fPurchaseReturnList();
	}
	
	
	/** 반품내역 한건 조회*/
   function fPcmReturnOne(return_id) {
      
      var param = { return_id : return_id };
      
		var resultCallback = function(data) {
			fPcmReturnOneResult(data, currentPage);
			//alert(data.pcmOrderListModel.orderid);
		};
      
		callAjax("/pcm/pcmReturnOne.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 반품내역 한건 조회 콜백 */
	function fPcmReturnOneResult(data) {
		//alert(data.pcmOrderListModel.orderid);
		if (data.result == "SUCCESS") {
			console.log(data);
			//var uName = data.uName;			
			//var outData = data.outData;
			
			
			// 모달 팝업
			gfModalPop("#layer1");
	
			//(controller에서 리턴한 Model명에서 실수함)
			fInitPcmReturn(data.pcmReturnListModel);
			
		} else {
			swal(data.resultMsg);
		}	
	}
	
	function changeConfirmCheck() {
		fPurchaseReturnList(1)
	}
	
</script>
</head>
<body>
<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value="1"> 
		 <!--form을 대상으로 serialize()메소드를 사용하면 폼의 객체들을 한번에 받을 수 있다.
		 ajax에 data 값을 세팅할 때 사용하면, 해당 form의 모든 값을 쉽게 받을 수 있다.
		 -->
		<input type="hidden" id="searchKey" value="">
		<input type="hidden" id="sname" value="">
		<input type="hidden" id="cal1" value="">
		<input type="hidden" id="cal2" value="">
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
								<span class="btn_nav bold">반품업체</span>
								<span class="btn_nav bold">반품지시서목록</span> 
								<!-- <a href="${CTX_PATH}/pcm/purchaseOrder.do " class="btn_set
								 refresh">새로고침</a> -->
								<a href="../pcm/returnPurchase.do" class="btn_set refresh">새로고침</a>
							</p>
							
							<div id="thispagecontent">
								<!-- 이 곳에 내 코드를 작성하세요 -->
							
							<div class="purchaseReturnList_area">
							<!--검색창 부분  -->
								<table style="margin-top:10px; margin-bottom:20px;" width="100%" cellpadding="5"
									cellspacing="0" border="1" align="left"
									style="collapse; border: 1px #50bcdf;">
									<tr style="border: 0px; border-color: blue">
										<td height="25" style="font-size: 100%;">&nbsp;&nbsp;<input type="checkbox" value="" onchange="changeConfirmCheck()" id="confirmCheck">&nbsp;승인 요청만 표기</td>
										<td width="*" height="25" style="font-size: 100%; text-align: center;">
											<select id="searchKeyInput" name="searchKey" style="width: 80px;">
												<option value="purchase_copnm">업체</option>
												<option value="purchase_modelnm">제품</option>
											</select>
											<input type="text" style="width: 150px; height: 25px;" id="snameInput" name="sname"> &nbsp;&nbsp;&nbsp;
											<input type="date" id="cal1Input" name="cal1" /> ~ <input type="date" id="cal2Input" name="cal2" /> &nbsp;
											<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검색</span></a>&nbsp;
											<!-- <a href="" class="btnType blue" id="btnInitSearch" name="btn"><span>초기화</span></a></td> -->
										<td width="40" height="25" style="font-size: 120%;">&nbsp;</td>
									</tr>
								</table>
								
								
								<table class="col">
									<caption>caption</caption>
									<colgroup>
									<col width="7%">
										<col width="7%">
										<col width="20%">
										<col width="25%">
										<col width="*%">
										<col width="10%">
										<col width="7%">
										<col width="8%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">목록번호</th>
											<th scope="col">반품번호</th>
											<th scope="col">반품업체</th>
											<th scope="col">제품명</th>
											<th scope="col">수량</th>
											<th scope="col">날짜</th>
											<th scope="col">임원승인</th>
											<th scope="col">상세보기</th>
										</tr>
									</thead>
<!-- 									listPurchaseOrder -->
									<tbody id="listPurchaseReturn"></tbody>
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
					<strong>반품내역 상세</strong>
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
								<th scope="row">반품 번호 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" id="return_id" name="return_id" />
								</td>
								<th scope="row">반품회사 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" id="comp_nm" name="comp_nm" readonly/>
								</td>
							</tr>
							<tr>
								<th scope="row">제품명<span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" id="sales_nm" name="sales_nm" readonly/>
								</td>
								<th scope="row">수량<span class="font_red">*</span></th>
								<td>
									<input type="" class="inputTxt p100" id="return_cnt" name="return_cnt" readonly/>
								</td>
							</tr>
						</tbody>
					</table>
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