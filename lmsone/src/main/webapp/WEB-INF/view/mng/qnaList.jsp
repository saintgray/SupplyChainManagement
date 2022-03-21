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
		#noticeListPageTd,#qnaReplyTfoot td{
			text-align: center;
		}
		.ABtn,.titleTd,#sortTh{
			cursor: pointer;
			
		}
		#qnaReplyTfoot th{
			background-color: lightgray;
			font-size: 15px;
			font-weight: bold;
		}
		#qnaDetail th{
			width : 180px;
			font-size: 18px;
			font-weight: bold;
		}
		.updateReplyForm{
			display: none;
		}		
		.paging_area{
			height: 50px;
		}
</style>
<script type="text/javascript">
function qnaListPageMove(nowPage) {
	
	$.ajax({
		url : "qnaListPageMove.do",
		type : "post",
		data : {
			searchKind : $('#searchKindInput').val(),
			searchKeyword : $('#searchKeywordInput').val(),
			nowPage : nowPage
		},
		success : function(map) {
			var qnaList = map.qnaList;
			var qnaListPaging = map.qnaListPaging;
			var str = "";
			var str2 = "";
			const offset = new Date().getTimezoneOffset()*60000;
			
			$.each(qnaList,function(i){
				var board_Date = new Date(qnaList[i].board_Date-offset).toISOString().substring(0,10);
				str+="<tr><td style='text-align: left; padding-left: 20px' onclick='selectDetail("+qnaList[i].board_No+")'  class='titleTd'>"+qnaList[i].board_Nm+"</td>";
				str+="<td>"+board_Date+"</td>";
				str+="<td>"+qnaList[i].name+"</td></tr>";
			})
			for(var i = qnaListPaging.startPage; i <= qnaListPaging.endPage ; i++){
				if(i == qnaListPaging.nowPage){
					str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
				}else{
					str2+="<span class='pageNum pageNumColor' onclick='qnaListPageMove("+i+")'>"+i+"</span>&nbsp;";        						
				}
				
			}
			
			str2 = getPaginationHtml(qnaListPaging.nowPage,qnaListPaging.total,qnaListPaging.cntPerPage,qnaListPaging.cntPage,'qnaListPageMove');
			
			
			$('#nowPageInput').val(nowPage)
			$('#qnaListTbody').empty();
			$('#qnaListTbody').append(str)
			$('#qnaListPageTd').empty();
			$('#qnaListPageTd').append(str2);
		},
		error : function(e) {
			alert("페이지 이동중 ajax 통신 오류")
		}
		
	})
	
	
}

function searchResult() {				
	$('#searchKindInput').val($('#s_SearchKindSelect').prop('selected',true).val());
	$('#searchKeywordInput').val($('#s_KeywordInput').val());
	qnaListPageMove(1)
}

 function insertNotice(){
	 if($('#board_ContentTextArea').val().trim()==""){
		 alert("글 내용을 입력하셔야 합니다.");
		 return false;
	 }
	 if(!$('#board_NmInput').val()){
		 alert("글 제목을 입력하셔야 합니다.");
		 return false;
	 }
	 $('#insertNoticeForm').submit();
	 
}
 
 function selectDetail(board_No) {
	 
	$.ajax({
		url : "selectQnaDetail.do",
		type : "post",
		data : {
			board_No : board_No
		},
		success : function(map) {
			var qnaReplyListPaging = map.qnaReplyListPaging;
			var qna = map.qna;
			var qnaReplyList = map.qnaReplyList;
			var str1 = "";
			var str2 = "";
			var str3 = "";			
			const offset = new Date().getTimezoneOffset()*60000;

			$('#qnaTitleTd').html(qna.board_Nm);
			$('#qnaContentTd').html(qna.board_Content);
			$('#board_NmUpdateInput').val(qna.board_Nm);
			$('#board_ContentUpdateTextArea').text(map.updateContent);
			$('#updateBoard_NoInput').val(qna.board_No);
			
			if($('#userTypeInput').val() == 'A'|| $('#loginIDInput').val()== qna.loginID){
				
				$('#updateDeleteTd').css("display","");
				
			}else{
				$('#updateDeleteTd').css("display","none");
			}
			
			 
			
			
			$.each(qnaReplyList, function(i) {
				var updateReplyContent = qnaReplyList[i].reply_Content.replaceAll('<br>','\r\n');					
				var userTitle;
				if(qnaReplyList[i].user_Type == 'A'){
					userTitle = " 관리자";
				}else if(qnaReplyList[i].user_Type == 'C'){
					userTitle = " 학생";
				}else if(qnaReplyList[i].user_Type == 'D'){
					userTitle = " 강사";
				}
				if(i==0){
					str3 = "<th style = 'background-color: white;text-align: center; font-size: 20px; font-weight: bold; border: none;'>↳</th>";
				}else{
					str3 = "<th style = 'background-color: white;'></th>";
				}
				
				
				var reply_Date = new Date(qnaReplyList[i].reply_Date-offset).toISOString().substring(0,10);
				str1 += "<tr><td><br><br><td></tr>";
				str1 += "<tr>"+str3+"<th>작성자</th><th>내용</th><th>작성일</th></tr>";
				str1 += "<tr><td></td><td>"+qnaReplyList[i].name+userTitle+"</td><td>"+qnaReplyList[i].reply_Content+"</td><td>"+reply_Date+"</td></tr>";
				
				
				if($('#userTypeInput').val() == 'A'|| $('#loginIDInput').val()== qnaReplyList[i].loginID){
					
					str1 += "<tr><td><br><td><tr>";
					str1 += "<tr><td colspan = '3'></td><td style = 'text-align: right;padding-right: 10px;'><button type='button' onclick='updateReplyForm("+qnaReplyList[i].reply_No+")'>수정</button> ";
					str1 += "<button type='button' onclick='deleteReply("+qnaReplyList[i].reply_No+",1)'>삭제</button></td></tr>";
					str1 += "<tr class = 'updateReplyForm' id = 'updateR"+qnaReplyList[i].reply_No+"'><td></td><td colspan = '3'><textarea id='tt'>"+updateReplyContent+"</textarea>";
					str1 += "<button type='button' onclick='updateReply("+qnaReplyList[i].reply_No+",1)'>수정완료</button> <button type='button' onclick='closeUpdateReply()'>닫기</button></td></tr>";
					
				}
				
				

			})
			str2 += "<tr><td><br></td></tr><tr><td></td><td colspan = '3'>"
		/* 	for(var i = qnaReplyListPaging.startPage; i <= qnaReplyListPaging.endPage ; i++){
				if(i == qnaReplyListPaging.nowPage){
					str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
				}else{
					str2+="<span class='pageNum pageNumColor' onclick='qnaReplyPageMove("+i+")'>"+i+"</span>&nbsp;";        						
				}

			} */
			str2 += getPaginationHtml(qnaReplyListPaging.nowPage,qnaReplyListPaging.total,qnaReplyListPaging.cntPerPage,qnaReplyListPaging.cntPage,'qnaReplyPageMove');
			
			str2 += "</td></tr>"
			$('#board_NoInput').val(qna.board_No);
			$('#qnaReplyTfoot').empty();
			$('#qnaReplyTfoot').append(str1+str2)
			i_ReplyClose();
			gfModalPop("#qnaDetail");
		},
		error : function(e) {
			alert("qna 상세보기 연결중 ajax 통신 오류")
		}
		
	})
}
	
	
	function qnaReplyPageMove(nowPage) {
		
		$.ajax({
			
			url : "qnaReplyPageMove.do",
			type : "post",
			data : {
				board_No : $('#board_NoInput').val(),
				nowPage : nowPage
			},
			success : function(map) {
					
				var qnaReplyListPaging = map.qnaReplyListPaging;
				var qnaReplyList = map.qnaReplyList;
				var str1 = "";
				var str2 = "";
				var str3 = "";			
				const offset = new Date().getTimezoneOffset()*60000;
				
				$.each(qnaReplyList, function(i) {
					var updateReplyContent = qnaReplyList[i].reply_Content.replaceAll('<br>','\r\n');
					var userTitle;
					if(qnaReplyList[i].user_Type == 'A'){
						userTitle = " 관리자";
					}else if(qnaReplyList[i].user_Type == 'C'){
						userTitle = " 학생";
					}else if(qnaReplyList[i].user_Type == 'D'){
						userTitle = " 강사";
					}
					if(i==0){
						str3 = "<th style = 'background-color: white;text-align: center; font-size: 20px; font-weight: bold; border: none;width : 10px;'>↳</th>";
					 }else{
						str3 = "<th style = 'background-color: white;'></th>";
					}
					
					
					var reply_Date = new Date(qnaReplyList[i].reply_Date-offset).toISOString().substring(0,10);
					str1 += "<tr><td><br><br><td><tr>"
					str1 += "<tr>"+str3+"<th>작성자</th><th>내용</th><th>작성일</th><tr>";
					str1 += "<tr><td></td><td>"+qnaReplyList[i].name+userTitle+"</td><td>"+qnaReplyList[i].reply_Content+"</td><td>"+reply_Date+"</td><tr>";
					
					if($('#userTypeInput').val() == 'A'|| $('#loginIDInput').val()== qnaReplyList[i].loginID){
						
						str1 += "<tr><td><br><td><tr>";
						str1 += "<tr><td colspan = '3'></td><td style = 'text-align: right;padding-right: 10px;'><button type='button' onclick='updateReplyForm("+qnaReplyList[i].reply_No+")'>수정</button> ";
						str1 += "<button type='button' onclick='deleteReply("+qnaReplyList[i].reply_No+",1)'>삭제</button></td><tr>";
						str1 += "<tr class = 'updateReplyForm' id = 'updateR"+qnaReplyList[i].reply_No+"'><td></td><td colspan = '3'><textarea id='tt'>"+updateReplyContent+"</textarea>";
						str1 += "<button type='button' onclick='updateReply("+qnaReplyList[i].reply_No+",1)'>수정완료</button> <button type='button' onclick='closeUpdateReply()'>닫기</button></td><tr>";
						
					}
				})
				str2 += "<tr><td><br></td></tr><tr><td></td><td colspan = '3'>"
				/* for(var i = qnaReplyListPaging.startPage; i <= qnaReplyListPaging.endPage ; i++){
					if(i == qnaReplyListPaging.nowPage){
						str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
					}else{
						str2+="<span class='pageNum pageNumColor' onclick='qnaReplyPageMove("+i+")'>"+i+"</span>&nbsp;";        						
					}

				} */
				str2 += getPaginationHtml(qnaReplyListPaging.nowPage,qnaReplyListPaging.total,qnaReplyListPaging.cntPerPage,qnaReplyListPaging.cntPage,'qnaReplyPageMove');
				
				str2 += "</td></tr>"
				$('#qnaReplyTfoot').empty();
				$('#qnaReplyTfoot').append(str1+str2)
			},
			error : function(e) {
				alert("qna댓글 페이지 이동중 ajax 통신 오류")
			}
			
			
			
		})
	}
	
	function insertReplyForm() {
		$('#insertReplyTr').css("display","");
	}
	
	function i_ReplyClose() {
		$('#insertReplyTr').css("display","none");	
		$('#replyTextarea').text("");
	}
	
	/** 그룹코드 모달 실행 */
	function fPopModalComnGrpCod() {
		
		
			gfModalPop("#qnaDetail");

	}
	
	/** 그룹코드 모달 실행 */
	function qnaInsertForm() {
		
		
			gfModalPop("#qnaInsert");

	}
	function qnaUpdateForm() {
		
		
		gfModalPop("#qnaUpdate");

}

	
	function insertReply() {
		var formData = $("#insertReplyForm").serialize();
		if($('#replyTextarea').val()==null||$('#replyTextarea').val().trim()==""){
			alert("내용을 입력하셔야 합니다.");
			return false;
		}
		
		$.ajax({
            url : "insertReply.do", 
            type : 'POST', 
            cache: false,
            data : formData, 
            success : function(str) {
                if(str=='pass'){
                	i_ReplyClose();
                	qnaReplyPageMove(1);
                }
            }, 
    
            error : function(e) {
                alert ("댓글 등록중 ajax통신 오류");
            }
        });
	}
	
	function updateReplyForm(reply_No) {
		$('.updateReplyForm').css("display","none");
		$('#updateR'+reply_No).css("display","table-row");
	}
	
	function closeUpdateReply() {
			$('.updateReplyForm').css("display","none");
		}
	
	function updateReply(reply_No,nowPage) {
		var updateContent = $('#updateR'+reply_No+' #tt').val();
		if(updateContent==null||updateContent.trim()==""){
			alert("내용을 입력하셔야 합니다.");
			return false;
		}
		$.ajax({
            url : "updateReply.do", 
            type : 'POST', 
            cache: false,
            data : {
            	reply_No : reply_No,
            	reply_Content : updateContent
            }, 
            success : function(str) {
                if(str=='pass'){
                	qnaReplyPageMove(nowPage);
                }
            }, 
    
            error : function(e) {
                alert ("댓글 등록중 ajax통신 오류");
            }
        });
	}
	
	function deleteReply(reply_No,nowPage) {
		if(!confirm("정말로 삭제 하시겠습니까?")){
			return false;
		}
		$.ajax({
            url : "deleteReply.do", 
            type : 'POST', 
            cache: false,
            data : {
            	reply_No : reply_No
            }, 
            success : function(str) {
                if(str=='pass'){
                	qnaReplyPageMove(nowPage);
                }
            }, 
    
            error : function(e) {
                alert ("댓글 등록중 ajax통신 오류");
            }
        });
	}
	
	function insertQna() {
		 var formData = $("#insertQnaForm").serialize();
		 if($('#board_ContentTextArea').val().trim()==""){
			 alert("글 내용을 입력하셔야 합니다.");
			 return false;
		 }
		 if(!$('#board_NmInput').val()){
			 alert("글 제목을 입력하셔야 합니다.");
			 return false;
		 }
		 $.ajax({
	            url : "insertQna.do", 
	            type : 'POST', 
	            cache: false,
	            data : formData, 
	            success : function(str) {
	                if(str=='pass'){
	                	gfCloseModal();
	                	qnaListPageMove(1);
	                }
	            }, 
	    
	            error : function(e) {
	                alert ("댓글 등록중 ajax통신 오류");
	            }
	        });
	}
	
	function qnaUpdate() {
		 var formData = $("#updateQnaForm").serialize();
		 if($('#board_ContentUpdateTextArea').val().trim()==""){
			 alert("글 내용을 입력하셔야 합니다.");
			 return false;
		 }
		 if(!$('#board_NmUpdateInput').val()){
			 alert("글 제목을 입력하셔야 합니다.");
			 return false;
		 }
		 
		 $.ajax({
	            url : "updateQna.do", 
	            type : 'POST', 
	            cache: false,
	            data : formData, 
	            success : function(str) {
	                if(str=='pass'){
	                	gfCloseModal();
	                	selectDetail($('#updateBoard_NoInput').val());
	                }
	            }, 
	    
	            error : function(e) {
	                alert ("댓글 등록중 ajax통신 오류");
	            }
	        });
	}
	
	function deleteQna() {
		
		if(confirm("정말 QnA를 삭제 하시겠습니까?")){
			$.ajax({
	            url : "deleteQna.do", 
	            type : 'POST', 
	            data : {
	            	board_No : $('#board_NoInput').val()
	            },
	            success : function(str) {
	                if(str=='pass'){
	                	gfCloseModal();
	                	qnaListPageMove(1);
	                }
	            }, 
	    
	            error : function(e) {
	                alert ("qna 삭제중 ajax통신 오류");
	            }
	        });
		}
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
								class="btn_nav bold">커뮤니티</span> <span class="btn_nav bold">Q & A</span>
						</p>

						<p class="conTitle">
							<span>QnA</span> <span class="fr"> 
							<a class="btnType blue" href="javascript:qnaInsertForm();" name="modal"><span>QnA 등록</span></a>
							</span>
							
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								
	
								<thead>
									<tr>
				                        <th>제목</th>
				                        <th>작성일</th>
				                        <th>작성자</th>
				                        
									</tr>
								</thead>
								<tbody id="qnaListTbody">
	                	<c:forEach items="${requestScope.qnaList}" var="list" varStatus="status">
		                    <tr>
		                        <td style="text-align: left; padding-left: 20px" onclick="selectDetail(${list.board_No})" class="titleTd">${list.board_Nm}</td>
		                        <td><fmt:formatDate value="${list.board_Date}" pattern="yyyy-MM-dd" /></td>
		                        <td>${list.name}</td>
		                    </tr>
	                    </c:forEach>
	                </tbody>
	                <tfoot>
                        	<tr>
                        		<td id="qnaListPageTd" colspan="5" class="paging_area" style="text-align: center;">
                        			<c:forEach begin="${requestScope.qnaListPaging.startPage}" end="${requestScope.qnaListPaging.endPage}" var="item">
                        				
                        				
                        				<c:if test="${item == requestScope.qnaListPaging.nowPage}">
                        					<span class="pageNum">${item}</span>
                        				</c:if>
                        				<c:if test="${item != requestScope.qnaListPaging.nowPage}">
                        					<span class="pageNum pageNumColor" onclick="qnaListPageMove(${item})">${item}</span>
                        				</c:if>                       			
                        			</c:forEach>
                        			&nbsp;
                        		</td>
                        	</tr>
                        </tfoot>
							</table>
							<input type="hidden" name="searchKind" id="searchKindInput">
	            <input type="hidden" name="searchKeyword" id="searchKeywordInput">
	            <input type="hidden" name="sortCondition" id="sortConditionInput" value="desc">
	            <input type="hidden" id="nowPageInput" value="${requestScope.noticeListPaging.nowPage}">
						</div>
	
						<div class="paging_area"  id="comnGrpCodPagination"> </div>
						
						
						
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
	                           <select name="userSearchKind" id="s_SearchKindSelect" style="width: 150px;" v-model="searchKey">
				                    <option value="title" selected>QnA 제목</option>
				                    <option value="name">QnA 작성자</option>
				                </select>
							
     	                       <input type="text"  style="width: 300px; height: 25px;" name="userSearchKeyword" id="s_KeywordInput">                   
	                           <a class="btnType blue ABtn" onclick="searchResult()"><span>검  색</span></a>
	                           
	                            

                           </td> 
                           
                        </tr>
                     </table> 
                     
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="qnaDetail" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>QnA</strong>
			</dt>
			<dd class="content">
				<table class="row">
					

					<tbody id="qnaTbody">
						<tr>
							<th>QnA 제목</th>
							<td id="qnaTitleTd" colspan="3">
							</td>
						</tr>
						<tr>
							<th>QnA 내용</th>
							<td style="height: 100px;  text-align: left;" id="qnaContentTd" colspan="3">
							</td>
						</tr>
				
						<tr>
							<td colspan="3" style="border: none"></td>
							<td style="text-align: right; border: none">
								<a class="btnType blue ABtn" onclick="insertReplyForm()" name="btn"><span>댓글작성</span></a>
							</td>
						</tr>
						<tr id="insertReplyTr" style="display: none">
							<td style="border: none"></td>
							<td colspan="3">
								<form action="" method="post" id="insertReplyForm">
									<input type="hidden" name="loginID" id="loginIDInput" value="${sessionScope.loginId}">
									<input type="hidden" name="userType" id="userTypeInput" value="${sessionScope.userType}">
									<input type="hidden" id="board_NoInput" name="board_No">
									<textarea rows="" cols="" id="replyTextarea" name="reply_Content" maxlength="500" placeholder="500자 내로 입력해 주세요"></textarea><br><br>
									<a class="btnType blue ABtn" onclick="insertReply()" name="btn"><span>댓글저장</span></a> 
									<a class="btnType gray ABtn"  name="btn" onclick="i_ReplyClose()"><span>닫기</span></a>
								</form>
							</td>
						</tr>
					</tbody>
					<tfoot id="qnaReplyTfoot">
						
					</tfoot>
				</table>
				<div class="btn_areaC mt30">
					<table style="width: 100%">
						<tr>
							<td style="text-align: left; padding-left: 20px;" id="updateDeleteTd">								
								<a class="btnType blue ABtn" onclick="qnaUpdateForm()" name="btn" style="margin-right: auto;"><span>수정</span></a> 
								<a class="btnType gray ABtn" onclick="deleteQna()" name="btn" style="margin-right: auto;"><span>삭제</span></a>
							</td>
							<td style="text-align: right; padding-right: 20px;">
								<a class="btnType gray ABtn"  name="btn" onclick="gfCloseModal()"><span>닫기</span></a>
							</td>
						</tr>
					</table>
					
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!-- 모달팝업 -->
	<div id="qnaInsert" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>QnA 등록</strong>
			</dt>
			<dd class="content">
				<form action="" id="insertQnaForm">
				<table class="row">
					

					<tbody>
						<tr>
							<th>QnA 제목<span class="font_red">*</span></th>
							<td id="qnaTitleTd" colspan="3">
								<input type="text" maxlength="20" placeholder="20자 내로 입력해주세요" class="inputTxt p100" name="board_Nm" id="board_NmInput">						
							</td>
						</tr>
						<tr>
							<th>QnA 내용<span class="font_red">*</span></th>
							<td style="height: 200px;  text-align: left;" id="qnaContentTd" colspan="3">
								<textarea name="board_Content" id="board_ContentTextArea" cols="60" rows="10" maxlength="500" placeholder="500자 내로 입력해 주세요" style="height: 200px;"></textarea>
								<input type="hidden" name="loginID" value="${sessionScope.loginId}">
							</td>
						</tr>
				
						<tr>
							<td colspan="3" style="border: none"></td>
							<td style="text-align: right; border: none">
								<a class="btnType blue ABtn" onclick="insertQna()" name="btn"><span>QnA 등록</span></a>
								<a class="btnType gray ABtn"  name="btn" onclick="gfCloseModal()"><span>닫기</span></a>
							</td>
						</tr>
					</tbody>
				</table>
				</form>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<!-- 모달팝업 -->
	<div id="qnaUpdate" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>QnA 수정</strong>
			</dt>
			<dd class="content">
				<form action="" id="updateQnaForm">
				<table class="row">
					

					<tbody>
						<tr>
							<th>QnA 제목<span class="font_red">*</span></th>
							<td id="qnaTitleTd" colspan="3">
								<input type="text" maxlength="20" placeholder="20자 내로 입력해주세요" class="inputTxt p100" name="board_Nm" id="board_NmUpdateInput">						
							</td>
						</tr>
						<tr>
							<th>QnA 내용<span class="font_red">*</span></th>
							<td style="height: 200px;  text-align: left;" id="qnaContentTd" colspan="3">
								<textarea name="board_Content" id="board_ContentUpdateTextArea" cols="60" rows="10" maxlength="500" placeholder="500자 내로 입력해 주세요" style="height: 200px;"></textarea>
								<input type="hidden" name="loginID" value="${sessionScope.loginId}">
								<input type="hidden" name="board_No" id="updateBoard_NoInput">
							</td>
						</tr>
				
						<tr>
							<td colspan="3" style="border: none"></td>
							<td style="text-align: right; border: none">
								<a class="btnType blue ABtn" onclick="qnaUpdate()" name="btn"><span>QnA 수정</span></a>
								<a class="btnType gray ABtn"  name="btn" onclick="gfCloseModal()"><span>닫기</span></a>
							</td>
						</tr>
					</tbody>
				</table>
				</form>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</body>
</html>