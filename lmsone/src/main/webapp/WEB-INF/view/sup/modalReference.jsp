<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script>

	/*학습자료 모달 실행*/
	function fReferenceRegister(){
		     
		initModal(0);	
	
		gfModalPop('#layerReference');
	}
	
	function initModal(mode, data){
		
		
		if(mode == 0){
			if($("#user_type").val() == "A" || $("#user_type").val() == "D"){
				$("#fileTd").html('');
				$("#RegisterCom").show();	
				$("#referenceSubject").val("").attr("readonly", false);
				$("#referenceContent").val("").attr("readonly", false);
				$("#referenceFile").show();
				$("#referenceFile").val("").attr("readonly", false);
				$("#UpdateCom").hide();
				$("#btndel").hide();
				$("#fileTd").append("<input type = 'file' class = 'inputTxt p100' id = 'referenceFile' name = 'referenceFile'/>");
			}
		}
		/*단건 조회, 작성자와 열람자가 동일하다면 수정/삭제 가능 */
		else if(mode == 1){
			$("#referenceFile").hide();
			$("#fileTd").html('');
			$("#UpdateCom").hide();
			$("#btndel").hide();
			$("#RegisterCom").hide();
			$("#referenceSubject").val(data.referenceInfo.board_nm).attr("readonly", true);
			$("#referenceContent").val(data.referenceInfo.board_content).attr("readonly", true);
			//$("#referenceFile").val(data.referenceInfo.file_name).attr("readonly", true);
			$("#referenceFile").hide();
			var str = "<a href='javascript:fReferenceDownFiles("+data.referenceInfo.board_no+");' id='btnDownFiles'>" +data.referenceInfo.file_name+ "</a>";
			
			$("#fileTd").append(str);
		
			if($("#loginID").val() == data.referenceInfo.loginID ){
				$("#UpdateCom").show();
				$("#btndel").show();
				$("#referenceSubject").val(data.referenceInfo.board_nm).attr("readonly", false);
				$("#referenceContent").val(data.referenceInfo.board_content).attr("readonly", false);
				$("#board_no").val(data.referenceInfo.board_no);	
				$("#fileTd").append("<input type = 'file' class = 'inputTxt p100' id = 'referenceFile' name = 'referenceFile'/>");
			}
			//관리자 삭제 가능
			if($("#user_type").val() == "A" ){
				$("#btndel").show();
				$("#board_no").val(data.referenceInfo.board_no);
			}
		}
	}
	
	
	
	function CompleteRegister(action){
		//빈칸 체크
		var chk = checkNotEmpty(
				[
						[ "referenceSubject", "제목을 입력해 주세요" ]
					,	[ "referenceContent", "내용을 입력해 주세요" ]
					
				]
		);

		if (!chk) {
			return;
		}
		$('#action').val(action);			
		const imageInput = $("#referenceFile")[0];
		console.log("imageInput: ", imageInput.files)
	
		if(action == 'I'){

			if(imageInput.files.length === 0){
				swal("파일은 선택해주세요");
			return;
			}
		}
		
		else if(action == 'U'){
			if(imageInput.files.length === 0){
				//udpate not file
				//파일은 업데이트 하지 않음
				$('#action').val("UNF");				
			}
			
		}
		var subject = $('#referenceSubject').val();
		var content = $('#referenceContent').val();
		
		content = content.replace(/(?:\r\n|\r|\n)/g, '<br>');
		
		var param = {
				subject : subject
			,	content : content
		}
		
		  var frm = document.getElementById("ReferenceForm");
        frm.enctype = 'multipart/form-data';
         var fileData = new FormData(frm);

		console.log(content);
		var resultCallback = function(data) {
			fCloseModal();
			
		}

		
		callAjaxFileUploadSetFormData("/sup/registerReference.do", "post", "json",true, fileData,resultCallback);
	}
	/** 학습자료 단건 조회 */
	function fSelectOne(board_no) {
		
		var param = { board_no : board_no };
		
		var resultCallback = function(data) {
			
			fSelectOneResult(data);
		};
		
		callAjax("/sup/referenceDtlInfo.do", "post", "json", true, param, resultCallback);
		
	}

	/** 학습자료 단건 조회 콜백 함수*/
	function fSelectOneResult(data) {

		console.log("fSelectOneResult : "+JSON.stringify(data)) //나중에 삭제해야할 부분

		
		//instaffRegister(user_type, data, update);
		initModal(1, data);
		// 모달 팝업
		gfModalPop("#layerReference");
		      
			
	}
	
	
	function fReferenceDownFiles(board_no){
		  var params = "";
	      params += "<input type='hidden' name='board_no' value='"+ board_no +"' />";
	      jQuery("<form action='/sup/referenceDownloadFile.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();

	}
	
	function fDeleteReference(){
		
		var board_no = $('#board_no').val();
		
		  var frm = document.getElementById("ReferenceForm");
	        frm.enctype = 'multipart/form-data';
	         var fileData = new FormData(frm);
		var resultCallback = function(data) {
			fCloseModal();
		};
		//Ajax실행 방식
		
		callAjaxFileUploadSetFormData("/sup/deleteReference.do", "post", "text", true, fileData,	resultCallback);
		
		
	}
	

</script>
</head>

<body>
<div id="layerReference" class="layerPosition layerPop layerType2" style="width: 700px;">
	<form id="ReferenceForm" action="" method="post">
		<input type="hidden" name="user_type" id="user_type" value="${sessionScope.userType}"/>
		<input type="hidden" name="loginID" id="loginID" value="${sessionScope.loginId}"/>
		<input type="hidden" name="action" id="action" value=""/>
		<input type="hidden" name="board_no" id="board_no" value=""/>
		<table class = 'row'>
			<colgroup>
				<col width='120px'>
				<col width='500px'>
			</colgroup>
			<tr height = "50">
				<td align = 'center' >제목</td>
				<td>
					<input type = "text" class="inputTxt p100"  id = "referenceSubject" name = "referenceSubject" style="font-size: 18px"/>
				</td>
			</tr>
			<tr height = "200">
				<td align = 'center'>내  용</td>
				<td>
					<textarea class="inputTxt p100"  style = "width: 100%; height:100%" name = "referenceContent" id = "referenceContent" ></textarea>	
				</td>
			</tr>
			<tr height = "50">  
				<td align = 'center'>파일</td>
				<td id = "fileTd">
					<input type = "file" class = "inputTxt p100" id = "referenceFile" name = "referenceFile"/>	
				</td>
			</tr>
		</table>
		<div class="btn_areaC mt30">
			<a href="javascript:CompleteRegister('U');" class="btnType blue" id="UpdateCom"> <span>수정</span></a>
			<a href="javascript:CompleteRegister('I');" class="btnType blue" id="RegisterCom" > <span>확인</span></a> 
			<a href="javascript:fDeleteReference()" class="btnType gray" id="btndel"><span>삭제</span></a>
			<a href="" class="btnType gray" id="btnCloseLsmCod" name="btn"><span>닫기</span></a>
		</div>
		
	</form>
</div>


