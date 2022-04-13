<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>

<div id="formwrap" class="bts">
	<fmt:setLocale value="ko-KR"/>
	
	<div id="salesInfoArea">
	
		
		
		<div class="mt20" id="area-left">
			<div>
				<c:if test='${action ne "NEW"}'>
					<div class="form-inline">
						<span>상품번호</span>
						<input type="text" class="form-control" value='<c:if test="${not empty info}">${info.sales_id}</c:if>' name="sales_id" id="sales_id" readonly>
					</div>
				</c:if>
				<c:if test='${action eq "NEW"}'>
					<div class="mb30">
						<select id="sb-salestype" name="sales_type"></select>
					</div>
					<span>상품 사진</span>
				</c:if>
				
			</div>
			<div id="salesImgArea">
			
				
				<c:if test="${not empty info.files}">
					<img src="${info.files[0].file_server_path}" id="representPhoto" alt="/images/nonesalesimg.jpg">
				</c:if>
				<c:if test='${empty info.files || action=="NEW"}'>
					<img src="/images/nonesalesimg.jpg" id="representPhoto">
				</c:if>

				<!-- 상품사진 등록 버튼 -->
				<label for="files" id="l_files">
					
				</label>
			    <input type="file" name="files" id="files" multiple>
				
			</div>
			
			<div id ="shortImages">
				<div> 
					<c:if test="${not empty info.files}">
						<c:forEach items="${info.files}" var="photo">
							<img src="${photo.file_server_path}">
						</c:forEach>
					</c:if>
				</div> 
			</div>
		</div>
		
		
		<div id="area-right" class="bts">
			
			<table>
				<tr>
					<td>모델명</td>
					<td><input type="text" class="form-control" value='<c:if test="${not empty info}">${info.model_nm}</c:if>' name="model_nm" id="model_nm"></td>
					<td colspan="2"></td>	
				</tr>
				<tr>
					<td>모델번호</td>
					<td><input type="text" class="form-control" value='<c:if test="${not empty info}">${info.model_code}</c:if>' name="model_code" id="model_code"></td>
					<td>제조사</td>
					<td><input type="text" class="form-control" value='<c:if test="${not empty info}">${info.mfcomp}</c:if>' name="mfcomp" id="mfcomp"></td>
					
				</tr>
				<tr>
					<td>제품명</td>
					<td><input type="text" class="form-control" value='<c:if test="${not empty info}">${info.sales_nm}</c:if>' name="sales_nm" id="sales_nm"></td>
					<td>제품가격</td>
					<td>
						<input type="text" class="form-control" value='<c:if test="${not empty info}">
																			<fmt:formatNumber type="currency">${info.price}</fmt:formatNumber> 
																	   </c:if>' name="price" id="price">
				    </td>
				</tr>
				
				<tr>
					<td colspan="4">
						<textarea name="info" id="dtInfoArea" rows="3" class="form-control" style="width:100%; text-align:left;">
							<c:if test="${not empty info}">${info.info}</c:if>
						</textarea>
					</td>
				</tr>
			
			</table>

		
			<input type="hidden" value='${action}' name="action" id="action">
			
			
		</div>
	
	
	</div>
	
	<div class="salesMngBtnArea text-right" style="margin-right:15px; margin-bottom:30px;">
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
		<button type="button" class="btn" id="close">취소</button>
	</div>
</div>