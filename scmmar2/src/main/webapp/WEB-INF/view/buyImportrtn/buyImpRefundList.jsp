<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${RefundTotal eq 0 }">
	<tr>
		<td colspan="7">반품 지시서가 없습니다.</td>
	</tr>
</c:if>

<c:if test="${RefundTotal > 0 }">
	<c:forEach items="${items }" var="row">
		<tr>
			<td>${row.rtnno }</td>
			<td>
				<c:choose>
					<c:when test="${row.imppayyn eq 'Y' }">
						<span>${row.client}</span>
					</c:when>
					<c:otherwise>
							<span>${row.client}</span>
					</c:otherwise>
				</c:choose>
			</td>
			<td>${row.pdnm }</td>
			<td>${row.brtncnt }</td>
			<td>${row.brtnregdate }</td>
			<td>
				<c:if test="${row.brtncomdate eq null }">
					<span>-</span>
				</c:if>
				<c:if test="${row.brtncomdate ne null }">
					<span>${row.brtncomdate }</span>
				</c:if>
			</td>
			<td>
				<c:if test="${row.imppayyn eq 'Y' }">
					<span>입금완료</span>
				</c:if>
				<c:if test="${row.imppayyn eq 'N' }">
					<a class="btnType blue radius" href="">
						<span>입금확인</span>
					</a>
				</c:if>
			</td>
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" name="RefundTotal" id="RefundTotal" value="${RefundTotal }" />