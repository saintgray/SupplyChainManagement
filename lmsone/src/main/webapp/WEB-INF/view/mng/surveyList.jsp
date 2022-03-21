<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${listCount eq 0 }">
	<tr>
		<td colspan="6">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${listCount > 0 }">
<c:set var="nRow" value="${pageSize*(listCount-1)}" />
	<c:forEach items="${surveyList}" var="list">
		<tr>
			<td>${list.class_no}</a></td>
			<td><a href = "javascript:surveyModal_popup('${list.appraisal_no}')">${list.class_nm}</td>
			<td>${list.t_name}</td>
			<td>${list.class_startdate}</td>
			<td>${list.class_enddate}</td>
			<td>${list.s_name}</td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
	</c:if>
	
	<input type="hidden" id="listCount" name="listCount" value="${listCount}" />