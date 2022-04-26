<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">


var searchgrouptype = '';
var searchtext = '';
var pageSize = 10;
var pageBlockSize = 10;

// onload list 및 검색조건 함수 불러오기
$(function(){
	
	init();
	$('body').on('click','#whlist>tr.blur',function(){
		$(this).removeClass('blur');
		$('#detail').remove();
	})
	
});

function init(currentPage){
	currentPage = currentPage || 1;
	var param = {
			searchgrouptype : searchgrouptype
		,	searchtext : searchtext
		,	currentPage : currentPage
		,	pageSize : pageSize
			};
	var resultCallback = function(data) {
		$("#whlist").empty().append(data);
		var total = $("#total").val();
		
		var paginationHtml = getPaginationHtml(currentPage, total,  pageSize, pageBlockSize, 'init');
		$("#comnGrpCodPagination").empty().append( paginationHtml ); 
	};
	
	callAjax("/scm/whInventoryFormlist.do", "post", "text", true, param, resultCallback);
}

function search(){
	searchgrouptype = $("#searchgrouptype").val();
	searchtext = $("#searchtext").val();
	init();
}
	
function getStocksDetail(idx,row){
	
	if(!$(row).hasClass('blur')){
		
		$('#detail').remove();
		$('#whlist>tr.blur').removeClass('blur');
		
		var resultCallback = function(data) {
			
			$(row).addClass('blur');
			$(row).after(data);
			
		};

		callAjax('/scm/warehousestock/'+idx, "post", "text", true, null, resultCallback);	
		
	}
	
}
	
</script>
    