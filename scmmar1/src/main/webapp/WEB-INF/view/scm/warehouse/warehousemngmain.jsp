<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>

<!-- DAUM Postcode cdn API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

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
	#whListArea{
		margin-bottom:30px;
	}
	#whListArea table, #whInfoArea table{
		margin:0 auto;
		
	}

	#btn-close-daum{
		position:absolute;
		right:0;
	    bottom: 0;
	    z-index: 11;
	    cursor: pointer;
		
	}
	
	
	#formwrap{
		margin-top: 50px;
		margin-bottom:50px;
		border: 2px solid rgb(190,190,190);
		padding-left:50px;
		
	}
	#formwrap #formtable{
		border-collapse: separate;
		border-spacing: 10px 10px;
		margin:10px auto;
	}
	#formwrap #phoneArea input{
		width: 100px;
	}
	


</style>
<title>창고정보 관리</title>
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
                  	<span class="btn_nav bold">창고 정보 관리</span> 
                  
                  	<a href="${CTX_PATH}/scm/whinfo.do" class="btn_set refresh">새로고침</a>
                </p>
				<!-- SearchArea -->
				<div class="searchArea">
					<table style="margin-top: 10px" width="100%" cellpadding="5" cellsapcing="0" border="1">
					   <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                       <select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
     	                       		<option value="all">전체</option>
									<option value="wh_nm" >창고명</option>
									<option value="wh_loc" >창고 위치</option>
							   </select>
							   
				
     	                       <input type="text" style="width: 300px; height: 25px;" id="keyword">
     	                       
     	                       
     	                       <div class="bts btnMngWareHouseArea" id="searchBtnWrap">
     	                       		<button type="button" class="btn btn-primary" id="searchBtn">검색</button>
     	                       </div>                 
	                           
                            </td> 
                       	</tr>
					</table>
				</div>
				
				<div id="whListArea" class="mt30"></div>
				
				
				<form id="whFormArea"></form>
				
            </div>
         </li>
      </ul>
   </div>

</div>


</body>
<%@ include file="/WEB-INF/view/scm/warehouse/pageset/warehouseManagePageset.jsp" %>

</html>