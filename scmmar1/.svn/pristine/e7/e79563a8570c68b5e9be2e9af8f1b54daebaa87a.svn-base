<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="salesInfoArea">

	
	
	<div class="mt20" id="area-left">
		<div>
			<c:if test='${action ne "NEW"}'>
				<span>상품번호</span>
				<input type="text" value='<c:if test="${not empty info}">${info.sales_id}</c:if>' name="sales_id" id="sales_id">
			</c:if>
			<c:if test='${action eq "NEW"}'>
				<span>상품 사진</span>
			</c:if>
			
		</div>
		<div>
			<c:if test="${not empty info.files}">
				<img src="${info.files[0].file_server_path}" id="representPhoto">
			</c:if>
			<c:if test='${empty info.files || action=="NEW"}'>
				<img src="/sdfsdf" id="representPhoto">
			</c:if>
			<!-- 파일업로드 테스트 -->
		    <input type="file" name="files" id="files" multiple>
			
		</div>
	</div>
	
	
	<div id="area-right">
		
		<table>
			<tr>
				<td>모델명</td>
				<td><input type="text" value='<c:if test="${not empty info}">${info.model_nm}</c:if>' name="model_nm" id="model_nm"></td>
				<td colspan="2"></td>	
			</tr>
			<tr>
				<td>모델번호</td>
				<td><input type="text" value='<c:if test="${not empty info}">${info.model_code}</c:if>' name="model_code" id="model_code"></td>
				<td>제조사</td>
				<td><input type="text" value='<c:if test="${not empty info}">${info.mfcomp}</c:if>' name="mfcomp" id="mfcomp"></td>
				
			</tr>
			<tr>
				<td>제품명</td>
				<td><input type="text" value='<c:if test="${not empty info}">${info.sales_nm}</c:if>' name="sales_nm" id="sales_nm"></td>
				<td>제품가격</td>
				<td><input type="text" value='<c:if test="${not empty info}">${info.price}</c:if>' name="price" id="price"></td>
			</tr>
			
			<tr>
				<td colspan="4">
					<input type="text" value='<c:if test="${not empty info}">${info.info}</c:if>'  name="info" id="dtInfoArea" style="width:100%">
				</td>
			</tr>
		
		</table>
		
		
		<div class="salesMngBtnArea text-right bts">
			<button type="button" class="btn btn-primary" id="btnRegister">
				<c:if test='${action eq "NEW"}'>
					등록
				</c:if>
				<c:if test='${action ne "NEW"}'>
					저장
				</c:if>
			</button>
			<c:if test='${action ne "NEW"}'>
				<button type="button" class="btn btn-danger" id="btnDelete">삭제</button>
			</c:if>
			<button type="button" class="btn btn-primaty" id="close">취소</button>
		</div>
	
	
		<input type="hidden" value='${action}' name="action" id="action">
		
		
	</div>


</div>