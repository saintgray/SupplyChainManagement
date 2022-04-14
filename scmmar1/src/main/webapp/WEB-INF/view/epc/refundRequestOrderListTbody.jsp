<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <c:forEach items="${orderRecordList}" var="item" varStatus="status">
                <tr>
                    <td>
                        <c:out value="${item.pur_id}" />
                        <input type="hidden" id="sales_id" value="${item.sales_id}" />
                        <input type="hidden" id="pur_id" value="${item.pur_id}" />
                    </td>
                    <td>${item.pur_cnt}</td>
                    <td>${item.total} </td>
                    <td>${item.purdate}</td>
                    <td>${item.wanted_date}</td>
                    <td>${item.deliverStatus}</td>
                    <td>
                        <input type="button" class="returnBtn" name="returnBtn" row-num="<c:out value='${status.index}' />" value="반품" />
                    </td>

                </tr>
            </c:forEach>
            <input type="hidden" value="${totalOrderListCnt}" id="totalOrderListCnt" />