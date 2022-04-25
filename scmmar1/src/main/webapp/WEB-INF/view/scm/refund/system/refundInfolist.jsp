<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
<c:forEach items="${reinfolist}" var="info">
	<tr style="cursor: pointer;" onclick="reinfo('${info.refundInfo.refundInfoId}')">
		<td>${info.refundInfo.refundInfoId}</td>
		<td>${info.sales.salesName}</td>
		<td>${info.wantedDate}</td>
		<td>${info.refundInfo.returnCnt}</td>
		<td>
			<fmt:formatNumber type="currency">
				${info.refundInfo.cnt_total}
			</fmt:formatNumber>
		</td>
	</tr>
</c:forEach>
<input type="hidden" id="total" name="total" value ="${total}"/>

