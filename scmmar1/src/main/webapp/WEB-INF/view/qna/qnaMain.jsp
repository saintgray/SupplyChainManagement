<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="/js/summernote/summernote.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/js/summernote/summernote.css">
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
	#qnaListArea{
	
		margin: 30px auto;
		
	}
	
	#qnaListArea table{
		margin:10px auto;
		border-collapse: separate;
	}
	#qnaInfoArea{
		margin: 30px auto;
	}
	#qnaInfoArea #info-title, #qnaInfoArea #info-content{
		
	    border: 1px solid #bbc2cd;
	    
	}
	#qnaInfoArea #info-title{
		height: 27px;
	    padding: 5px 10px;
		font-weight: bold;
	    background: #dce1e6;
	    text-align: center;
	}
	#qnaInfoArea #info-content-body{
		padding:10px
	}
	
	

</style>
<title>1:1 문의</title>
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
                  
                  	<span class="btn_nav bold">1:1 문의</span> 
                  	 
                  
                  	<a href="${CTX_PATH}/sti/inquiry.do" class="btn_set refresh">새로고침</a>
                </p>
				<!-- SearchArea -->
				<div class="searchArea">
					<table style="margin-top: 10px" width="100%" cellpadding="5" cellsapcing="0" border="1">
					   <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                       <select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
     	                       		<option value="all">전체</option>
									<option value="qna_title">제목</option>
									<option value="qna_content">내용</option>
							   </select>
							   
				
     	                       <input type="text" style="width: 300px; height: 25px;" id="keyword">
     	                       
     	                       
     	                       <div class="bts" id="searchBtnWrap">
     	                       		<button type="button" class="btn btn-primary" id="searchBtn">검색</button>
     	                       </div>                 
	                           
                            </td> 
                       	</tr>
					</table>
				</div>
				<!-- List Area -->
				<div id="qnaListArea" class="bts"></div>
				<!-- Register Btn -->
				
				<!-- Info Area -->
				<div id="qnaInfoArea" class="bts"></div>
				
				
            </div>
         </li>
      </ul>
   </div>

</div>


</body>


	<script>
		$(document).ready(function(){
			
			connectEvents();
			getQnaList();
			
		})
		
		function connectEvents(){
			// 버튼 클릭시 이벤트
			$('#searchBtn').on('click',function(){
				getQnaList();
			})
			// 검색창에서 엔터누를시 자동검색
			$('#keyword').on('keydown',function(e){
				if(e.keyCode==13){
					getQnaList();
				}
			})
			// Qna 상세정보
			$('#qnaListArea').on('click','table tr',function(){
				getQnaInfo(this);
			})
			
			$('body').on('click','button',function(){
				switch($(this).attr('id')){
					case 'btnUpdateForm':
						transForm('UPDATE');
						break;
					case 'btnNewQna':
						transForm('NEW');
						break;
					case 'btnCancelUpdate':
						if(confirm('취소하시겠습니까?')){
							$('#qnaInfoArea').empty();
						}
						break;
					case 'btnRegisterQna':
						manageQna('REGISTER');
						break;
					case 'btnDeleteQna':
						if(confirm('정말로 삭제하시겠습니까?')){
							manageQna('DELETE');	
						}
						break;
					case 'btnUpdateQna':
						manageQna('UPDATE');
						break;
				}
			})
		}
		
		
		
		function getQnaList(num){
			var param={
					selectPage :num=num || 1,
					rowsPerPage:5,
					searchType:$('#searchKey').val(),
					keyword:$('#keyword').val()
			}
			var callback=function(data){
				fAfterGetList(data,param);
			}
			callAjax('${CTX_PATH}/sti/qna/list', 'POST', 'text',true, param, callback);
		}
		
		function fAfterGetList(data, param){
			
			$('#qnaListArea').empty()
							.append(data)
							.append(getPaginationHtml($('#sp').val(), 
												  $('#tc').val(),
												  param.rowsPerPage,
												  5, 
												  'getQnaList'
												  ));
			
		}
		
		function getQnaInfo(tr){
			var idx=$(tr).children('.qna_id').text();
			if(idx!=undefined || idx.length>0){
				var callback=function(data){
					$('#qnaInfoArea').empty().append(data);
				}
				callAjax('${CTX_PATH}/sti/qna/'+idx, 'POST', 'text',true, null, callback);
			}
		}
		
		function transForm(action){
			
			$('#qnaInfoArea').hide();
			
			if(action=='UPDATE'){
				console.log('update process..');
				
				$('#btnUpdateForm').attr('id','btnUpdateQna').text('저장');
				$('#btnDeleteQna').attr('id','btnCancelUpdate').text('취소').removeClass('btn-danger').addClass('btn-default');
				$('#info-title').html('<span class="input-group-addon">제목</span><input name="qna_title" id="qna_title" class="form-control" value="'+$('#info-title #info-title-text').text().trim()+'"/>').addClass('input-group');
				let content=$('#info-content-body').text();
				
				initSummernote($('#info-content')).summernote('code',content);
			}else{
				console.log('new reg process..');
				
				$('#btnNewReply').attr('id','btnRegisterQna').text('등록');
				let titleArea=$('<div id="info-title" class="text-center input-group text-bold"><span class="input-group-addon">제목</span><input name="qna_title" id="qna_title" class="form-control"/></div>');
				let contentArea=$('<div id="info-content"></div>');
				let btnHtml='<div id="btnArea" class="text-right mt10">';
				btnHtml+='<button type="button" class="btn btn-primary" id="btnRegisterQna">등록</button>';
				btnHtml+='<button type="button" class="btn btn-default" id="btnCancelUpdate">취소</button>';
				btnHtml+='</div>';
				$('#qnaInfoArea').empty().append(titleArea).append(contentArea).append($(btnHtml));
				initSummernote($('#info-content'));
				
			}
			
			$('#qnaInfoArea').show();	
		}
		
		function initSummernote(targetDom){
			$(targetDom).summernote({
				toolbar:[	
				         	['fontNames',['fontname']],
				         	['font',['bold','underline','Italic','clear']],
				         	['color', ['forecolor','color']],
				         	['insert',['picture','link','video']],
				         	['table', ['table']],
						    ['para', ['ul', 'ol', 'paragraph']],
				         	['fontSize','fontsize']
				        ],
		    	image:[
					       ['image','resizeQuarter'],
					       ['float','floatLeft]']
				       ],
		       	fontSizes:['8','9','10','12','14','16','18','20','24','30','36','50'],
		       	fontNames:['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
				lang: "ko-KR",
				placeholder: "내용을 입력하세요",
				height:"500",
				maxHeight:"700"
				
			})
			return targetDom
		}
		
		function manageQna(action){
			
			
			
			let param={
					qna_id:$('#qna_id').val(),
					qna_title:$('#qna_title').val(),
					qna_content:$('#info-content').summernote('code')
			};
			
			let callback=function(data){
				
				
				if(Object.keys(data).length==0){
					
					if(action=='REGISTER'){
						alert('정상적으로 등록되었습니다');
					}else if(action=='UPDATE'){
						alert('정상적으로 수정되었습니다');
					}else{
						alert('정상적으로 삭제되었습니다');
					}
					
					$('#qnaInfoArea').empty();
					
					getQnaList($('#qnaListArea .paging strong').text());
					
				}else{
					alert(data.msg);
				}
			}
			console.log(param.qna_id);
			console.log(param.qna_title);
			console.log(param.qna_content);
			console.log('${CTX_PATH}/sti/manage/'+action.toLowerCase()+'/'+param.qna_id);
			
			callAjax('${CTX_PATH}/sti/manage/'+action.toLowerCase()+'/'+param.qna_id,'post','json',true,param,callback);
			
			
		}
		
	</script>
	
	
</html>