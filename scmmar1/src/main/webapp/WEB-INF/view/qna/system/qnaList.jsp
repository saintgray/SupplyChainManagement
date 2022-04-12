<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<input type="hidden" value="${page.params.selectPage}" id="sp">
<input type="hidden" value="${page.params.totalCount}" id="tc">
<table>
	<tr>
		<td>번호</td>
		<td>제목</td>
		<td>작성일</td>
		<td>작성자</td>
	</tr>
	<c:if test="${not empty page.list}">
	<c:forEach items="${page.list}" var="item">
		<tr>
			<td>
				<c:out value="${item.qna_id}" escapeXml="true"></c:out>
			</td>
			<td>
				<c:out value="${item.qna_title}" escapeXml="true"></c:out>
			</td>
			<td>
				<c:out value="${item.qna_regdate}" escapeXml="true"></c:out>
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
					<c:if test="${type ne 'C'}">
						처리할 문의가 없습니다
					</c:if>
					<c:if test="${type eq 'C'}">
						등록한 문의가 없습니다
					</c:if>
				</strong>
			</td>
		</tr>
	</c:if>

</table>