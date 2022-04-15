<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalCntProfitAndLoss eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCntProfitAndLoss > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageProfitAndLoss-1)}" />
								<c:forEach items="${listMgrProfitAndLossModel}" var="list">
									<tr>
										<td><a href="javascript:fListDtProfitAndLoss(1, '${list.userID}') ">${list.name}</a></td>
										<td>${list.totalorder}</td>
										<td>${list.totalreturn}</td>
										<td>${list.totalprofit}</td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCntProfitAndLoss" name="totalCntProfitAndLoss" value ="${totalCntProfitAndLoss}"/>