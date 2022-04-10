<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Chain Maker :: 공지사항</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="/js/view/scm/notice/notice.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="/js/summernote/summernote.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/js/summernote/summernote.css">
	<style>
 		input[name=date].datetype{
			padding:4px 2px 5px 25px; width:95px; border:1px solid #CACACA;
			font-size:11px; color:#666; 
			background:url('http://cfile23.uf.tistory.com/image/26100D4F5864C76827F535') no-repeat 2px 2px; background-size:15px
   		 }   
		textarea.autosize { min-height: 50px; }
		#ntc-reg-modal{
			margin:0;
		}
		.note-editable.panel-body{
			overflow-x:scroll;
		}
		.bts-noteeditor.note-frame{
			margin:0 auto;
		}
		#attrfiles{
			display: flex;
			flex-wrap:wrap;
			max-width:500px;
		}
		#attrfiles .remove{
			width: 10px;
		    height: 10px;
		    margin-left: 3px;
		    cursor:pointer;
		}
		#attrfiles div{
			margin: 3px 5px;
		}
		.n_files{
			cursor:pointer;
		}
		.n_files::before{
		    padding: 0 10px;
		    content: '';
		    background: url(/images/admin/comm/files.svg);
		    background-repeat: no-repeat;
		    background-color: transparent;
	        background-size: 14px;
   			background-position: 4px;
		}
	</style>
</head>
<body>
<!-- 공지사항 페이지는 관리자, 회원 통합으로 관리한다 -->
<%-- <c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if> --%>

		
		<input type="hidden" id="currentPage" value="1">
		<!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
 
		 
	
		<div id="wrap_area">

			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
					 <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> 
						<div class="content">
							<p class="Location">
								<a href="/dashboard/dashboard.do" class="btn_set home">메인으로</a> 
								<a href="/scm/noticeMgr.do"	class="btn_nav">시스템 관리</a> <span class="btn_nav bold">공지사항</span>
								<a href="/scm/noticeMgr.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>공지 사항 </span> <span class="fr">							
								<input class="datetype" style="width: 120px" id="from_date" name="date" readonly>
								<input class="datetype" style="width: 120px" id="to_date" name="date" readonly>
							</p></span>

							<!--검색창  -->
							
							<div style = "float:right;">				
								<select id="searchKey" name="searchKey" style="width: 80px; height: 30px;">
										<option value="all" selected>전체</option>
										<option value="title">제목</option>
										<option value="content">내용</option>
								</select>
							
							    <!-- enter입력하면 검색실행   -->
								<input type="text" style="width: 160px; height: 30px;" id="sname" name="sname" onkeypress="if( event.keyCode == 13 ){selectNoticeList();}">  
								<a href="javascript:board_search()" class="btnType blue" id="searchBtn" name="btn" ><span>검  색</span></a>
							</div>
							<div class="container" style="margin-top: 60px">
							
								<div class="divComGrpCodList">
									<table class="col">
										<caption>caption</caption>
										<colgroup>
											<col width="50px">
											<col width="200px">
											<col width="60px">
											<col width="60px">										
										</colgroup>
										<thead>
											<tr>
												<th scope="col">공지 번호</th>
												<th scope="col">공지 제목</th>
												<th scope="col">공지 날짜</th>											
												<th scope="col">작성자</th>
											</tr>
										</thead>
										<tbody id="noticeList"></tbody>
									</table>
	
									<!-- 페이징 처리  -->
									<div class="paging_area" id="pagingnavi">
										<div class="paging">
											<a class="first" href="javascript:selectNoticeList(1)">
											<span class="hidden">맨앞</span></a> 
											<a class="pre" href="javascript:selectNoticeList(1)"> 
											<span class="hidden">이전</span></a> <strong>1</strong> 
											<a href="javascript:selectNoticeList(2)">2</a> 
											<a href="javascript:selectNoticeList(3)">3</a>
											<a href="javascript:selectNoticeList(4)">4</a>
											<a href="javascript:selectNoticeList(5)">5</a> 
											<a class="next" href="javascript:selectNoticeList(5)"> 
											<span class="hidden">다음</span></a> 
											<a class="last" href="javascript:selectNoticeList(5)"> 
											<span class="hidden">맨뒤</span></a>
										</div>
									</div>
								</div>
							</div>
													
							<c:if test="${userType eq 'A'}">
								<div style = "float:right;">
									<a class="btnType blue mt10" href="javascript:fNoticeModal(${nullNum});" name="modal"><span>신규등록</span></a>
								</div>
							</c:if>
							
						</div>
						<!-- end of <div class="content"> -->		
					</li>
				</ul>
			</div>
		</div>
		<!-- end of wrap area -->
	<form id="myNotice">
		<!-- 모달팝업 -->
		<div id="notice" class="layerPop layerType2" style="width: auto; min-width: 700px;">
			
			<dl>
				<dt>
					<strong>공지사항</strong>
				</dt>
				
				<dd class="content bts">

					<table class="row" id="ntc-reg-modal">
						<caption>caption</caption>
						<tbody>
							<tr id="r-title">
								<th scope="row">제목 </th>
								<td colspan="3">
								<input type="text" class="inputTxt p100 form-control"
									   name="ntc_title" id="ntc_title" /></td>
							</tr>
							<tr id="r-writer">
								<th scope="row">작성자 </th>
								<td>
								<input type="text" class="inputTxt p100 form-control" 
								       name="loginID" id="loginID" /></td>
							</tr>
							<tr id="r-regdate">
								<th scope="row">작성일 </th>
								<td>
								<input type="text" class="inputTxt p100 form-control" 
								       id="ntc_regdate" /></td>
							</tr>														
							<tr id="r-content">
								<th scope="row">내용</th>
								<td>
									<textarea class="autosize form-control" onkeydown="resize(this)" onkeyup="resize(this)"
									 		  id="ntc_content">
						 		  	</textarea>
					 		  	</td>
							</tr>
							<c:if test="${not empty userType && userType eq 'A'}">
								
								<tr>
									<th scope="row">파일</th>
									<td>
										<c:if test="${empty files}">
											<label for="file" class="btn">
												파일 추가<!-- <button type="button" class="btn">파일 추가</button> -->
											</label>
											<input type="file" id="file" name="file" style="display:none;" multiple/>
										</c:if>
									</td>
								</tr>
								
							</c:if>
							<tr>
								<th scope="row">첨부 파일 </th>
								<td>
								    <div id="attrfiles"></div>
								</td>
							</tr>
						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<button class="btn btn-primary" id="btnSaveNotice">
							<strong>등록</strong>
						</button>
						<button  class="btn btn-primary" id="btnUpdateNotice">
							<strong>수정</strong>
						</button> 
						<button  class="btn btn-danger" id="btnDeleteNotice">
							<strong>삭제</strong>
						</button>
						<button class="btn" id="btnClose">
							<strong>취소</strong>
						</button>
					</div>
				</dd>
			</dl>
		</div>
		
		<input type="hidden" name="action" id="action"> 
		<%-- <input type="hidden" id="swriter" value="${writer}"> --%>
		<!-- 작성자 session에서 java에서 넘어온값 -->
		<input type="hidden" name="ntc_no" id="ntc_no">
	</form>
	
</body>
</html>
