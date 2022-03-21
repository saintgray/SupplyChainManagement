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
		.UITable th{
			width: 20%;
			text-align: center;
			font-size: 17px;
		}
		.titleSpan{
			font-size: 18px;
			font-weight: bold;
		}
		.paging_area{
			height: 50px;
		}
</style>
	    
<script type="text/javascript">

$(function(){
	resumeCListPageMove(1);
	});


function resumeCListPageMove(nowPage) {


	$.ajax({
		url : "resumeAllClassList.do",
		type : "post",
		data : {
			searchKeyword : $('#searchKeywordInput').val(),
			nowPage : nowPage
		},
		success : function(map) {
			var allClassList = map.allClassList;
			var allClassListPaging = map.allClassListPaging;
			var str = "";
			var str2 = "";
			const offset = new Date().getTimezoneOffset()*60000;
			
			$.each(allClassList,function(i){
				var class_Startdate = new Date(allClassList[i].class_Startdate-offset).toISOString().substring(0,10);
				var class_Enddate = new Date(allClassList[i].class_Enddate-offset).toISOString().substring(0,10);
				str+="<tr class='cPoint' onclick = 'selectUserListPre("+allClassList[i].class_No+",\""+allClassList[i].class_Nm+"\",1)'>";
				str+="<td>"+allClassList[i].class_Type+"</td>";
				str+="<td>"+allClassList[i].class_Nm+"</td>";
				str+="<td>"+allClassList[i].name+"</td>";
				str+="<td>"+class_Startdate+"</td>";
				str+="<td>"+class_Enddate+"</td>";
				str+="<td>"+allClassList[i].class_Cnt+"</td>";
				str+="<td>"+allClassList[i].class_Totalcnt+"</td></tr>";
			})
			for(var i = allClassListPaging.startPage; i <= allClassListPaging.endPage ; i++){
				if(i == allClassListPaging.nowPage){
					str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
				}else{
					str2+="<span class='pageNum pageNumColor' onclick='resumeCListPageMove("+i+")'>"+i+"</span>&nbsp;";        						
				}
				
			}
			str2 = getPaginationHtml(allClassListPaging.nowPage,allClassListPaging.total,allClassListPaging.cntPerPage,allClassListPaging.cntPage,'resumeCListPageMove');
			
			
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
	$('#searchKeywordInput').val($('#s_KeywordInput').val());
	resumeCListPageMove(1)
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
					                    	
					                    	
		 	url : "resumeUserList.do",
			type : "post",
			data : {
				class_No : class_No,
				nowPage : nowPage
			},
			success : function(map) {
				var resumeUserList = map.resumeUserList;
				var resumeUserListPaging = map.resumeUserListPaging;
				var str = "";
				var str2 = "";
				var birth = "정보없음";
				var join_Yn = "정보없음";
				var gender = "정보없음";
				var email = "정보없음";
				const offset = new Date().getTimezoneOffset()*60000;
				

				 
				
				$.each(resumeUserList,function(i){
					if(resumeUserList[i].birth != null && resumeUserList[i].birth != ""){
						birth = new Date(resumeUserList[i].birth-offset).toISOString().substring(0,10);
					}
					if(resumeUserList[i].join_Yn != null && resumeUserList[i].join_Yn.trim() != ""){
						join_Yn = resumeUserList[i].join_Yn;
					}
					if(resumeUserList[i].gender != null && resumeUserList[i].gender.trim() != ""){
						gender = resumeUserList[i].gender;
					}
					if(resumeUserList[i].email != null && resumeUserList[i].email.trim() != ""){
						email = resumeUserList[i].email;
					}
					str+="<tr class='cPoint' onclick = 'selectUser(\""+resumeUserList[i].loginID+"\")'>";					
					str+="<td>"+resumeUserList[i].name+"</td>";
					str+="<td>"+gender+"</td>";
					str+="<td>"+birth+"</td>";
					str+="<td>"+email+"</td>";
					str+="<td>"+join_Yn+"</td>";
				})
				for(var i = resumeUserListPaging.startPage; i <= resumeUserListPaging.endPage ; i++){
					if(i == resumeUserListPaging.nowPage){
						str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
					}else{
						str2+="<span class='pageNum pageNumColor' onclick='selectUserList("+class_No+",\""+class_Nm+"\","+i+")'>"+i+"</span>&nbsp;";        						
					}
					
				}				
				str2 = getPaginationHtml(resumeUserListPaging.nowPage,resumeUserListPaging.total,resumeUserListPaging.cntPerPage,resumeUserListPaging.cntPage,'selectUserList');
				
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
	
	
	
	function selectUser(loginID) {
		
		 $.ajax({	 	
         	
         	
			 	url : "resumeUser.do",
				type : "post",
				data : {
					loginID : loginID
				},
				
				
				success : function(user) {
					var str = "";
					var str2 = "";
					var birth = "정보없음";
					var join_Yn = "정보없음";
					var gender = "정보없음";
					var email = "정보없음";
					var tel = "정보없음";
					var addr = "정보없음";
					
					
					const offset = new Date().getTimezoneOffset()*60000;
					if(user.birth != null && user.birth != ""){
						birth = new Date(user.birth-offset).toISOString().substring(0,10);
					}
					if(user.join_Yn != null && user.join_Yn.trim() != ""){
						join_Yn = user.join_Yn;
					}
					if(user.gender != null && user.gender.trim() != ""){
						gender = user.gender;
					}
					if(user.email != null && user.email.trim() != ""){
						email = user.email;
					}
					if(user.tel != null && user.tel.trim() != ""){
						tel = user.tel;
					}
					if(user.zipCd != null && user.zipCd.trim() != ""){
						addr = user.zipCd+"   "+user.addr;
						
						if(user.dtl_Addr != null && user.dtl_Addr.trim() != ""){
							
						}else{
							addr += "   "+user.dtl_Addr;
						}
					}
					
					$('#loginIDTd').html(user.loginID);
					$('#nameTd').html(user.name);
					$('#telTd').html(tel);
					$('#addrTd').html(addr);
					$('#emailTd').html(email);
					$('#birthTd').html(birth);
					$('#genderTd').html(gender);
					$('#join_YnTd').html(join_Yn);

					$('#userNameSpan').html(user.name+"님 ");
					
					$('#loginIDInput').val(loginID);
					
					
					resumeUserClassList(1);
					resumeUserAwardList(loginID,1);
					resumeUserCareerList(1);
					gfModalPop("#userInfo");
				},
				error : function(e) {
					alert("페이지 이동중 ajax 통신 오류")
				}
				
			 
			 
		 })
		 
		 
	}
	
	
	function resumeUserClassList(nowPage) {
		
		var loginID = $('#loginIDInput').val();
		
		$.ajax({	 	
			
		 	url : "resumeUserClassList.do",
			type : "post",
			data : {
				loginID : loginID,
				nowPage : nowPage
			},
			success : function(map) {
				var userClassList = map.userClassList;
				var userClassListPaging = map.userClassListPaging;
				var str = "";
				var str2 = "";
				var score = "정보없음";
				var state = "정보없음";
				const offset = new Date().getTimezoneOffset()*60000;
				 
				$.each(userClassList,function(i){
					var class_Startdate = new Date(userClassList[i].class_Startdate-offset).toISOString().substring(0,10);
					var class_Enddate = new Date(userClassList[i].class_Enddate-offset).toISOString().substring(0,10);
					
					if(userClassList[i].q_Type != null && userClassList[i].q_Type.trim() != ""){
						score = userClassList[i].score;
						state = userClassList[i].state;
					}else{
						score = "정보없음";
						state = "정보없음";
					}
					
					str+="<tr>";
					str+="<td>"+userClassList[i].class_Nm+"</td>";
					str+="<td>"+userClassList[i].name+"</td>";
					str+="<td>"+class_Startdate+"</td>";
					str+="<td>"+class_Enddate+"</td>";
					str+="<td>"+userClassList[i].class_Cnt+"</td>";
					str+="<td>"+userClassList[i].class_Totalcnt+"</td>";
					str+="<td>"+score+"</td>";
					str+="<td>"+state+"</td></tr>";
				})
				
				for(var i = userClassListPaging.startPage; i <= userClassListPaging.endPage ; i++){
					if(i == userClassListPaging.nowPage){
						str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
					}else{
						str2+="<span class='pageNum pageNumColor' onclick='resumeUserClassList(\""+loginID+"\","+i+")'>"+i+"</span>&nbsp;";        						
					}
					
				}		
				
				str2 = getPaginationHtml(userClassListPaging.nowPage,userClassListPaging.total,userClassListPaging.cntPerPage,userClassListPaging.cntPage,'resumeUserClassList');
				
				if(Object.keys(userClassList).length === 0){
					str = "<tr><td colspan='8' style='text-align: center; font-size: 22px; font-weight: bold;'>수강 내역없음</td></tr>";
				}
				$('#classInfoTbody').empty();
				$('#classInfoTbody').append(str)
				$('#classInfoPageTd').empty();
				$('#classInfoPageTd').append(str2);
			},
			error : function(e) {
				alert("페이지 이동중 ajax 통신 오류")
			}
			
		 
		 
	 })
	}
	

function resumeUserAwardList(loginID,nowPage) {
	
	 $.ajax({	 	
     	
     	
		 	url : "resumeUserAwardList.do",
			type : "post",
			data : {
				loginID : loginID,
				nowPage : nowPage
			},
			success : function(map) {
				var userAwardList = map.userAwardList;
				var userAwardListPaging = map.userAwardListPaging;
				var str = "";
				var str2 = "";
				const offset = new Date().getTimezoneOffset()*60000;
				var award_Date;
				
				$.each(userAwardList,function(i){
					award_Date = new Date(userAwardList[i].award_Date-offset).toISOString().substring(0,10);
									
					str+="<tr><td>"+userAwardList[i].award_Nm+"</td>";
					str+="<td>"+award_Date+"</td></tr>";
				})
				for(var i = userAwardListPaging.startPage; i <= userAwardListPaging.endPage ; i++){
					if(i == userAwardListPaging.nowPage){
						str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
					}else{
						str2+="<span class='pageNum pageNumColor' onclick='resumeUserAwardList(\""+loginID+"\","+i+")'>"+i+"</span>&nbsp;";        						
					}
					
				}	
				if(Object.keys(userAwardList).length === 0){
					str = "<tr><td colspan='2' style='text-align: center; font-size: 22px; font-weight: bold;'>수상 내역없음</td></tr>";					
				}
				$('#awardListTbody').empty();
				$('#awardListTbody').append(str)
				$('#awardListPageTd').empty();
				$('#awardListPageTd').append(str2);
			},
			error : function(e) {
				alert("페이지 이동중 ajax 통신 오류")
			}
			
		 
		 
	 })
	 
	 
	 
	 
}
	
function resumeUserCareerList(nowPage) {
	
	var loginID = $('#loginIDInput').val();
	
	$.ajax({	 	
		
	 	url : "resumeUserCareerList.do",
		type : "post",
		data : {
			loginID : loginID,
			nowPage : nowPage
		},
		success : function(map) {
			
			var userCareerList = map.userCareerList;
			var userCareerListPaging = map.userCareerListPaging;
			var str = "";
			var str2 = "";
			const offset = new Date().getTimezoneOffset()*60000;
			 
			
			$.each(userCareerList,function(i){
				var join_Date = new Date(userCareerList[i].join_Date-offset).toISOString().substring(0,10);
				var resign_Date = new Date(userCareerList[i].resign_Date-offset).toISOString().substring(0,10);				
				
				str+="<tr>";
				str+="<td>"+userCareerList[i].corp+"</td>";
				str+="<td>"+join_Date+"</td>";
				str+="<td>"+resign_Date+"</td>";
				if(resign_Date.length != 0 && resign_Date!=null){
					str+="<td>퇴사</td>";
				}else{
					str+="<td></td>";
				}
			})
				
			for(var i = userCareerListPaging.startPage; i <= userCareerListPaging.endPage ; i++){
				if(i == userCareerListPaging.nowPage){
					str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
				}else{
					str2+="<span class='pageNum pageNumColor' onclick='userCareerListPaging(\""+loginID+"\","+i+")'>"+i+"</span>&nbsp;";        						
				}
				
			}	
			str2 = getPaginationHtml(userCareerListPaging.nowPage,userCareerListPaging.total,userCareerListPaging.cntPerPage,userCareerListPaging.cntPage,'resumeUserCareerList');
			
			if(Object.keys(userCareerList).length === 0){
				str = "<tr><td colspan='4' style='text-align: center; font-size: 22px; font-weight: bold;'>취업 이력 없음</td></tr>";
			}
			$('#careerListTbody').empty();
			$('#careerListTbody').append(str)
			$('#careerListPageTd').empty();
			$('#careerListPageTd').append(str2);
		},
		error : function(e) {
			alert("페이지 이동중 ajax 통신 오류")
		}
		
	 
	 
 })
}
	
</script>

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
								class="btn_nav bold">취업관리</span> <span class="btn_nav bold">이력서 관리</span>
						</p>

						<p class="conTitle">
							<span>이력서 관리</span> 
							
						</p>
						
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="50" height="25" style="font-size: 100%; text-align: center;">
                           <div>
                           		강의 이름 : 
							
     	                       <input type="text"  style="width: 300px; height: 25px;" name="userSearchKeyword" id="s_KeywordInput">  
     	                       	&nbsp;&nbsp;<a class="btnType blue ABtn cPoint" onclick="searchResult()"><span>검  색</span></a>
	                           
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
										<th style="width: 25%">이름</th>
				                        <th style="width: 15%">성별</th>
				                        <th style="width: 20%">생년월일</th>
				                        <th style="width: 25%">이메일</th>
				                        <th style="width: 15%">재직여부</th>
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
		<input type="hidden" id="loginIDInput">
	</div>

	<!-- 모달팝업 -->
	<div id="userInfo" class="layerPop layerType2" style="width: 950px;">
		<dl>
			<dt>
				<strong><span class="titleSpan" id="userNameSpan"></span>이력서</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<span class="titleSpan">개인정보 : </span><br><br>
				<table class="row UITable" style="width: 900px">
					
					<tbody>
						<tr>
							<th rowspan="2">성명 </th>
							<td colspan="3">(아이디) 
								<span id="loginIDTd"></span>
							</td>
						</tr>
						<tr>
							<td colspan="3">(이름) 
								<span id="nameTd"></span>
							</td>
						</tr>
						<tr>
							<th>연락처 </th>
							<td colspan="3" id="telTd">
							</td>
						</tr>
						<tr>
							<th>이메일 </th>
							<td colspan="3" id="emailTd">
							</td>
						</tr>
						<tr>
							<th>주소 </th>
							<td colspan="3" id="addrTd">
							</td>
						</tr>
						<tr>
							<th>생일 </th>
							<td id="birthTd">
							</td>
							<th>성별 </th>
							<td id="genderTd">
							</td>
						</tr>
						<tr>
							<th>취업여부 </th>
							<td colspan="3" id="join_YnTd">
							</td>
						</tr>
						
					</tbody>
					
				</table>
				
				<br><br>
				<span class="titleSpan">수상내역 : </span><br><br>
				<table class="col UITable" style="width: 900px">
					<thead>
						<tr>
							<th style="width: 50%">수상명 </th>
							<th style="width: 50%">수상일자</th>
						</tr>
						
					</thead>
					
					<tbody id="awardListTbody">
						<tr>
							<td colspan="2" style="text-align: center; font-size: 22px; font-weight: bold;">
								수상 내역없음
							</td>
						
						</tr>
				
						
					</tbody>
					<tfoot>
                       	<tr>
                       		<td id="awardListPageTd" colspan="2" class="paging_area" style="text-align: center;">
                       			
                       		</td>
                       	</tr>
                       </tfoot>
				</table>
				
				<br><br>
				
				<span class="titleSpan">수강정보 : </span><br><br>
				<table class="col UITable" style="width: 900px">
					<thead>
									<tr>
				                        <th style="width: 15%">강의이름</th>
				                        <th style="width: 15%">강사명</th>
				                        <th style="width: 15%">강의시작일</th>
				                        <th style="width: 15%">강의종료일</th>
				                        <th style="width: 10%">수강인원</th>
				                        <th style="width: 10%">정원</th>
										<th style="width: 10%">시험점수</th>
										<th style="width: 10%">과락여부</th>
									</tr>
								</thead>
					
					<tbody id="classInfoTbody">
						<tr>
							<td colspan="8" style="text-align: center; font-size: 22px; font-weight: bold;">
								수강 내역없음
							</td>
						
						</tr>
				
						
					</tbody>
					<tfoot>
                       	<tr>
                       		<td id="classInfoPageTd" colspan="8" class="paging_area" style="text-align: center;">
                       			
                       		</td>
                       	</tr>
                       </tfoot>
				</table>
				
				<br><br>
				<span class="titleSpan">취업이력 : </span><br><br>
				<table class="col UITable" style="width: 900px">
					<thead>
						<tr>
							<th style="width: 20%">회사이름 </th>
							<th style="width: 30%">입사일자</th>
							<th style="width: 30%">퇴사일자</th>
							<th style="width: 20%">비고</th>
						</tr>
						
					</thead>
					
					<tbody id="careerListTbody">
						<tr>
							<td colspan="4" style="text-align: center; font-size: 22px; font-weight: bold;">
								취업 이력 없음
							</td>
						
						</tr>
				
						
					</tbody>
					<tfoot>
                       	<tr>
                       		<td id="careerListPageTd" colspan="4" class="paging_area" style="text-align: center;">
                       			
                       		</td>
                       	</tr>
                       </tfoot>
				</table>
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a class="btnType gray ABtn cPoint"   name="btn" onclick="gfCloseModal()"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	

</body>
</html>