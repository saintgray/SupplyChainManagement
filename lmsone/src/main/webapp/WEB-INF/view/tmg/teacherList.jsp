<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<c:if test="${totalCntTeacher eq 0 }">
		<tr>
			<td colspan="12">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	<c:set var="nRow" value="${pageSizeTeacher*(currentPageTeacher-1)}" />
	<c:if test="${totalCntTeacher > 0 }">
	<c:forEach items="${listTeacherModel}" var="list">
		<tr>
			<td><input type="checkbox"  id="${list.loginID }" name="tmg_${list.loginID }" value="${list.loginID}"style="width: 15px; height: 15px;" > </td>
			
			<td><a href="javascript:fPopModalSelectOne('${list.loginID}', 'D')">${list.name}</a></td>
			<td>${list.loginID }</td>
			<td>${list.password}</td>
			<td>
				${list.tel}
			</td>
			<td>${list.reg_date}</td>
			<td><a href="javascript:fPopModalSelectOne('${list.loginID}', 'D', 'U')" class="btnType blue"><span>수정</span></a></td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach> 
	</c:if>
	<input type="hidden" id="totalCntTeacher" name="totalCntTeacher" value ="${totalCntTeacher}"/>