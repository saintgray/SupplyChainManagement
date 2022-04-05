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
											<td>${list.returnYN}</td>
											<td>${list.wanted_date}</td>
											<td>${list.depositYN}</td>
											<td>
												<a class="btnType blue" onclick="orderhi('${list.pur_id}','${list.sales_id }','${list.loginID }')" >
												<span style="cursor: pointer;">지시서 작성</span></a>
											</td>
										</tr>
							</c:forEach>
							
						<input type="hidden" id="total" name="total" value ="${total}"/>