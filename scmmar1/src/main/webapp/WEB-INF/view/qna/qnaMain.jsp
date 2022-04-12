<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='/js/sweetalert/sweetalert.min.js'></script>
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
	#qnaListArea{
		margin-bottom:30px;
		
	}
	#qnaListArea table{
		margin:0 auto;
		border-collapse: separate;
    	border-spacing: 10px 5px;
	}

</style>
<title>1:1 문의</title>
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
                  
                  	<span class="btn_nav bold">1:1 문의</span> 
                  	 
                  
                  	<a href="${CTX_PATH}/sti/inquiry.do" class="btn_set refresh">새로고침</a>
                </p>
				<!-- SearchArea -->
				<div class="searchArea">
					<table style="margin-top: 10px" width="100%" cellpadding="5" cellsapcing="0" border="1">
					   <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                       <select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
     	                       		<option value="all">전체</option>
									<option value="qna_title">제목</option>
									<option value="qna_content">내용</option>
							   </select>
							   
				
     	                       <input type="text" style="width: 300px; height: 25px;" id="keyword">
     	                       
     	                       
     	                       <div class="bts" id="searchBtnWrap">
     	                       		<button type="button" class="btn btn-primary" id="searchBtn">검색</button>
     	                       </div>                 
	                           
                            </td> 
                       	</tr>
					</table>
				</div>
				
				<div id="qnaListArea"></div>
				
            </div>
         </li>
      </ul>
   </div>

</div>


</body>


	<script>
		$(document).ready(function(){
			
			connectEvents();
			getQnaList();
			
		})
		
		function connectEvents(){
			// 버튼 클릭시 이벤트
			$('#searchBtn').on('click',function(){
				getQnaList();
			})
			// 검색창에서 엔터누를시 자동검색
			$('#keyword').on('keydown',function(e){
				if(e.keyCode==13){
					getQnaList();
				}
			})
			//
			
			
		}
		
		
		
		function getQnaList(num){
			var param={
					selectPage :num=num || 1,
					rowsPerPage:5,
					searchType:$('#searchKey').val(),
					keyword:$('#keyword').val()
			}
			var callback=function(data){
				fAfterGetList(data,param)
			}
			callAjax('${CTX_PATH}/sti/qna/list', 'POST', 'text',true, param, callback);
		}
		function fAfterGetList(data, param){
			
			console.log($('#sp').val());
			console.log($('#tc').val());
			
			$('#qnaListArea').empty()
							.append(data)
							.append(getPaginationHtml($('#sp').val(), 
												  $('#tc').val(),
												  param.rowsPerPage,
												  5, 
												  'getQnaList'
												  ));
			
		}
		
	</script>
	
	
</html>