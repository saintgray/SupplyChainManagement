<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:if test="${totalCount eq 0}">
		<tr>
			<td colspan="11">일별 수주 내역이 없습니다.</td>
		</tr>
	</c:if>

	<c:if test="${totalCount > 0}">
		<c:set var="startRow" value="${pagePostNum * (setCurrentPage - 1)}" />
		<c:forEach items="${dailyDealData}" var="row">
			<tr class="whtr">
				<td>${row.oddtno} <%-- ${totalCount - startRow} --%><%--${startRow}--%></td>
				<td>${row.client}</td>
				<td>${row.pdnm}</td>
				<td>${row.oddtcnt}</td>
				<td>	
					<fmt:formatNumber value="${row.orderamount}" pattern="#,###"/>
				</td>
				<td>
					${row.orderpayynStr}
				</td>				
				<td>
					<c:choose>
						<c:when test="${row.orderdate ne ''}">
							<fmt:formatDate value="${row.orderdate}" pattern="yyyy-MM-dd"/>
						</c:when>
						<c:otherwise>
							<span>-</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td>${row.stockcnt}</td>
				<td>
					<span>${row.oddtreqynStr}</span>
				</td>
				<td>
					<c:choose>
						<c:when test="${row.rtncomdate eq null}">
							<span>-</span>
						</c:when>
						<c:otherwise>
							<fmt:formatDate value="${row.rtncomdate}" pattern="yyyy-MM-dd"/>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${row.oddtreqynStr eq '미입금' }">
							<span>입금요망</span>
						</c:when>
						<c:when test="${row.oddtreqynStr eq '반품신청' || row.oddtreqynStr eq '반품완료' }">
							<span> - </span>
						</c:when>
						<c:otherwise>
							<c:if test="${row.dcnt eq 1}">
								<a class="btnType blue radius" href="javascript:fDealApproval('${row.oddtcntStr}', '${row.oddtno}')">
									<span>${row.oddtcntStr}</span>
								</a>
							</c:if>
							<c:if test="${row.dcnt > 1}">
								<span>출고지시</span>
							</c:if>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		<%-- <c:set var="startRow" value="${startRow + 1}" /> --%>
		</c:forEach>
	</c:if>
	<input type="hidden" id="orderTotalCount" value="${totalCount}" />
	
<!-- 	발주 상세와 수주 상세에 연결고리가 없다.
	수주 상세 PK두개를 발주 상세 일반컬럼으로 이동.
	리스트를 출력하기 위해선 JOIN 후 COUNT를 구해서 출력하기. -->
	