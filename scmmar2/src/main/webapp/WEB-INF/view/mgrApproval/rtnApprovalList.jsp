<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalCntImpApproval eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCntRtnApproval > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageRtnApproval-1)}" />
								<c:forEach items="${listRtnApprovalModel}" var="list">
									<tr>
										<td>${list.name}</td>
										<td>${list.pdnm}</td>
										<td><fmt:formatDate value="${list.oddtdate}" pattern="yyyy-MM-dd" /></td>
										<td><fmt:formatDate value="${list.rtnregdate}" pattern="yyyy-MM-dd" /></td>
										<td>${list.crtncnt}</td>
										<td>${list.crtnprice}</td>
										<td>
											<a class="btnType3 color1" href="javascript:fPopModalComnGrpCod('${list.crtrtio}');"><span>승인</span></a>
										</td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCntRtnApproval" name="totalCntRtnApproval" value ="${totalCntRtnApproval}"/>