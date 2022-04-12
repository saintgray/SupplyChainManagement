<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:forEach items="${listdailyOrderHistory}" var="list">
										<tr>
											<td>${list.pur_id}</td>
											<td>${list.purdate }</td>
											<td>${list.name}</td>
											<td>${list.sales_nm}</td>
											<td>${list.price_sum}</td>
											<td>${list.price}</td>
											<td>${list.pur_cnt}</td>
											<td>${list.price_cnt}</td>
									<c:choose>
										<c:when test='${list.returnYN eq "Y"}'>
											<td style="color: red">신청</td>
										</c:when>
										<c:otherwise>
											<td>-</td>
										</c:otherwise>	
									</c:choose>
											<td>${list.wanted_date}</td>
									<c:choose>
										<c:when test='${list.depositYN eq "Y"}'>
											<td style="color: blue">완료</td>
										</c:when>
										<c:otherwise>
											<td style="color: red">대기</td>
										</c:otherwise>	
									</c:choose>
											<td>
												<a class="btnType blue" onclick="orderhi('${list.pur_id}','${list.sales_id }','${list.loginID }'
												,'${list.returnYN}','${list.depositYN}')" >
												<span style="cursor: pointer;">지시서 작성</span></a>
											</td>
										</tr>
										<input type="hidden" id="price_sum" value = "${list.price_sum}">
										<input type="hidden" id="pur_cnt" value = "${list.pur_cnt}">
							</c:forEach>
							
						<input type="hidden" id="total" name="total" value ="${total}"/>