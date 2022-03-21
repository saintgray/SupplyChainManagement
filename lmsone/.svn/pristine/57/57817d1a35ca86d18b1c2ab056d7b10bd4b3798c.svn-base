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
	    	function updateForm() {
				if(confirm("글을 수정하시겠습니까?")){
					gfModalPop("#updateModal");
				}
	    		
			}
	    	
	    	function updateNotice(){
       		 if($('#board_ContentTextArea').val().trim()==""){
       			 alert("글 내용을 입력하셔야 합니다.");
       			 return false;
       		 }
       		 if(!$('#board_NmInput').val()){
       			 alert("글 제목을 입력하셔야 합니다.");
       			 return false;
       		 }
       		 $('#updateNoticeForm').submit();
			}
	    	
	    	function deleteNotice() {
	    		if(confirm("글을 정말 삭제하시겠습니까?")){
	    			$('#deleteNoticeForm').submit();
				}
	    		
	    		
			}
	
	
</script>
<style type="text/css">
.ABtn{
	cursor: pointer;
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
							<span>공지 사항</span> 
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
        <thead>
            <tr>
                <th colspan="2" style="font-size: 20px">[공지] ${requestScope.notice.board_Nm}</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>작성자 : ${requestScope.notice.loginID}</td>
                <td style="text-align: right;">
                	등록일 : <fmt:formatDate value="${requestScope.notice.board_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>  &nbsp;&nbsp;&nbsp; 조회수 : ${requestScope.notice.view_Cnt} &nbsp; &nbsp; 
                </td>
            </tr>
            <tr>
                <td colspan="2" style="border: 1px solid black; height: 200px;  text-align: left;">${requestScope.notice.board_Content}</td>
            </tr>
        </tbody>
        <tfoot>
        	<tr><td colspan="2"><br></td></tr>            
            <tr>
                <td>
                <a class="btnType blue ABtn"  name="btn" onclick="location.href='/sup/notice.do'"><span>목록보기</span></a> 
                </td>
                <td style="text-align: right;">
                	<c:if test="${sessionScope.userType eq 'A'}">
							
							
                	<a class="btnType blue ABtn"  name="btn" onclick="updateForm()"><span>수정하기</span></a>  &nbsp;
                    <a class="btnType gray ABtn"  name="btn" onclick="deleteNotice()"><span>삭제하기</span></a> 
                    <form action="deleteNotice.do" method="post" id="deleteNoticeForm">
                    	<input type="hidden" name="board_No" value="${requestScope.notice.board_No}">
                    </form> 
                    </c:if> 
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
	</div>

	
	<!-- 모달팝업 -->
	<div id="updateModal" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>공지사항 수정</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<form action="updateNotice.do" method="post" id="updateNoticeForm">
				<table class="row">
					

					<tbody>
						<tr>
							<th>공지제목 <span class="font_red">*</span></th>
							<td>
							<input type="text" maxlength="20" placeholder="20자 내로 입력해주세요" class="inputTxt p100" 
							name="board_Nm" id="board_NmInput" value="${requestScope.notice.board_Nm}"></td>
						</tr>
						<tr>
							<th>공지내용<span class="font_red">*</span></th>
							<td colspan="3"><textarea name="board_Content" id="board_ContentTextArea" cols="60" rows="10" maxlength="500" placeholder="500자 내로 입력해 주세요">${requestScope.noticeUpdateContent}</textarea>
							<input type="hidden" name="board_No" value="${requestScope.notice.board_No}">                       
                        </td>
						</tr>
				
						
					</tbody>
				</table>
				 </form>
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a class="btnType blue ABtn" onclick="updateNotice()" name="btn"><span>수정저장</span></a> 
					<a class="btnType gray ABtn"  name="btn" onclick="gfCloseModal()"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	

</body>
</html>