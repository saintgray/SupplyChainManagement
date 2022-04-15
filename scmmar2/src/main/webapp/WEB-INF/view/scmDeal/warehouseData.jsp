<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<c:if test="${totalCount eq 0 }">
		<tr>
			<td colspan="7">창고 내역이 없습니다.</td>
		</tr>
	</c:if>
	<c:if test="${totalCount > 0 }">
		<c:forEach items="${items }" var="row">
			<tr>
				<td>${row.whcode}</td>
				<td>
					<a href="javascript:fGetListDetail(1, '${row.whcode}', '${row.whnm}')">
						${row.whnm}
					</a>
				</td>
				<td>${row.whplace}</td>
				<td>${row.whaddr}</td>
				<td>${row.whzip}</td>
				<td>${row.pdnm}</td>
				<td>${row.stockcnt}</td>
			</tr>
		</c:forEach>
	</c:if>
	<input type="hidden" id="totalCount" name="totalCount" value="${totalCount }" />