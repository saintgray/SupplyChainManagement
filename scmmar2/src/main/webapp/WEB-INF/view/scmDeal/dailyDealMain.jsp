<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>SCM시스템 | 일별 수주 내역</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
	<style>
		/* input[name=date].datetype, textarea.autosize는 datepicker CSS */
		input[name=date].calendar {
			/* padding:4px 2px 5px 25px; */
			border:1px solid #CACACA;
		    font-size:11px; 
		    color:#666; 
		    background:url('http://cfile23.uf.tistory.com/image/26100D4F5864C76827F535') no-repeat 5px 6.75px; 
		    background-size:15px;
	   	}   
		textarea.autosize { min-height: 50px; }
		input {
			text-align: center;
		}
		.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:first-child a { color: red; }
		.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:last-child a { color: blue; }
		.ui-widget-header {
			border: 1px solid #ddd;
			background: #eee;
		}
		#filterOrderDate {
			margin-right: -3.5px;
		}
		.slide-container {
			width: 1480px;
		}
		.slide-box {
		    width: 740px;
		    float: left;
		}
		.option-hide {
            display: none;
        }
        .chkStrMsg {
        	font-family: '나눔바른고딕', NanumBarunGothic;
        	line-height:20px; font-size:12px; font-weight: bold;
        	display: inline-block;
        	width: 100%;
        	text-align: center;
        	color: #CD3861;
        }
        .stCntforModal {
        	height: 28px;
        }
        .checkNum2, .checkNum3 {
        	width: 148px;
        	height: 28px;
        }
        .stCntforModal2, .stCntforModal3 {
        	width: 133px;
        	height: 28px;
        }
	</style>
<script>

	var pagePostNum = 5;
	var pageBlock = 5;
	
	window.onload = function() {
		fDatePicker();
		fGetList();
		fSearchEvt();
		fConnectEvt();
		fBtnEvt();
	}
	
	function fBtnEvt() {
		$("a[name=btn]").click(function(e) {
			e.preventDefault();
			var btnId = $(this).attr('id');
			switch (btnId) {
			case "btnRedo" :
			case "btnCancle" : 
				gfCloseModal();
				break;
			}
		});
	}
	
	function fDatePicker(){
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$( "#startDate" ).datepicker({
 	        changeMonth: true, 
 	        changeYear: true,
 	        nextText: '다음 달',
 	        prevText: '이전 달', 
 	        dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
 	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
 	        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
 	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
 	        showAnim: "slideDown", //애니메이션 적용
 	        dateFormat: "yy-mm-dd",
 	        maxDate: 0, // 선택할 수 있는 최소날짜(0:오늘 이후 날짜 선택 불가)
 	        onClose: function( selectedDate ) {
 	       	   // 시작일(startDate) datepicker가 닫힐 때, 
 	       	   // 종료일(endDate)의 선택할 수 있는 최소 날짜(minDate)를 선택한 시작일로 지정
 	           $("#endDate").datepicker( "option", "minDate", selectedDate );
 	        }
 	    });
		$( "#endDate" ).datepicker({
	        changeMonth: true, 
	        changeYear: true,
	        nextText: '다음 달',
	        prevText: '이전 달', 
	        dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        showAnim: "slideDown", //애니메이션 적용
	        dateFormat: "yy-mm-dd",
	        maxDate: 0, // 선택할 수 있는 최소날짜(0:오늘 이후 날짜 선택 불가)
	        onClose: function( selectedDate ) {
	 	       	// 종료일(endDate) datepicker가 닫힐 때, 
	 	       	// 시작일(startDate)의 선택할 수 있는 최대 날짜(maxDate)를 선택한 시작일로 지정
	            $("#startDate").datepicker( "option", "maxDate", selectedDate );
	        }
	    });
		$("#startDate").datepicker('setDate', '-1M');
 	    $("#endDate").datepicker('setDate', 'today');
	}
	
	function fGetList(currentPage) {
		currentPage = currentPage || 1;
		/* 1페이지에서는 검색조건이 실행되나, 2페이지부터는 검색조건이 실행되지 않음
		   따라서, 검색조건에 필요한 모든 파라미터를 추가 선언하여 넘김 */
		var param = { currentPage : currentPage
				    , pagePostNum : pagePostNum
					, oddtreqyn   : $("#filterReturn").val()
					, ordertype   : $("#filterOrderDate").val()
					, startDate   : $("#startDate").val()
					, endDate     : $("#endDate").val() }
		var callback = function(data) { fGetListRslt(data, currentPage); }
		callAjax("/scmDeal/getList.do", "post", "text", true, param, callback);
	}
	
	function fSearchEvt(currentPage) {
		currentPage = currentPage || 1;
		$("#filterReturn, #filterOrderDate, #startDate, #endDate").on('change', function(e) {
			var optionSelected = $(e.target).find("option:selected").val();			
			if ( optionSelected == 'N' || optionSelected == 'rtncomdate' ) {
				$(".optHide").addClass('option-hide');
			} else {
				$(".optHide").removeClass('option-hide');
			}
			var param = {
						  currentPage : currentPage
				   		, pagePostNum : pagePostNum
						, oddtreqyn   : $("#filterReturn").val()
						, ordertype   : $("#filterOrderDate").val()
						, startDate   : $("#startDate").val()
						, endDate     : $("#endDate").val()
						}
			var callback = function(data) { fGetListRslt(data, currentPage); }
			callAjax("/scmDeal/getList.do", "post", "text", true, param, callback);
		});
	}
	
	function fGetListRslt(data, currentPage) {
		document.getElementById("listDailyDeal").innerHTML = '';
		document.getElementById("listDailyDeal").innerHTML = data;
		var paginationHTML = getPaginationHtml( currentPage
									 		  , document
									 		    .getElementById("orderTotalCount")
									 		    .value
											  , pagePostNum
											  , pageBlock
											  , 'fGetList');
		document.getElementById("dailyDealPagination").innerHTML = '';
		document.getElementById("dailyDealPagination").innerHTML = paginationHTML;
		document.getElementById("setCurrentPage").value = currentPage;
	}

	function fConnectEvt() {
		var addCount = 0;
		var clone;
		$("#mask").on("click", function(e) {
			if ( e.target.id == $("#mask").attr('id') ) {
				$('#mask').hide();
				$('.layerPop').hide();
				$('#wrap_pop .scroll').scrollTop(0);
			}
		});
		$(".checkNum").on("input", function(e) {
			var numOnly = /^[0-9]+$/;
			var getInputVal = $(this).val();
			if ( numOnly.test(getInputVal) == false ) {
				$(".chkStrMsg").text("※ 숫자만 입력 가능합니다.").css("color", "#CD3861");
			} else {
				$(".chkStrMsg").text("");
			}
		 });
		$(".btnMove").on("click", function(e) {
			var getBtnText = $(e.target).text();
			if ( getBtnText == '다음') {
				$(".slide-container").css('transform', 'translateX(-740px)');
				$(".warehouses").trigger("change");
				$(".productnm").trigger("change");
			} else if ( getBtnText == '이전' ) {
				$(".slide-container").css('transform', 'translateX(0px)');
			}
		});
		$(".addTr").on("click", function(e) {
			if ( addCount < 2 ) {
				addCount += 1 ;
				clone = $('.tr').first().clone();
				$('#deliverInfoTbody').append(clone);
				$(".tr:nth-child(n+2):nth-last-child(n)").children('td:last-child').children('a').attr("class", "removeTr").text("삭제");
				$(".tr:nth-child(2)").children("td:nth-child(1)").children(".warehouses").attr("name", "warehouse2");
				$(".tr:nth-child(2)").children("td:nth-child(2)").children(".productnm").attr("name", "productnm2");
				$(".tr:nth-child(2)").children("td:nth-child(3)").children(".stCntforModal").attr({"name":"stCntforModal2"
																								  ,"class":"stCntforModal2"});
				$(".tr:nth-child(2)").children("td:nth-child(4)").children(".checkNum").attr({"name":"oddtdelcnt2",
																							  "class":"checkNum2"});
				$(".tr:nth-child(3)").children("td:nth-child(1)").children(".warehouses").attr("name", "warehouse3");
				$(".tr:nth-child(3)").children("td:nth-child(2)").children(".productnm").attr("name", "productnm3");
				$(".tr:nth-child(3)").children("td:nth-child(3)").children(".stCntforModal").attr({"name":"stCntforModal3"
					 																			  ,"class":"stCntforModal3"});
				$(".tr:nth-child(3)").children("td:nth-child(4)").children(".checkNum").attr({"name":"oddtdelcnt3"
					  																		 ,"class":"checkNum3"});				
				//fWarehouseModal();
			} else if (addCount == 2 ) {
				e.preventDefault();
			}
		});
		$(document).on("click", ".removeTr", function(e) {
			addCount -= 1 ;
			$(this).parents('tr').remove();
		});
	}
	
	function fDealApproval(refundStr, oddtno) {
		if ( refundStr == '입고' ) {
			fgetOne(refundStr, oddtno);
		} else if ( refundStr == '출고' ) {
			fgetOne(refundStr, oddtno);
		} 
	}
	
	function fgetOne(refundStr, oddtno) {
		var param = { oddtno : oddtno };
		var callback = function(data) { fGetOneRslt(data, refundStr); }
		callAjax("/scmDeal/getOne.do", "post", "json", true, param, callback);
	}
	
	function fGetOneRslt(data, refundStr) {
		if ( refundStr == '출고' ) {
			$("#oddtno").val(data.item.oddtno);
			$("#client").val(data.item.client);
			$("#orderpayynStr").val(data.item.orderpayynStr);
			$("#pdmdnm").val(data.item.pdnm);
			$("#orderdate").val(data.item.orderdate);
			$("#oddtcnt").val(data.item.oddtcnt);
			$("#orderno").val(data.item.orderno);
			fWarehouse();
			gfModalPop("#deliveryApproval");
		}
		if ( refundStr == '입고' ) {
			$("#orderPdno").val(data.item.pdno);
			$("#orderPdnm").val(data.item.pdnm);
			$("#pdmdprice").val(data.item.pdmdprice);
			
			console.log("단가 보기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + JSON.stringify(data.item));
			
			gfModalPop("#orderApproval");
		}
	}
	
	function fSaveImport() {
		if ( $("#impdtcnt").val() <= 0 || $("#impdtcnt").val() == "" || $("#impdtcnt").val() == null || $("#impdtcnt").val() == undefined ) {
			swal("발주수량을 확인해주세요.");
			return;
		}
		var param = { compId : $("#comList").val()
					, pdno : $("#orderPdno").val()
					, impdtcnt : $("#impdtcnt").val()
					, impprice : $("#pdmdprice").val() }
		var savecallback = function(data) {
			fSaveImportRslt(data);		
		};		
		callAjax("/scmDeal/saveImportsInfo.do", "post", "json", true, param, savecallback);
	}
	
	function fSaveImportRslt(data) {
		if ( data.logicResult == "SUCCESS" ) {
			swal(data.resultMsg);
			gfCloseModal("#orderApproval");
		} else if ( data.logicResult == "FALSE" ) {
			swal(data.resultMsg);
			return;
		}
	}
	
	function fWarehouse() {		
		$(document).on("change", ".warehouses", function() {
			var warehouse = $(this);
			$.ajax({
				url : "/scmDeal/getProductList.do",
				type : "post",
				dataType : "json",
				async : true,
				data : { whcode : warehouse.val()
					   , pdmdno : warehouse.parent().next().children(".productnm").val() },
				beforeSend: function(xhr) {
					xhr.setRequestHeader("AJAX", "true");
				},
				success : function(data) {
					var htmlOption = '';
					$(data.pdList).each(function(idx, item) {
						htmlOption += '<option value='+item.pdno+'>'+item.pdnm+'</option>';
					});
					warehouse.parent().next().children(".productnm").empty().html(htmlOption); //취급품목
					warehouse.parent().next().next().children(".stCntforModal").val(data.stTotal); 
					warehouse.parent().next().next().children(".stCntforModal2").val(data.stTotal); 
					warehouse.parent().next().next().children(".stCntforModal3").val(data.stTotal); 
				},
				error : function(xhr, status, err) {
					console.log("xhr : " + xhr);
					console.log("status : " + status);
					console.log("err : " + err);
					if (xhr.status == 901) {
						swal("로그인 정보가 없습니다.\n다시 로그인 해 주시기 바랍니다.");
						location.replace('/login.do');
					} else {
						alert('A system error has occurred.' + err);
					}
				},
				complete: function(data) {
					$.unblockUI();
				}
			});
		});		
		$(document).on("change", ".productnm", function() {
			var productnm = $(this);
			$.ajax({
				url : "/scmDeal/getProductList.do",
				type : "post",
				dataType : "json",
				async : true,
				data : { whcode : productnm.parent().siblings("td:nth-child(1)").children(".warehouses").val()
					   , pdmdno : productnm.val() },
				beforeSend: function(xhr) {
					xhr.setRequestHeader("AJAX", "true");
				},
				success : function(data) {
					productnm.parent().siblings("td:nth-child(3)").children(".stCntforModal").val(data.stTotal); //재고수량
					productnm.parent().siblings("td:nth-child(3)").children(".stCntforModal2").val(data.stTotal); //재고수량
					productnm.parent().siblings("td:nth-child(3)").children(".stCntforModal3").val(data.stTotal); //재고수량
				},
				error : function(xhr, status, err) {
					console.log("xhr : " + xhr);
					console.log("status : " + status);
					console.log("err : " + err);
		      			
					if (xhr.status == 901) {
						alert("로그인 정보가 없습니다.\n다시 로그인 해 주시기 바랍니다.");
						location.replace('/login.do');
					} else {
						alert('A system error has occurred.' + err);
					}
				},
				complete: function(data) {
					$.unblockUI();
				}
			});
		});
	}
	
	function checkInputValEmpty(arr) {
		for(var i=0, len=arr.length; i<len; i++) {
			var $elem = $('.' + arr[i][0]);
			if($elem.length <= 0){ //not exist
				continue;
			}
			var elemValue = $.trim( $elem.val() );
			var alertMsg = arr[i][1];
			if ( elemValue == "" ) {
				swal(alertMsg);
				$elem.focus();
				return false;
			}
		} 
	    return true;	 
	}
	
	function fValidateInputVal() {
		var chk = checkInputValEmpty([
			     						[ "checkNum", "출고수량을 확인해주세요." ],
			     						[ "checkNum2", "출고수량을 확인해주세요." ],
			     						[ "checkNum3", "출고수량을 확인해주세요." ]
			     				    ]);
		if (!chk) {	return; }
		return true;
	}
	
	function fDeliverySubmit() {
		var trLength = $(".tr").length;
		var stCntVal = $(".stCntforModal").val();
		var stCntVal2 = $(".stCntforModal2").val();
		var stCntVal3 = $(".stCntforModal3").val();
		if ( !fValidateInputVal() ) { return; }
		if ( stCntVal == 0 || stCntVal2 == 0 || stCntVal3 == 0 ) {
			swal("재고수량을 확인해주세요.");
			return;
		}
		$("#totalDelInfoCnt").val(trLength);
		callAjax("/scmDeal/saveDeliveryInfo.do", "post", "json", true, $("#allData").serialize(), fDeliverySubmitRslt);
	}
	
	function fDeliverySubmitRslt(data) {
		console.log("콜백완료");
		$("#allData").each(function() {
			this.reset();
		});
		$(".slide-container").css('transform', 'translateX(0px)');
		$(".tr:nth-child(n+2):nth-last-child(n)").remove();
		gfCloseModal("#deliveryApproval");
		swal("해당 주문 건에 대한 배송을 지시하였습니다.");
	}
		
</script>
</head>
<body>
<form id="allData" action="" method="">
<!-- 현재페이지는 처음에 항상 1로 설정하여 넘김 -->
<input type="hidden" id="setCurrentPage" value="1"/>
<input type="hidden" value="" name="orderno" id='orderno' />
<input type="hidden" value="" name="totalDelInfoCnt" id="totalDelInfoCnt" />
<input type="hidden" value="" name="pdno" id="pdno" />

	<div id="mask"></div><!-- //모달배경 -->
	<jsp:include page="/WEB-INF/view/scmDeal/dealOrderApproval.jsp"/> <!-- value="pdmdnm"가 선언되어 있어 하위jsp에 value값이 출력되지 않았음 -->
	<jsp:include page="/WEB-INF/view/scmDeal/dealDeliveryApproval.jsp"/>
	
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
							<span class="btn_nav bold">일별수주내역</span>
							<a href="../scmDeal/dailyOrderHistory.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle">
							<span>일별 수주 내역</span> 
							<span class="fr">
								<select id="filterReturn" style="width: 115px; height: 30.5px">
						            <option value="">전체</option>
						            <option value="Y">반품신청건</option>
						            <option value="N" class="optHide">반품미신청건</option>
							    </select>
								<select id="filterOrderDate" style="width: 115px; height: 30.5px">
						            <option value="orderdate">주문일자</option>
						            <option value="rtncomdate" class="optHide">반품처리일자</option>
							    </select>&nbsp;
								<input id="startDate" class="calendar" name="date" style="width: 118px; height: 28.5px;" readonly/>
								<input id="endDate" class="calendar" name="date" style="width: 118px; height: 28.5px;" readonly/>
							</span>
						</p>
						
						<div class="divComDtlCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="70px">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="110px">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">주문번호</th>
										<th scope="col">고객기업</th>
										<th scope="col">주문제품</th>
										<th scope="col">주문수량</th>
										<th scope="col">주문금액(원)</th>
										<th scope="col">입금상태</th>
										<th scope="col">주문일자</th>
										<th scope="col">재고수량</th>
										<th scope="col">반품상태</th>
										<th scope="col">반품처리일</th>
										<th scope="col">입·출고</th>
									</tr>
								</thead>
								<tbody id="listDailyDeal">
									<!-- dailyDealData.jsp -->
								</tbody>
							</table>
						</div><!-- // table div -->
						<div class="paging_area" id="dailyDealPagination"></div>
						
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