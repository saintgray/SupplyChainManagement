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
			},
			methods:{
				getList:function(selectPage){
					getUserListByParam(selectPage);
				}
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
				},
				findZip:function(e){
					e.preventDefault();
					fOpenWinZipCod('zipFrame', 'zipCode', 'address', 'dtAddress');
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
				fAfterInsertOrUpdate(data,controlType);
			}
			
			if(controlType=='REGISTER' && (!validationChecked() || isDuplicated(vueUserModel.info.loginID))){
				return;
			}else{
				
				
				let param=vueUserModel.info;
				param.action=controlType;
				if(confirm(param.action=='REGISTER'?'등록하시겠습니까?':param.action=='UPDATE'?'수정하시겠습니까?':'삭제하시겠습니까?')){
					callAjax('/scm/userinfo/manage', 'POST', 'json', true, param, callback);	
				}
				
			}
				
		}
	}

	function fAfterInsertOrUpdate(data,controlType) {
		
		if (data==1) {
			let msg=controlType=='REGISTER'?'등록이 완료되었습니다':controlType=='UPDATE'?'수정이 완료되었습니다':'정상적으로 삭제되었습니다';
			swal(msg);
			
			vueUserModel.action='';
			vueUserList.getList(vueUserList.selectPage);	

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
		
		$('#userListArea .paging').remove();
		$('#userListArea table').after	(
											getPaginationHtml(	vueUserList.selectPage, 
																vueUserList.totalCount, 
																vueUserList.rowsPerPage,
																5, 
																'vueUserList.getList')
										);
	}
</script>