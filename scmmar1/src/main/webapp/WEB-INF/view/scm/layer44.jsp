<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   

		<dl>
			<dt>
				<strong>발주지시서 작성</strong>
			</dt>
			<dd class="content">
				<div style="text-align: left; font-size: 15px; font-weight: bold;">발주정보 입력</div> <br>
				<form action="">
					<table class="row">
					<caption>caption</caption>
						<tbody>
							<tr>
								<th>창고별 품목</th>
								<th>주문 개수 입력</th>
							</tr>
							
						
							<tr>
								<td style="text-align: center;">
									<select id="selcomcnt">
											<option value ="" selected="selected" disabled >::업체를 선택해 주세요::</option>
										<c:forEach items="${comp}" var="list">
											<option value="${list.comp_id }">${list.comp_nm }</option>
										</c:forEach>
									</select>
								</td>
								<td style="text-align: center">
									<input type="number" id="compcnt">
								</td>
								<td id="userID"></td>
							</tr>
							
						</tbody>
					</table>
				</form>

				<div class="btn_areaC mt30">
				    <!-- <input type="hidden" name="Action" id="Action" value="wa"> -->
					<a class="btnType blue" id="savesa" name="btn" ><span onclick="send('com')" style="cursor: pointer;">작성</span></a> 
					<a href=""	class="btnType gray"  id="btnClosewa" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		
		
