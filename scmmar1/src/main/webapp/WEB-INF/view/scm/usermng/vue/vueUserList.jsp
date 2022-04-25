<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<div id="userListArea">

	
	<div class="bts mt30">

		<table class="col">
	
			
				<thead>
					<tr>
						<th scope="col">아이디</th>
						<th scope="col">구분명</th>
						<th scope="col">회사명/성명</th>
						<th scope="col">담당업무</th>
						<th scope="col">담당자명</th>
						<th scope="col">연락처</th>
					</tr>
				</thead>
			
				<tbody v-if='userlist.length>0' v-for='(item,index) in userlist'>
						<tr>
							<!-- @click 속성 내의 변수들은 해당 Vue 인스턴스의 변수로 자동 바인딩된다.
									만약 단순 문자열을 파라미터로 보내고 싶다면 "" 안에 선언해주면 된다. -->
							<td><span class="userID" @click='userinfo(item.loginID,"UPDATE")'>{{item.loginID}}</span></td>
							<td>
								<span v-if='item.user_Type=="C"'>기업고객</span>
								<span v-if='item.user_Type!="C"'>내부직원</span>
							</td>
							<td>
								<span v-if='item.user_Type=="C"'>{{item.client}}</span>
								<span v-if='item.user_Type!="C"'>{{item.name}}</span>
							</td>
							<td>
								<span v-if='item.user_Type=="A"'>SCM관리자</span>
								<span v-if='item.user_Type=="B"'>배송담당자</span>
								<span v-if='item.user_Type=="D"'>구매담당자</span>
								<span v-if='item.user_Type=="E"'>임원</span>
							</td>
							<td>
								<span v-if='item.user_Type!="C"'>{{item.name}}</span>
							</td>
							<td><span>{{item.phone}}</span></td>
							
						</tr>
				</tbody>
			
			
		</table>
	</div>
</div>

<!-- Register And Delete Btn Area -->
<div class="bts userInfoBtnArea" style="margin: 10px 0">
	<%-- <%@ include file="/WEB-INF/view/scm/usermng/vue/vueUserForm.jsp" %> --%>
	<div class="text-right">
		<button type="button" class="btn btn-primary" @click='userinfo("","NEW")'>신규등록</button>
		<button type="button" class="btn btn-danger" @click='deleteUser' >삭제</button>
	</div>
</div>
	