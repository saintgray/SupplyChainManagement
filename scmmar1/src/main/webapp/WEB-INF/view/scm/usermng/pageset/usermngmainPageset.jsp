<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	$(document).ready(function() {

		getUserListByParam();

		$('body').on('click', '.userInfoBtnArea button, .userID', function(e) {
			e.preventDefault();

			var param = {
				action : '',
				userID : ''
			}
			
			
			switch ($(this).attr('id')) {
			
				case 'regUserBtn':
					fManageUser('REGISTER');
					return;
				
				case 'delUserBtn' :
					$('#action').val('DELETE');
					fManageUser('DELETE');
					return;
			
				case 'btnEditUserInfo':
					fManageUser('UPDATE');
					return;
					
				
				
				
				case 'regFormBtn':
					param.action = 'REGISTER';
					fuserFormPop(param);
					break;
				
				case undefined:
	
					param.userID = $(this).text();
					param.action = 'UPDATE';
					fuserFormPop(param);
					break;
					
					
				case 'closeModal': 
					console.log('closeModal called');
					$('#userinfoarea').remove();
					return;
			}

		})

		$('#searchBtn').on('click', function() {
			getUserListByParam();
		})

		$('#userModalForm').on('change', '#sb-userType', function() {
			console.log($(this).val());
			if ($(this).val() == 'Cust') {
				$('#userModalForm .empInfo').remove();
				$('.basicinfo-row1').after($(getAdditionalInfoFormForCust()));
			} else {
				$('#userModalForm .custInfo').remove();
				$('.basicinfo-row2').after($(getAdditionalInfoFormForEMP()));
			}
		})

	})

	// 신규등록, 유저 상세보기

	function fuserFormPop(param) {

		callAjax('/scm/userinfo/getForm', 'post', 'text', false, param,
				fafterFormPop);

		if (param.action == 'REGISTER') {
			$('.basicinfo-row1').after($(getAdditionalInfoFormForCust()));
			$('#btnEditUserInfo').attr('id', 'regUserBtn').text('등록');

		}

	}

	function fafterFormPop(data) {
		console.log('do afterSuccess func');
		$('#userModalForm').empty().append($(data));

	}
	///////////////////////////////////////

	// 신규등록 , 정보수정

	function fManageUser(controlType) {
		
		var test=$('#user_Type').length;
		console.log(test);
		
		if($('#user_Type').length==0){
			alert('삭제하실 회원을 선택하세요');
		}else{
			var callback=function(data){
				fAfterInsertOrUpdate(data,controlType);
			}
			
			if((controlType=='DELETE' && confirm('정말로 삭제하시겠습니까?')) || controlType!='DELETE'){
				callAjax('/scm/userinfo/manage', 'POST', 'json', true, $('#userModalForm').serialize(), callback);
			}
				
		}
	}

	function fAfterInsertOrUpdate(data,controlType) {
		if (data == 1) {
			if(controlType=='REGISTER'){
				alert('등록이 완료되었습니다');	
			}else if(controlType=='UPDATE'){
				alert('수정이 완료되었습니다');
			}else{
				alert('정상적으로 삭제되었습니다');
			}
			
			window.location.reload();

		} else {
			alert('오류가 발생하였습니다. 잠시후 다시 시도하세요');
		}

	}

	////////////////////////////////////////////

	function getAdditionalInfoFormForEMP() {
		var html = '';
		html += '<tr class="empInfo">\r\n';
		html += '<td>\r\n';
		html += '<span>직원명</span>\r\n';
		html += '</td>\r\n';
		html += '<td>\r\n';
		html += '<input type="text" name="name"\r\n';
		html += '</td>\r\n';
		html += '<td>\r\n';
		html += '<span>담당업무</span>\r\n';
		html += '</td>\r\n';
		html += '<td>\r\n'
		html += '<select>\r\n';
		html += '<option value="A">SCM</option>\r\n';
		html += '<option value="B">배송</option>\r\n';
		html += '<option value="D">구매</option>\r\n';
		html += '<option value="E">임원</option>\r\n';
		html += '</select>\r\n';
		html += '</td>\r\n';
		html += '</tr>';
		return html;

	}

	function getAdditionalInfoFormForCust() {
		var html = '';
		html += '<tr class="custInfo">\r\n';
		html += '<td>\r\n';
		html += '<span>회사명</span>\r\n';
		html += '</td>\r\n';
		html += '<td>\r\n';
		html += '<input type="text" name="client"\r\n';
		html += '</td>\r\n';
		html += '<td>\r\n';
		html += '<span>담당자명</span>\r\n';
		html += '</td>\r\n';
		html += '<td>\r\n'
		html += '<input type="text" name="name"\r\n';
		html += '</td>\r\n';
		html += '</tr>';
		return html;

	}

	// get User List
	function getUserListByParam(selectPage) {
		
		/* var test=$('#keyword').val().trim().length==0 ? null : $('#keyword').val().trim();
		console.log(test); */

		var searchParam = {
			showall : $('#showall').is(':checked') ? 'Y' : 'N',
			searchType : $('#searchKey').val(),
			keyword : $('#keyword').val().trim().length==0 ? null : $('#keyword').val().trim(),
			selectPage : (selectPage == null || selectPage == "undefined") ? 1
					: selectPage,
			rowsPerPage : 5
		}

		var resultCallback = function(data) {
			fUserListCallBack(data, searchParam);
		}

		callAjax('/scm/userinfo/userlist', 'post', 'text', true, searchParam, resultCallback);

	}

	function fUserListCallBack(data, searchParam) {
		console.log('beforecall getPaginationHtml(...)')
		console.log($(data).find('#totalCount').val());
		console.log(searchParam.selectPage);
		var paginationHtml = getPaginationHtml(searchParam.selectPage, $(data)
				.find('#totalCount').val(), searchParam.rowsPerPage,
		// pageBlockSize : 페이지의 페이징 : 한 페이지당 몇개의 페이지 번호를 볼 수 있을 지 파라미터로 넘긴다
		// 5 , 6 , 7,... 변경해보며 테스트해보자
		5, 'getUserListByParam');

		$('#userListArea').empty().append(data).append(paginationHtml);
	}
</script>