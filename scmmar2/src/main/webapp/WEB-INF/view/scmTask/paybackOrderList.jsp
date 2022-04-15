<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




<c:if test="${totalCntPaybackOrder eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCntPaybackOrder > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPagePaybackOrder-1)}" />
	<c:forEach items="${listPaybackOrderModel}" var="list">

		<tr>
			
			<td><fmt:formatDate value="${list.oddtdate  }" pattern="yyyy-MM-dd" /></td>
			<td>${list.pdnm  }</td>
			<td>${list.crtncnt  } EA</td>
			<td>￦ ${list.crtnprice  }</td>
			<td class="hiddeninfo">${list.crtrtyn }
				<input type="hidden" id="rtnno" value="${list.rtnno }">
				<input type="hidden" id="crtrtio" value="${list.crtrtio }">
			</td>
			<td>
				<a class="btnType blue" id="btnYesPaybackOrder" name="btn" ><span style="cursor:pointer;" onclick="popModal(this)">입 금</span></a>
				
			</td>

		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<!-- 	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<strong>입금하시겠습니까?</strong>
		<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnYesPayback" name="btn" onclick="fYesPaybackOrder();"><span>확인</span></a> 
					<a href=""	class="btnType gray"  id="btnNoPayback" name="btn" onclick="gfCloseModal();"><span>취소</span></a>
		</div>
	
	</div> -->

<input type="hidden" id="totalCntPaybackOrder" name="totalCntPaybackOrder" value="${totalCntPaybackOrder}" />