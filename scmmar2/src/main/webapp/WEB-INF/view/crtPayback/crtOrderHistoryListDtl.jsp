<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${totalOrderHistoryCountDtl eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalOrderHistoryCountDtl > 0 }">
	<c:forEach items="${listorderHistoryDtl}" var="list">
		<tr name="orderinfo">
			
			<td><input type="checkbox" id="choicepd" name="choicepd"></td>
			<td style="display:none;"><input type="hidden" id="orderno" name="orderno" value="${list.orderno }"></td>
			<td style="display:none;"><input type="hidden" id="pdcode" name="pdcode" value="${list.pdcode }"></td>
			<td style="display:none;"><input type="hidden" id="pdno" name="pdno" value="${list.pdno }"></td>
			<td style="display:none;"><input type="hidden" id="pdmdno" name="pdmdno" value="${list.pdmdno }"></td>
			<td style="display:none;"><input type="hidden" id="rtncnt" name="rtncnt" value=""></td>
			<td style="display:none;"><input type="hidden" id="rtnamount" name="rtnamount"></td>
			
				<c:if test="${list.oddtrecnt eq 0}">
				<td><input type="number" min="1" max="${list.oddtcnt }" name="oddtrecnt" id="oddtrecnt" value="${list.oddtcnt }" style="width: 30px;"></td>
				</c:if>
				<c:if test="${list.oddtrecnt ne 0}">
				<td><input type="number" min="1" max="${list.oddtrecnt }" name="oddtrecnt" id="oddtrecnt" value="${list.oddtcnt - list.oddtrecnt }" style="width: 30px;"></td>
				</c:if>
			
			<td><input type="hidden" id="oddtno" name="oddtno" value="${list.oddtno}">${list.oddtno}</td>
			<td><input type="hidden" id="pdcodenm" name="pdcodenm" value="${list.pdcodenm}">${list.pdcodenm}</td>
			<td><input type="hidden" id="pdmdnm" name="pdmdnm" value="${list.pdmdnm}">${list.pdmdnm}</td>
			<td><input type="hidden" id="pdmdcop" name="pdmdcop" value="${list.oddtno}">${list.pdmdcop}</td>
			<td><input type="hidden" id="pdmdprice" name="pdmdprice" value="${list.pdmdprice}">${list.pdmdprice}</td>
			<td><input type="hidden" id="oddtcnt" name="oddtcnt" value="${list.oddtcnt}">${list.oddtcnt}</td>
			<td>${list.oddtcnt * list.pdmdprice}</td>
			<td>
				<c:choose>
					<c:when test="${list.delstate eq '0'}">
					 	배송준비중
					</c:when>
					<c:when test="${list.delstate eq '1'}">
					 	배송중
					</c:when>
					<c:when test="${list.delstate eq '2'}">
					 	배송완료
					</c:when>
				</c:choose>
			</td>
			
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="totalOrderHistoryCountDtl" name="totalOrderHistoryCountDtl" value="${totalOrderHistoryCountDtl}" />