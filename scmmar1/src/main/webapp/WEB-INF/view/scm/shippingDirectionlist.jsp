<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:forEach items="${listship}" var="list">
										<tr style="cursor: pointer;" onclick="ship('${list.deliv_id}')">
											<td>${list.deliv_id}</td>
											<td>${list.regdate}</td>
											<td>${list.client}</td>
											<td>${list.pur_cnt}</td>
										</tr>
							</c:forEach>
							<input type="hidden" id="total" name="total" value ="${total}"/>
