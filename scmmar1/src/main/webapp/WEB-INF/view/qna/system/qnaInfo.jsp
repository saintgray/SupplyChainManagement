<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<input type="hidden" value="${info.qna_id}" name="qna_id" id="qna_id">

<!-- title area -->
<div id="info-title" class="text-center text-bold">
	<strong id="info-title-text">
		<c:out value="${info.qna_title}" escapeXml="true"></c:out>
	</strong>
	<strong style="float:right;">
		<c:out value="${info.client}"></c:out>
	</strong>
</div>

<!-- content area -->
<div id="info-content">

	<div id="info-date" class="text-right">
		작성일 : <c:out value="${info.qna_regdate}  " escapeXml="true" />
		<c:if test="${not empty qna_editdate}">
		수정일: <c:out value="${info.editdate}" escapeXml="true" />
		</c:if>
	</div>
	
	<div id="info-content-body">
		<c:out value="${info.qna_content}" escapeXml="true" />
	</div>

</div>

<!--  button area  -->
<div id="btnArea" class="text-right mt10">
	<c:if test="${userType ne 'C'}">
		<button type="button" class="btn btn-primary" id="btnNewReply">답변등록</button>
	</c:if>
	<c:if test="${userType eq 'C'}">
		<button type="button" class="btn btn-primary" id="btnUpdateForm">수정</button>
		<button type="button" class="btn btn-danger" id="btnDeleteQna">삭제</button>
	</c:if>
</div>