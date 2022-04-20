<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <c:set var="delDone" value="E" />
        <c:set var="delYet" value="U" />
            <c:forEach items="${orderRecordList}" var="item" varStatus="status">
                <tr>
                    <td>
                        <c:out value="${item.pur_id}" />
                        <input type="hidden" id="sales_id" value="${item.sales_id}" />
                        <input type="hidden" id="pur_id" value="${item.pur_id}" />
                    </td>
                    <td>${item.pur_cnt}</td>
                    <td><fmt:formatNumber value="${item.total}" type="number" /></td>
                    <td>${item.purdate}</td>
                    <td>${item.wanted_date}</td>
                    <td>
                    	<c:choose>
                            <c:when test="${item.deliverStatus == delDone}">
                                <span name="refund_cnt">배송 완료</span>
                            </c:when>
                            <c:when test="${item.deliverStatus == delYet}">
                                <span>배송 중</span>
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                       <c:if test="${item.deliverStatus == delDone}">
                           <input type="button" class="returnBtn" name="returnBtn" row-num="<c:out value='${status.index}' />" value="반품" />
                       </c:if>
                    </td>

                </tr>
            </c:forEach>
            <input type="hidden" value="${totalOrderListCnt}" id="totalOrderListCnt" />