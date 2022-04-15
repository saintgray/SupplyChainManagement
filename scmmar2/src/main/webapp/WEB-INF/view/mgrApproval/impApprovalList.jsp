<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalCntImpApproval eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCntImpApproval > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageImpApproval-1)}" />
								<c:forEach items="${listImpApprovalModel}" var="list">
									<tr>
										<td>${list.comp_nm}</a></td>
										<td><a href="javascript:fListComnDtlCod(1, '${list.impno}') ">${list.pdnm}</a></td>
										<td>${list.impcnt}</td>
										<td>${list.impamount}</td>
										<td><fmt:formatDate value="${list.impregdate}" pattern="yyyy-MM-dd" /></td>
										<td class="hiddeninfo">
											<button type="button" onclick="fPopModalComnGrpCod(this);">승인</button>
											<input type="hidden" id="impno" name="impno" value="${list.impno}">
											<input type="hidden" id="impordno" name="impordno" value="${list.impordno}">
											<input type="hidden" id="impdtcnt" name="impdtcnt" value="${list.impdtcnt }">
											<input type="hidden" id="pdcode" name="pdcode" value="${list.pdcode }">
											<input type="hidden" id="pdmdno" name="pdmdno" value="${list.pdmdno }">
											<input type="hidden" id="pdno" name="pdno" value="${list.pdno }">
										</td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCntImpApproval" name="totalCntImpApproval" value ="${totalCntImpApproval}"/>