<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
 							
							<c:if test="${totalCntListDeliOrder eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							 
							 
 							<c:if test="${totalCntListDeliOrder > 0 }">
 							
								<c:set var="nRow" value="${pageSize*(currentPageListDeliOrder-1)}" />
								
								<c:forEach items="${listShippingModel}" var="list">
								
									<tr class="hover_row"  onclick="fPopModalDeliOrder('${list.deliv_id}', '${list.deliverStatus}','${list.deliv_wh_id }')">
										<td style="color: black; font-weight: bold;">${totalCntListDeliOrder - nRow}</td>
										<td>${list.deliv_id}</td>
										<td>${list.sales_nm}</td>
										<td>${list.pur_cnt}</td>
										<td>${list.name}</td>
										<td>
											<c:if test="${list.deliverStatus eq 'U'}">배송준비</c:if>
<%-- 											<c:if test="${list.deliverStatus eq 'O'}">배송시작</c:if> --%>
											<c:if test="${list.deliverStatus eq 'E'}">배송완료</c:if>
										</td>
<%-- 										<td>${list.regdate}</td> --%>
<%-- 										<td>${list.editdate}</td> --%>
<%-- 										<td>${list.deldate}</td> --%>
										<td><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd" /></td>
										<td><fmt:formatDate value="${list.editdate}" pattern="yyyy-MM-dd" /></td>
<%-- 										<td><fmt:formatDate value="${list.deldate}" pattern="yyyy-MM-dd" /></td>	 --%>
									</tr>
									
									<c:set var="nRow" value="${nRow + 1}" />
									
								</c:forEach>
									
							</c:if>
							 
							 
							 
<%-- 							 <td><a href="javascript:fListComnDtlCod(1, '${list.grp_cod}', '${list.grp_cod_nm}')">${list.grp_cod}</a></td> --%>
							
<!-- 							<td> -->
								
<!-- 							</td> -->
							
							<!-- 배송지시서 목록 조회 콜백 함수용 : 총 개수 추출 -->
							<input type="hidden" id="totalCntListDeliOrder" name="totalCntListDeliOrder" value ="${totalCntListDeliOrder}"/>
