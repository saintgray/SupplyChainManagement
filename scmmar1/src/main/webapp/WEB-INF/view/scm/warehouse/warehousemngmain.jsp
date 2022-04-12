<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>

<!-- DAUM Postcode cdn API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<style>
	.searchArea{
		margin-top: 35px;
	    padding: 50px 0;
	    border: 2px solid rgb(190,190,190);
	}
	#searchBtnWrap{
		display: inline-block;
		margin: 0 10px;
	}
	#whListArea{
		margin-bottom:30px;
	}
	#whListArea table, #whInfoArea table{
		margin:0 auto;
		
	}

	#btn-close-daum{
		position:absolute;
		right:0;
	    bottom: 0;
	    z-index: 11;
	    cursor: pointer;
		
	}
	
	
	#formwrap{
		margin-top: 50px;
		margin-bottom:50px;
		border: 2px solid rgb(190,190,190);
		padding-left:50px;
		
	}
	#formwrap #formtable{
		border-collapse: separate;
		border-spacing: 10px 10px;
		margin:10px auto;
	}
	#formwrap #phoneArea input{
		width: 100px;
	}
	


</style>
<title>창고정보 관리</title>
</head>
<body>


<!--GLOBAL MASKING -->
<div id="mask"></div>


<!-- GLOBAL WRAP -->
<div id="wrap_area">


   <!-- Header area -->
   <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
   
   <!-- Content area -->
   <div id="container">
      
      <ul>
         <li class="lnb">
            <!-- lnb area -->
            <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
         
         </li>
         <li class="contents">
            <div class="content">
            
                <p class="Location">
                  	<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
                  
                  	<span class="btn_nav bold">기준정보</span> 
                  	<span class="btn_nav bold">창고 정보 관리</span> 
                  
                  	<a href="${CTX_PATH}/scm/whinfo.do" class="btn_set refresh">새로고침</a>
                </p>
				<!-- SearchArea -->
				<div class="searchArea">
					<table style="margin-top: 10px" width="100%" cellpadding="5" cellsapcing="0" border="1">
					   <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                       <select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
     	                       		<option value="all">전체</option>
									<option value="wh_nm" >창고명</option>
									<option value="wh_loc" >창고 위치</option>
							   </select>
							   
				
     	                       <input type="text" style="width: 300px; height: 25px;" id="keyword">
     	                       
     	                       
     	                       <div class="bts btnMngWareHouseArea" id="searchBtnWrap">
     	                       		<button type="button" class="btn btn-primary" id="searchBtn">검색</button>
     	                       </div>                 
	                           
                            </td> 
                       	</tr>
					</table>
				</div>
				
				<div id="whListArea" class="mt30"></div>
				
				
				<form id="whFormArea"></form>
				
            </div>
         </li>
      </ul>
   </div>

</div>


</body>

<script>
	$(document).ready(function(){
		
		connectEvent();
		getWareHouseList();
	})

	
	
	
	function connectEvent(){
		
		$('body').on('click', '.btnMngWareHouseArea button, #whListArea table td',function(){
			
			
			switch($(this).attr('id')){
				case 'searchBtn':
					getWareHouseList();
					return;
				case undefined:
					showForm($(this),'INFO');
					return;
				
				case 'btnRegNew':
					showForm($(this),'NEW');
					return;
				case 'close':
					$('#whFormArea').empty();
					return;
				case 'btnDelete':
					if(confirm('정말로 삭제하시겠습니까?\r삭제한 데이터는 복구할 수 없습니다')){
						// manageWhInfo
						manageWhInfo('DELETE');
					}
					return;
				case 'btnUpdate':
					if(confirm('정말로 수정하시겠습니까?')){
						// manageWhInfo
						manageWhInfo('UPDATE');
					}
					return;
				case 'btnRegister':
					manageWhInfo('REGISTER');
					return;
			
			}	

		})
		
		// 창고코드 값 (Primary key), 전화번호, 이메일 변경 차단
		$('body').on('keydown','#wh_id, #phoneArea input, #email',function(e){
			
			alert('변경할 수 없는 값입니다');
			e.preventDefault();
			$(this).attr('readonly',true);
			
		})
		
		// 우편번호 찾기 이벤트
		$('body').on('click','#findAddress',function(e){
			e.preventDefault();
			// id: 우편번호 창 찾기를 띄울 영역 id 값
			// zcd: 우편번호 넣을 input id 값
			// adrs: 주소 넣을 input id 값
			// dtlAdrs: 상세 주소 넣을 input id 값
			// fOpenWinZipCod(id, zcd, adrs, dtlAdrs)
			fOpenWinZipCod('zipFrame','zipCode' , 'addr', 'dtAddress');
			
		})
		// 우편번호 팝업창 닫기
		$('body').on('click','#btn-close-daum',function(){
			closeDaumPostcode('zipFrame');
			
		})
		
		// 창고 등록시 담당자 select box 변경시 담당자의 전화번호,이메일 가져오기
		$('body').on('change','#advisor',function(){
			if($(this).val()!=''){
				
				var callback=function(data){
					if(data==null){
						alert('유효하지 않은 요청입니다');
					}else{
						putPhone(data.phone);
						$('#email').val(data.email);
					}
				}
				
				callAjax('${CTX_PATH}/scm/userinfo/'+$(this).val(),'post','json',true,null,callback)				
				
			}	
		})
		
	} // end of connectEvents
	
	
	function getWareHouseList(selectPage){
		
		var param={
				keyword:$('#keyword').val(),
				searchType :$('#searchKey').val(),
				selectPage : (selectPage == null || selectPage == "undefined") ? 1 : selectPage,
				rowsPerPage : 5
		}
		
		var callback=function(data){
			fAfterGetList(data,param);
			console.log($(data).find('#selectPage'));
			console.log($(data).find('#totalCount'));
		}
		
		callAjax('${CTX_PATH}/scm/whlist','post','text',true,param,callback)
		
	}
	function fAfterGetList(data,param){

		$('#whListArea').empty().append(data)
								.append(
										getPaginationHtml(
															$(data).find('#selectPage').val(),
															$(data).find('#totalCount').val(), 
															param.rowsPerPage, 
															5, 
															'getWareHouseList'
														  )
										);			
								
	}
	
	function showForm(dom,act){
		
		var param={	action:act, wh_id:''}
		if(param.action=='INFO'){
			
			param.wh_id=$(dom).parent().children('.wh_id').html();
		}
		var callback=function(data){
			fAfterShowForm(data, param);	
		}
		
		callAjax('${CTX_PATH}/scm/whinfo','post','text',true,param,callback)
		
	}
	function fAfterShowForm(data,param){
		
		$('#whFormArea').empty().css('display','none').append(data);
		
		
		// param에 따른 분기로직 
		var type=null;
		
		
		if(param.action=='INFO'){
			
			putPhone($(data).find('#phone').val());
		
			
			
		}else{
			type='sel';
			// 창고 위치 선택 를 위한 comcombo 요청
			comcombo('wareCD','wh_loc',type,null,null);
		}
		// 담당자 배정을 위한 comcombo 요청
		comcombo('B','advisor',type,$('#loginID').val(),'${CTX_PATH}/scm/whComcombo.do');
		
		
		//////
		
		$('#whFormArea').css('display','block');
		
	}
	
	// 창고정보의 수정/삭제 function
	function manageWhInfo(action){
		
		$('#action').val(action);
		var targetId=$('#wh_id').val();
		var callback=function(data){
			
			console.log('manage Result...');
			console.log(data);
			if(data==1){
				if(action=='UPDATE'){
					alert('정상적으로 수정되었습니다');
				}else if(action=='DELETE'){
						alert('정상적으로 삭제되었습니다');
				}else{
					alert('정상적으로 등록되었습니다');
				}
				$('#whFormArea').empty();
				getWareHouseList($('.paging strong').text());
			}else if(data==-1){
				if(action=='DELETE'){
					alert('창고에 재고가 남아있어 삭제할 수 없습니다');
				}
				
			}else{
				alert('오류가 발생하였습니다. 잠시 후 다시 시도하세요');
			}
			
			
		}
		
		callAjax('${CTX_PATH}/scm/whManage2','post','json',true,$('#whFormArea').serialize(),callback)
		
		
	}
	
	
	
	// 전화번호 구분해서 넣기 3-4-4 자리 기준
	function putPhone(phone){
		console.log(phone);
		
		var p=phone.replaceAll("-",'').trim();
		$('#p-head').val(p.substr(0,3));
		$('#p-mid').val(p.substr(3,4));
		$('#p-end').val(p.substr(7,4));
	}
	
	

</script>
</html>