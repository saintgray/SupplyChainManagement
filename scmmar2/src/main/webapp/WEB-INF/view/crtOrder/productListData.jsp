 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	   
		<c:if test="${totalCntProductList eq 0 }">
			<tr>
				<td colspan="9">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
		<c:if test="${totalCntProductList > 0 }">
			<c:set var="nRow" value="${pageSize*(currentPageProductList-1)}" />
			<c:forEach items="${listProductModel}" var="list">
				<tr onclick="fPopProductDtl(${list.pdno})" style="cursor: pointer;">
					<td>${totalCntProductList - nRow}</td>
					<%-- <td><a href="javascript:fListComnDtlCod(1, '${list.grp_cod}', '${list.grp_cod_nm}')">${list.grp_cod}</a></td> --%>
					<td>${list.pdcode}</td>
					<td>${list.pdcodenm}</td>
					<td>${list.pdmdno}</td>
					<td>${list.pdmdnm}</td>
					<td>${list.pdnm}</td>
					<td>${list.pdmdcop}</td>
					<td>${list.pdmdprice}</td>
				</tr>
				<c:set var="nRow" value="${nRow + 1}" />
			</c:forEach>
		</c:if>
		
		<input type="hidden" id="totalCntProduct" name="totalCntProduct" value ="${totalCntProductList}"/> 