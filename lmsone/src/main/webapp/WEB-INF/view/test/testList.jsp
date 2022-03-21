<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${totalCntComnGrpCod eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCntComnGrpCod > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPageComnGrpCod-1) }" />
	<c:forEach items="${listComnGrpCodModel }" var="list">
		<tr>
			<td>${totalCntComnGrpCod - nRow}</td>
			<td>${list.grp_cod }</td>
			<td>${list.grp_cod_nm }</td>
			<td>${list.grp_cod_eplti}</td>
			<td>${list.use_poa}</td>
			<td>
				<fmt:formatDate value="${list.fst_enlm_dtt}" pattern="yyyy-MM-dd" />
			</td>
			<td>
				<a class="btnType3 color1" href="javascript:fPopModalComnGrpCod('${list.grp_cod }');">
				<!-- 이슈사항 : href="javascript:fPopModalComnGrpCod(${list.grp_cod });으로 했더니 값이 안 넘어옴
				                el태그 좌우로 '' 싱글쿼테이션을 사용해야 함 -->
					<span>수정</span>
				</a>
			</td>
		</tr>
		<c:set var="nRow" value="${ nRow + 1 }" />
	</c:forEach>
</c:if>
<input type="hidden" id="totalCntComnGrpCod" name="totalCntComnGrpCod" value ="${totalCntComnGrpCod}"/>