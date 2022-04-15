<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

					<div class="divEmpty">
						<div class="hiddenData">
							  <span id="totalCntDtImpApproval">${totalCntDtImpApproval}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">납품업체명</th>
									<th scope="col">제품명</th>
									<th scope="col">수량</th>
									<th scope="col">발주단가</th>
									<th scope="col">구매일자</th>
								</tr>
							</thead>
							<tbody id="listDtImpApproval">
							<c:if test="${totalCntDtImpApproval eq 0 }">
								<tr>
									<td colspan="12">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPageImpApprvalDt-1)}" />
							<c:forEach items="${listDtImpApprovalModel}" var="list">
								<tr>
									<td>${list.comp_nm}</td>
									<td>${list.pdnm}</td>
									<td>${list.impdtcnt}</td>
									<td>${list.impdtprice}</td>
									<td><fmt:formatDate value="${list.impregdate}" pattern="yyyy-MM-dd" /></td>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>
					
					<input type="hidden" id="totalCntDtImpApproval" name="totalCntDtImpApproval" value ="${totalCntDtImpApproval}"/>