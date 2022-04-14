<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

				
	
		<c:if test="${salesStatusCnt eq 0 }">
			<tr>
				<td colspan="4">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
	
		<c:if test="${salesStatusCnt > 0 }">
			<c:set var="nRow" value="${pageSize*(currentPage-1)}" /> 
			<c:forEach items="${salesStatus}" var="list">
				<tr>			
						<td>${list.client}</td>
						<td>${list.sales_Nm}</td>
						<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.sell}"></fmt:formatNumber></td>
						<td>${list.purdate}</td>
					
				</tr>
				 <c:set var="nRow" value="${nRow + 1}" /> 
			</c:forEach>
		</c:if>
		
		

        <input type="hidden" id="totSalesStatusCnt" name="totcnt2" value="${salesStatusCnt}"/>











