<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 공통 코드 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
		<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>  -->
<script type="text/javascript">

$(function(){
	classListPageMove(1);
	});


function classListPageMove(nowPage) {

	$.ajax({
		url : "selectClassList.do",
		type : "post",
		data : {
			searchKind : $('#searchKindInput').val(),
			searchKeyword : $('#searchKeywordInput').val(),
			searchStartDate :  $('#searchStartDateInput').val(),
			searchEndDate :  $('#searchEndDateInput').val(),
			nowPage : nowPage
		},
		success : function(map) {
			var classList = map.classList;
			var classListPaging = map.classListPaging;
			var str = "";
			var str2 = "";
			const offset = new Date().getTimezoneOffset()*60000;
			
			$.each(classList,function(i){
				var class_Startdate = new Date(classList[i].class_Startdate-offset).toISOString().substring(0,10);
				var class_Enddate = new Date(classList[i].class_Enddate-offset).toISOString().substring(0,10);
				str+="<tr class='cPoint' onclick = 'selectUserListPre("+classList[i].class_No+",\""+classList[i].class_Nm+"\",1)'>";
				str+="<td>"+classList[i].class_Type+"</td>";
				str+="<td>"+classList[i].class_Nm+"</td>";
				str+="<td>"+classList[i].name+"</td>";
				str+="<td>"+class_Startdate+"</td>";
				str+="<td>"+class_Enddate+"</td>";
				str+="<td>"+classList[i].class_Cnt+"</td>";
				str+="<td>"+classList[i].class_Totalcnt+"</td></tr>";
			})
			for(var i = classListPaging.startPage; i <= classListPaging.endPage ; i++){
				if(i == classListPaging.nowPage){
					str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
				}else{
					str2+="<span class='pageNum pageNumColor' onclick='classListPageMove("+i+")'>"+i+"</span>&nbsp;";        						
				}
				
			}
			str2 = getPaginationHtml(classListPaging.nowPage,classListPaging.total,classListPaging.cntPerPage,classListPaging.cntPage,'classListPageMove');
			
			
			$('#nowPageInput').val(nowPage);
			$('#classListTbody').empty();
			$('#classListTbody').append(str)
			$('#classListPageTd').empty();
			$('#classListPageTd').append(str2);
		},
		error : function(e) {
			alert("페이지 이동중 ajax 통신 오류")
		}
		
	})
	
	
}

function searchResult() {				
	$('#searchKindInput').val($('#s_SearchKindSelect').prop('selected',true).val());
	$('#searchKeywordInput').val($('#s_KeywordInput').val());
	$('#searchStartDateInput').val($('#startDate').val());
	$('#searchEndDateInput').val($('#endDate').val());
	classListPageMove(1)
}
function selectUserListPre(class_No,class_Nm,nowPage) {
	$('#class_NoInput').val(class_No);
	$('#class_NmInput').val(class_Nm);
	selectUserList(nowPage);
	
}
 
 function selectUserList(nowPage) {
	 
	 var class_No = $('#class_NoInput').val();
	 var class_Nm =	$('#class_NmInput').val();
	 $.ajax({	 	
					                    	
					                    	
		 	url : "selectUserList.do",
			type : "post",
			data : {
				class_No : class_No,
				nowPage : nowPage
			},
			success : function(map) {
				var classUserList = map.classUserList;
				var classUserListPaging = map.classUserListPaging;
				var str = "";
				var str2 = "";
				var birth = "정보없음";
				var join_Yn = "정보없음";
				var gender = "정보없음";
				var email = "정보없음";
				const offset = new Date().getTimezoneOffset()*60000;
				

				 
				
				$.each(classUserList,function(i){
					if(classUserList[i].birth != null && classUserList[i].birth != ""){
						birth = new Date(classUserList[i].birth-offset).toISOString().substring(0,10);
					}
					if(classUserList[i].join_Yn != null && classUserList[i].join_Yn.trim() != ""){
						join_Yn = classUserList[i].join_Yn;
					}
					if(classUserList[i].gender != null && classUserList[i].gender.trim() != ""){
						gender = classUserList[i].gender;
					}
					if(classUserList[i].email != null && classUserList[i].email.trim() != ""){
						email = classUserList[i].email;
					}
					var reg_date = new Date(classUserList[i].reg_date-offset).toISOString().substring(0,10);
					
					str+="<tr><td>"+classUserList[i].name+"</td>";
					str+="<td>"+gender+"</td>";
					str+="<td>"+birth+"</td>";
					str+="<td>"+email+"</td>";
					str+="<td>"+join_Yn+"</td>";
					str+="<td>"+reg_date+"</td></tr>";
				})
				for(var i = classUserListPaging.startPage; i <= classUserListPaging.endPage ; i++){
					if(i == classUserListPaging.nowPage){
						str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
					}else{
						str2+="<span class='pageNum pageNumColor' onclick='selectUserList("+class_No+",\""+class_Nm+"\","+i+")'>"+i+"</span>&nbsp;";        						
					}
					
				}				
				str2 = getPaginationHtml(classUserListPaging.nowPage,classUserListPaging.total,classUserListPaging.cntPerPage,classUserListPaging.cntPage,'selectUserList');
				
				$('#classUserListTbody').empty();
				$('#classUserListTbody').append(str)
				$('#classUserListPageTd').empty();
				$('#classUserListPageTd').append(str2);
			},
			error : function(e) {
				alert("페이지 이동중 ajax 통신 오류")
			}
			
		 
		 
	 })
	 
	 
	$('#classNameSpan').html(class_Nm);
	$('#classUserListDiv').css("display","");
}
	
	
	
	
	
	
	
	

	
	
	
	
</script>
<style type="text/css">
 		.pageNum{
				margin: 5px;
				cursor: pointer;
				font-size: 18px;
				font-weight: bold;
		}
		.pageNumColor{
			color: red;
		}
		.cPoint{
			cursor: pointer;
		}
		.paging_area{
			height: 50px;
		}
</style>

</head>
<body>

	
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">수강인원/강의목록</span>
						</p>

						<p class="conTitle">
							<span>수강인원/강의목록</span> 
							
						</p>
						
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="50" height="25" style="font-size: 100%; text-align: center;">
                           <div>
	                           <select name="userSearchKind" id="s_SearchKindSelect" style="width: 150px;" >
				                    <option value="class_Nm" selected>강의 이름</option>
				                    <option value="name">강사 이름</option>
				                </select>
							
     	                       <input type="text"  style="width: 300px; height: 25px;" name="userSearchKeyword" id="s_KeywordInput">  
     	                       	&nbsp;&nbsp;&nbsp;날짜 &nbsp;: &nbsp;<input type="date" id="startDate"> ~ <input type="date" id="endDate">            
	                           <a class="btnType blue ABtn" onclick="searchResult()"><span>검  색</span></a>
	                           
	                            </div>

                           </td> 
                           
                        </tr>
                     </table>
                     <br><br><br>
						<div class="divComGrpCodList">
							<table class="col">								
	
								<thead>
									<tr>
										<th style="width: 15%">강의분류</th>
				                        <th style="width: 20%">강의이름</th>
				                        <th style="width: 15%">강사명</th>
				                        <th style="width: 15%">강의시작일</th>
				                        <th style="width: 15%">강의종료일</th>
				                        <th style="width: 10%">수강인원</th>
				                        <th style="width: 10%">정원</th>
									</tr>
								</thead>
								<tbody id="classListTbody">
	                	
	                </tbody>
	                <tfoot>
                        	<tr>
                        		<td id="classListPageTd" colspan="7" class="paging_area" style="text-align: center;">
                        			
                        		</td>
                        	</tr>
                        </tfoot>
							</table>
							<input type="hidden" name="searchKind" id="searchKindInput" >
				            <input type="hidden" name="searchKeyword" id="searchKeywordInput">
							<input type="hidden" name="searchStartDate" id="searchStartDateInput">
				            <input type="hidden" name="searchEndDate" id="searchEndDateInput">
				            <input type="hidden" id="nowPageInput" value="1">
						</div>
	
						
						
                     <br><br><br>
						
						 <div id="classUserListDiv" style="display: none;">
						 	<span style="font-size: 16px;font-weight: bold;" id="classNameSpan"></span> 강의 수강중인 인원목록
							<table class="col">								
	
								<thead>
									<tr>
										<th style="width: 20%">이름</th>
				                        <th style="width: 10%">성별</th>
				                        <th style="width: 15%">생년월일</th>
				                        <th style="width: 25%">이메일</th>
				                        <th style="width: 15%">재직여부</th>
				                        <th style="width: 15%">등록일자</th>
									</tr>
								</thead>
								<tbody id="classUserListTbody">
				                	<tr><td colspan="6" style="font-size: 20px;font-weight: bold;"><br>수강중인 인원이 없습니다<br><br></td></tr>
				                </tbody>
				                <tfoot>
			                        	<tr>
			                        		<td id="classUserListPageTd" colspan="7" class="paging_area" style="text-align: center;">
			                        			
			                        		</td>
			                        	</tr>
			                        </tfoot>
							</table>
						 </div>
                     

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
		<input type="hidden" id="class_NoInput">
		<input type="hidden" id="class_NmInput">
	</div>

	

	

</body>
</html>