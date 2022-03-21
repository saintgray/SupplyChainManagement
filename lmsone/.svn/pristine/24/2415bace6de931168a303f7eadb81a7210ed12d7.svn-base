<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${listCount2 eq 0 })">
	<tr>
		<td colspan="3">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${listCount2 > 0 }">
<c:set var="nRow" value="${pageSize*(listCount2-1)}" />
	<c:forEach items="${resultlistdtl}" var="list">
		<tr>
			<td>${list.appraisal_no}</td>
			<td><a href = "javascript:surveyModal_popup('${list.appraisal_no}');">${list.name}</a></td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
	</c:if>
	
<input type="hidden" id="listCount2" name="listCount2" value="${listCount2}" />