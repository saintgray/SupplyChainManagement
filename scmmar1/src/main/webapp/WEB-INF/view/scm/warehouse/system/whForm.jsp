<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="formwrap" class="bts">
	
	<table id="formtable">
		<tr>
			<td>창고코드</td>
			<td>
				<c:if test="${action eq 'INFO'}">
					<input type="text" value='${info.wh_id}' class="form-control" readonly>
				</c:if>
				<c:if test="${action eq 'NEW'}">
					<input type="text" class="form-control" >
				</c:if>
			</td>
			<td>창고명</td>
			<td>
				<input type="text" class="form-control" >
			</td>
		</tr>
		
		<tr>
			<td>담당자</td>
			<td>
				<c:if test="${action eq 'INFO'}">
					<input type="text" class="form-control"  value='${info.wh_nm}' readonly>
				</c:if>
				<c:if test="${action eq 'NEW'}">
					<input type="text" class="form-control" >
				</c:if>
			</td>
			<td>전화번호</td>
			<td>sdfdf</td>
		</tr>
		
		<tr>
			<td>이메일</td>
			<td colspan="3">
				<div class="form-inline" style="border-spacing:0 0;">
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control" value='<c:if test="${action ne 'NEW'}">${info.email}</c:if>'>
							<span id="dot" class="input-group-addon">@</span>
							<select class="form-control">
								<option value="none">선택하세요</option>
								<option value="none">naver.com</option>
								<option value="none">nate.com</option>
								<option value="none">daum.net</option>
								<option value="none">kakao.com</option>
								<option value="none">gmail.com</option>
							</select>
						</div>
					</div>
				</div>
			</td>
		
		</tr>
		
		<tr>
			<td>우편번호</td>
			<td colspan="3">
				<div class="form-inline">
					<input type="text" class="form-control"  value='<c:if test="${action ne 'NEW'}">${info.zipCode}</c:if>'>
					<button id='findAddress' class="form-control btn btn-primary">주소찾기</button>
				</div>
			</td>
		</tr>
		<tr>
			<td>창고위치</td>
			<td colspan="3">
				<input type="text" class="form-control"  value='<c:if test="${action ne 'NEW'}">${info.wh_loc}</c:if>'>
			</td>
		</tr>
		<tr>
			<td>상세주소</td>
			<td colspan="3">
				<input type="text" class="form-control"  value='<c:if test="${action ne 'NEW'}">${info.dtAddress}</c:if>'>
			</td>
		</tr>
		
		
		
	
	
	</table>
	
	<div class="salesMngBtnArea text-center mt30" style="margin-bottom: 50px;">
		<c:if test="${action eq 'NEW'}">
			<button type="button" class="btn btn-primary mx10" id="btnRegister">등록</button>
		</c:if>
		<c:if test="${action ne 'NEW'}">
			<button type="button" class="btn btn-primary mx10" id="btnUpdate">저장</button>
		</c:if>
		
		<button type="button" class="btn btn-danger mx10" id="btnDelete">삭제</button>
		<button type="button" class="btn mx10" id="close">취소</button>
	</div>


</div>