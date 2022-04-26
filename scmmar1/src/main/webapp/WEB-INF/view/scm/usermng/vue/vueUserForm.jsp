<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


		
		
			<!-- action 의 값이 ''(공백) 이라면 공백에 대한 boolean 자동 변환값은 false 이다 -->
			<!-- 이 외에도 숫자 0, NaN, 객체의 null, undefined, 값 또한 false 로 변환된다 -->
			<div id="userinfoarea" class="bts" v-if='action'>
			
		
				
				<table>
				
					<tbody>
						<tr class="basicinfo-row1">
							
							<td rowspan="3" style="vertical-align: top" v-if='action=="NEW"'>
								<select id="sb-userType" class="form-control"  v-model="regType">
									<option value="cust">기업고객</option>
									<option value="emp">내부직원</option>
								</select>
							</td>
							
							
							<td>
								<span>아이디</span>
							</td>
							<td>
								
								<input type="text" 
										name="loginID" 
										:readonly='action=="UPDATE"'
										class="form-control" v-model='info.loginID'
								>
									
							</td>
							<td>
								<span>비밀번호</span>
							</td>
							<td>
								<input type="password" 
										name="password"
										:readonly='action=="UPDATE"'
										v-model='info.password'
										class="form-control"
										
								>
							</td>
						</tr>
						
						<%-- <c:if test="${(not empty info) && (info.user_Type eq 'C')}"> --%>
							<tr class="custInfo" v-if='(action=="UPDATE" && info.userType=="C") || (action=="NEW" && regType=="cust")'>
								<td>
									<span>회사명</span>
								</td>
								<td>
									<input type="text" class="form-control" name="client" v-model='info.client'>
								</td>
								<td>
									<span>담당자명</span>
								</td>
								<td>
									<input type="text" class="form-control" name="name" v-model='info.name'>
								</td>
							</tr>
						<%-- </c:if> --%>
						
						<tr class="basicinfo-row2">
							<td>
								<span>연락처</span>
							</td>
							<td>
								<input type="text" class="form-control" name="phone" v-model='info.phone'>
							</td>
							<td>
								<span>이메일</span>
							</td>
							<td>
								<input type="text" class="form-control" v-model='info.email'>
							</td>
						</tr>
					
						
						<tr class="empInfo" v-if='(action=="UPDATE" && info.userType!="C") ||(action=="NEW" && regType=="emp")'>
							<td>
								<span>직원명</span>
							</td>
							<td>
								<input type="text"  class="form-control" v-model='info.name'>
							</td>
							<td>
								<span>담당업무</span>
							</td>
							<td>
								<select class="form-control" v-model='info.user_Type'>
									<option value="A" :selected='info.user_Type==""'>SCM</option>
									<option value="B">배송</option>
									<option value="D">구매</option>
									<option value="E">임원</option>
								</select>
							</td>
						</tr>
					
				
						<tr>
							<td>
								<span>우편번호</span>
							</td>
							<td colspan="4">
								<div class="form-inline">
									<input type="text" class="form-control" v-model='info.zipCode' @click='findZip'>
									<button type="button" class="btn" id="findZip">주소찾기</button>
								</div>
								
							</td>
						</tr>
						<tr>
							<td>
								<span>주소</span>
							</td>
							<td colspan="4">
								<input type="text" id="address" class="form-control" v-model='info.address' style="width:100%">
							</td>
						</tr>
						<tr>
							<td>
								<span>상세주소</span>
							</td>
							<td colspan="4">
								<input type="text" id="dtAddress" class="form-control" v-model='info.dtAddress' style="width:100%">
							</td>
						</tr>
					</tbody>
				
				</table>
				
				
				
				<div class="userInfoBtnArea bts">
					<div class="text-right">
						<button type="button" class="btn btn-primary" v-if='action=="UPDATE"' @click='update'>수정</button>
						<button type="button" class="btn btn-primary" v-if='action=="NEW"' @click='reg'>등록</button>
						<button type="button" class="btn btn-secondary" @click='closeModal'>취소</button>
					</div>
				</div>
			</div>
			
		
		
		

		
		<!-- zipFrame for Daum zipCode API -->
		<div id="zipFrame" style="position:absolute; display:none" >
			<img src="/images/admin/comm/btn_close.png" id="btn-close-daum">
		</div>
		
