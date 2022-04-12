<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:forEach items="${relist}" var="list">
										<tr>
											<td>${list.regdate}</td>
											<td>${list.sales_nm}</td>
											<td>${list.client}</td>
											<td>${list.return_cnt}</td>
											<td>${list.avg}</td>
										<c:if test='${list.confirm_requestYN eq "1"}'>
											<c:choose>
												<c:when test='${list.confirmYN eq "Y"}'>
													<td style="color: blue;">승인 완료</td>
												</c:when>
												<c:when test='${list.confirmYN eq "N"}'>
													<td style="color: red;">승인 반려</td>
												</c:when>
												<c:otherwise>
													<td style="color: green;">승인 대기</td>
												</c:otherwise>
											</c:choose>
										</c:if>
										<c:if test='${list.confirm_requestYN ne "1"}'>
											<td>미요청</td>
										</c:if>
										
							</c:forEach>
							<input type="hidden" id="total" name="total" value ="${total}"/>
							
