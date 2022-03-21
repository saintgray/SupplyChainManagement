<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<c:if test="${totalCntClassPlan eq 0 }">
		<tr>
			<td colspan="12">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	<c:set var="nRow" value="${pageSizeClassPlan*(currentPageClassPlan-1)}" />
	<c:if test="${totalCntClassPlan > 0 }">
		<c:forEach items="${listClassPlanModel}" var="list">
			<tr>
				
				<td>
					<c:if test = "${sessionScope.userType == 'A' }">
						<input type="checkbox"  id="${list.class_no }" name="classPlan_${list.class_no}" value="${list.class_no}"style="width: 15px; height: 15px;" >
					</c:if> 
				</td>
				
				<td>
					<c:choose>
						<c:when test = "${list.class_type eq 'A' }">
							실업자교육
						</c:when>
						<c:when test = "${list.class_type eq 'B' }">
							직장인교육
						</c:when>
					</c:choose>
					
				</td>
				<td><a href="javascript:fSelectOne('${list.class_no}')">${list.class_nm }</a></td>
				<td>${list.name }</td>
				<td>${list.class_date}</td>
				<td>
					${list.recv_date}
				</td>
				<td>${list.class_cnt}</td>
				<td>${list.class_totalcnt}</td>
				
			</tr>
			<c:set var="nRow" value="${nRow + 1}" />
		</c:forEach> 
	</c:if>
	<input type="hidden" id="totalCntClassPlan" name="totalCntCalssPlan" value ="${totalCntClassPlan}"/>