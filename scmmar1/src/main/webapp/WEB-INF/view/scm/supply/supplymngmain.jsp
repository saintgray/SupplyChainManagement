<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<title>납품 업체 정보</title>

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
	#supplyListArea{
		margin-bottom:30px;
	}
	#supplyListArea table, #impSalesListArea table{
		margin:0 auto;
	}
</style>
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
                  	<span class="btn_nav bold">납품업체 관리</span> 
                  
                  	<a href="${CTX_PATH}/scm/supplierInfo.do" class="btn_set refresh">새로고침</a>
                </p>
				<!-- SearchArea -->
				<div class="searchArea">
					<table style="margin-top: 10px" width="100%" cellpadding="5" cellsapcing="0" border="1">
					   <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                       <select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
     	                       		<option value="all">전체</option>
									<option value="comp_nm" >회사명</option>
									<option value="sales_nm" >제품명</option>
							   </select>
							   
				
     	                       <input type="text" style="width: 300px; height: 25px;" id="keyword">
     	                       
     	                       
     	                       <div class="bts" id="searchBtnWrap">
     	                       		<button type="button" class="btn btn-primary" id="searchBtn">검색</button>
     	                       </div>                 
	                           
                            </td> 
                       	</tr>
					</table>
				</div>
			    <!-- SUPPLY LIST WRAP -->
				<div id="supplyListWrap"></div>
				
				<!-- IMP SALES LIST WRAP -->
				<div id="impSalesWrap"></div>
				
            </div>
         </li>
         
        
      </ul>
      
      
      
      
   </div>

</div>


</body>

<script>
	$(document).ready(function(){
		
		connectEvent();
		getSuppliers();
		
	})
	
	
	function connectEvent(){
		
		// 검색버튼 이벤트
		$('#searchBtn').on('click',function(){
			getSuppliers();
		})
		
		$('#keyword').on('keydown',function(e){
			
			if(e.keyCode==13){
				$('#searchBtn').trigger('click');
			}
		})
		
		// 회사의 납품 상품 정보 보기
		$('#supplyListWrap').on('click','#supplyListTable td',function(){
			
			getImpSales($(this).parent().children('.comp_id').html());
			
		})
	}
	
	
	
	
	function getSuppliers(selectPage){
		
		var param={
					selectPage:(selectPage==undefined || selectPage=='')?1:selectPage,
					rowsPerPage:5,
					searchType:$('#searchKey').val(),
					keyword:$('#keyword').val()		
		}
		console.log(param);
		var callback=function(data){
			fAfterGetSuppliers(data,param);
		}
		
		callAjax('${CTX_PATH}/scm/supplier/list','post','text',true, param, callback);
	}
	
	function fAfterGetSuppliers(data,param){
		
		$('#supplyListWrap').empty()
							.append(data)
							.append(
									getPaginationHtml(
														param.selectPage, 
														$(data).find('#totalCount').val(), 
														param.rowsPerPage,
														5, 
														'getSuppliers'
														)
									)
	}
	
	
	function getImpSales(compID){
		
		console.log(compID);
		var callback=function(data){
			
			$('#impSalesWrap').empty().append(data);
		}
		
		callAjax('${CTX_PATH}/scm/supplier/info','post','text',true,{comp_id:compID},callback);
		
	}

</script>
</html>