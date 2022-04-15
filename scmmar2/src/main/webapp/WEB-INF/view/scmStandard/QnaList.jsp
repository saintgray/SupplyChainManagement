<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${totalqnaCount eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
							
<c:if test="${totalqnaCount > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPageqnaList-1)}" />
	<c:forEach items="${qnaListModel}" var="list">
		<tr>
			<td>${totalqnaCount - nRow}</td>
			<c:if test="${list.qna_astate eq 1 }">
				<td><a onclick="qnaDetail('${list.qna_no}')">${list.qna_title} <h1 style="color:red;display:inline-block;">(답변완료)</h1></a>
			</c:if>
			<c:if test="${list.qna_astate eq 0 }">
				<td><a onclick="qnaDetail('${list.qna_no}')">${list.qna_title}</a>
			</c:if>
			
			<span id="anComplete"></span>
			</td>
			<td>${list.qna_regdate }</td>
			<td>${list.loginid}</td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="totalqnaCount" name="totalqnaCount" value ="${totalqnaCount}"/>