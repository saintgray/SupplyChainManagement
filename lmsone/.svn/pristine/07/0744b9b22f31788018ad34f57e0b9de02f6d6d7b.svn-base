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
	noticeListPageMove(1);
	});
function noticeListPageMove(nowPage) {
	
	$.ajax({
		url : "noticeListMovePage.do",
		type : "post",
		data : {
			searchKind : $('#searchKindInput').val(),
			searchKeyword : $('#searchKeywordInput').val(),
			sortCondition :  $('#sortConditionInput').val(),
			nowPage : nowPage
		},
		success : function(map) {
			var noticeList = map.noticeList;
			var noticeListPaging = map.noticeListPaging;
			var str = "";
			var str2 = "";
			const offset = new Date().getTimezoneOffset()*60000;
			
			$.each(noticeList,function(i){
				var board_Date = new Date(noticeList[i].board_Date-offset).toISOString().substring(0,10);
				str+="<tr><td>"+noticeList[i].board_No+"</td>";
				str+="<td style='text-align: left; padding-left: 20px' onclick='selectDetail("+noticeList[i].board_No+")'  class='titleTd'>"+noticeList[i].board_Nm+"</td>";
				str+="<td>"+noticeList[i].loginID+"</td>";
				str+="<td>"+board_Date+"</td>";
				str+="<td>"+noticeList[i].view_Cnt+"</td></tr>";
			})
			for(var i = noticeListPaging.startPage; i <= noticeListPaging.endPage ; i++){
				if(i == noticeListPaging.nowPage){
					str2+="<span class='pageNum'>"+i+"</span>&nbsp;";   
				}else{
					str2+="<span class='pageNum pageNumColor' onclick='noticeListPageMove("+i+")'>"+i+"</span>&nbsp;";        						
				}
				
			}
			str2 = getPaginationHtml(noticeListPaging.nowPage,noticeListPaging.total,noticeListPaging.cntPerPage,noticeListPaging.cntPage,'noticeListPageMove');
			
			$('#nowPageInput').val(nowPage)
			$('#noticeListTbody').empty();
			$('#noticeListTbody').append(str)
			$('#noticeListPageTd').empty();
			$('#noticeListPageTd').append(str2);
		},
		error : function(e) {
			alert("페이지 이동중 ajax 통신 오류")
		}
		
	})
	
	
}

function searchResult() {				
	$('#searchKindInput').val($('#s_SearchKindSelect').prop('selected',true).val());
	$('#searchKeywordInput').val($('#s_KeywordInput').val());
	noticeListPageMove(1)
}

function sortChange() {
	if($('#sortConditionInput').val()=='desc'){
		$('#sortConditionInput').val('asc');
		$('#sortTh').html('등록일 ▲');
		noticeListPageMove($('#nowPageInput').val());
	}else{
		$('#sortConditionInput').val('desc');
		$('#sortTh').html('등록일 ▼');  
		noticeListPageMove($('#nowPageInput').val());
	}
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
	location.href = '/sup/noticeDetail.do?board_No='+board_No;
}
	

	
	
	
	
	
	
	/** 그룹코드 모달 실행 */
	function fPopModalComnGrpCod() {
		
		
			gfModalPop("#layer1");

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
		#noticeListPageTd{
			text-align: center;
		}
		.ABtn,.titleTd,#sortTh{
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
								class="btn_nav bold">학습지원</span> <span class="btn_nav bold">공지사항</span>
						</p>

						<p class="conTitle">
							<span>공지 사항</span> <span class="fr"> 
							<c:if test="${sessionScope.userType eq 'A'}">
							<a class="btnType blue" href="javascript:fPopModalComnGrpCod();" name="modal"><span>공지사항 등록</span></a>
							</c:if> 
							</span>
							
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								
	
								<thead>
									<tr>
										<th>번호</th>
				                        <th>제목</th>
				                        <th>작성자</th>
				                        <th id="sortTh" onclick="sortChange()">등록일 ▼</th>
				                        <th>조회수</th>
									</tr>
								</thead>
								<tbody id="noticeListTbody">
	                	<c:forEach items="${requestScope.noticeList}" var="list" varStatus="status">
		                    <tr>
		                        <td>${list.board_No}</td>
		                        <td style="text-align: left; padding-left: 20px" onclick="selectDetail(${list.board_No})" class="titleTd">${list.board_Nm}</td>
		                        <td>${list.loginID}</td>
		                        <td><fmt:formatDate value="${list.board_Date}" pattern="yyyy-MM-dd" /></td>
		                        <td>${list.view_Cnt}</td>
		                    </tr>
	                    </c:forEach>
	                </tbody>
	                <tfoot>
                        	<tr>
                        		<td id="noticeListPageTd" colspan="5" class="paging_area" style="text-align: center;">
                        			<c:forEach begin="${requestScope.noticeListPaging.startPage}" end="${requestScope.noticeListPaging.endPage}" var="item">
                        				
                        				
                        				<c:if test="${item == requestScope.noticeListPaging.nowPage}">
                        					<span class="pageNum">${item}</span>
                        				</c:if>
                        				<c:if test="${item != requestScope.noticeListPaging.nowPage}">
                        					<span class="pageNum pageNumColor" onclick="noticeListPageMove(${item})">${item}</span>
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
	
						
						
						
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
	                           <select name="userSearchKind" id="s_SearchKindSelect" style="width: 150px;" v-model="searchKey">
				                    <option value="title" selected>공지사항 제목</option>
				                    <option value="content">공지사항 내용</option>
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
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>공지사항 등록</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<form action="insertNotice.do" method="post" id="insertNoticeForm">
				<table class="row">
					

					<tbody>
						<tr>
							<th>공지제목 <span class="font_red">*</span></th>
							<td>
							<input type="text" maxlength="20" placeholder="20자 내로 입력해주세요" class="inputTxt p100" name="board_Nm" id="board_NmInput"></td>
						</tr>
						<tr>
							<th>공지내용<span class="font_red">*</span></th>
							<td colspan="3"><textarea name="board_Content" id="board_ContentTextArea" cols="60" rows="10" maxlength="500" placeholder="500자 내로 입력해 주세요"></textarea>
							<input type="hidden" name="loginID" value="${sessionScope.loginId}">
                        </td>
						</tr>
				
						
					</tbody>
				</table>
				 </form>
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a class="btnType blue ABtn" onclick="insertNotice()" name="btn"><span>저장</span></a> 
					<a class="btnType gray ABtn"  name="btn" onclick="gfCloseModal()"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	

</body>
</html>