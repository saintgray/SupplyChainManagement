<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<input type="hidden" value="${page.params.selectPage}" id="sp">
<input type="hidden" value="${page.params.totalCount}" id="tc">

<table class="col">
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">작성일</th>
			<th scope="col">작성자</th>
		</tr>
	</thead>
	<c:if test="${not empty page.list}">
	<c:forEach items="${page.list}" var="item">
		<tr>
			<td class="qna_id">
				<c:out value="${item.qna_id}" escapeXml="true"></c:out>
			</td>
			<td>
				<c:out value="${item.qna_title}" escapeXml="true"></c:out>
			</td>
			<td>
				<fmt:parseDate value="${item.qna_regdate}" var="qnareg" pattern="yyyy-MM-dd"></fmt:parseDate>
				<fmt:formatDate value="${qnareg}" pattern="yyyy-MM-dd" var="qna_regdate"/>
				<c:out value="${qna_regdate}" escapeXml="true"></c:out>
			</td>
			<td>
				<c:out value="${item.name}" escapeXml="true"></c:out>
			</td>
		</tr>
	</c:forEach>
	</c:if>
	
	<c:if test="${empty page.list}">
		<tr>
			<td colspan="4" style="text-align:center">
				<strong>
					<c:if test="${page.params.userType ne 'C'}">
						처리할 문의가 없습니다
					</c:if>
					<c:if test="${page.params.userType eq 'C'}">
						등록한 문의가 없습니다
					</c:if>
				</strong>
			</td>
		</tr>
	</c:if>

</table>

<button type="button" class="btn btn-primary" id="btnNewQna" style="float:right;">신규등록</button>