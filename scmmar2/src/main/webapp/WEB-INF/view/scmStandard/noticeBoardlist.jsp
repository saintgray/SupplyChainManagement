<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<c:if test="${totalNoticeCod > 0 }">
		<c:set var="nRow" value="${pageSize*(currentPageNTCCod-1)}" />
		<c:forEach items="${noticeBoardlist}" var="ntc">
			<tr>
				<td>${ntc.ntc_no}</td>
				<td><a href="javascript:fPopModalNoticeCod('${ntc.ntc_no}')">${ntc.ntc_title}</a></td>
				<td>${ntc.name}</td>
				<td>${ntc.ntc_readcnt}</td>
				<td>${ntc.ntc_regdate}</td>
			</tr>
		<c:set var="nRow" value="${nRow + 1}" />
		</c:forEach>
	</c:if>
	
	<c:if test="${totalNoticeCod eq 0 }">
		<tr>
			<td colspan="9">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<input type="hidden" id="totalNoticeCod" name="totalNoticeCod" value ="${totalNoticeCod}"/>