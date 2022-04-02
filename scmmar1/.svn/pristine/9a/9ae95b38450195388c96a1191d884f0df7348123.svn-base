<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


		
	
		<!-- <div id="layer1" class="layerPop layerType2" style="width:600px"> -->
			<div id="userinfoarea" class="bts">
			
				
				<table>
				
					<tbody>
						<tr class="basicinfo-row1">
							<c:if test="${empty info}">
								<td rowspan="3" style="vertical-align: top">
									<select id="sb-userType">
										<option selected value="Cust">기업고객</option>
										<option value="Emp">내부직원</option>
									</select>
								</td>
							</c:if>
							
							<td>
								<span>아이디</span>
							</td>
							<td>
								
								<input type="text" 
										name="loginID" 
										value='<c:if test="${not empty info}">${info.loginID}</c:if>'
										<c:if test="${action eq 'UPDATE'}">readonly</c:if>
								>
									
							</td>
							<td>
								<span>비밀번호</span>
							</td>
							<td>
								<input type="password" 
										name="password"
										value='<c:if test="${not empty info}">${info.password}</c:if>'
										<c:if test="${action eq 'UPDATE'}">readonly</c:if>
								>
							</td>
						</tr>
						
						<c:if test="${(not empty info) && (info.user_Type eq 'C')}">
							<tr class="custInfo">
								
								
								<td>
									<span>회사명</span>
								</td>
								<td>
									<input type="text" name="client" value='<c:if test="${not empty info}">${info.client}</c:if>'>
								</td>
								<td>
									<span>담당자명</span>
								</td>
								<td>
									<input type="text" name="name" value='<c:if test="${not empty info}">${info.name}</c:if>'>
								</td>
							</tr>
						</c:if>
						
						<tr class="basicinfo-row2">
							<td>
								<span>연락처</span>
							</td>
							<td>
								<input type="text" name="phone" value='<c:if test="${not empty info}">${info.phone}</c:if>'>
							</td>
							<td>
								<span>이메일</span>
							</td>
							<td>
								<input type="text" name="email" value='<c:if test="${not empty info}">${info.email}</c:if>'>
							</td>
						</tr>
						<c:if test="${(not empty info) && (info.user_Type ne 'C')}">
							<%-- <c:if test="${info.user_Type ne 'C'}"> --%>
								<tr class="empInfo">
									<td>
										<span>직원명</span>
									</td>
									<td>
										<input type="text" name="name" value='<c:if test="${not empty info}">${info.name}</c:if>'>
									</td>
									<td>
										<span>담당업무</span>
									</td>
									<td>
										<select>
											<option value="A" <c:if test='${info.user_Type eq "A"}'>selected</c:if> >SCM</option>
											<option value="B" <c:if test='${info.user_Type eq "B"}'>selected</c:if> >배송</option>
											<option value="D" <c:if test='${info.user_Type eq "D"}'>selected</c:if> >구매</option>
											<option value="E" <c:if test='${info.user_Type eq "E"}'>selected</c:if> >임원</option>
										</select>
									</td>
								</tr>
							<%-- </c:if> --%>
						</c:if>
						<tr>
							<td>
								<span>우편번호</span>
							</td>
							<td colspan="4">
								<input type="text" name="zipCode" value='<c:if test="${not empty info}">${info.zipCode}</c:if>' >
							</td>
						</tr>
						<tr>
							<td>
								<span>주소</span>
							</td>
							<td colspan="4">
								<input type="text" name="address" value='<c:if test="${not empty info}">${info.address}</c:if>' style="width:100%">
							</td>
						</tr>
						<tr>
							<td>
								<span>상세주소</span>
							</td>
							<td colspan="4">
								<input type="text" name="dtAddress" value='<c:if test="${not empty info}">${info.dtAddress}</c:if>' style="width:100%">
							</td>
						</tr>
					</tbody>
				
				</table>
				
				
				
				<div class="userInfoBtnArea bts">
					<div class="text-right">
						<button type="button" class="btn btn-info" id="btnEditUserInfo">수정</button>
						<button type="button" class="btn btn-secondary" id="closeModal">취소</button>
					</div>
				</div>
			</div>
			
		<!-- </div> -->
		
		
		<input type="hidden" id="action" name="action" value="${action}">
		<c:if test="${not empty info}">
			<input type="hidden" id="user_Type" name="user_Type" value="${info.user_Type}">
		</c:if>
