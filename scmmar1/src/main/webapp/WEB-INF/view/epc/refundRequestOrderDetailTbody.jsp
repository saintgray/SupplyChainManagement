<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <c:forEach items="${orderDetailList}" var="item">
                <tr>
                    <td>
                        <c:choose>
                            <c:when test="${item.returnYN == 'Y'}">
                                <input type="button" name="cancelRefund" class="cancelRefund" value="반품 취소">
                            </c:when>
                            <c:when test="${item.returnYN == 'N'}">
                                <input type="checkbox" name="isRefund" id="isRefund">
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${item.returnYN == 'Y'}">
                                <span name="refund_cnt">${item.return_cnt}</span>
                            </c:when>
                            <c:when test="${item.returnYN == 'N'}">
                                <input type="number" name="refund_cnt" class="refund_cnt" id="refund_cnt" value="${item.pur_cnt}" min="1" max="${item.pur_cnt}">
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <span name="pur_cnt" id="pur_cnt">${item.pur_cnt}</span>
                    </td>
                    <td>
                        <span name="pur_id" id="pur_id">${item.pur_id}</span>
                        <input type="hidden" name="purinf_id" class="purinf_id" value="${item.purinf_id}" />
                        <input type="hidden" name="rfinfo_id" class="rfinfo_id" value="${item.rfinfo_id}" />
                        <input type="hidden" id="totalOrderDetailListCnt" value="${totalOrderDetailListCnt}" />
                    </td>
                    <td>
                        <span name="sales_type" id="sales_type">${item.sales_type}</span>
                    </td>
                    <td>
                        <span name="model_nm" id="model_nm">${item.model_nm}</span>
                    </td>
                    <td>
                        <span name="mfcomp" id="mfcomp">${item.mfcomp}</span>
                    </td>
                    <td>
                        <span name="price" id="price"><fmt:formatNumber value="${item.price}" type="number" /></span>
                    </td>
                    <td>
                        <span name="total_price" id="total_price"><fmt:formatNumber value="${item.total}" type="number" /></span>
                    </td>

                </tr>
            </c:forEach>