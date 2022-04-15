<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:forEach items="${items}" var="row">
		<tr>
			<td>${row.whcode }</td>
			<td>${row.pdno }</td>
			<td>${row.pdnm }</td>
			<c:if test="${row.oi eq 'I' }">
				<td>${row.oddtcnt }</td>
				<td>${row.oddtdate }</td>
				<td>${row.impdtcnt }</td>
				<td>${row.impdtdate }</td>
			</c:if>
			<c:if test="${row.oi eq 'O' }">
				<td>${row.impdtcnt }</td>
				<td>${row.impdtdate }</td>
				<td>${row.oddtcnt }</td>
				<td>${row.oddtdate }</td>
			</c:if>
		</tr>	
	</c:forEach>
	
	<input type="hidden" id="detailTotal" name="detailTotal" value="${detailTotal}" />