<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>


	
		

	$(document).ready(function(){
		
		connectEvent();
		
		getSalesList();
		
		$('#st-btn').on('click',function(){
			console.log('up!');
			$('html').animate({'scrollTop':0},100);
		})
		
		$('#test').on('click',function(){
			console.log($('#files')[0].files);
		})
		
		
	})
	
	function connectEvent(){
		
		// 제품등록폼, 제품 등록, 제품 삭제, 취소버튼 통합관리
		$('body').on('click','.salesMngBtnArea button, #salesListTable td',function(){
			
			console.log("...entering Event...");
			
			var param={action:'',
						sales_id:''}
			
			switch($(this).attr('id')){
			
			// Form request Control
			case 'btnNewSales':
				param.action='NEW';
				break;
			case undefined :
				param.action='INFO';
				
				param.sales_id=$(this).parent().children('.sales_id').html();
				break;
				
			// Register / Edit / Update Control
			case 'btnRegister':
				$('#action').val($('#action').val()=='NEW'?'REGISTER':'UPDATE');
				if($('#action').val()=='UPDATE'){
					if(confirm('정말로 수정하시겠습니까?')){
						fManageSales();		
					}
				}else{
					fManageSales();
				}
				
				return;
			case 'btnDelete':
				$('#action').val('DELETE');
				if(confirm('정말로 삭제하시겠습니까?\r삭제한 정보는 되돌릴 수 없습니다')){
					fManageSales(param);	
				}
				return;
			case 'close':
				$('#salesInfoForm').empty();
				return;
			}
			
			var callback=function(data){
				fPopUpSaleInfoForm(data,param);
			}
			
			
			console.log(param.action);
			
			callAjax('${CTX_PATH}/scm/sales/form', 'POST', 'text',true, param, callback);
			
			
			
		})
		
		// 가격 숫자만 입력
		$('body').on('keydown','#price',function(e){
			if(e.crtlKey || e.altKey || e.shiftKey){
				e.preventDefault();
			}else{
				fFilterNumber(e)
			}
		})
		
		// 상품 사진 토글 이벤트
		$('body').on('mouseover','#shortImages img',function(){
			$('#representPhoto').attr('src',$(this).attr('src'));
			
		})
		$('body').on('mouseleave','#shortImages',function(){
			$('#representPhoto').attr('src',$(
												$('#shortImages img')[0]
											).attr('src')
									 );
		})
		
		// 사진 미리보기 이벤트
		$('body').on('change','#files',function(e){
			
			var files=e.target.files;
			
			var fileReader=new FileReader();
			var allImageType=true;
			
			// image Type check
			$(files).each(function(index,item){
				
				if(!item.type.match("image/*")){
					allImageType=false;
				}
				
			})
			
			if(allImageType){
				
				$('#shortImages').empty();
				
				$(files).each(function(index,item){
					
					var fileReader = new FileReader();
					
					$(fileReader).on('load',function(e){
						
						$('#shortImages').append('<img src='+e.target.result+'>');
						
						if(index==0){
							$('#representPhoto').attr('src',e.target.result);
						}
					
					})	 
					
					fileReader.readAsDataURL(item);
				}) 
				
				
			}else{
				alert('이미지만 등록하실 수 있습니다');
			}
			
			
			
			
			
		})
		
	}
	
	
	function getSalesList(selectPage){
		
		
		
		var param={
				keyword:$('#keyword').val(),
				searchType :$('#searchKey').val(),
				selectPage : (selectPage == null || selectPage == "undefined") ? 1 : selectPage,
				rowsPerPage : 5
		}
		
		var callback=function(data){
			fSalesListCallback(data,param)
		}
		
		callAjax('${CTX_PATH}/scm/saleslist','post','text',true, param, callback);
		
	}
	
	function fSalesListCallback(data,param){
		
		
		
		var paginationHtml = getPaginationHtml(
												param.selectPage, 
												$(data).find('#totalCount').val(), 
												param.rowsPerPage,
												5, 
												'getSalesList'
												);

		$('#salesListWrap').empty().append(data).append(paginationHtml);
	}
	
	function fPopUpSaleInfoForm(data,param){
		
		$('#salesInfoForm').empty().append(data);
		
		if(param.action=='NEW'){
			comcombo('proCD', 'sb-salestype', 'all', 'all');
		}
		
		
	}
	
	function fManageSales(){
		
		
		
		callAjaxFileUpload('${CTX_PATH}/scm/sales/manage', 'POST', 'json',true, 'salesInfoForm', fAfterManageCallback);
	}
	
	function fAfterManageCallback(data){
		
		var action=$('#action').val();
		
		if(data==1){
			if(action=='REGISTER'){
				alert('정상적으로 등록되었습니다');
			}else if(action=='UPDATE'){
				alert('정상적으로 수정되었습니다');
			}else{
				alert('정상적으로 삭제되었습니다');
			}
			
			window.location.reload();
			
		}else{
			alert('오류가 발생하였습니다 잠시 후 다시 시도하세요');
		}
		
		$('#salesInfoForm').empty();
		
	}

</script>