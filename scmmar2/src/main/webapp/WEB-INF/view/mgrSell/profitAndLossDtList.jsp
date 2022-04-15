<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

					<div class="divEmpty">
						<div class="hiddenData">
							  <span id="totalCntDtProfitAndLoss">${totalCntDtProfitAndLoss}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">기업고객명</th>
									<th scope="col">제품명</th>
									<th scope="col">수익</th>
									<th scope="col">반품</th>
									<th scope="col">거래일자</th>
								</tr>
							</thead>
							<tbody id="listDtProfitAndLoss">
							<c:if test="${totalCntDtProfitAndLoss eq 0 }">
								<tr>
									<td colspan="12">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPageDtProfitAndLoss-1)}" />
							<c:forEach items="${listMgrProfitAndLossDtModel}" var="list">
								<tr>
									<td>${list.name}</td>
									<td>${list.pdnm}</td>
									<td>${list.oddtsell}</td>
									<td>${list.crtndtsell}</td>
									<td><fmt:formatDate value="${list.oddtdate}" pattern="yyyy-MM-dd" /></td>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>