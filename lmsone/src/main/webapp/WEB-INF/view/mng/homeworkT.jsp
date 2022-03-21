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
		.homeworkContentTable th{
			text-align: center;
		}
		.ABtn,.titleTd,#sortTh{
			cursor: pointer;
		}
		.homeworkTable th{
		 width: 20%;
		}
		.HW_H_Tr { 
			display: none;
		}
		.hwSubmitContent th{
			width: 20%;
		}
		.c_pointer{
			cursor: pointer;
		}
		.paging_area{
			height: 50px;
		}
</style>
<script type="text/javascript">	

$(function(){
	classListPageMove(1);
	});
	
function classListPageMove(nowPage) {
	$.ajax({
		url : "tClassListMovePage.do",
		type : "post",
		data : {
			nowPage : nowPage
		},
		success : function(map) {
			var classInfoList = map.classInfoList;
			var CIListPaging = map.CIListPaging;
			var str = "";
			var str2 = "";
			const offset = new Date().getTimezoneOffset()*60000;
			
			$.each(classInfoList,function(i){
				var class_Startdate = new Date(classInfoList[i].class_Startdate-offset).toISOString().substring(0,10);
				var class_Enddate = new Date(classInfoList[i].class_Enddate-offset).toISOString().substring(0,10);
				str+="<tr><td class='c_pointer' onclick='selectHomeworkListPre("+classInfoList[i].class_No+",1,\""+classInfoList[i].class_Nm+"\")'>"+classInfoList[i].class_Nm+"</td>";
				str+="<td>"+classInfoList[i].name+"</td>";
				str+="<td>"+class_Startdate+"</td>";
				str+="<td>"+class_Enddate+"</td>";
				str+="<td>"+classInfoList[i].class_Type+"</td></tr>";
			})
			for(var i = CIListPaging.startPage; i <= CIListPaging.endPage ; i++){
				if(i == CIListPaging.nowPage){
					str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
				}else{
					str2+="<span class='pageNum pageNumColor' onclick='classListPageMove("+i+")'>"+i+"</span>&nbsp;";        						
				}
				
			}
			
			str2 = getPaginationHtml(CIListPaging.nowPage,CIListPaging.total,CIListPaging.cntPerPage,CIListPaging.cntPage,'classListPageMove');
			
			
			$('#nowClassNameInput').val(nowPage)
			$('#nowPageInput').val(nowPage)
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

function selectHomeworkListPre(class_No,nowPage,class_Nm) {
	$('#class_NoInput').val(class_No);
	$('#class_NmInput').val(class_Nm);
	selectHomeworkList(nowPage);
	
}
	
	function selectHomeworkList(nowPage) {
		
		 var class_No = $('#class_NoInput').val();
		 var className =	$('#class_NmInput').val();

		const offset = new Date().getTimezoneOffset()*60000;
		$.ajax({
			url : "selectHomeworkList.do",
			tyep : "post",
			data : {
				class_No : class_No,
				nowPage : nowPage
			},
			success : function(map) {
				
				var homeworkListPaging = map.homeworkListPaging;
				var homeworkList = map.homeworkList;
				var str1 = "";
				var str2 = "";
				$.each(homeworkList, function(i) {
					var hw_Date = new Date(homeworkList[i].hw_Date-offset).toISOString().substring(0,10);
					var fileName = "";
					if(homeworkList[i].file_Name == null||homeworkList[i].file_Name == undefined){
						fileName = "없음";
					}else{
						fileName = homeworkList[i].file_Name;
					}
					str1 += "<tr><td class='c_pointer' onclick='selectHomework("+homeworkList[i].hw_No+")'>"+homeworkList[i].hw_Subject+"</td><td>"+homeworkList[i].class_nm+"</td>";
					str1 += "<td>"+homeworkList[i].name+"</td><td>"+hw_Date+"</td><td><span  class = 'c_pointer' onclick = 'hwFileDownload("+homeworkList[i].no+")'>"+fileName+"</span></td></tr>";
				})
				
				for(var i = homeworkListPaging.startPage; i <= homeworkListPaging.endPage ; i++){
					if(i == homeworkListPaging.nowPage){
						str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
					}else{
						str2+="<span class='pageNum pageNumColor' onclick='selectHomeworkList("+i+")'>"+i+"</span>&nbsp;";        						
					}
					
				}
				$('.HWTitleTr').css("display","table-row")
				$('.HW_Content').css("display","none")
				$('#insertHWBtnDiv').css("display","table-row")
				
				$('#classNameSpan').html(className+" 강의 과제목록")
				$('#class_NoInput').val(class_No);
				$('#class_NoHWInput').val(class_No);
				
				$('#nowPageInput').val(nowPage);
				$('#HWListTbody').empty();
				$('#HWListTbody').append(str1);

				$('#HWListPageTd').empty();
				$('#HWListPageTd').append(str2);
					
			},
			error : function(e) {
				alert("과제 리스트 로딩중 ajax 통신 오류");
			}
			
		})
		
	}
	
	
	
	function selectHomework(hw_No) {
		
		$.ajax({
		
			url : "selectTHomework.do",
			type : "post",
			data : {
				hw_No : hw_No,
				loginID : $('#loginIDInput').val()
			},
			success : function(map) {
				
				var homework = map.homework;
				var submitCheck = map.submitCheck;
				var fileName = "";
				var str = "";
				if(homework.file_Name == null||homework.file_Name == undefined){
					
					$('#updateFileDiv').css("display","none");	
					fileName = "없음";
					str = fileName;
					$('#fileCheckInput').val("N");
				}else{

					$('#updateFileDiv').css("display","");
					$('#fileCheckInput').val("Y");
					$('#noUpdateInput').val(homework.no);
					
					fileName = homework.file_Name;
					str = "<span  class = 'c_pointer' onclick = 'hwFileDownload("+homework.no+")'>"+fileName+"</span>"
				}
				
				$('#updateFileTr').css("display","");
				$('.HW_Content').css("display","table-row");
				$('#HWTitleTd').html(homework.hw_Subject);
				$('#HWContentTd').html(homework.hw_Content);
				$('#HWFlieTd').html(str);
				$('#hwHomeworkFlieSpan').html(str);
				
				
				$('#hw_No_U_Input').val(homework.hw_No);
				$('#class_NoInput').val(homework.class_No);
				$('#hw_Subject_U_Input').val(homework.hw_Subject);
				$('#hw_U_contentTextArea').text(map.updateHomeworkContent);
				$('#hw_No_U_Input').val(homework.hw_No);
				
				
			},
			error : function(e) {
				alert("과제 불러오기중 ajax 통신 오류");
			}
			
			
		})
		
	}
	function insertHomeworkForm() {
		$('#hw_SubjectInput').val("");
		$('#hw_contentTextArea').val("");
		$('#homeworkFileInput').val("");
		gfModalPop("#insertHomework");
		
		
		
	}

	function insertHomework() {
		if($('#hw_contentTextArea').val().trim()==""){
			 alert("과제 내용을 입력하셔야 합니다.");
			 return false;
		 }
		 if(!$('#hw_SubjectInput').val()){
			 alert("과제 제목을 입력하셔야 합니다.");
			 return false;
		 }
		/* var formData = $("#insertHwsubmitForm").serialize(); */
		var formData = new FormData($("#insertHomeworkForm")[0]);
		
		$.ajax({
            url : "insertHomework.do", 
            type : 'POST', 
            cache: false,
            contentType: false, 
            processData: false,
            data : formData, 
            success : function(str) {
            	
            	var hw_No = parseInt(str);
            	
            	gfCloseModal();
            	$('#class_NoInput').val($('#class_NoHWInput').val());
            	selectHomeworkList(1);
            }, 
    
            error : function(e) {
                alert ("답안 등록중 ajax통신 오류");
            }
        });
	}	
	
	
	function hwFileDownload(no) {
		$('#hwNoInput').val(no)
		$('#homeworkFlieDownloadForm').submit();
	}
	
	function fileDownload() {
		$('#flieDownloadForm').submit();
	}
	
	
	function updateHomeworkForm() {
		$('#flie_U_Input').val("");
		gfModalPop("#updateHomework");
	}
	
	function updateDelFile() {		
		   $('#fileDelCheckInput').val("Y");	
		   $('#updateFileTr').css("display","none");
		   $('#flie_U_Input').val("");
	}
	
	
	function updateHomework() {
		if($('#hw_U_contentTextArea').val().trim()==""){
			 alert("글 내용을 입력하셔야 합니다.");
			 return false;
		 }
		if(!$('#hw_Subject_U_Input').val()){
			 alert("과제 제목을 입력하셔야 합니다.");
			 return false;
		 } 
		/* var formData = $("#insertHwsubmitForm").serialize(); */
		var formData = new FormData($("#updateHomeworkForm")[0]);
		$.ajax({
            url : "updateHomework.do", 
            type : 'POST', 
            cache: false,
            contentType: false, 
            processData: false,
            data : formData, 
            success : function(str) {
            	
            	gfCloseModal();
            	
            	selectHomework($('#hw_No_U_Input').val());
            }, 
    
            error : function(e) {
                alert ("과제 수정중 ajax통신 오류");
            }
        });
	}
	
	
	
	
	
	
	
	function deleteHomework() {
		var class_No = $('#class_NoInput').val();
		var nowPage = $('#nowPageInput').val();
		if(!confirm("정말 과제를 삭제 하시겠습니까?")){
			 return false;
		 }
		$.ajax({
           url : "deleteHomework.do", 
           type : 'POST', 
           data : {
        	   hw_No : $('#hw_No_U_Input').val(),
        	   fileCheck : $('#fileCheckInput').val(),
        	   no : $('#noUpdateInput').val()
           },
           success : function(str) {
        	   
       		gfCloseModal();
       	 	selectHomeworkList(class_No,nowPage);
           }, 
   
           error : function(e) {
               alert ("답안 삭제중 ajax통신 오류");
           }
       });
		
		
	}
	
	function selectHWSubmitList(nowPage) {
		var hw_No = $('#hw_No_U_Input').val();
		
		$.ajax({
			url : "selectHWSubmitList.do",
			type : "post",
			data : {
				hw_No : hw_No,
				nowPage : nowPage
			},
			success : function(map) {
				
				var HWSubmitListPaging = map.HWSubmitListPaging;
				var HWSubmitList = map.HWSubmitList;
				var str1 = "";
				var str2 = "";
				var fileDown = "";
				const offset = new Date().getTimezoneOffset()*60000;
				$.each(HWSubmitList, function(i) {
					var hw_Date = new Date(HWSubmitList[i].hw_Date-offset).toISOString().substring(0,10);
					var fileName = "";
					var submitCheck = "";
					var hw_DateCheck = "";
					if(HWSubmitList[i].file_Name == null||HWSubmitList[i].file_Name == undefined){
						fileDown = "없음";
						
					}else{
						fileDown = "<span  class = 'c_pointer' onclick = 'hwFileDownload("+HWSubmitList[i].file_No+")'>"+HWSubmitList[i].file_Name+"</span>";
					}
					if(HWSubmitList[i].hw_Submit_No==0){
						submitCheck = "<td>미제출</td>";
						hw_Date = "미제출";
					}else{
						submitCheck = "<td class='c_pointer' onclick='selectTHwsubmit("+HWSubmitList[i].hw_Submit_No+")'>제출(클릭시 상세오픈)</td>";
						
						
					}
					str1 += "<tr><td>"+HWSubmitList[i].hw_Subject+"</td><td>"+HWSubmitList[i].name+"</td><td>"+hw_Date+"</td>";
					str1 += "<td>"+fileDown+"</td>"+submitCheck+"</tr>";
				})
				
				for(var i = HWSubmitListPaging.startPage; i <= HWSubmitListPaging.endPage ; i++){
					if(i == HWSubmitListPaging.nowPage){
						str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
					}else{
						str2+="<span class='pageNum pageNumColor' onclick='selectHWSubmitList("+i+")'>"+i+"</span>&nbsp;";        						
					}
					
				}
				
				str2 = getPaginationHtml(HWSubmitListPaging.nowPage,HWSubmitListPaging.total,HWSubmitListPaging.cntPerPage,HWSubmitListPaging.cntPage,'selectHWSubmitList');
				
				
				$('#hwSubmitListTbody').empty();
				$('#hwSubmitListTbody').append(str1);

				$('#hwSubmitListPageTd').empty();
				$('#hwSubmitListPageTd').append(str2);
				$('#submitListNowPageInput').val(nowPage);
				
				gfModalPop("#selectHWSubmitList");
			},
			error : function(e) {
				alert("과제 제출인원 리스트 로딩중 ajax 통신 오류")
			}
		})
		
	}
	
	function selectTHwsubmit(hw_Submit_No) {
		$.ajax({
			
			
			url : "selectTHwsubmit.do",
			type : "post",
			data : {
				hw_Submit_No : hw_Submit_No
			},
			success : function(map) {
				var str = "";
				var hwSubmit = map.hwSubmit;
				if(hwSubmit.no != 0){
				   str = "<a class = 'c_pointer' onclick='fileDownload()'>"+map.flieName+"</a>";
				}
				$('#hwSubmitContentTd').html(hwSubmit.hw_Content);
				$('#hwSubmitFlieTd').html(str);
				$('#noInput').val(hwSubmit.no);
				
				gfModalPop("#selectTHwsubmit");
			},
			error : function(e) {
				alert("과제 불러오기중 ajax 통신 오류")
			}
			
			
		})
	}
	
	function hwSubmitClose() {
		
		
		gfCloseModal();
		selectHWSubmitList($('#submitListNowPageInput').val());
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">과제</span>
						</p>

						<p class="conTitle">
							<span>과제</span>
							
						</p>
							
						<div class="divComGrpCodList">
							<br>
							<span style="font-size: 20px;font-weight: bold;">강의중인 수업</span><br><br>
							<table class="col homeworkTable">
								
	
								<thead>
									<tr>
										<th>수업 이름</th>
				                        <th>강사</th>
				                        <th>수업 시작일</th>
				                        <th>수업 종료일</th>
				                        <th>수업 분류</th>
									</tr>
								</thead>
								<tbody id="classListTbody">
	                	<c:forEach items="${requestScope.classInfoList}" var="list" varStatus="status">
		                    <tr>
		                        <td class="c_pointer" onclick="selectHomeworkList(${list.class_No},1,'${list.class_Nm}')">${list.class_Nm}</td>
		                        <td>${list.name}</td>
		                        <td><fmt:formatDate value="${list.class_Startdate}" pattern="yyyy-MM-dd" /></td>
		                        <td><fmt:formatDate value="${list.class_Enddate}" pattern="yyyy-MM-dd" /></td>
		                        <td>${list.class_Type}</td>
		                    </tr>
	                    </c:forEach>
	                </tbody>
	                <tfoot>
                        	<tr>
                        		<td id="classListPageTd" colspan="5" class="paging_area" style="text-align: center;">
                        			<c:forEach begin="${requestScope.CIListPaging.startPage}" end="${requestScope.CIListPaging.endPage}" var="item">
                        				
                        				
                        				<c:if test="${item == requestScope.CIListPaging.nowPage}">
                        					<span class="pageNum">${item}</span>
                        				</c:if>
                        				<c:if test="${item != requestScope.CIListPaging.nowPage}">
                        					<span class="pageNum pageNumColor" onclick="classListPageMove(${item})">${item}</span>
                        				</c:if>                       			
                        			</c:forEach>
                        			&nbsp;
                        		</td>
                        	</tr>
                        </tfoot>
							</table>
						
						
						
						
						
								<br><br><br><br>
								<div id="insertHWBtnDiv" class="HW_H_Tr">
									<table style="width: 1020px;"><tr>
										<td>
											<span id = "classNameSpan" style="font-size: 20px; font-weight: bold;"></span>
										</td>
										<td style="text-align: right;">
											<a class="btnType blue ABtn" onclick="insertHomeworkForm()" name="btn"><span>과제 등록</span></a>
										</td>
									</tr></table>
								</div>
								<br><br>
								
								
								<table class="col homeworkTable">
								
	
								<thead>
									<tr class = "HW_H_Tr HWTitleTr">
										<th>과제 이름</th>
										<th>수업 이름</th>
				                        <th>강사</th>
				                        <th>과제등록일</th>
				                        <th>첨부파일</th>
				                        
									</tr>
								</thead>
								<tbody id="HWListTbody">
	                </tbody>
	                <tfoot>
                        	<tr class = "HW_H_Tr HWTitleTr">
                        		<td id="HWListPageTd" colspan="5" class="paging_area" style="text-align: center;">
                        			
                        		</td>
                        	</tr>
                        </tfoot>
							</table>
                     <input type="hidden" name="nowPage" id="nowPageInput">
                     <input type="hidden" name="nowPage" id="submitListNowPageInput">
                     <input type="hidden" name="nowClassName" id="nowClassNameInput">

			<br><br><br><br>
			<div style="width: 1020px;" class = "HW_H_Tr HW_Content">
			 
			 <table style="width: 1020px;">
			 <tr>
				<td>
					<a class="btnType blue ABtn" onclick="selectHWSubmitList(1)" name="btn"><span>제출 인원 확인</span></a>
				</td>
				<td style="text-align: right;">
					<a class="btnType blue ABtn" onclick="updateHomeworkForm()" name="btn"><span>과제 수정</span></a>
				<a class="btnType blue ABtn" onclick="deleteHomework()" name="btn"><span>과제 삭제</span></a>
				</td>
			</tr></table>
			 <br><br>
			<table class="row  homeworkContentTable" style="width: 1020px;">
					

					<tbody>
						<tr >
							<th style="width: 20%;">과제 제목</th>
							<td id="HWTitleTd">
							</td>
						</tr>
						<tr>
							<th style="width: 20%;">과제 내용</th>
							<td style="height: 100px;  text-align: left;" id="HWContentTd" >
							</td>
						</tr>
				
						<tr>
							<th style="width: 20%;">첨부파일</th>
							<td id="HWFlieTd">
								
							</td>
						</tr>
						
					</tbody>
					<tfoot>
						
					</tfoot>
				</table>
				</div>
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
	<div>
		<form action="flieDownload.do" method="post" id="homeworkFlieDownloadForm">
				<input type="hidden" name="no" id="hwNoInput">
		</form>
	</div>
	<!-- 모달팝업 -->
	<div id="insertHomework" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>과제 등록</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<form action="insertHomework" method="post" id="insertHomeworkForm" enctype="multipart/form-data">
				<table class="row">
					

					<tbody>
						<tr>
							<th>과제 제목<span class="font_red">*</span></th>
							<td id="HWTitleTd" colspan="3">
								<input type="text" maxlength="20" placeholder="20자 내로 입력해주세요" class="inputTxt p100" name="hw_Subject" id="hw_SubjectInput">						
							</td>
						</tr>
						<tr>
							<th>과제 내용<span class="font_red">*</span></th>
							<td colspan="3"><textarea name="hw_Content" id="hw_contentTextArea" style="height: 200px; width: 600px;" cols="60" rows="10" maxlength="500" placeholder="500자 내로 입력해 주세요"></textarea>
							<input type="hidden" name="loginID" value="${sessionScope.loginId}" id="loginIDInput">
							<input type="hidden" name="class_No" id="class_NoHWInput">
							
                        </td>
						</tr>
						<tr>
							<th>첨부파일 등록</th>
							<td><input type="file" name="homeworkFile" id="homeworkFileInput"></td>
						</tr>
						
					</tbody>
				</table>
				 </form>
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a class="btnType blue ABtn" onclick="insertHomework()" name="btn"><span>답안 등록</span></a> 
					<a class="btnType gray ABtn"  name="btn" onclick="gfCloseModal()"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	
	
	<!-- 모달팝업 -->
	<div id="updateHomework" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>과제 수정</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<form action="updateHomework.do" method="post" id="updateHomeworkForm" enctype="multipart/form-data">
				
				
				
				<table class="row">
					

					<tbody>
						<tr>
							<th>과제 제목 <span class="font_red">*</span></th>
							<td id="HWTitleTd" colspan="3">
								<input type="text" maxlength="20" placeholder="20자 내로 입력해주세요" class="inputTxt p100" name="hw_Subject" id="hw_Subject_U_Input">						
							</td>
						</tr>
						<tr>
							<th>과제 내용<span class="font_red">*</span></th>
							<td colspan="3"><textarea name="hw_Content" id="hw_U_contentTextArea" style="height: 200px; width: 600px;" cols="60" rows="10" maxlength="500" placeholder="500자 내로 입력해 주세요"></textarea>
							
							<input type="hidden" name="fileCheck" id="fileCheckInput" value="N">
							<input type="hidden" name="fileDelCheck" id="fileDelCheckInput" value="N">
							<input type="hidden" name="hw_No" id="hw_No_U_Input">
							<input type="hidden" name="no" id="noUpdateInput" value="0">
                        </td>
						</tr>
						<tr id="updateFileTr">
							<th>첨부파일 교체</th>
							<td>
								<div id="updateFileDiv">저장된 첨부 파일 &nbsp;: &nbsp;&nbsp;<span id="hwHomeworkFlieSpan"></span>&nbsp;&nbsp;<button type="button" onclick="updateDelFile()">교체 없이 파일 삭제</button></div>
								<input type="file" name="homeworkFile" id="flie_U_Input">
							</td>
						</tr>
						
					</tbody>
				</table>
				
				 </form>
				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a class="btnType blue ABtn" onclick="updateHomework()" name="btn"><span>수정 등록</span></a> 
					<a class="btnType gray ABtn"  name="btn" onclick="gfCloseModal()"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<!-- 모달팝업 -->
	<div id="selectHWSubmitList" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>과제 제출 인원</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				
				
				
				<table class="col homeworkTable">
								
	
								<thead>
									<tr>
										<th>과제 제목</th>
				                        <th>학생명</th>
				                        <th>제출 시간</th>
				                        <th>파일</th>
				                        <th>제출여부</th>
									</tr>
								</thead>
								<tbody id="hwSubmitListTbody">
	                	
	                </tbody>
	                <tfoot>
                        	<tr>
                        		<td id="hwSubmitListPageTd" colspan="5" class="paging_area" style="text-align: center;">
                        			
                        		</td>
                        	</tr>
                        </tfoot>
							</table>
						
				
				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a class="btnType gray ABtn"  name="btn" onclick="gfCloseModal()"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!-- 모달팝업 -->
	<div id="selectTHwsubmit" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>제출 과제</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row hwSubmitContent">
					

					<tbody>
						<tr>
							<th>답안 내용</th>
							<td id="hwSubmitContentTd">
							
                        </td>
						</tr>
						<tr>
							<th>첨부파일
							<form action="flieDownload.do" method="post" id="flieDownloadForm">
									<input type="hidden" name="no" id="noInput">
								</form>
							 </th>
							<td id="hwSubmitFlieTd">
								
								
							</td>
						</tr>
						
					</tbody>
				</table>
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a class="btnType gray ABtn"  name="btn" onclick="hwSubmitClose()"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
</body>
</html>