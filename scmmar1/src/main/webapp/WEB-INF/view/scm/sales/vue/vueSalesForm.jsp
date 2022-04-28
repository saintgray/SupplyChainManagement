<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>

<div id="formwrap" class="bts" v-show='action'>
	<fmt:setLocale value="ko-KR"/>
	
	<div id="salesInfoArea">
	
		
		
		<div class="mt20" id="area-left">
			<div>
					<div class="form-inline" v-if='action=="INFO"'>
						<span>상품번호</span>
						<input type="text" class="form-control" name="sales_id" v-model='info.sales_id' :readonly='action="INFO"'>
					</div>
					<div class="mb30" v-show='action=="NEW"'>
						<select id="sb-salestype" name="sales_type"></select>
					</div>
					
			</div>
			<div id="salesImgArea">

				<!-- 바인딩된 src 속성은 html 태그의 alt 속성과 연동되지 않는다. -->
				<!-- 해당 src를 찾으려 할때  에러가 날 경우 @error 를 사용하여 이 경로의 src 경로를 alt 경로로 맞추어 주어야 한다. -->
				<img :src='info.files[0].file_server_path' id="representPhoto" @error='showBasicImg' v-if='action=="INFO" && info.files.length>0'>
				<img :src='representPhoto' id="representPhoto" @error='showBasicImg' v-else-if='action=="NEW" || (action=="INFO" && info.files.length==0)'>
		
				<!-- 상품사진 등록 버튼 -->
				<label for="files" id="l_files">
				</label>
			    <input type="file" name="files" id="files" multiple @change='photoPreview'>
				
			</div>
			
			<div id ="shortImages" v-if='action=="INFO"'>
				<div v-if='info.files.length>0' v-for='(item,index) in info.files'> 
					<img :src='item.file_server_path'>
				</div>
				<div v-if='photos.length>0' v-for='(path,index) in photos'> 
					<img :src='path'>
				</div>  
			</div>
			<div id ="shortImages" v-if='action=="NEW"'>
				<div v-if='action=="NEW"' class="testdiv" v-for='(path,index) in photos'>
					<img :src='path'/>
				</div>
			</div>
			
		</div>
		
		
		<div id="area-right" class="bts">
			
			<table>
				<tr>
					<td>모델명</td>
					<td><input type="text" class="form-control" name="model_nm" id="model_nm" v-model='info.model_nm'></td>
					<td colspan="2"></td>	
				</tr>
				<tr>
					<td>모델번호</td>
					<td><input type="text" class="form-control" name="model_code" id="model_code" v-model='info.model_code'></td>
					<td>제조사</td>
					<td><input type="text" class="form-control" name="mfcomp" id="mfcomp" v-model='info.mfcomp'></td>
					
				</tr>
				<tr>
					<td>제품명</td>
					<td><input type="text" class="form-control" name="sales_nm" id="sales_nm" v-model='info.sales_nm'></td>
					<td>제품가격</td>
					<td>
						<input type="text" class="form-control" name="price" id="price" v-model='info.price' @keydown='fFilterNumber'>
				    </td>
				</tr>
				
				<tr>
					<td colspan="4">
						<textarea name="info" id="dtInfoArea" rows="3" class="form-control" style="width:100%; text-align:left;" v-model='info.info'></textarea>
					</td>
				</tr>
			
			</table>

		
			<%-- <input type="hidden" value='${action}' name="action" id="action"> --%>
			
			
		</div>
	
	
	</div>
	
	<div class="salesMngBtnArea text-right" style="margin-right:15px; margin-bottom:30px;">
	
		<button type="button" class="btn btn-primary" v-if='action=="NEW"' @click='manage("POST")'>등록</button>			
		<button type="button" class="btn btn-primary" v-if='action=="INFO"' @click='manage("POST",info.sales_id)'>저장</button>		
		<button type="button" class="btn btn-danger" v-if='action=="INFO"' @click='manage("DELETE",info.sales_id)'>삭제</button>
		<button type="button" class="btn" id="close" @click='close'>취소</button>
		
	</div>
</div>