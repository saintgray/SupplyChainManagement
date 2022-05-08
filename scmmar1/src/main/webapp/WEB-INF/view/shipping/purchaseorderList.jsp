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
								
								<c:forEach items="${ListPurchaseOrder}" var="list">
									<tr class="hover_row"  onclick="fPopModalPurchase('${list.orderid}')">
										<td style="color: black; font-weight: bold;">${totalCntListDeliOrder - nRow}</td>
										<td>${list.sales_nm}</td>
										<td>${list.name}</td> 
										<td>발주</td>
										<td>${list.order_cnt}</td>
										<td><fmt:formatNumber value="${list.order_cnt * list.price}" /></td>
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
