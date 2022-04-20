<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>SamplePage10</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
                              
<script type="text/javascript">
    
    // page default setting
    const pagesize=5;
    const pageBlock=10;
    
    // Vue Components
    var divComGrpCodList='';
    var divComGrpCodPaging='';
   
    $(document).ready(function() {
    	
       init();
       fn_listsearch();
       
   });
    
    function init(){
    	
    	// divComGrpCodList 변수를 Vue 인스턴스로 초기화
    	divComGrpCodList = new Vue({
    		// 어느 DOM 을 Vue 인스턴스로 선언할지를 결정 el
    		el : '#divComGrpCodList',
    		// 변수 선언
    		data : {
    			// 목록(리스트) 에 관한 영역이 될 것이므로 변수도 배열형으로 선언
    			searchList:[]
    		}
    	})
    	// 그룹코드 테이블에 대한 페이징
    	divComnGrpCodPaging= new Vue({
    		el:'#comnCodPaging',
    		
    	})
    }
    
    function fn_listsearch(selectPage){
    	selectPage = selectPage || 1;
    	var param={currentPage:selectPage , pageSize:pagesize};
    	var callback=function(data){
    		// 받는 데이터는 JSON Object
    		// print data test
    		console.log(JSON.stringify(data));
    		// data(반환한 Map 객체를 자동으로 자바스크립트 객체로 변환) 에서 변수이름(key 값) 으로 꺼내서 출력
    		console.log(data.listComnGrpCodModel);
    		console.log('총 데이터 수 : '+data.totalCntComnGrpCod);
    		console.log('선택한 페이지: '+data.currentPageComnGrpCod);
    		console.log('페이지크기 : '+data.pageSize);
    		// Vue Insatnce 변수에 리스트 할당
    		divComGrpCodList.searchList=data.listComnGrpCodModel;
    		// 가상 DOM 과 실제 HTML 의 변경점을 감지하여 자동으로 변화된 내용을 실제 HTML 에 랜더링한다
    		
    		// pageNavigation
    		$('#comnCodPaging').empty()
    						   .append(getPaginationHtml(selectPage,
    								   					 data.totalCntComnGrpCod,
   								   						 data.pageSize,
   								   						 pageBlock,
   								   						 'fn_listsearch'));
    		
    	}
    	callAjax('${CTX_PATH}/system/vueListComnGrpCod.do','POST','json',true,param,callback);
    }

</script>

</head>
<body>
   <!-- 모달 배경 -->
   <div id="mask"></div>

   <div id="wrap_area">

      <h2 class="hidden">header 영역</h2>
      <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

      <h2 class="hidden">컨텐츠 영역</h2>
      <div id="container">
         <ul>
            <li class="lnb">
               <!-- lnb 영역 --> <jsp:include
                  page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
            </li>
            <li class="contents">
			<!-- contents -->
				<h3 class="hidden">contents 영역</h3> <!-- content -->
				<div class="content">
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">Sample</span> <span class="btn_nav bold">공통코드
								관리</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>그룹 코드</span> 
							<span class="fr">
							     <select id="searchgrouptype"  name="searchgrouptype" style="width: 150px;">
							            <option value="" >전체</option>
							    		<option value="grp_cod" >그룹코드</option>
							    		<option value="grp_cod_nm" >그룹코드명</option>
							     </select> 
							     <input type="text" style="width: 300px; height: 25px;" id="sgroupinput" name="sgroupinput">                    
	                              <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
							     <a class="btnType blue" href="javascript:fn_PopModalComnGrpCod();" name="modal"><span>신규등록</span></a>
							</span>
    
						</p>
						
						<div id="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="17%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">그룹코드</th>
										<th scope="col">그룹코드명</th>
										<th scope="col">그룹코드 설명</th>
										<th scope="col">사용여부</th>
										<th scope="col">등록일</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="listComnGrpCod" v-for='(item,index) in searchList' v-if='searchList.length>0'>
									<tr>
										<td>{{index}}</td>
										<td>{{item.grp_cod}}</td>
										<td>{{item.grp_cod_nm}}</td>
										<td>{{item.grp_cod_eplti}}</td>
										<td>{{item.use_poa}}</td>
										<td>{{item.reg_date}}</td>
										<td>-</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div id="comnCodPaging"></div>
					</div> 

                <h3 class="hidden">풋터 영역</h3>
                <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
            </li>
         </ul>
      </div>
   </div>

   <!--// 모달팝업 -->
</body>
</html>