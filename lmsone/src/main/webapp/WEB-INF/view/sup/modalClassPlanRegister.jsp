<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(document).ready(function() {
	
	initModal(0);
});

function initModal(mode, data){
	console.log(data);
	if($("#user_type").val() == "A"){
		//강의 기간 선택전
		if(mode == 0){
			$('#modalStartDate').val("").attr("readonly", false);
			$('#modalEndDate').val("").attr("readonly", false);
			$("#class_nm").val("").attr("readonly", true);
			
			$("#class_type").val("A").attr("disabled", true);
			
			$("#teacherName").val("").attr("disabled", true);

			$("#registerTel").val("").attr("readonly", true);
			$("#registerEmail").val("").attr("readonly", true);
			
			$("#classRoomName").val("").attr("disabled", true);
			
			$("#fixedNumber").val("30").attr("readonly", true);
			$("#recvStartDate").val("").attr("readonly", true);
			$("#recvEndDate").val("").attr("readonly", true);
			
			
			
			$("#classPlan_div").hide();
			$("#RegisterCom").hide();
			$("#UpdateCom").hide();
		}
		else if(mode == 1){
			//swal();
			$("#class_nm").attr("readonly", false);
			$("#fixedNumber").attr("readonly", false);
	
			$("#class_type").attr("disabled", false);
			
			$("#recvStartDate").attr("readonly", false);
			$("#recvEndDate").attr("readonly", false);
			
			$("#RegisterCom").show();
		}

		//강의 계획서 단건 조회
		else if(mode == 2){
			$("#RegisterCom").hide();
			$('#modalStartDate').val(data.classPlanInfo.class_startdate).attr("readonly", true);
			$('#modalEndDate').val(data.classPlanInfo.class_enddate).attr("readonly", true);
			$("#class_nm").val(data.classPlanInfo.class_nm).attr("readonly", true);
			
			$("#class_type").val(data.classPlanInfo.class_type).attr("disabled", true);
			
			
			/**/
			$("#teacherName").html('');
			var str = "<option value='" + data.classPlanInfo.name + "'>" + data.classPlanInfo.name + "</option>";
			$("#teacherName").append(str);
			$("#teacherName").attr("disabled", true);
		 	
			/**/
			$("#classRoomName").html('');
			var str = "<option value='" + data.classPlanInfo.room_nm + "'>" + data.classPlanInfo.room_nm + "</option>";
			$("#classRoomName").append(str);
			$("#classRoomName").attr("disabled", true);
			
			
			
			$("#registerTel").val(data.classPlanInfo.tel).attr("readonly", true);
			$("#registerEmail").val(data.classPlanInfo.email).attr("readonly", true);
			
			
			$("#fixedNumber").val(data.classPlanInfo.class_totalcnt).attr("readonly", true);
			$("#recvStartDate").val(data.classPlanInfo.recv_startdate).attr("readonly", true);
			$("#recvEndDate").val(data.classPlanInfo.recv_enddate).attr("readonly", true);
			
			
			
			$("#classPlan_div").show().attr("readonly", true);
			$("#class_obj").val(data.classPlanInfo.class_obj).attr("readonly", true);
			$("#class_att").val(data.classPlanInfo.class_att).attr("readonly", true);
			$("#class_plan").val(data.classPlanInfo.class_plan).attr("readonly", true);
		}
	}
	if($("#user_type").val() == "D"){
		if(mode == 2){
			$("#RegisterCom").hide();
			$("#UpdateCom").hide();
			$('#modalStartDate').val(data.classPlanInfo.class_startdate).attr("readonly", true);
			$('#modalEndDate').val(data.classPlanInfo.class_enddate).attr("readonly", true);
			$("#class_nm").val(data.classPlanInfo.class_nm).attr("readonly", true);
			
			$("#class_type").val(data.classPlanInfo.class_type).attr("disabled", true);
			
			
			/**/
			$("#teacherName").html('');
			var str = "<option value='" + data.classPlanInfo.name + "'>" + data.classPlanInfo.name + "</option>";
			$("#teacherName").append(str);
			$("#teacherName").attr("disabled", true);
		 	
			/**/
			$("#classRoomName").html('');
			var str = "<option value='" + data.classPlanInfo.room_nm + "'>" + data.classPlanInfo.room_nm + "</option>";
			$("#classRoomName").append(str);
			$("#classRoomName").attr("disabled", true);
			
			
			
			$("#registerTel").val(data.classPlanInfo.tel).attr("readonly", true);
			$("#registerEmail").val(data.classPlanInfo.email).attr("readonly", true);
			
			
			$("#fixedNumber").val(data.classPlanInfo.class_totalcnt).attr("readonly", true);
			$("#recvStartDate").val(data.classPlanInfo.recv_startdate).attr("readonly", true);
			$("#recvEndDate").val(data.classPlanInfo.recv_enddate).attr("readonly", true);
			
			
			
			$("#classPlan_div").show().attr("readonly", true);
			$("#class_obj").val(data.classPlanInfo.class_obj).attr("readonly", true);
			$("#class_att").val(data.classPlanInfo.class_att).attr("readonly", true);
			$("#class_plan").val(data.classPlanInfo.class_plan).attr("readonly", true);
			
			/*로그인한 사람과 강의 지정한 사람이 같다면 수정 가능*/
			if($("#loginID").val() == data.classPlanInfo.loginID ){
				$("#UpdateCom").show();
				$("#class_obj").val(data.classPlanInfo.class_obj).attr("readonly", false);
				$("#class_att").val(data.classPlanInfo.class_att).attr("readonly", false);
				$("#class_plan").val(data.classPlanInfo.class_plan).attr("readonly", false);	
				$("#class_no").val(data.classPlanInfo.class_no);	
				
			}
		}
		
	}
		
}

function fMemberRegisterCloseModal(){
	gfCloseModal();
}
/* 모달창 실행 */
function fClassPlanRegister(action) {
	var div_cd;
	$("#action").val(action);
	
	// 모달 팝업
	gfModalPop("#layerClassPlanRegister");
	
	//instaffRegister(flag);
	initModal(0);
}


/* 등록  완료*/
function CompleteRegister(action) {

	$("#action").val(action);
	
	var param = $("#RegisterForm").serialize();

 	console.log(param);

	
	var resultCallback = function(data) {
		fSaveRegister(data);
	}
	callAjax("/sup/registerClassPlan.do", "post", "json", true, param, resultCallback);
}

/* 저장 콜백함수 */
function fSaveRegister(data) {
	console.log(data);
	console.log(data.result);
	if (data.result == "SUCCESS") {
		//alert(data.resultMsg);
		gfCloseModal();
	} else {
		//alert(data.resultMsg);
		return false;
	} 
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



/** 강의계획서 단건 조회 */
function fSelectOne(class_no) {
	
	var param = { class_no : class_no };
	
	var resultCallback = function(data) {
		
		fSelectOneResult(data);
	};
	
	callAjax("/sup/classPlanDtlInfo.do", "post", "json", true, param, resultCallback);
	
}

/** 강의계획서 단건 조회 콜백 함수*/
function fSelectOneResult(data) {

	console.log("fSelectOneResult : "+JSON.stringify(data)) //나중에 삭제해야할 부분

	
	//instaffRegister(user_type, data, update);
	initModal(2, data);
	// 모달 팝업
	gfModalPop("#layerClassPlanRegister");
	      
		
}

/*날짜 체크*/
function fChkDate(){
	var startDate = $('#modalStartDate').val();
	var endDate = $('#modalEndDate').val();
	
	if(startDate == "" || endDate == ""){
		return ;
	}
	
	if(startDate > endDate){
		swal('날짜 잘못 입력');
	}
	
	/**/
	fselectListRegsiterClassPlan(startDate, endDate);
}

/*startDate ~ endDate 기간에 강의가 없는 강사와 강의실 list*/
function fselectListRegsiterClassPlan(startDate, endDate){
	
	/*강의기간 정하면 모집기간 -1달로 셋팅*/
	const start = new Date(startDate);
	const end = new Date(endDate);
	start.setMonth(start.getMonth()-1);
	end.setMonth(end.getMonth()-1);
	
	$('#recvStartDate').val(start.toISOString().split("T")[0]);
	$('#recvEndDate').val(end.toISOString().split("T")[0]);
	var param = {
			startDate : startDate,
			endDate : endDate
	}
	
	var resultCallback = function(data) {
		
		
		fselectListRegsiterClassPlanResult(data);
	};
	
	callAjax("/sup/selectListRegsiterClassPlan.do", "post", "json", true, param, resultCallback);
}

/*임시 data*/
var tmpData=[];

/*리스트 출력*/
function fselectListRegsiterClassPlanResult(data){
	//콤보박스 활성화
	$("#teacherName").attr("disabled",false); 
	//comboBox 생성
	$("#teacherName").html('');
	
	//콤보박스 활성화
	$("#classRoomName").attr("disabled",false); 
	//comboBox 생성
	$("#classRoomName").html('');
	
	
 	for(var i = 0; i < data.listTeacher.length; i++){
		var str = "<option value='" + data.listTeacher[i].loginID + "'>" + data.listTeacher[i].name + "</option>";
		$("#teacherName").append(str);
		tmpData[i] = data.listTeacher[i];
	}
 	
 	for(var i = 0; i < data.listClassRoom.length; i++){
		var str = "<option value='" + data.listClassRoom[i].room_no + "'>" + data.listClassRoom[i].room_nm + "</option>";
		$("#classRoomName").append(str);
		
	} 
 	//console.log(tmpData);
}


/*comboBox 선택*/
function fComboSelectName(){
	var teacherID = $("#teacherName").val();
	var i = 0;
	//연락처, 이메일
	teacherID = $("#teacherName").val();
	
	for(i = 0 ; i < tmpData.length; i++){
		if(tmpData[i].loginID == teacherID){
			break;
		}
	}
	
	console.log("after: " + tmpData[i].loginID);
	
	$("#registerEmail").val(tmpData[i].email);

	$("#registerTel").val(tmpData[i].tel);

	
	initModal(1);
	
}
</script>


<!-- 모달팝업 -->


	<div id="layerClassPlanRegister" class="layerPosition layerPop layerType2" style="width: 700px; height: 800px">
		<form id="RegisterForm" action="" method="post">

			<input type="hidden" name="action" id="action" value="">
			<input type="hidden" name="ckIdcheckreg" id="ckIdcheckreg" value="0" /> 
			<input type="hidden" name="ckEmailcheckreg" id="ckEmailcheckreg" value="0" />
			<input type="hidden" name="tableLength" id="tableLength" value="0" />
			<input type="hidden" name="user_type" id="user_type" value="${sessionScope.userType}"/>
			<input type="hidden" name="loginID" id="loginID" value="${sessionScope.loginId}"/>
			<input type="hidden" name="class_no" id="class_no" value=""/>
			<dl>
				<dt>
					<br> <br> <strong style="font-size: 120%">&nbsp;&nbsp;&nbsp;&nbsp;강의계획서</strong> <br>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="100px">
							<col width="*">
							<col width="100px">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th scope = "row">
									강의일
								</th>
								<td colspan="3" >
									<input type="date" name="modalStartDate" id="modalStartDate" style="font-size: 18px" onchange = "fChkDate()"/> ~ 
									<input type="date" name="modalEndDate" id="modalEndDate" style="font-size: 18px" onchange = "fChkDate()"/> &emsp;
								</td>
							</tr>
							<tr id = "trTeahcerName">
								<th scope = "row">
									이름
								</th>
								<td>
									<select name = "teacherName" id = "teacherName" onchange = "fComboSelectName()"style="width: 100px; height: 28px;" >
									</select>
								</td>
								<th scope="row">
									전화번호
								</th>
								<td >
									<input type="text" class="inputTxt p100" name="user_tel" id="registerTel"> 
								</td>
							</tr>
							<tr>
								<th scope="row">
									이메일
								</th>
								<td >
									<input type="text" class="inputTxt p100" name="user_email" id="registerEmail"> 								
								</td> 
								<th scope = "row">
									강의실
								</th>
								<td>
									<select name = "classRoomName" id = "classRoomName" style="width: 100px; height: 28px;" >
								
									</select>
								</td>
							</tr>
							<tr>
								<th scope = "row">
									과정명
								</th>
								<td>
									<input type="text" class="inputTxt p100" name="class_nm" id="class_nm"> 
								</td>
								
								<th scope = "row">
									분류
								</th>
								<td>
									<select id = "class_type" name = "class_type">
										<option value = "A">실업자교육</option>
										<option value = "B">취업자교육</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope = "row">
									정원
								</th>
								<td>
									<input type="number" class="inputTxt p100" name="fixedNumber" id="fixedNumber" value ="30" min = "1"> 	
								</td>
							</tr>
							
							<tr >
								<th scope="row">모집기간 </th>
								
								<td colspan="3">
									<input type="date" name="recvStartDate" id="recvStartDate" style="font-size: 18px"/> ~ 
									<input type="date" name="recvEndDate" id="recvEndDate" style="font-size: 18px" /> &emsp;
								</td>
								
							</tr>
					

					</table>

					<!-- 강의계획 강사가 작성 ---------------------------------------------------------------------->
					<div id = "classPlan_div">
						<br> <br> <strong style="font-size: 120%">&nbsp;&nbsp;&nbsp;&nbsp;강의계획</strong> <br> <br>
						<table id = "careerTable" class = "row">
							<colgroup>
				
						<col width="80px">
						<col width=*>
					
					</colgroup>
					<tr>
						<th scope="row">수업목표</th>
							<td >
								<textarea  class="inputTxt p100" name="class_obj" id="class_obj" /></textarea>
							</td>
					</tr>
					</table>
					<table class="row">
					<colgroup>
				
						<col width="80px">
						<col width=*>
					
					</colgroup>
						<tr>
							<th scope="row">출석</th>
								<td>
									<textarea class="inputTxt p100" name="class_att" id="class_att"  /></textarea>
								</td>
						</tr>					
					</table>
					
					<table class="row">
					<colgroup>
				
						<col width="80px">
						<col width=*>
					
					</colgroup>
						<tr>
							<th scope="row">강의계획</th>
								<td>
									<textarea class="inputTxt p100" name="class_plan" id="class_plan"  /></textarea>
								</td>
						</tr>		
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
	
	
