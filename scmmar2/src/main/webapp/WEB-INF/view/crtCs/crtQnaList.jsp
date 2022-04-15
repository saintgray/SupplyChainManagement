 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	   
		<c:if test="${totalCntqnalist eq 0 }">
			<tr>
				<td colspan="5">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
		<c:if test="${totalCntqnalist > 0 }">
			<c:set var="nRow" value="${pageSize*(currentPageQnaList-1)}" />
			<c:forEach items="${listCrtCsModel}" var="list">
				<tr onclick="fPopQnaDtl('${list.qna_no}')" style="cursor: pointer;">
					<td>${totalCntqnalist - nRow}</td>
					<td>${list.qna_category}</td>
					<td>${list.qna_title}</td>
					<td><fmt:formatDate value="${list.qna_regdate}" pattern="yyyy-MM-dd" /></td>
					
					<c:choose>
						<c:when test="${list.qna_astate eq 0}">
							<td>답변준비중</td>	
						</c:when>
						<c:when test="${list.qna_astate eq 1}">
							<td>답변완료</td>	
						</c:when>
					</c:choose>
					
				</tr>
				<c:set var="nRow" value="${nRow + 1}" />
			</c:forEach>
		</c:if>
		
		<input type="hidden" id="totalCntqnalist" name="totalCntqnalist" value ="${totalCntqnalist}"/> 