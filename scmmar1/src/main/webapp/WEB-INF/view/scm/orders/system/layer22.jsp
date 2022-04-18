<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
					
		<dl>
			<dt>
				<strong>반품지시서 작성</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<tbody>
						<tr>
							<th scope="row">상품 구매번호</th>
							<th scope="row">제품명</th>
							<th scope="row">구매 수량</th>
							<th scope="row">고객명</th>
							<th scope="row">반품 수량</th>
						</tr>
						<tr>	
				<c:choose>
					<c:when test='${comfg eq "Y" }'>
							<td colspan="5" style="text-align: center;">반품 신청 완료</td>
					</c:when>
					<c:otherwise>
							<td><input type="text" id = "pur_id" value="${onedata.pur_id}" style="border: none; text-align: center;" readonly></td>
							<td><input type="text" id = "sales_nm" value="${onedata.sales_nm}" style="border: none; text-align: center;" readonly></td>
							<td><input type="text" id = "pur_cnt_one" value="${onedata.pur_cnt}" style="border: none; text-align: center;" readonly></td>
							<td><input type="text" id = "name" value="${onedata.name}" style="border: none; text-align: center;" readonly></td>
							<td><input type="text" id = "return_cnt" value="${onedata.return_cnt}" style="border: none; text-align: center;" readonly></td>
					</c:otherwise>
				</c:choose>
						</tr>
						
					</tbody>
				</table>


				<div class="btn_areaC mt30">
				    <!-- <input type="hidden" name="Action" id="Action" value="wa"> -->
				    <input type="hidden" name="pur_cnt" id="pur_cnt" value="${onedata.pur_cnt}">
				    <c:choose>
						<c:when test='${comfg eq "N" }'>
							<a class="btnType blue" id="savesa" name="btn" ><span onclick="send('re')" style="cursor: pointer;">작성</span></a>
						</c:when>
					</c:choose> 
					<a class="btnType gray"  id="btnClosewa" name="btn"><span onclick="closemodel()" style="cursor: pointer;">취소</span></a>
				</div>
							
