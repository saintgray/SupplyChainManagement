<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<style>

	#st-btn{
		width:51px;
		height:51px;
		position: fixed;
		bottom: 30px;
	    right: 30px;
	    cursor: pointer;
	    background-image: url(/images/mainicons.png);
	    background-size: 457px 434px;
	    background-position: -148px -210px;
	    background-repeat: no-repeat;
	}
	


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
	#formwrap{
		margin-top: 50px;
		margin-bottom:50px;
		border: 2px solid rgb(190,190,190);
		padding-left:50px;
	}
	
	#salesInfoArea {
		display:flex;
		flex-direction :row;
		justify-content: space-around;
		
	}
	
	#salesInfoArea table{
		border-collapse: separate;
		border-spacing: 5px 10px;
	}
	#salesImgArea{
		display: flex;
		flex-direction: column;
		position: relative;
		
	}
	#shortImages{
	    display: flex;
    	flex-wrap: nowrap;
		margin-top:10px;
		height:80px;
		width: 200px;
		padding: 10px;
		overflow-x:scroll;
		white-space: nowrap;
	}
	#shortImages img{
		width:50px;
		height:50px;
		margin: 0 5px;
	
	}
	#formwrap ::-webkit-scrollbar{
		background-color:white;
		height:10px;
	}
	#formwrap ::-webkit-scrollbar-thumb{
		background-color:rgb(197,197,197);
		border-radius:10px;
	}
	
	#l_files{
     	position: absolute;
	    top: 20px;
	    width: 15px;
	    height: 15px;
	    background: url(/images/treeview/plus.gif);
	    background-repeat: no-repeat;
	    background-position: 1px 1px;
	    background-size: 15px 15px;
	}
	#files{
		visibility: hidden;
	}
	#salesInfoArea #representPhoto{
		width:200px;
		height:200px;
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

<!-- scroll top btn -->
<div id="st-btn"></div>


<%@include file="/WEB-INF/view/scm/sales/pageset/salesMngMainPageset.jsp" %>
</body>

</html>