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
    
    var pagesize = 10;
    var navicnt = 10;
    
    var divComGrpCodList = "";
    var layer1 = "";
    $(document).ready(function() {
         
       init();     

       fn_listsearch();
       
    });

    function init() {
       
       divComGrpCodList = new Vue({
                                    el : "#divComGrpCodList" ,
                                 data : {
                                            searchlist : []
                                 },
                                 methods : {
                                    rowclick: function (grd_cod) {
                                       fPopModalComnGrpCod(grd_cod);
                                    }
                                 }
       });
       
       layer1 = new Vue({
                                  el : "#layer1",
                               data : {
                                          grp_cod_eplti : "",
                                          grp_use_poa : "",
                                          grp_cod_nm : "",
                                          grp_cod : "",
                                             action : "",
                                             delshow : false
                               },
                               methods : {
                                  popupsave : function() {
                                     fn_save();
                                  },
                               	  popupdelete : function(){
                               		  fn_delete();
                               	  }
                               }
       });
    }    
    
    function fn_listsearch(currpage) {
       
       currpage = currpage || 1;
       
       var param = {
             currentPage : currpage,      
             pageSize : pagesize
       };
       
       var listcollback = function(resultdata) {
            displatylist(resultdata, currpage);
       }
       
       callAjax("/system/vueListComnGrpCod.do", "post", "json", true, param, listcollback);
    }    
    
    function displatylist(resultdata, currpage) {
       
       console.log("displatylist : " +  JSON.stringify(resultdata)    );
       
       
       divComGrpCodList.searchlist = resultdata.listComnGrpCodModel;
       
       var  totalCntComnGrpCod = resultdata.totalCntComnGrpCod;
       
      var paginationHtml = getPaginationHtml(currpage, totalCntComnGrpCod, pagesize, navicnt, 'fn_listsearch');
      console.log("paginationHtml : " + paginationHtml);
      //swal(paginationHtml);
      $("#comnGrpCodPagination").empty().append( paginationHtml );
       
    } 
    
    function fPopModalComnGrpCod(grd_cod) {
       
       if (grd_cod == null || grd_cod=="") {
          alert("등록"); 
          layer1.action = "I";
          
          initeditpopup();
          
          gfModalPop("#layer1");
          
       } else {
          alert("수정 : " + grd_cod);          
          layer1.action = "U";
          
          fn_selectgroupcode(grd_cod);
          
       }
       
    }
    
    function initeditpopup(object) {
       
       if (object == null || object=="") {
          layer1.grp_cod_eplti = "";
          layer1.grp_use_poa = "Y";
          layer1.grp_cod_nm = "";
          layer1.grp_cod = "";
          layer1.delshow = false;
       } else {
          console.log("initeditpopup : " +  JSON.stringify(object)    );
          
          //{"row_num":0,"grp_cod":"chaCD","grp_cod_nm":"업무코드","grp_cod_eplti":null,"tmp_fld_01":"6","tmp_fld_02":null,"tmp_fld_03":null,"use_poa":"Y","fst_enlm_dtt":1648177974000,"reg_date":null,"fst_rgst_sst_id":null,"fnl_mdfd_dtt":"2022-03-25 15:09:14.0","fnl_mdfr_sst_id":null,"detailcnt":0}
          
          var regcnt = object.tmp_fld_01;
          
          layer1.grp_cod_eplti = object.grp_cod_eplti;
          layer1.grp_use_poa = object.use_poa;
          layer1.grp_cod_nm = object.grp_cod_nm;
          layer1.grp_cod = object.grp_cod;
          
          if(regcnt > 0) {
             layer1.delshow = false;
          } else {
             layer1.delshow = true;
          }
          
          gfModalPop("#layer1");
       }
       
    }
    
    function popupclose() {
       gfCloseModal();       
    }
    
    function fn_selectgroupcode(grd_cod) {
       
       var param = {
             grp_cod : grd_cod
       };
       
       var selectonecallback = function(onedata) {
          initeditpopup(onedata.comnGrpCodModel);
       } 
       
       callAjax("/system/selectComnGrpCod.do", "post", "json", true, param, selectonecallback);
       
       
    }
    
    function fn_save() {
       
       var param = {
             grp_cod_eplti : layer1.grp_cod_eplti,
             grp_use_poa : layer1.grp_use_poa,
             grp_cod_nm : layer1.grp_cod_nm,
             grp_cod : layer1.grp_cod,
             action : layer1.action
       };
       
       var savecallback = function(saveresilt) {
          console.log("savecallback : " +  JSON.stringify(saveresilt)    );
          
          if(saveresilt.result == "SUCCESS") {
             alert("저장 완료");       
             
             popupclose();
             
             fn_listsearch();
             
          } else {
             alert(saveresilt.resultMsg);
          }
          
       } 
       
       callAjax("/system/saveComnGrpCod.do", "post", "json", false, param, savecallback);
       
    }
    
    // 삭제
    function fn_delete(){
    	
    	var callback=function(resultMap){
    		if(resultMap.result=="SUCCESS"){
    			alert(resultMap.resultMsg);
    			popupclose();
    			// fn_listsearch();
    		}else{
    			alert("알수 없는 요청입니다");
    		}
    	}
    	console.log(layer1.grp_cod);
    	callAjax("/system/deleteComnGrpCod.do","POST","JSON",false,{grp_cod : layer1.grp_cod,},callback);
    	
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
                        class="btn_nav bold">Sample</span> <span class="btn_nav bold">SampleTest3
                        </span> <a href="/sampletest/samplepage3.do" class="btn_set refresh">새로고침</a>
                  </p>
                 
               <p class="conTitle">
                  <span>그룹 코드</span> <span class="fr"> 
                       <a class="btnType blue" href="javascript:fPopModalComnGrpCod();" name="modal"><span>신규등록</span></a>
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
                     <tbody v-for="(oneitem,index) in searchlist">
                          <tr @click="rowclick(oneitem.grp_cod)">
                           <td>{{ index + 1 }}</td>
                           <td>{{ oneitem.grp_cod}}</td>
                           <td>{{ oneitem.grp_cod_nm}}</td>
                           <td>{{ oneitem.grp_cod_eplti}}</td>
                           <td>{{ oneitem.use_poa}}</td>
                           <td>{{ oneitem.reg_date}}</td>
                           <td>{{ oneitem.grp_cod_eplti}}</td>   
                        </tr>   
                     </tbody>
                  </table>
               </div>

               <div class="paging_area"  id="comnGrpCodPagination"> </div>
               
                  
                  
                  
                  
                  
           </div> <!--// content -->

               <h3 class="hidden">풋터 영역</h3>
               <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
            </li>
         </ul>
      </div>
   </div>

   <!-- 모달팝업 -->
   <div id="layer1" class="layerPop layerType2" style="width: 600px;">
      <dl>
         <dt>
            <strong>그룹코드 관리</strong>
         </dt>
         <dd class="content">
            <!-- s : 여기에 내용입력 -->
            <table class="row">
               <caption>caption</caption>
               <colgroup>
                  <col width="120px">
                  <col width="*">
                  <col width="120px">
                  <col width="*">
               </colgroup>

               <tbody>
                  <tr>
                     <th scope="row">그룹 코드 <span class="font_red">*</span></th>
                     <td><input type="text" class="inputTxt p100" name="grp_cod" id="grp_cod"  v-model="grp_cod" /></td>
                     <th scope="row">그룹 코드 명 <span class="font_red">*</span></th>
                     <td><input type="text" class="inputTxt p100" name="grp_cod_nm" id="grp_cod_nm" v-model="grp_cod_nm"  /></td>
                  </tr>
                  <tr>
                     <th scope="row">코드 설명 <span class="font_red">*</span></th>
                     <td colspan="3"><input type="text" class="inputTxt p100" name="grp_cod_eplti" id="grp_cod_eplti" v-model="grp_cod_eplti"  /></td>
                  </tr>
            
                  <tr>
                     <th scope="row">사용 유무 <span class="font_red">*</span></th>
                     <td colspan="3"><input type="radio" id="radio1-1"    name="grp_use_poa" id="grp_use_poa_1" value='Y'  v-model="grp_use_poa"  /> <label for="radio1-1">사용</label>
                        &nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="radio1-2"    name="grp_use_poa" id="grp_use_poa_2" value="N"  v-model="grp_use_poa"  /> <label for="radio1-2">미사용</label></td>
                  </tr>
               </tbody>
            </table>

            <!-- e : 여기에 내용입력 -->

            <div class="btn_areaC mt30">
               <a href="" class="btnType blue" id="btnSaveGrpCod" name="btn" @click="popupsave"><span>저장</span></a> 
               <a href="" class="btnType blue" id="btnDeleteGrpCod" name="btn" v-show="delshow" @click="popupdelete"  ><span>삭제</span></a> 
               <a href="javascript:popupclose();"   class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
            </div>
         </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
   </div>
</body>
</html>