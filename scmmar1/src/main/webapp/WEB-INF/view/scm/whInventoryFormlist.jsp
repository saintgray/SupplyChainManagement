<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:forEach items="${whlist}" var="list">
										<tr onclick="test('${list.wh_id}','${list.sales_id}','${list.sales_nm}')" style="cursor: pointer;">
											<td>${list.wh_id}</td>
											<td>${list.wh_nm}</td>
											<td>${list.sales_id}</td>
											<td>${list.sales_nm}</td>
											<td>${list.st_cnt}</td>
											<td>${list.wh_loc}</td>
											<td>${list.addr}</td>
										</tr>
							</c:forEach>
							
