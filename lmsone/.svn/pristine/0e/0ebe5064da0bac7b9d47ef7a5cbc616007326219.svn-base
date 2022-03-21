<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalCntClassroom eq 0 }">
								<tr>
									<td colspan="6">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
					
							<c:if test="${totalCntClassroom > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageClassroom-1)}" />
								<c:forEach items="${listClassroomModel}" var="list">
									<tr>
										<td>${totalCntClassroom - nRow}</td>
										<td>${list.roomNo}</td>
										<td><a href="javascript:fListEquipment(1,'${list.roomNo}');">${list.roomNm}</a></td>
										<td>${list.roomArea}</td>
										<td>${list.roomSize}</td>
										<td><a class="btnType blue" href="javascript:fPopModalCmgRoomCod(${list.roomNo});" name=""><span>수정</span></a></td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCntClassroom" name="totalCntClassroom" value ="${totalCntClassroom}"/>