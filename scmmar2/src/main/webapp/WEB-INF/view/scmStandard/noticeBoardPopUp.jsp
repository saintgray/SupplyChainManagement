<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.content {
	padding-top: 30px;
}
div.row1 {
	width: 100%;
	height: 30%;
	display: flex;
	padding-bottom: 10px;
}
div.row {
	width: 100%;
	display: flex;
}
#ntcpopupcod {
	width: 289px;
	height: 247px;
}
.btnType {
	cursor: pointer;
}
</style>

<div id="ntcpopuptable" style="margin: 10px;">
	<dl>
		<dd class="content">
			<input type="hidden" id="ntc_no" name="ntc_no" value="${ntc_no}"> <!-- 수정시 필요한 num 값을 넘김  -->
			<input type="hidden" id="loginID" name="loginID" value="${loginID}">
			<div class="row">
			<table class="col">
				<tbody id="ntcpopupcod"> <!-- tbody 시작 -->
					<tr>
						<th>제목</th>
						<td colspan="12"><input type="text" class="inputTxt p100" name="ntc_title" id="ntc_title" value="${ntc_title}"/></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td colspan="12"><input type="text" class="inputTxt p100" name="name" id="name" value="${name}" readonly/></td>
					</tr>
					<tr>
						<th>작성일</th>
						<td colspan="12"><input type="text" class="inputTxt p100" name="ntc_regdate" id="ntc_regdate" value="${ntc_regdate}" readonly></td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="12"><textarea class="inputTxt p100" name="ntc_content" id="ntc_content" value="${ntc_content}"></textarea></td>
					</tr>
					<tr>
						<th scope="row">파일</th>
						<td>
						<input type="file" id="file" name="file"/></td>
					</tr>
					<tr id="filedowndiv">
						<th scope="row">첨부 파일 </th>
						<td>
						    <div id="filedown"></div>
						</td>
					</tr>
				</tbody> <!-- tbody 끝 -->
			</table>
			</div>
				
			<div class="btn_areaC mt30" style="margin-bottom: 10px;">
				<input type="hidden" name="ntc_readcnt" id="ntc_readcnt" value="${ntc_readcnt}">
				<a class="btnType blue" id="insertNotcieCod" name="btn"><span>저장</span></a>
				<a class="btnType blue" id="deleteNoticeCod" name="btn"><span>삭제</span></a>
				<a class="btnType gray" id="closeCod" name="btn"><span>취소</span></a>
			</div>
		</dd>
	</dl>
	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>
<!--// 모달팝업 -->
	