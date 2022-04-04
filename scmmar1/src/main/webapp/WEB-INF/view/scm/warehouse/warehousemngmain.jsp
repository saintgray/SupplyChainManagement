<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
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
     	                       
     	                       
     	                       <div class="bts" id="searchBtnWrap">
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

<script>
	$(document).ready(function(){
		
		connectEvent();
		getWareHouseList();
	})

	
	
	
	function connectEvent(){
		
		$('body').on('click', '.btnMngWareHouseArea button, #whListArea table td',function(){
			
			
			switch($(this).attr('id')){
				case 'searchBtn':
					getWareHouseList();
					return;
				case undefined:
					showForm($(this),'INFO');
					return;
				
				case 'btnRegNew':
					showForm($(this),'NEW');
					return;
				case 'close':
					$('#whFormArea').empty();
					return;
			
			}	

		})
		
		// 창고코드 값 (Primary key) 변경 차단
		$('body').on('keydown','#wh_id',function(e){
			
			alert('변경할 수 없는 값입니다');
			e.preventDefault();
			$(this).attr('readonly',true);
			
		})
		
		
		
		
	}
	
	
	function getWareHouseList(selectPage){
		
		var param={
				keyword:$('#keyword').val(),
				searchType :$('#searchKey').val(),
				selectPage : (selectPage == null || selectPage == "undefined") ? 1 : selectPage,
				rowsPerPage : 5
		}
		
		var callback=function(data){
			fAfterGetList(data,param);
		}
		
		callAjax('${CTX_PATH}/scm/whlist','post','text',true,param,callback)
		
	}
	function fAfterGetList(data,param){
		
		$('#whListArea').empty().append(data);
		
	}
	
	function showForm(dom,act){
		
		var param={	action:act, wh_id:''}
		if(param.action=='INFO'){
			
			param.wh_id=$(dom).parent().children('.wh_id').html();
		}
		var callback=function(data){
			fAfterShowForm(data, param);	
		}
		
		callAjax('${CTX_PATH}/scm/whinfo','post','text',true,param,callback)
		
	}
	function fAfterShowForm(data,param){
		
		$('#whFormArea').empty().css('display','none').append(data);
		// param에 따른 분기로직 
		if(param.action=='INFO'){
			comcombo('B','advisor','sel',$('#name').val(),'${CTX_PATH}/scm/whComcombo.do');
		}
		//////
		
		$('#whFormArea').css('display','block');
		
	}

</script>
</html>