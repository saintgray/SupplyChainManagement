<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

	var vueSearchArea="";
	var vueUserList="";
	var vueUserModel="";

	$(document).ready(function(){
		
		
		
		vueUserList=new Vue({
			el:'#userListArea',
			data:{
				selectPage:'',
				rowsPerPage:'',
				totalCount:'',
				userlist:[]
			},
			methods:{
				getList:function(selectPage){
					getUserListByParam(selectPage);
				},
				userinfo:function(userID,action){
					fuserFormPop({userID:userID, action:action});
				},
				deleteUser:function(){
					fManageUser("DELETE");
				}
			}
		});
		
		vueSearchArea=new Vue({
			el:'#searchArea',
			data:{
				keyword:null,
				showall:'',
				searchType:''
			}
		})
		
		vueUserModel=new Vue({
			el:'#userModalForm',
			data:{
				action:'',
				readonly:false,
				regType:null,
				info:{}
			},
			methods:{
				closeModal:function(){
					this.action='';
				},
				reg:function(){
					fManageUser("REGISTER");
				},
				update:function(){
					fManageUser("UPDATE");
				}
			}
		})
		
		// initiate Page List
		vueUserList.getList();
	})


	

	
	
	function fuserFormPop(param) {

		
		console.log('init fuserFormPop');
		console.log(param);
		callAjax('/scm/vue/getForm', 'post', 'json', false, param, function(data){

				
				vueUserModel.info=data.info;
				vueUserModel.action=param.action;
				if(param.action=='NEW'){
					vueUserModel.regType='cust';
				}
				
				
				/* if (param.action == 'REGISTER') {
					$('.basicinfo-row1').after($(getAdditionalInfoFormForCust()));
					$('#btnEditUserInfo').attr('id', 'regUserBtn').text('등록');

				} */

				
				// $('#userModalForm').empty().append($(data));

			
			///////////////////////////////////////
			
		});

		
	}

	

	// 신규등록 , 정보수정

	function fManageUser(controlType) {
		
		var action=vueUserModel.action;
		console.log(action);
		
		if(controlType=="DELETE" && (action=="NEW" || action=='')){
			swal('삭제하실 회원을 선택하세요');
		}else{
			
			
			var callback=function(data){
				vueUserModel.action='';
				fAfterInsertOrUpdate(data,controlType);
			}
			
			if(
				(controlType=='REGISTER') ||
				(controlType=='UPDATE' && confirm('수정하시겠습니까?')) ||
				(controlType=='DELETE' && confirm('정말로 삭제하시겠습니까?'))
			  ){
				
				/* if(controlType=='DELETE'){
					$('#action').val('DELETE');
				} */
				
				if(controlType=='REGISTER' && (!validationChecked() || isDuplicated(vueUserModel.info.loginID))){
					return;
				}else{
					
					swal('등록/수정 및 삭제 를 시작합니다');
					// callAjax('/scm/userinfo/manage', 'POST', 'json', true, $('#userModalForm').serialize(), callback);
					// callAjax('/scm/userinfo/manage', 'POST', 'json', true, vueUserModel.info, callback);
				}
			}	
		}
	}

	function fAfterInsertOrUpdate(data,controlType) {
		console.log(data);
		if (data==1) {
			if(controlType=='REGISTER'){
				alert('등록이 완료되었습니다');	
			}else if(controlType=='UPDATE'){
				alert('수정이 완료되었습니다');
			}else{
				alert('정상적으로 삭제되었습니다');
			}
			
			window.location.reload();

		} else {
			swal('오류가 발생하였습니다. 잠시후 다시 시도하세요');
		}

	}
	
	function isDuplicated(loginID){
		var duplicated=false;
		
		var callback=function(data){
			
			if(data==1){
				swal('이미 등록된 사용자이거나 탈퇴한 회원입니다');
				duplicated=true;	
			}
		}
		callAjax('/scm/userinfo/'+loginID, 'POST', 'json', false, {}, callback);
		return duplicated;
	}
	function validationChecked(){
		var validated=false;
		let loginID= vueUserModel.info.loginID;
		let password=vueUserModel.info.password;
		
		
		
		if(loginID ==null || loginID.length<8){
			if(loginID==null){
				swal('아이디는 필수 입력 사항입니다');
			}else{
				if(loginID.length<8){
					swal('아이디는 8자 이상이어야 합니다');	
				}
			}
		}else if(password==null||password.length<8){
			if(password==null){
				swal('비밀번호는 필수 입력사항입니다');
			}else if(password.length<8){
				swal('8자리 이상의 비밀번호를 사용해주세요');
			}
		}else{
			validated=true;
		}
		return validated;
	}



	// get User List
	function getUserListByParam(selectPage) {
		
		
		var searchParam = {
				
			selectPage: selectPage = selectPage || 1,
			rowsPerPage: vueUserList.rowsPerPage = vueUserList.rowsPerPage || 5,
			searchType: vueSearchArea.searchType = vueSearchArea.searchType || 'all',
			keyword: vueSearchArea.keyword,
			showall: vueSearchArea.showall = vueSearchArea.showall || 'N'
			
		}
		
		console.log(searchParam);

		var resultCallback = function(data) {
			fUserListCallBack(data, searchParam);
		}

		callAjax('/scm/vue/userList', 'post', 'json', true, searchParam, resultCallback);

	}

	function fUserListCallBack(data, searchParam) {
	
		
		vueUserList.selectPage=data.page.selectPage;
		vueUserList.rowsPerPage=data.page.rowsPerPage;
		vueUserList.searchType=data.page.searchType;
		
		vueSearchArea.keyword=data.page.keyword;
		vueSearchArea.showall=data.page.showall;
		
		vueUserList.totalCount=data.page.totalCount;
		vueUserList.userlist=data.page.userlist;
		
		
		var paginationHtml = getPaginationHtml(vueUserList.selectPage, vueUserList.totalCount, vueUserList.rowsPerPage,
		// pageBlockSize : 페이지의 페이징 : 한 페이지당 몇개의 페이지 번호를 볼 수 있을 지 파라미터로 넘긴다
		// 5 , 6 , 7,... 변경해보며 테스트해보자
		5, 'vueUserList.getList');

		// $('#userListArea').empty().append(data).append(paginationHtml);
		$('#userListArea .paging').remove();
		$('#userListArea table').after(paginationHtml);
	}
</script>