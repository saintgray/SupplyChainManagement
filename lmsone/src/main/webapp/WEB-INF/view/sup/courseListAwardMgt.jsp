<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalCntCourse eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCntCourse > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageCourse-1)}" />
								<c:forEach items="${listCourse}" var="list">
									<tr>
										<td><a href="javascript:fSelectUserList(1, '${list.class_no}')">${list.class_nm}</a></td>
										<td>${list.class_startdate} ~ ${list.class_enddate}</td>
										<td>${list.name}</td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCntCourse" name="totalCntCourse" value ="${totalCntCourse}"/>