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
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<style>
	#dirRadioArea{
		display: flex;
		justify-content: space-around;
	}
	#v-warehouse{
		margin:15px;
		display: flex;
		width:675px;
		flex-direction:row;
		flex-wrap:wrap;
		justify-content:space-between;
	}
 	#v-orderAndReturn{
 		width:350px;
 		margin:20px auto;
 	}
	#v-warehouse>div{
		margin:10px;
	}
	#v-orderAndReturn>div{
		position: relative;
	}
	#layer{
	    max-height: 500px;
   		overflow-y: scroll;
	}
	.remove{
		position: absolute;
		right: 5px;
		top: 5px;
		width:10px;
		height:10px;
		cursor: pointer;
	}
</style>
<title>일별수주내역</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

var pageSize = 10;
var pageBlockSize = 5;
var returnsearch = '';	// 반품 목록 조회 검색 조건
var selectsearch = '';	// 검색 조건 일자 구분
var datesearch1 = '';	// 검색 조건 앞 날짜
var datesearch2 = '';	// 검색 조건 뒤 날짜
var pur_id = '';
today = new Date();
today = today.toISOString().slice(0, 10);
var sales_id = '';
var test = '';
var loginID='';

// onload list 및 검색조건 함수 불러오기
$(function(){
	
	$('#serchdate2').val(today);
	connectEvent();
	init();
	
});

// list 조회
function init(currentPage) {
	
	currentPage = currentPage || 1;
	var param = {	
			currentPage : currentPage
		,	pageSize : pageSize
		,	returnsearch : returnsearch
		,	selectsearch : selectsearch
		,	datesearch1 : datesearch1
		,	datesearch2 : datesearch2
		,	pur_id : pur_id
			}
	var resultCallback = function(data) {
		
		// list tbody에 넣는 내용
		$("#dailyOrderlist").empty().append(data);
		var total = $('#total').val();
		
		// 페이지 네비게이션 생성
		// pageBlockSize 보여지는 페이징 갯수
		var paginationHtml = getPaginationHtml(currentPage, total,  pageSize, pageBlockSize, 'init');
		console.log("paginationHtml : " + paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml );
	};
	callAjax("/scm/listdailyOrderHistory.do", "post", "text", true, param, resultCallback);
}

function connectEvent(){
	// 발주대상 제외
	$('body').on('click','.remove',function(){
		if(confirm($(this).prev().text()+' 발주를 취소하시겠습니까?')){
			$(this).parent().parent().remove();	
		}
	})
	// 발주 수량 숫자만 삭정
	$('body').on('keydown','.orderCnt',function(e){
		 fFilterNumber(e);
	})
	
	// 주문 상세 내역 팝업
	$('body').on('click','#dailyOrderlist tr',function(){
		
		var callback=function(data){
			$("#layer").empty().append(data);
			gfModalPop("#layer");
		}
		callAjax('/scm/purchaseinfo/'+$(this).children().eq(0).text(),"post", "text",true,null,callback);

	})
	
	// 지시서 form 요청
	$('body').on('change','#dirRadioArea input[type=radio]',function(){
		if($(this).is(':checked')){
			
			let id =$(this).attr('id');
			let url='';
			let dataType='';
			let param={};
			var callback;
			switch(id){
			///////////////////////////////
				case 'orderDir':
					param={pur_id:$(this).val()};
					callback=function(data){
						console.log('order dir input ');
						$('#v-warehouse, #v-orderAndReturn').remove();
						$('#layer').append(data);
						$('#action').val(id);
						if($('.su').length>0){
							let combo_name=$('.sb').eq(0).attr('id');
							$('.su').each(function(index,item){
								// console.log('sb'+index);
								// comcombo('','sb'+index,null,null,'/scm/whCombo.do');
								comcombo('','su'+index,null,null,'/scm/supply/comnCod.do');
							});
						}
					};
					break;
				case 'shippingDir':
					
					param=null;
					callback=function(data){
						$('#v-warehouse, #v-orderAndReturn').remove();
						$('#layer').append(data);
						$('#action').val(id);
					}
					break;
			///////////////////////////////
			}
			 callAjax(
					 	'/scm/callDirForm/'+id+'/'+$(this).val(),
						'post',
						'text',
						true,
						param,
						callback
					);	
		}	
	})
	
	// 상품에 대한 발주시 상품당 출고할 창고번호  다중 선택 방지
	$('body').on('change','#v-warehouse table input[type=checkbox]',function(){
		$(this).parent().
				parent().
				siblings().
				children().
				children('input[type=checkbox]').
				attr('checked',false);
	})
	
	// 배송 및 발주 지시서 작성
	$('body').on('click','.btn_areaC #writeBtn',function(){
		let action=$('#action').val();
		console.log(action);
		var param={};
		switch(action){
			case 'shippingDir':
				console.log($('#layer #orderinfo tr').length-1);
				console.log($('#v-warehouse table').length);
				if($('#layer #orderinfo tr').length-1!= $('#v-warehouse table').length){
					alert('창고에 없는 구매상품이 있습니다. 발주 후 진행하세요');
					return;
				}else{
					var purinfIdxArr=[];
					$('.targetIdx').each(function(index,item){
						purinfIdxArr.push($(item).text());
					})
					var exportWhArr=[];
					$('.shippingTarget:checked').each(function(index,item){
						exportWhArr.push($(item).val());
					})
					console.log(purinfIdxArr);
					console.log(exportWhArr);
					param={
							idxList:purinfIdxArr,
							targetWh:exportWhArr
						  };
					
				}
				break;
			case 'orderDir':
				var whArr=[];
				$('#v-orderAndReturn .orderinfo').each(function(index,item){
					console.log($(item).children('.salesinfo').children('input').val());
					console.log($(item).children('.su').val());
					console.log($(item).children('.orderCnt').val());
					whArr.push($(item).children('.salesinfo').children('input').val()+','+$(item).children('.su').val()+','+$(item).children('.orderCnt').val());
				})
				console.log(whArr);
				param={targetWh:whArr};
				break;
			}
		// end of switch
		var callback=function(data){
			if(data>0){
				swal('작성되었습니다');
			}else{
				swal('오류가 발생했습니다. 잠시 후 다시 시도하세요');
			}
			init($('.paging_area strong').text());
		};
		// 지시서 작성 요청 전달
		console.log(param);
		callAjax('/scm/dirManage/'+$('#action').val(),'POST','json',true,param,callback);
		
	})
	
}

// 반품/미반품 목록 검색 조회
function returns(value){
	
	returnsearch = value;
	init();
}
function search(){
	
	selectsearch = $("#searchgrouptype option:selected").val();
	datesearch1 = $("#serchdate1").val();
	datesearch2 = $("#serchdate2").val();
	var testdate ='';
	
	if(datesearch1 < datesearch2){
		datesearch1 = datesearch1;
		datesearch2 = datesearch2
		
	}else{
		testdate = datesearch2;
		datesearch2 = datesearch1;
		datesearch1 = testdate;
		
		$('#serchdate1').val(datesearch1);
		$('#serchdate2').val(datesearch2);
		
	}
	init();
	
}

// 검색 조건 초기화
function reset(){
	$('#serchdate1').val('');
	$('#serchdate2').val(today);
	$('#returnsearch1').prop('checked',false);
	$('#returnsearch2').prop('checked',false);
	$('#searchgrouptype').val('');
	
	init();
}

// 지시서 작성 radio 모달창 실행
function orderhi(purid,salesid,login_ID,rYN,dYN){
	pur_id = purid;
	sales_id = salesid;
	loginID = login_ID;
	gfModalPop("#layer1");
	var price_sum = $("#price_sum").val(); 
	var pur_cnt = $("#pur_cnt").val(); 
	
	// 반품,입금 유무에 따른 지시서 작성 버튼 활성화 
	if(dYN =='N'){
		$("#sel1").css("display","none");
		$("#sel2").css("display","none");
		$("#sel4").css("display","none");
		$("#sel5").css("display","none");
	}else{
		$("#sel1").css("display","inline-block");
		$("#sel2").css("display","inline-block");
		$("#sel4").css("display","inline-block");
		$("#sel5").css("display","inline-block");
		
		if(rYN == 'Y'){
			$("#sel2").css("display","none");
			$("#sel3").css("display","none");
			$("#sel5").css("display","none");
			$("#sel6").css("display","none");
		}else{
			 $("#sel1").css("display","none");
			 $("#sel4").css("display","none");
			 $('#sel2').css("display","inline-block"); 
			 $('#sel3').css("display","inline-block"); 
			 $('#sel5').css("display","inline-block"); 
			 $('#sel6').css("display","inline-block"); 
		}
	}
}

// 지시서 작성  팝업 구분 실행
function layer1btn(){
	var selcheck = $('input:radio[name=sel]:checked').val();
	if(selcheck == null){
		alert("지시서를 선택해 주세요.");
	}else{
		var param = {	
				pur_id : pur_id
			,	selcheck : selcheck
			,	sales_id : sales_id
				}
		var resultCallback = function(data) {
			console.log(data);
			console.log(param.selcheck);
			$("#layer").empty().append(data);
			gfModalPop("#layer");
		};
		callAjax("/scm/onedailyOrderHistory.do", "post", "text", true, param, resultCallback);
	}
}

function whcnt(v){
	var param = {
			sales_id : sales_id
		,	wh_id : v
	}
	var resultCallback = function(data){
		
		if(data.whcnt == null){
			alert(data.msg);
		}else{
			$("#warehcnt").html(data.whcnt.st_cnt);
			test = data.whcnt.st_cnt;
		}
	}
	callAjax("/scm/whcnd.do", "post", "json", true, param, resultCallback);
}

// 주문 입력 수가 총 재고수 넘지 못하게 막기
function t(){
	var val = $("#warehinput").val();
	if(val > test){
		alert("재고가 부족 합니다.");
		$("#warehinput").val('');			
		return;
	}
}

//지시서 작성
function send(f){
	
	//배송지시서
	if(f == 'wa'){
		var deliv_wh_id = $('#wasel option:selected').val();		// 창고 지정
		var delname = $('#purchaser option:selected').val();	// 배송담당자 지정
		var pur_cnt =$('#warehinput').val();					// 수량 지정
		var param = {
				active : f					// 구분자
			,	pur_id : pur_id				// 구매 번호
			,	name : delname				// 배송 담당자
			,	deliv_wh_id : deliv_wh_id	// 창고 타임
			,	sales_id : sales_id
				}
		var resultCallback = function(data){
			alert(data.msg);
			closemodel();
		}
		callAjax("/scm/sendtotal.do", "post", "json", true, param, resultCallback);
		
	//발주지시서
	}else if(f == 'com'){
		console.log(f);
		var a = $("#compcnt").val();
		var b = $("#selcomcnt").val();
		var selcheck = $('#selcomcnt option:selected').val();
		
		var param = {
				com_cnt : a				// 발주 개수
			,	com_code : b			// 발주 회사 코드
			,	sales_id : sales_id		// 제품 코드 
			,	active : f				// 구분자
			,	pur_id : pur_id			// 구매 번호
			,	loginID : loginID		// 구매한 이용자 아이디
			,	wh_id : selcheck		// 창고 선택 코드 
				}
		var resultCallback = function(data){
			alert(data.msg);
			closemodel();
		}
		callAjax("/scm/sendtotal.do", "post", "json", true, param, resultCallback);
		
	//반품지시서	
	}else if(f == 're'){
		var sales_nm = $("#sales_nm").val();
		var pur_cnt_one = $("#pur_cnt_one").val();
		var name = $("#name").val();
		var return_cnt = $("#return_cnt").val();
		console.log("pur_id : " + pur_id);
		console.log("sales_nm : " + sales_nm);
		console.log("pur_cnt_one : " + pur_cnt_one);
		console.log("name : " + name);
		console.log("return_cnt : " + return_cnt);
		console.log("pur_cnt type : " + typeof(pur_cnt_one));
		
		var param = {
					active : f				// 구분자
				,	pur_id : pur_id
				,	sales_nm : sales_nm
				,	pur_cnt_one : pur_cnt_one
				,	name : name
				,	return_cnt : return_cnt
				}
		var resultCallback = function(data){
			alert(data.msg);
			$("#ordersned").css("display","none"); 
			closemodel();
		}
		
		callAjax("/scm/sendtotal.do", "post", "json", true, param, resultCallback);
	}
}

// 취소시 모달창 닫기
function closemodel(){
	gfCloseModal();
}

function addrow(){
	alert(" 행 추가 ");
}


</script>


</head>
<body>
<form id="myForm" action=""  method="">
    <input type="hidden" name="selfrpcd" id="selfrpcd" value="">
    <input type="hidden" name="selfrpnm" id="selfrpnm" value="">
	
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
								class="btn_nav bold">Sample</span> <span class="btn_nav bold">일별수주내역</span> 
								<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>일별수주내역</span> 
							<span class="fr">
								 <input type="radio" id="returnsearch1" name="returnsearch" class="returnsearch" value="a" onclick="returns(this.value)" style="cursor: pointer;">반품요청 목록 조회    
	                             <input type="radio" id="returnsearch2" name="returnsearch" class="returnsearch" value="b" onclick="returns(this.value)" style="cursor: pointer;">미반품요청 목록 조회
							     <select id="searchgrouptype"  name="searchgrouptype" style="width: 150px;">
							            <option value="" >전체</option>
							    		<option value="0" >주문일자로 조회</option>
							    		<option value="1" >반품처리일자로 조회</option>
							     </select> 
							     <input type = "date" id="serchdate1" name="serchdate1"> ~
							     <input type = "date" id="serchdate2" name="serchdate2">
	                              <a class="btnType blue" id="btnSearchGrpcod" name="btn" style="cursor: pointer;"><span onclick="search()" >검  색</span></a>
	                              <a class="btnType blue" id="btnSearchGrpcod" name="btn" style="cursor: pointer;"><span onclick="reset()" >초기화</span></a>
	                             
							</span>
    
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="4%">
									<col width="6%">
									<col width="6%">
									<!-- 
									<col width="10%">
									<col width="6%">
									<col width="6%"> 
									-->
									<col width="6%">
									<col width="6%">
									<col width="4%">
									<!-- <col width="8%"> -->
									<col width="4%">
									<col width="8%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">주문번호</th>
										<th scope="col">주문일자</th>
										<th scope="col">고객명</th>
										<!-- 
										<th scope="col">제품명</th>
										<th scope="col">재고수</th>
										<th scope="col">단가</th> 
										-->
										<th scope="col">주문수</th>
										<th scope="col">총 금액</th>
										<th scope="col">반품요청</th>
										<!-- <th scope="col">반품처리일자</th> -->
										<th scope="col">입금</th>
										<th scope="col">지시서 작성</th>
									</tr>
								</thead>
								
								<!-- 일별 수주내역 Data 영역 -->
								<tbody id="dailyOrderlist"></tbody>
								
								
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
	
	<div id="layer" class="layerPop layerType2 bts" style="width: auto;"></div>
	
	
</form>
</body>
</html>