<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- c:if :조건식에 해당하는 블럭과 사용될 scope설정 -->
<!--(eq : ==),
totalCntEquipment가 0이면-->
<c:if test="${totalCntEquipment eq 0 }">
	<tr>
		<td colspan="6">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
<c:if test="${totalCntEquipment > 0 }">
<!-- c:set :변수명에 값을 할당  -->
	<c:set var="nRow" value="${pageSize*(currentPageEquipment-1)}" /> <!--nRow에 값을 할당했다.  -->
	<!--c:forEach :다른언어의 loop문 items 속성에 배열을 할당할 수 있음  -->
	<c:forEach items="${listEquipmentModel}" var="list">
		<tr>
			<td>${list.room_No}</td>
			<td>${list.equi_No}</td>
			<td>${list.equi_Nm}</td>
			<td>${list.equi_Cnt}</td>
			<td>${list.equi_Etc}</td>
			<td>
				<a class="btnType blue" href="javascript:fPopModalCmgEqui('${list.room_No}','${list.equi_No}');"><span>수정</span>
			</a>
			</td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="totalCntEquipment" name="totalCntEquipment" value="${totalCntEquipment}"/>