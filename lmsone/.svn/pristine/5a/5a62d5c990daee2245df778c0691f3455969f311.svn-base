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
		.lectureTable td,.lectureTable th{
			width: 12.5%;
			text-align: center;
		}
		.paging_area{
			height: 50px;
		}
</style>
<script type="text/javascript">

$(function(){
	lectureListPageMove(1);
	});

function lectureListPageMove(nowPage) {
	$.ajax({
		url : "selectLectureList.do",
		type : "post",
		data : {
			nowPage : nowPage
		},
		success : function(map) {

			var lectureList = map.lectureList;
			var lectureListPaging = map.lectureListPaging;
			var str = "";
			var str2 = "";
			const offset = new Date().getTimezoneOffset()*60000;

			$.each(lectureList,function(i){
				

				var class_Startdate = new Date(lectureList[i].class_Startdate-offset).toISOString().substring(0,10);
				var class_Enddate = new Date(lectureList[i].class_Enddate-offset).toISOString().substring(0,10);
				str+="<tr class='cPoint' onclick = 'selectLecture("+lectureList[i].class_No+")'>";
				
				str+="<td>"+lectureList[i].class_Nm+"</td>";
				str+="<td>"+lectureList[i].name+"</td>";
				str+="<td>"+class_Startdate+"</td>";
				str+="<td>"+class_Enddate+"</td></tr>";
			})
			for(var i = lectureListPaging.startPage; i <= lectureListPaging.endPage ; i++){
				if(i == lectureListPaging.nowPage){
					str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
				}else{
					str2+="<span class='pageNum pageNumColor' onclick='lectureListPageMove("+i+")'>"+i+"</span>&nbsp;";        						
				}
				
			}
			str2 = getPaginationHtml(lectureListPaging.nowPage,lectureListPaging.total,lectureListPaging.cntPerPage,lectureListPaging.cntPage,'lectureListPageMove');
			
			$('#nowPageInput').val(nowPage);
			$('#lectureListTbody').empty();
			$('#lectureListTbody').append(str)
			$('#lectureListPageTd').empty();
			$('#lectureListPageTd').append(str2);
		},
		error : function(e) {
			alert("페이지 이동중 ajax 통신 오류")
		}
		
	})
	
	
}

function selectLecture(class_No) {


	$.ajax({	 	
		
		
	 	url : "selectLecture.do",
		type : "post",
		data : {
			class_No : class_No
		},
		success : function(lecture) {
			var str = "";
			var str2 = "";
			var room_Nm = "정보없음";
			var class_Plan = "정보없음";
			var class_Obj = "정보없음";
			var file_name = "파일없음";
			const offset = new Date().getTimezoneOffset()*60000;
			if(lecture.room_Nm != null && lecture.room_Nm != ""){
				room_Nm = lecture.room_Nm;
			}
			if(lecture.class_Plan != null && lecture.class_Plan != ""){
				class_Plan = lecture.class_Plan;
			}
			if(lecture.class_Obj != null && lecture.class_Obj != ""){
				class_Obj = lecture.class_Obj;
			}
			if(lecture.file_name != null && lecture.file_name != ""){
				str2 = "<td onclick = 'fileDownload("+lecture.no+")'>"+file_name+"</td>";
				$('#noInput').val(lecture.no);
			}else{
				str2 = "<td>"+file_name+"</td>";
			}
			var class_Startdate = new Date(lecture.class_Startdate-offset).toISOString().substring(0,10);
			var class_Enddate = new Date(lecture.class_Enddate-offset).toISOString().substring(0,10);
			
			$('#class_NmTd').html(lecture.class_Nm);
			$('#dateTd').html(class_Startdate+" ~ "+class_Enddate);
			$('#nameTd').html(lecture.name);
			$('#room_NmTd').html(room_Nm);
			$('#class_CntTd').html(lecture.class_Cnt);
			$('#class_TotalcntTd').html(lecture.class_Totalcnt);
			$('#class_ObjTd').html(class_Obj);
			$('#class_PlanTd').html(class_Plan);
			
			/* $('#file_nameTd').html(str2); */
	
	
			$('#classNameSpan').html(lecture.class_Nm);
			$('#classInfoDiv').css("display","");
		},
		error : function(e) {
			alert("수업정보 로딩중 ajax 통신 오류")
		}
	
	 
	})

}

function fileDownload() {
	alert($('#noInput').val());
	/* $('#flieDownloadForm').submit(); */
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">수강목록</span>
						</p>

						<p class="conTitle">
							<span>수강목록</span> 
							
						</p>
						
                     <br><br><br>
						<div class="divComGrpCodList">
							<table class="col">								
	
								<thead>
									<tr>
				                        <th style="width: 30%">강의이름</th>
				                        <th style="width: 20%">강사명</th>
				                        <th style="width: 25%">강의시작일</th>
				                        <th style="width: 25%">강의종료일</th>
									</tr>
								</thead>
								<tbody id="lectureListTbody">
	                	
	                </tbody>
	                <tfoot>
                        	<tr>
                        		<td id="lectureListPageTd" colspan="7" class="paging_area" style="text-align: center;">
                        			
                        		</td>
                        	</tr>
                        </tfoot>
							</table>
				            <input type="hidden" id="nowPageInput" value="1">
						</div>
	
						
						
                     <br><br><br>
						
						 <div id="classInfoDiv" style="display: none;">
						 	<span style="font-size: 17px;font-weight: bold;" id="classNameSpan"></span> 수업 정보<br><br>
							<table class="row lectureTable">
					
						<tbody>
							<tr>
								<th>과목명 </th>
								<td colspan="3" id="class_NmTd"></td>
								<th>강의 기간</th>
								<td colspan="3" id="dateTd"></td>
							</tr>
							<tr>
								<th>강사이름 </th>
								<td id="nameTd"></td>
								<th>강의실위치 </th>
								<td id="room_NmTd"></td>
								<th>수강인원 </th>
								<td id="class_CntTd"></td>
								<th>수강정원</th>
								<td id="class_TotalcntTd"></td>
							</tr>
							<tr>
								<th colspan="2">수업목표 </th>
								<td colspan="6" id="class_ObjTd"></td>
							</tr>
							<tr>
								<th colspan="2">강의계획 </th>
								<td colspan="6" style="height: 200px;" id="class_PlanTd"></td>
							</tr>
							
							<!-- <tr>
								<th colspan="2">수강계획서 
									<form action="planFlieDownload.do" method="post" id="flieDownloadForm">
										<input type="hidden" name="no" id="noInput">
									</form>
								</th>
								<td colspan="6" id="file_nameTd"></td>
							</tr> -->
							
						</tbody>
				</table>
						 </div>
                     

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	

</body>
</html>