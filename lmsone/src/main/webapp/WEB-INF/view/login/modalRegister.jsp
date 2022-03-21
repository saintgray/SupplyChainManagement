<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(document).ready(function() {
	
	comcombo("MAILCD", "selectEmail", "input","");
	
	
	/*추가 버튼 이벤트*/
	$('#CareerAdd').click(function(e){
		i++;
		e.preventDefault();
		
		$('#careerInfo').append('<tr class="addCareerTr"><td align = "center"><input class="inputTxt" style="width: 118px" type="text" name="corp_'+ i +'"></td>' +
				'<td align = "center"><input type="date" class="inputTxt p100" name="join_date_'+ i +'"  style="font-size: 15px" /></td>' +
				'<td align = "center"><input type="date" class="inputTxt p100" name="resign_date_'+ i +'"  style="font-size: 15px" /></td>' +
				'<td><a href="" class="btnType gray CareerDel" name="btn"><span>삭제</span></a></td></tr>'
				);
	});
	//동적으로 생성된 버튼에 이번트 달기
	$('#careerInfo').on('click', '.CareerDel', function(e){
		e.preventDefault();

		$(this).parent().parent().remove();
	});
	
	
});

function fMemberRegisterCloseModal(){
	gfCloseModal();
}
/* 회원가입 모달창 실행 */
function fMemberRegister(flag, action) {
	var div_cd;
	$("#action").val(action);
	
	// 모달 팝업
	gfModalPop("#layerMemberRegister");
	
	instaffRegister(flag);
}

/*일반 회원가입 폼 초기화*/
function instaffRegister(flag, data, update){
	i = 0;
	$('#UpdateCom').hide();
	$("#user_type").val(flag);
	
	if( data == "" || data == null || data == undefined) {
		if(flag == "C"){
			$("#join_th").show();
			$("#join_div").show();
			$("#career_div").show();
			$("#join_yn").val("");
		}
		else if(flag == "D"){
			$("#join_th").hide();
			$("#join_div").hide();
			$("#career_div").hide();
		}
		$("#div_cd").val("CommonMember");
		$("#user_type_li").hide();
		$("#registerId").val("").attr("readonly", false);;
		$("#registerPwd").val("").attr("readonly", false);;
		$("#passwordConfirm").show();
		$("#registerPwdOk").show();
		$("#registerPwdOk").val("").attr("readonly", false);
		$("#rggender_th").show();
		$("#rggender_td").show();
		$("#registerName").show();
		$("#registerName_th").show();
		$("#registerName").val("").attr("readonly", false);
	 	$("#gender").val("").attr("readonly", false);
		$("#registerEmail").val("").attr("readonly", false);
		$("#user_email2").val("").attr("readonly", false)
		$("#detailaddr").val("").attr("readonly", false);
		$("#loginaddr").val("").attr("readonly", false);
		$("#loginaddr1").val("").attr("readonly", false);
		$("#tel1").val("").attr("readonly", false);
		$("#tel2").val("").attr("readonly", false);
		$("#tel3").val("").attr("readonly", false);
		$("#birthday1").show();
		$("#birthday").val("").attr("readonly", false);
		$("#RegisterCom").show();
		$("#corp").val("").attr("readonly", false);
		$("#join_date").val("").attr("readonly", false);
		$("#resign_date").val("").attr("readonly", false);
		$(".addCareerTr").remove();
		
		


		
	}
	
	else{
		//수정
		if(update == 'U'){
			if(flag == "C"){
				$("#join_th").show();
				$("#join_div").show();
				$("#career_div").show();
				
				$("#join_yn").val("");
			}
			else if(flag == "D"){
				$("#join_th").hide();
				$("#join_div").hide();
				$("#career_div").hide();
				
			}
			
	 		$('#UpdateCom').show();
			$("#div_cd").val("CommonMember");
			
			$("#registerId").val(data.teacherInfo.loginID).attr("readonly", true);
			$("#registerPwd").val(data.teacherInfo.password).attr("readonly", false);
			$("#passwordConfirm").show();
			$("#registerPwdOk").show();
			$("#registerPwdOk").val(data.teacherInfo.password).attr("readonly", false);
			$("#registerName").val(data.teacherInfo.name).attr("readonly", false);
		 	$("#gender_cd").val(data.teacherInfo.gender).attr("readonly", false);
			$("#registerEmail").val(data.teacherInfo.user_email).attr("readonly", false);
			$("#selectEmail").show();
			$("#user_email2").val(data.teacherInfo.user_email2).attr("readonly", false);
			$("#detailaddr").val(data.teacherInfo.zipcd).attr("readonly", false);
			$("#loginaddr").val(data.teacherInfo.addr).attr("readonly", false);
			$("#loginaddr1").val(data.teacherInfo.dtl_addr).attr("readonly", false);
			$("#tel1").val(data.teacherInfo.tel1).attr("readonly", false);
			$("#tel2").val(data.teacherInfo.tel2).attr("readonly", false);
			$("#tel3").val(data.teacherInfo.tel3).attr("readonly", false);
			$("#birthday").val(data.teacherInfo.birth).attr("readonly", false);
			$("#idConfirm").hide();
			$("#searchZip").show();
			$("#RegisterCom").hide();
		}	
		
	
		//조회
		else{
			if(flag == "C"){
				$("#join_th").show();
				$("#join_div").show();
				$("#career_div").show();
				$("#join_yn").val("");
			}
			else if(flag == "D"){
				$("#join_th").hide();
				$("#join_div").hide();
				$("#career_div").hide();
			}
			
			$("#div_cd").val("CommonMember");
			
			$("#registerId").val(data.teacherInfo.loginID).attr("readonly", true);
			$("#registerPwd").val(data.teacherInfo.password).attr("readonly", true);
			$("#passwordConfirm").hide();
			$("#registerPwdOk").hide();
			$("#registerName").val(data.teacherInfo.name).attr("readonly", true);
		 	$("#gender_cd").val(data.teacherInfo.gender).attr("disabled", true);
			$("#registerEmail").val(data.teacherInfo.user_email).attr("readonly", true);
			$("#selectEmail").hide();
			$("#user_email2").val(data.teacherInfo.user_email2).attr("readonly", true);
			$("#detailaddr").val(data.teacherInfo.zipcd).attr("readonly", true);
			$("#loginaddr").val(data.teacherInfo.addr).attr("readonly", true);
			$("#loginaddr1").val(data.teacherInfo.dtl_addr).attr("readonly", true);
			$("#tel1").val(data.teacherInfo.tel1).attr("readonly", true);
			$("#tel2").val(data.teacherInfo.tel2).attr("readonly", true);
			$("#tel3").val(data.teacherInfo.tel3).attr("readonly", true);
			$("#birthday").val(data.teacherInfo.birth).attr("readonly", true);
			$("#idConfirm").hide();
			$("#searchZip").hide();
			$("#RegisterCom").hide();
		
		}
	}	
}
function RegisterVal(){
	  
	var div_cd = $('#div_cd').val();
	var user_type = $('#user_type').val();
	var rgid = $('#registerId').val();
	var rgpwd = $('#registerPwd').val();
	var rgpwdok = $('#registerPwdOk').val();
	var rgname = $('#registerName').val();
	var user_company =$('#user_company').val();
	var rgemail = $('#registerEmail').val();
	var dtadr = $('#detailaddr').val();
	var lgadr = $('#loginaddr').val();
	var lgadr1 = $('#loginaddr1').val();
	var tel1 = $('#tel1').val();
	var tel2 = $('#tel2').val();
	var tel3 = $('#tel3').val();

	if(user_type == ""){
		swal("타입을 입력해주세요.").then(function() {
			$("#user_type").focus();
		  });
		return false;
	}

	
	if(rgid.length < 1){
		swal("아이디를 입력하세요.").then(function() {
			$('#registerId').focus();
		  });
		return false;
	}
	
	if(rgpwd.length < 1){
		swal("비밀번호를 입력하세요.").then(function() {
			$('#registerPwd').focus();
		  });
		return false;
	}
	
	if(rgpwdok.length < 1){
		swal("비밀번호 확인을 입력하세요.").then(function() {
			$('#registerPwdOk').focus();
		  });
		return false;
	}
	
	if(rgpwd != rgpwdok){
		swal("비밀번호가 맞지 않습니다.").then(function() {
			$('#registerPwd').focus();
		  });
		return false;
	}
	
	if(rgname.length < 1){
		swal("이름을 입력하세요.").then(function() {
			$('#registerName').focus();
		  });
		return false;
	}
	
	
	
	if(rgemail.length < 1){
		swal("이메일을 입력하세요.").then(function() {
			$('#registerEmail').focus();
		  });
		return false;
	}
	
	if(dtadr.length < 1){
		swal("우편번호를 입력하세요.").then(function() {
			$('#detailaddr').focus();
		  });
		return false;
	}
	
	if(lgadr.length < 1){
		swal("주소를 입력하세요.").then(function() {
			$('#loginaddr').focus();
		  });
		return false;
	}
	

	
	if(tel1.length < 1){
		swal("전화번호를 입력하세요.").then(function() {
			$('#tel1').focus();
		  });
		return false;
	}
	
	if(tel2.length < 1){
		swal("전화번호를 입력하세요.").then(function() {
			$('#tel2').focus();
		  });
		return false;
	}
	
	if(tel3.length < 1){
		swal("전화번호를 입력하세요.").then(function() {
			$('#tel3').focus();
		  });
		return false;
	}
	

	return true;
	
}
/*loginID 중복체크*/
function loginIdCheck(){
	
	var data = {"loginID" : $("#registerId").val()};
	
	var idRules =  /^[a-z0-9]{6,20}$/g ;
	var id = $("#registerId").val();

	/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
	$.ajax({
		url : '/check_loginID.do',
		type : 'post',
		data : data,
		dataType : 'text',
		async : true,
		success : function(data) {
			if($("#registerId").val()==""){
				console.log("입력 아이디 없음");
				swal("아이디를 입력해주세요.").then(function(){
					$("#registerId").focus();
				});
				$("#ckIdcheckreg").val("0");
			}
			 else if (data==1){
				console.log("아이디 있음");
				swal("중복된 아이디가 존재합니다.").then(function(){
					$("#registerId").focus();
				});
				console.log(data);
				$("#ckIdcheckreg").val("0");
			} else if(!idRules.test($("#registerId").val())){
				swal('아이디는 숫자,영문자 조합으로 6~20자리를 사용해야 합니다.').then(function(){
					$("#registerId").focus();
				});
				$("#ckIdcheckreg").val("0");
				return false;
			} else if(data == 0){
				console.log("아이디 없음");
				swal("사용할 수 있는 아이디 입니다.");
				$("#ckIdcheckreg").val("1");
			}
		}
	});
}

/*회원가입 버튼 아이디 중복 체크*/
function loginIdCheckComplete(){
	
	var data = {"loginID" : $("#registerId").val()}
	
	var idRules =  /^[a-z0-9]{6,20}$/g ;
	var id = $("#registerId").val();

	/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
	$.ajax({
		url : '/check_loginID.do',
		type : 'post',
		data : data,
		dataType : 'text',
		async : false,
		success : function(data) {
			if (data == 1){
				$("#ckIdcheckreg").val("0");
				console.log("아이디 있음");
				return false;
			} else if(!idRules.test($("#registerId").val())){
				$("#ckIdcheckreg").val("0");
				return false;
			}
		}
	});
}


/*-------  이메일 입력방식 선택  ------*/




/*이메일 중복 체크*/
function emailCheck(){
	var data = {"user_email" : $("#registerEmail").val()};

	$.ajax({
		url : '/check_email.do',
		type : 'post',
		data : data,
		dataType : 'text',
		async : false,
		success : function(data) {
			if(data == 1){
				$("#ckEmailcheckreg").val("0");
				console.log("이메일 있음");
				console.log(data);
				return false;
			} else {
				$("#ckEmailcheckreg").val("1");
				console.log(data);
				console.log("이메일 없음");
			}
			
		}
	});
}

/* 회원가입  완료*/
function CompleteRegister(action) {
	
	//console.log("corp_0: " + $("#corp_0").val())
	$("#action").val(action);
	var str = $("#corp_0").val();
	if(str != ""){
		console.log("corp_0: " + $("#corp_0").val());
		$("#tableLength").val(i+1);
	}

	
	var param = $("#RegisterForm").serialize();

 	console.log(param);
	/*패스워드 정규식*/
	var passwordRules = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
 	var password = $("#registerPwd").val();
 	/*이메일 정규식*/
	var emailRules = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var email = $("#registerEmail").val();
	
	/*전화번호 정규식*/
	var tel1Rules = /^\d{2,3}$/;
	var tel2Rules = /^\d{3,4}$/;
	var tel3Rules = /^\d{4}$/;
	
	var tel1 = $("#tel1").val();
	var tel2 = $("#tel2").val();
	var tel3 = $("#tel3").val();
	//console.log(div_cd);
	/* validation 체크 */
	
	if(action != 'U'){
		if(!RegisterVal()){
			return;
		} 
			
		loginIdCheckComplete();
		//emailCheck();
		console.log($("#registerEmail").val() + "@" +$("#user_email2").val());
		if (RegisterForm.ckIdcheckreg.value == "0"){
			swal("아이디 중복확인을 진행해주세요.").then(function() {
				$("#registerId").focus();
			  });
		} else if(!passwordRules.test($("#registerPwd").val())){
			swal('비밀 번호는 숫자,영문자,특수문자 조합으로 8~15자리를 사용해야 합니다.').then(function() {
				$("#registerPwd").focus();
			  });
			return false;
		} else if(!emailRules.test($("#registerEmail").val() + "@" +$("#user_email2").val() ) ){
			swal("이메일 형식을 확인해주세요.").then(function() {
				$("#registerEmail").focus();
			  });
		} /* else if(RegisterForm.ckEmailcheckreg.value =="0"){
			swal("중복된 이메일이 존재합니다. 다시 입력해주세요.").then(function() {
				$("#registerEmail").focus();
			  }); 
		}*/ else if(!tel1Rules.test($("#tel1").val())){
			swal("전화번호를 확인해주세요.").then(function() {
				$("#tel1").focus();
			  });
		} else if(!tel2Rules.test($("#tel2").val())){
			swal("전화번호를 확인해주세요.").then(function() {
				$("#tel2").focus();
			  });
		} else if(!tel3Rules.test($("#tel3").val())){
			swal("전화번호를 확인해주세요.").then(function() {
				$("#tel3").focus();
			  });
		}
		else{
			
			var resultCallback = function(data) {
			fSaveRegister(data);
			}
		
		callAjax("/register.do", "post", "json", true, param, resultCallback);
		} 
		
	}
	else{
	
		var resultCallback = function(data) {
		fSaveRegister(data);
		}
	
	callAjax("/register.do", "post", "json", true, param, resultCallback);
	} 
	
}

/* 회원 가입 저장 콜백함수 */
function fSaveRegister(data) {

	if (data.result == "SUCCESS") {
		//alert(data.resultMsg);
		gfCloseModal();
	} else {
		//alert(data.resultMsg);
		return false;
	} 
}


// 우편번호 api
function execDaumPostcode(q) {
	new daum.Postcode({
		oncomplete : function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if (data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('detailaddr').value = data.zonecode;
			document.getElementById("loginaddr").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("loginaddr1").focus();
		}
	}).open({
		q : q
	});

}
/*메일 선택*/
function fChangeMail() {
	var selectEmail = $('#selectEmail').val();
	
	$("#user_email2").val(selectEmail);
	
	if(selectEmail != '') {
		$("#user_email2").attr("disabled",true); //활성화 
		
	} else {
		$("#user_email2").attr("disabled",false); //활성화 
	}
}

/** 개발자 모달 실행 */
function fPopModalSelectOne(loginID,user_type, update) {
//	init();
	// 프로젝트 단건 조회
	fSelectOne(loginID,user_type, update);

}


/** 프로젝트 단건 조회 */
function fSelectOne(loginID,user_type, update) {
	
	var param = { loginID : loginID };
	
	var resultCallback = function(data) {
		
		
		fSelectOneResult(user_type, data, update);
	};
	
	callAjax("/tmg/teacherDtlInfo.do", "post", "json", true, param, resultCallback);
	
}

/** 프로젝트  단건 조회 콜백 함수*/
function fSelectOneResult(user_type, data, update) {

	console.log("fSelectOneResult : "+JSON.stringify(data)) //나중에 삭제해야할 부분
	console.log(data.teacherInfo);
	
	instaffRegister(user_type, data, update);
	// 모달 팝업
	gfModalPop("#layerMemberRegister");
	      
		
}

</script>


<!-- 모달팝업 -->


	<div id="layerMemberRegister" class="layerPosition layerPop layerType2" style="width: 700px; height: 1000px">
		<form id="RegisterForm" action="" method="post">

			<input type="hidden" name="action" id="action" value="">
			<input type="hidden" name="ckIdcheckreg" id="ckIdcheckreg" value="0" /> 
			<input type="hidden" name="ckEmailcheckreg" id="ckEmailcheckreg" value="0" />
			<input type="hidden" name="tableLength" id="tableLength" value="0" />
			<dl>
				<dt>
					<br> <br> <strong style="font-size: 120%">&nbsp;&nbsp;&nbsp;&nbsp;회원가입</strong> <br>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							
						</colgroup>
						<tbody>
							<tr class="hidden">
								<td><input type="text" name="user_type" id="user_type" /></td>
							</tr>
							<tr>
								<th scope="row">
									아이디<span class="font_red">*</span>
								</th>
								<td colspan="2">
									<input type="text" class="inputTxt p100" name="loginID" placeholder="숫자, 영문자 조합으로 6~20자리 " id="registerId" />
								</td>
								<td>
									<input type="button" id = "idConfirm" value="중복확인" onclick="loginIdCheck()" style="width: 130px; height: 20px;" />
								</td>
							</tr>
							<tr>
								<th scope="row">
									비밀번호 <span class="font_red">*</span>
								</th>
								<td colspan="3">
									<input type="password" placeholder="숫자, 영문자, 특수문자 조합으로 8~15자리 " class="inputTxt p100" name="password" id="registerPwd" />
								</td>
							</tr>

							<tr id = "passwordConfirm">
								<th scope="row" style="padding: 0 0">
									비밀번호 확인<span class="font_red">*</span>
								</th>
								<td colspan="3">
									<input type="password" class="inputTxt p100" name="password1" id="registerPwdOk" />
								</td>
							</tr>

							<tr>
								<th scope="row" id="registerName_th">이름 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="name" id="registerName" /></td>

								<th scope="row" id="rggender_th">성별</th>
								<td id="rggender_td">
									<select name="gender" id="gender_cd" style="width: 128px; height: 28px;">
										<option value="" selected="selected">선택</option>
										<option value="M">남자</option>
										<option value="F">여자</option>
									</select>
								</td>
							</tr>
							<tr>

								<th scope="row">전화번호<span class="font_red">*</span></th>
								<td colspan="3">
									<input class="inputTxt" style="width: 118px" maxlength="3" type="text" id="tel1" name="user_tel1"> - 
									<input class="inputTxt" style="width: 118px" maxlength="4" type="text" id="tel2" name="user_tel2"> - 
									<input class="inputTxt" style="width: 118px" maxlength="4" type="text" id="tel3" name="user_tel3">
								</td>
							</tr>
							<tr id="birthday1">
								<th scope="row">생년월일 <span class="font_red"></span></th>
								<td>
									<input type="date" class="inputTxt p100" name="birth" id="birthday" style="font-size: 15px" />
								</td>
								
								<th scope="row" id="join_th">재직여부</th>
								<td>
									<div id = "join_div"><input type = "checkbox" name = "join_yn" value = "y"></div>
									
								</td>
								
							</tr>
							<tr>
								<th scope="row">
									이메일<span class="font_red">*</span>
								</th>
								<td colspan="2">
									<input type="text" class="inputTxt p20" name="user_email" id="registerEmail" style="width: 128px; height: 28px;"> @
									<input type="text" class="inputTxt p20" name="user_email2" id="user_email2"  style="width:128px; height: 28px;" >
									<select id="selectEmail" name="user_email2" style="width: 20%; height: 28px; margin-right: 10px" onChange="javascript:fChangeMail()">
									
									</select>
								</td> 
							</tr>
							<tr>
								<th scope="row">우편번호<span class="font_red">*</span></th>
								<td colspan="2"><input type="text" class="inputTxt p100" name="zipcd" id="detailaddr" /></td>

								<td><input type="button" id = "searchZip" value="우편번호 찾기" onclick="execDaumPostcode()" style="width: 130px; height: 20px;" /></td>
							</tr>
							<tr>
								<th scope="row">주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="addr" id="loginaddr" /></td>
							</tr>
							<tr>
								<th scope="row">상세주소</th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="dtl_addr" id="loginaddr1" /></td>
							</tr>
							
					

					</table>

					<!-- 경력정보 ---------------------------------------------------------------------->
					<div id = "career_div">
						<br> <br> <strong style="font-size: 120%">&nbsp;&nbsp;&nbsp;&nbsp;경력정보</strong> <br> <br>
						<table id = "careerTable" class = "row">
							<caption>caption</caption>
							<colgroup>
								<col width="200px">
								<col width="200px">
								<col width="200px">
								<col width="100px">
							</colgroup>
							<tbody id = "careerInfo">
								<tr>
									<th>업체</th>
									<th>입사일</th>
									<th>퇴사일</th>
									<th>
										
										<a href="" class="btnType blue" id="CareerAdd" name="btn"> <span>추가</span></a>
									</th>
								</tr>
								<tr id = "careerBase">
									<td align = "center"><input class="inputTxt" style="width: 118px" name="corp_0" type="text" id="corp_0" ></td>
									<td align = "center"><input type="date" class="inputTxt p100" name="join_date_0" id="join_date" style="font-size: 15px" /></td>
									<td align = "center"><input type="date" class="inputTxt p100" name="resign_date_0" id="resign_date" style="font-size: 15px" /></td>
									
								</tr>
							</tbody>
						</table>
					</div>

					<div class="btn_areaC mt30">
					<a href="javascript:CompleteRegister('U');" class="btnType blue" id="UpdateCom"> <span>수정</span></a>
						<a href="javascript:CompleteRegister('I');" class="btnType blue" id="RegisterCom" > <span>확인</span></a> 
						<a href="javascript:fMemberRegisterCloseModal()" class="btnType gray" id="btnCloseLsmCod" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</form>
	</div>
	
	
