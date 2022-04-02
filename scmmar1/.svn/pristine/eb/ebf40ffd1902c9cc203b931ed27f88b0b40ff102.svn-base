<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<style>

	.searchArea{
		margin-top: 35px;
	    padding: 50px 0;
	    border: 2px solid rgb(190,190,190);
	}
	#searchBtnWrap{
		display: inline-block;
		margin: 0 10px;
	}
	#salesListArea{
		margin-bottom:30px;
	}
	#salesListArea table, #salesInfoArea table{
		margin:0 auto;
	}
	#salesInfoArea {
		display:flex;
		flex-direction :row;
		justify-content: space-around;
		margin-top: 50px;
		border: 2px solid rgb(190,190,190);
		padding-left:50px;
	}
	#salesInfoArea table{
		border-collapse: separate;
		border-spacing: 5px 10px;
	}
	#salesInfoArea #representPhoto{
		width:100%;
		height:230px;
		margin-top:20px;
	}
	#dtInfoArea{
		height:200px;
	}
	#area-left, #area-right{
		flex: 1 1 auto !important;
	
	}
</style>
<title>제품 정보 관리</title>

<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>
<body>


<!--GLOBAL MASKING -->
<div id="mask"></div>


<!-- GLOBAL WRAP -->
<div id="wrap_area">


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
                  
                  	<span class="btn_nav bold">기준정보</span> 
                  	<span class="btn_nav bold">제품 정보 관리</span> 
                  
                  	<a href="${CTX_PATH}/scm/productMng.do" class="btn_set refresh">새로고침</a>
                </p>
				<!-- SearchArea -->
				<div class="searchArea">
					<table style="margin-top: 10px" width="100%" cellpadding="5" cellsapcing="0" border="1">
					   <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                       <select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
     	                       		<option value="all">전체</option>
									<option value="sales_nm" >제품명</option>
									<option value="model_nm" >모델명</option>
									<option value="mfcomp">제조사</option>
							   </select>
							   
				
     	                       <input type="text" style="width: 300px; height: 25px;" id="keyword">
     	                       
     	                       
     	                       <div class="bts" id="searchBtnWrap">
     	                       		<button type="button" class="btn btn-primary" id="searchBtn">검색</button>
     	                       </div>                 
	                           
                            </td> 
                       	</tr>
					</table>
				</div>
				
				<div class="bts mt10">
					<div class="salesMngBtnArea text-right">
						<button type="button" class="btn btn-primary" id="btnNewSales">제품 등록</button>
					</div>
				</div>
				
				
				<!-- SALES LIST WRAP -->
				<div id="salesListWrap"></div>
				
				
				
				
				<!-- REGISTER // DELETE // UPDATE // INFO FORM -->
				<form id="salesInfoForm"></form>
				
				
				
						        
            
            
            </div>
            
            
         
         </li>
      </ul>
   </div>

</div>



</body>

<script>
	

	$(document).ready(function(){
		
		connectEvent();
		
		getSalesList();
		
		
	})
	
	function connectEvent(){
		
		$('body').on('click','.salesMngBtnArea button, #salesListTable td',function(){
			
			console.log("...entering Event...");
			
			var param={action:'',
						sales_id:''}
			
			switch($(this).attr('id')){
			
			// Form request Control
			case 'btnNewSales':
				param.action='NEW';
				break;
			case undefined :
				param.action='INFO';
				parm.sales_id=$(this).siblings().eq(3).text();
				break;
				
			// Register / Edit / Update Control
			case 'btnRegister':
				$('#action').val($('#action').val()=='NEW'?'REGISTER':'UPDATE');
				fManageSales();
				return;
			case 'btnDelete':
				$('#action').val('DELETE');
				fManageSales(param);
				return;
			}
			
			
			
			console.log(param.action);
			
			callAjax('${CTX_PATH}/scm/sales/form', 'POST', 'text',true, param, fPopUpSaleInfoForm);
			
			
			
		})
		
	}
	
	
	function getSalesList(selectPage){
		
		
		
		var param={
				keyword:$('#keyword').val(),
				searchType :$('#searchKey').val(),
				selectPage : (selectPage == null || selectPage == "undefined") ? 1 : selectPage,
				rowsPerPage : 5
		}
		
		var callback=function(data){
			fSalesListCallback(data,param)
		}
		
		callAjax('${CTX_PATH}/scm/saleslist','post','text',true, param, callback);
		
	}
	
	function fSalesListCallback(data,param){
		
		
		
		var paginationHtml = getPaginationHtml(
												param.selectPage, 
												$(data).find('#totalCount').val(), 
												param.rowsPerPage,
												5, 
												'getSalesList'
												);

		$('#salesListWrap').empty().append(data).append(paginationHtml);
	}
	
	function fPopUpSaleInfoForm(data){
		
		$('#salesInfoForm').empty().append(data);
	}
	
	function fManageSales(){
		
		
		
		callAjaxFileUpload('${CTX_PATH}/scm/sales/manage', 'POST', 'json',true, 'salesInfoForm', fAfterManageCallback);
	}
	
	function fAfterManageCallback(data){
		
		var action=$('#action').val();
		
		if(data==1){
			if(action=='REGISTER'){
				alert('정상적으로 등록되었습니다');
			}else if(action=='UPDATE'){
				alert('정상적으로 수정되었습니다');
			}else{
				alert('정상적으로 삭제되었습니다');
			}
			
		}else{
			alert('오류가 발생하였습니다 잠시 후 다시 시도하세요');
		}
		
		$('#salesInfoForm').empty();
		
	}

</script>
</html>