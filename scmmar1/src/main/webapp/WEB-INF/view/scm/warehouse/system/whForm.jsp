<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="formwrap" class="bts">
	<input type="hidden" value="${action}" id="action" name="action">
	<input type="hidden" value="${info.loginID}" id="loginID">
	<input type="hidden" value="${info.phone}" id="phone">
	
	
	<table id="formtable">
		<tr>
			<c:if test="${action eq 'INFO'}">
				<td>창고코드</td>
				<td>
					<input type="text" value='${info.wh_id}' class="form-control" readonly id="wh_id" name="wh_id">
				</td>
				<td>창고명</td>
				<td>
					<input type="text" class="form-control" value='${info.wh_nm}' name="wh_nm">
				</td>
			</c:if>
			<c:if test="${action eq 'NEW'}">
				<td>창고명</td>
				<td>
					<input type="text" class="form-control" name="wh_nm">
				</td>
				<td>창고위치</td>
				<td>
					<select id="wh_loc" name="wh_loc" class="form-control"></select>
				</td>
			</c:if>
			
		</tr>
		
		<tr>
			<td>담당자</td>
			<td>
				
					<%-- <input type="text" class="form-control"  value='${info.loginID}' readonly> --%>
					<select id="advisor" name="loginID">
					</select>
				
				<%-- <c:if test="${action eq 'NEW'}">
					<input type="text" class="form-control" >
				</c:if> --%>
			</td>
			<td>전화번호</td>
			<td>
				<div class="form-inline" id="phoneArea">
					<input type="text" class="form-control" id="p-head" name="p_head" readonly>
					<span>-</span>
					<input type="text" class="form-control" id="p-mid" name="p_mid" readonly>
					<span>-</span>
					<input type="text" class="form-control" id="p-end" name="p_end" readonly>
				</div>
			</td>
		</tr>
		
		<tr>
			<td>이메일</td>
			<td colspan="3">
				<input type="text" class="form-control" value='<c:if test="${action ne 'NEW'}">${info.email}</c:if>' id="email" readonly>
			</td>
		
		</tr>
		
		<tr>
			<td>우편번호</td>
			<td colspan="3">
				<div class="form-inline">
					<input type="text" class="form-control"  value='<c:if test="${action ne 'NEW'}">${info.zipCode}</c:if>' id="zipCode" name='zipCode'>
					<!-- <button id='findAddress' class="btn">주소찾기</button> -->
					<input type="button" id="findAddress" class="btn" value='주소찾기'>
				</div>
			</td>
		</tr>
		<tr>
			<td>주소</td>
			<td colspan="3">
				<input type="text" class="form-control"  value='<c:if test="${action ne 'NEW'}">${info.addr}</c:if>' id="addr" name='addr'>
			</td>
		</tr>
		<tr>
			<td>상세주소</td>
			<td colspan="3">
				<input type="text" class="form-control"  value='<c:if test="${action ne 'NEW'}">${info.dtAddress}</c:if>' id="dtAddress" name='dtAddress'>
			</td>
		</tr>
		
		
		
	
	
	</table>
	
	<div class="btnMngWareHouseArea text-center mt30" style="margin-bottom: 50px;">
		<c:if test="${action eq 'NEW'}">
			<button type="button" class="btn btn-primary mx10" id="btnRegister">등록</button>
		</c:if>
		<c:if test="${action ne 'NEW'}">
			<button type="button" class="btn btn-primary mx10" id="btnUpdate">저장</button>
			<button type="button" class="btn btn-danger mx10" id="btnDelete">삭제</button>
		</c:if>
		<button type="button" class="btn mx10" id="close">취소</button>
	</div>
	
	
	<!-- POST POP UP MODAL -->
	<div id="daumFindZipCodeArea">
		<div id="zipFrame" style="position:absolute; z-index:10; display:none;">
			<img src="/images/admin/comm/btn_close.png" id="btn-close-daum">
		</div>
	</div>
	
	


</div>