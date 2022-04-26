<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

	var vueSalesList="";
	var vueSalesForm="";
	var vueSearchForm="";
	
	
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
				getList:function(){
					getSalesList(selectPage);
				},
				showInfo:function(){
					getForm(action,salesID);
				}
			}
			
		});
		
		vueSalesForm=new Vue({
			el:'#salesInfoForm',
			data:{
				action:'',
			},
			methods:{}
		});
		
		vueSearchForm=new Vue({
			el:'#v-SearchArea',
			data:{
				searchType:'',
				keyword:''
			},
			methods:{
				getList:function(){
					getSalesList(selectPage);
				}
			}
		})
		
	})
	
	
	
	function getSalesList(selectPage){
		
		
		
		var param={
				/* keyword:$('#keyword').val(),
				searchType :$('#searchKey').val(),
				selectPage : (selectPage == null || selectPage == "undefined") ? 1 : selectPage,
				rowsPerPage : 5 */
				keyword:vueSalesList.keyword,
				searchType:vueSalesList.searchType,
				selectPage:vueSalesList.selectPage,
				rowsPerPage:vueSalesList.rowsPerPage
		}
		
		var callback=function(data){
			
			fSalesListCallback(data,param);
		}	
		
		callAjax('${CTX_PATH}/scm/vue/saleslist','post','text',true, param, callback);
		
	}
	
	function fSalesListCallback(data,param){
		
		
		vueSalesList.selectPage=data.page.selectPage;
		vueSalesList.rowsPerPage=data.page.rowsPerPage;
		vueSalesList.totalCount=data.page.totalCount;
		vueSalesList.salesList=data.page.salesList;
		
		// $('#salesListWrap').empty().append(data).append(paginationHtml);
		
		$('#salesListWrap').append	(	
										getPaginationHtml(
											vueSalesList.selectPage, 
											vueSalesList.totalCount, 
											vueSalesList.rowsPerPage,
											5, 
											'getList'
										)
									);
	}
	
	
	function getForm(action, salesID){
		
		callAjax(	
					'${CTX_PATH}/scm/vue/sales/'+action+'/'+(salesID==''||salesID==undefined)?'':salesID, 
					'POST', 
					'JSON',
					true, 
					null, 
					function(data){
						fPopUpSaleInfoForm(data,action);		
					}
				);
	}
	
	
	function fPopUpSaleInfoForm(data,action){
		
		$('#salesInfoForm').empty().append(data);
		
		if(action=='NEW'){
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
				swal('정상적으로 등록되었습니다');
			}else if(action=='UPDATE'){
				swal('정상적으로 수정되었습니다');
			}else{
				swal('정상적으로 삭제되었습니다');
			}
			
			// window.location.reload();
			
			
			// 상품 폼 닫기
			//...
			//////////
			vueSalesList.getList(vueSalesList.selectPage);
			
		}else{
			alert('오류가 발생하였습니다 잠시 후 다시 시도하세요');
		}
		
		$('#salesInfoForm').empty();
		
	}



</script>