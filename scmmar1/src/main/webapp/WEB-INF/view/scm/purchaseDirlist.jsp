<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:forEach items="${listpurchaseDir}" var="list">
										<tr>
											<td>${list.order_id}</td>
											<td>${list.sales_id}</td>
											<td>${list.sales_nm}</td>
											<td>${list.comp_nm}</td>
											<td>${list.regdate}</td>
											<td>${list.unitprice}</td>
											<td>${list.order_cnt}</td>
											<td>${list.avg}</td>
										</tr>
							</c:forEach>
							<input type="hidden" id="total" name="total" value ="${total}"/>
