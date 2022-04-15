<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalCntSellStatus eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCntSellStatus > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageSellStatus-1)}" />
								<c:forEach items="${listSellStautsModel}" var="list">
									<tr>
										<td><a href="javascript:fListDtSellStauts(1, '${list.userID}') ">${list.name}</a></td>
										<td>${list.usersell}</a></td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCntSellStatus" name="totalCntSellStatus" value ="${totalCntSellStatus}"/>