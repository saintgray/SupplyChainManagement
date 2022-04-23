<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:forEach items="${reinfolist}" var="list">
										<tr style="cursor: pointer;" onclick="reinfo('${list.return_id}')">
											<td>${list.sales_nm}</td>
											<td>${list.wanted_date}</td>
											<td>${list.return_cnt}</td>
											<td>${list.avg}</td>
										<c:choose>
											<c:when test='${list.confirm_requestYN eq 1}'>
												<td style="color: blue; font-weight: bold;">완료</td>
											</c:when>
											<c:otherwise>
												<td style="color: red; font-weight: bold;">대기</td>
											</c:otherwise>	
										</c:choose>
							</c:forEach>
							<input type="hidden" id="total" name="total" value ="${total}"/>
							
