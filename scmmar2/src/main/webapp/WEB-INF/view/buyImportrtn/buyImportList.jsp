<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:if test="${itemsTotal eq 0 }">
		<tr>
			<td colspan="7">발주 지시서가 없습니다.</td>
		</tr>
	</c:if>

	<c:if test="${itemsTotal > 0 }">
		<c:forEach items="${imports }" var="row">
			<tr>
				<td>${row.impordno }</td>
				<td>
					<c:choose>
						<c:when test="${row.impmgryn eq 'Y' && row.imppayyn eq 'Y'}">
							<a href="javascript:getOneModal('${row.impordno }')">
								<span>${row.client}</span>
							</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:getOneModal('fake')">
								<span>${row.client}</span>
							</a>
						</c:otherwise>
					</c:choose>
				</td>
				<td>${row.pdnm }</td>
				<td>${row.impdtcnt }</td>
				<td>${row.impdtdate }</td>
				<td>
					<c:if test="${row.impmgryn eq 'N' }">
						<span>미승인</span>
					</c:if>
					<c:if test="${row.impmgryn eq 'Y' }">
						<span>승인</span>
					</c:if>
				</td>
				<td>
					<c:if test="${row.imppayyn eq 'N' }" >
						<a class="btnType blue radius" onclick="fUpdatePayY('${row.impno}')">
							<span>입금</span>
						</a>
					</c:if>
					<c:if test="${row.imppayyn eq 'Y' }">
						<span>입금완료</span>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</c:if>
	
	<input type="hidden" name="itemsTotal" id="itemsTotal" value="${itemsTotal }" />