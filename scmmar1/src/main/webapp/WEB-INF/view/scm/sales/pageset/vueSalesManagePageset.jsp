<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

	var vueSalesList="";
	var vueSalesForm="";
	var vueSearchForm="";
	var vueUtil="";
	
	
	$(document).ready(function(){
		
		
		vueSalesList=new Vue({
			el:'#salesListWrap',
			data:{
				selectPage:1,
				rowsPerPage:5,
				totalCount:'',
				salesList:[]
			},
			methods:{
				getList:function(selectPage){
					getSalesList(selectPage);
				},
				showInfo:function(){
					getForm2(action,salesID);
				},
				getInfo:function(action,salesID){
					vueSalesForm.getForm(action,salesID);
				}
			}
		});
		
		vueSalesForm=new Vue({
			el:'#salesInfoForm',
			data:{
				action:'',
				info:{},
				photos:[],
				representPhoto:''
			},
			methods:{
				getForm:function(action, salesID){
					getForm(action, salesID);
				},
				photoPreview:function(e){
					preview(e);
				},
				showBasicImg:function(e){
					e.target.src='/images/nonesalesimg.jpg';
				},
				manage:function(action,salesID){
					fManageSales(action,salesID);
				},
				close:function(){
					this.action='';
					this.info={};
					this.photos=[];
					this.representPhoto='';
				}
			},
			watch:{
				action:function(changedValue){
					if(changedValue=='NEW'){
						comcombo('proCD', 'sb-salestype', null, 'all');
						this.photos=[];
						this.representPhoto='';
					}	
				}
				
			}
		});
		
		vueSearchForm=new Vue({
			el:'#v-SearchArea',
			data:{
				searchType:'all',
				keyword:''
			},
			methods:{
				getList:function(){
					getSalesList(vueSalesList.selectPage);
				},
				search:function(e){
					if(e.keyCode==13){
						this.getList();
					}
				}
			}
		})
		
		/* vueUtil=new Vue({
			methods:{
				toCurrency:function(num){
					console.log('??');
				}
			}
		})
		 */
		vueSalesList.getList();
		
	})
	
	
	
	function getSalesList(selectPage){
		
		selectPage= selectPage || 1;
		console.log(vueSearchForm.keyword);
		console.log(vueSearchForm.searchType);
		
		var param={
				/* keyword:$('#keyword').val(),
				searchType :$('#searchKey').val(),
				selectPage : (selectPage == null || selectPage == "undefined") ? 1 : selectPage,
				rowsPerPage : 5 */
				keyword:vueSearchForm.keyword,
				searchType:vueSearchForm.searchType,
				selectPage:selectPage,
				rowsPerPage:vueSalesList.rowsPerPage
		}
		console.log(param);
		
		var callback=function(data){
			
			fSalesListCallback(data,param);
		}	
		
		callAjax('${CTX_PATH}/scm/vue/saleslist','post','json',true, param, callback);
		
	}
	
	function fSalesListCallback(data,param){
		
		
		vueSalesList.selectPage=data.page.selectPage;
		vueSalesList.rowsPerPage=data.page.rowsPerPage;
		vueSalesList.totalCount=data.page.totalCount;
		vueSalesList.salesList=data.page.salesList;
		vueSearchForm.keyword=data.page.keyword;
		vueSearchForm.searchType=data.page.searchType;
		

		$('#salesListWrap .paging').remove();
		$('#salesListWrap').append	(	
										getPaginationHtml(
											vueSalesList.selectPage, 
											vueSalesList.totalCount, 
											vueSalesList.rowsPerPage,
											5, 
											'vueSalesList.getList'
										)
									);
	}
	
	
	function getForm(action, salesID){
		
		
		
		
		console.log(action);
		console.log(salesID);
		console.log('check salesID is null or undefined...'+salesID==undefined);
		
		//vueSalesForm.action=action;
		
		
		// debugging target Url
		console.log('target url >> ' + '/scm/vue/sales/'+action+'/'+(salesID=(salesID==''||salesID==undefined)?'':salesID));
		var testurl='/scm/vue/sales/new';
		
 		callAjax(	
					'${CTX_PATH}/scm/vue/sales/'+action+'/'+(salesID=(salesID==''||salesID==undefined)?'0':salesID),
					'POST', 
					'json',
					false, 
					null, 
					function(data){
						fPopUpSaleInfoForm(data,action);		
					}
				);
	}
	
	
	function fPopUpSaleInfoForm(data,action){
		
		vueSalesForm.action=action;
		vueSalesForm.info=data.info;
	}
	
	function fManageSales(action,idx){
		
		callAjaxFileUpload
							(
								'/scm/vue/manage/' + (idx=(idx==null || idx==undefined)?'0':idx), 
								action, 
								'json',
								true,
								'salesInfoForm', 
								function(data){
									fAfterManageCallback(data,action);						
								}
							);
	}
	
	function fAfterManageCallback(data,action){
		
		
		
		let msg='오류가 발생하였습니다. 잠시 후 다시 시도하세요';
		
		if(data==1){
			msg=action=='POST'?'정상적으로 등록되었습니다':action=='PUT'?'정상적으로 수정되었습니다':'정상적으로 삭제되었습니다';
			alert(msg);
			
			vueSalesForm.action='';
			vueSalesList.getList(vueSalesList.selectPage);
			
		}else{
			swal(msg);
		}
		
		
		
	}
	
	// 이미지 미리보기
	function preview(e){
		
		var files=e.target.files;
		
		var fileReader=new FileReader();
		var allImageType=true;
		
		let photos=[];
		
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
					
					photos.push(e.target.result);
					// $('#shortImages').append('<img src='+e.target.result+'>');
					
					if(index==0){
						vueSalesForm.representPhoto=e.target.result;
					    //	$('#representPhoto').attr('src',e.target.result);
					}
				
				})	 
				
				fileReader.readAsDataURL(item);
				
			})
			
			vueSalesForm.photos=photos;
			console.log(photos);
			console.log(vueSalesForm.photos);
		}else{
			swal('이미지만 등록하실 수 있습니다');
		}
	}



</script>