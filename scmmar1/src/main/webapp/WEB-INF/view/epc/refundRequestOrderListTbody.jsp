<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <c:forEach items="${orderRecordList}" var="item">
                <tr>
                    <td>index</td>
                    <td>${item.pur_cnt}</td>
                    <td>${item.price}</td>
                    <td>${item.purdate}</td>
                    <td>${item.wanted_date}</td>
                    <td>${item.deliv_type}</td>
                    <td>
                        <input type="button" class="returnBtn" name="returnBtn" row-num="" value="반품" />
                    </td>
                    <input type="hidden" id="sales_id" value="${item.pur_id}" />
                </tr>
            </c:forEach>
            <input type="hidden" value="${totalOrderListCnt}" id="totalOrderListCnt" />