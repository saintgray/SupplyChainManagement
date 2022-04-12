// unblock when ajax activity stops 
$(document).ajaxStop($.unblockUI);

/**
 * ajax 공통 호출 함수
 *
 * @param
 *   url : 서비스 호출URL
 *   method : post, get
 *   async : true, false
 *   param : data parameter
 *   callback : callback function name
 */

function callAjax(url, method, dataType, async, param, callback) {
   //console.log('>>>>>>param일떄',param);
   
   //method는 post 이다. async는 true/false이다.
   if (method == null || method == "") method = "post";
   
   $.ajax({
      url : url,
      type : method,
      dataType : dataType,
      async : async,
      data : param,
      beforeSend: function(xhr) {
         xhr.setRequestHeader("AJAX", "true");
         $.blockUI({ message: '<h1><img src="/images/admin/comm/busy.gif" /> Just a moment...</h1>', T:99999 });
      },
      success : function(data) {
         // 서버에서 JSON 객체로 받았지만, AJax 의 경우 javascript 객체로 자동 변화해주기 때문에
         // data 자체가 문자열이 아닌 자바스크립트 객체가 된다.
         console.log(data);
         console.log(JSON.stringify(data));
         // 파라미터로 받은 callback 매개변수 (= fLoginProcResult 함수 ) 를 실행한다.
         // fLoginProcResult 의 매개변수로 data 를 넣어준다.
         callback(data);
      },
      error : function(xhr, status, err) {
         console.log("xhr : " + xhr);
         console.log("status : " + status);
         console.log("err : " + err);
               
         if (xhr.status == 901) {
            alert("로그인 정보가 없습니다.\n다시 로그인 해 주시기 바랍니다.");
            location.replace('/login.do');
         } else {
            alert('A system error has occurred.' + err);
         }
      },
      complete: function(data) {
         $.unblockUI();
      }
   });
}

/**
 * ajax 공통 호출 함수 - 파일 업로드 포함
 *
 * @param
 *   url : 서비스 호출URL
 *   method : post, get
 *   async : true, false
 *   formName : form name
 *   callback : callback function name
 */
function callAjaxFileUpload(url, method, dataType, async, formName, callback) {
   
   if (method == null || method == "") method = "post";
   
   var frm = document.getElementById(formName);
   var fileData = null;
   if(frm == null){
      fileData = formName;
   }else{
      frm.enctype = 'multipart/form-data';
      fileData = new FormData(frm);
   }
   
   // 익스플로어에서 데이터를 못담는 현상이 발견되어 아래행 삽입 
   fileData.append("empty", "empty"); 
   
   $.ajax({
      url : url,
      type : method,
      dataType : dataType,
      async : async,
      data : fileData,
      contentType: false,
      processData: false,
      cache : false,
      beforeSend: function(xhr) {
         xhr.setRequestHeader("AJAX", "true");
         $.blockUI({ message: '<h1><img src="/images/admin/comm/busy.gif" /> Just a moment...</h1>', T:99999 });
      },
      success : function(data) {
         callback(data);
      },
      error : function(xhr, status, err) {
         console.log("xhr : " + xhr);
         console.log("status : " + status);
         console.log("err : " + err);
         
         if (xhr.status == 901) {
            alert("로그인 정보가 없습니다.\n다시 로그인 해 주시기 바랍니다.");
            location.replace('/login.do');
         } else {
            alert('A system error has occurred.' + err);
         }
      },
      complete: function(data) {
         $.unblockUI();
      }
   });
}


/**
 * ajax 공통 호출 함수 - 다수 파일 업로드 포함
 * (제작의뢰 전용)
 *
 * @param
 *   url : 서비스 호출URL
 *   method : post, get
 *   async : true, false
 *   formName : form name
 *   callback : callback function name
 */
function callAjaxFileUploadSetFormData(url, method, dataType, async, formData, callback) {
   
   if (method == null || method == "") method = "post";
   formData.append("empty", "empty");
   
   $.ajax({
      url : url,
      type : method,
      dataType : dataType,
      async : async,
      data : formData,
      contentType: false,
      processData: false,
      cache : false,
      beforeSend: function(xhr) {
         xhr.setRequestHeader("AJAX", "true");
         $.blockUI({ message: '<h1><img src="/images/admin/comm/busy.gif" /> Just a moment...</h1>', T:99999 }); 
      },
      success : function(data) { 
         callback(data); 
      },
      error : function(xhr, status, err) { 
         console.log("xhr : " + xhr);
         console.log("status : " + status);
         console.log("err : " + err);
         
         if (xhr.status == 901) {
            alert("로그인 정보가 없습니다.\n다시 로그인 해 주시기 바랍니다.");
            location.replace('/login.do');
         } else {
            alert('A system error has occurred.' + err);
         }
      },
      complete: function(data) {
         $.unblockUI();
      }
   });
}
// 2022-04-04 종현 수정
// 커스텀 url 을 파라미터로 넘겨 필요한 콤보박스를 만들 수 있도록 변경
// 상세코드에 대한 파라미터만 필요하다면 파라미터로 넘겨주지 않거나 null 로 보낼 것
function comcombo(group_code, combo_name, type, selvalue, url){
   
   console.log("comcombo Start !!!!!!!!!!! ");
   
   var selectbox = document.getElementById(combo_name);

   var data = {
         "group_code" : group_code
      };   
   
   $(selectbox).find("option").remove();
     
   //private String dtl_cod;   
   //private String dtl_cod_nm;
   
   $.ajax({ 
        type: "POST",  
        url: (url==null || url==undefined || url=='')?"/commonproc/comcombo.do":url, 
        dataType: "json",  
        data : data,
        success: function(data)
        {             
           
           var json_obj = $.parseJSON(JSON.stringify(data));//parse JSON 
           var jsonstr = json_obj.list;
           console.log("jsonstr : " + jsonstr);
           
           var jsonstr_obj = $.parseJSON(JSON.stringify(jsonstr));//parse JSON 
           var listLen = jsonstr_obj.length;

           if(type == "all") {
              $(selectbox).append("<option value=''>전체</option>");
           }           
           
           if(type == "sel") {
             $(selectbox).append("<option value=''>선택</option>");
           }
           console.log(" selvalue : " + selvalue);
            for(var i=0; i<listLen; i++)
            {       
               var eleString = JSON.stringify(jsonstr_obj[i]);
               var item_obj = $.parseJSON(eleString);//parse JSON
            
               if(selvalue != null && selvalue != null && selvalue != "") {
                  if(selvalue == item_obj.dtl_cod) {
                     console.log(" item_obj.dtl_cod : " + item_obj.dtl_cod);
                     
                     $(selectbox).append("<option value='"+ item_obj.dtl_cod + "' selected>" + item_obj.dtl_cod_nm + "</option>");
                  } else {
                     $(selectbox).append("<option value='"+ item_obj.dtl_cod + "'>" + item_obj.dtl_cod_nm + "</option>");
                  }
               } else {
                  $(selectbox).append("<option value='"+ item_obj.dtl_cod + "'>" + item_obj.dtl_cod_nm + "</option>");
               }
               
               
            } 
        },
        error:function(request,status,error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); }
   });  
};


function isEmpty(value){ 
   if( //$.trim(value) == ""
      value == ""
      || value == null
      || value == undefined 
      || (value != null && typeof value == "object" 
            && !Object.keys(value).length )
      ||(typeof value =="string" && !value.replace(/ /gi, "").length)
      ){   
      return true; 
   }else{ 
      return false; 
   } 
};



//selectComCombo(comtype, combo_name, type, searchkey,selvalue)   
//comtype    cli : 거래처    wh : 창고
//combo_name   select id
//type    sel : 선택   all : 전체

function selectComCombo(comtype, combo_name, type, selvalue){
      
      console.log("selectComCombo Start !!!!!!!!!!!!!! ");
      
      var selectbox = document.getElementById(combo_name);
      
      var data = {
            "comtype" : comtype
         };   
      
      $(selectbox).find("option").remove();
            
      $.ajax({ 
           type: "POST",  
           url: "/system/selectComCombo.do", 
           dataType: "json",  
           data : data,
           success: function(data)
           {             
              
              var json_obj = $.parseJSON(JSON.stringify(data));//parse JSON 
              var jsonstr = json_obj.list;
              console.log("jsonstr : " + jsonstr);
              
              var jsonstr_obj = $.parseJSON(JSON.stringify(jsonstr));//parse JSON 
              var listLen = jsonstr_obj.length;
      
              if(type == "all") {
                 $(selectbox).append("<option value=''>전체</option>");
              }           
              
              if(type == "sel") {
                $(selectbox).append("<option value=''>선택</option>");
              }
              console.log(" selvalue : " + selvalue);
               for(var i=0; i<listLen; i++)
               {       
                  var eleString = JSON.stringify(jsonstr_obj[i]);
                  var item_obj = $.parseJSON(eleString);//parse JSON
              
                  if(selvalue != null && selvalue != null && selvalue != "") {
                     if(selvalue == item_obj.dtl_cod) {
                        console.log(" item_obj.cd : " + item_obj.cd);
                        
                        $(selectbox).append("<option value='"+ item_obj.cd + "' selected>" + item_obj.name + "</option>");
                     } else {
                        $(selectbox).append("<option value='"+ item_obj.cd + "'>" + item_obj.name + "</option>");
                     }
                  } else {
                     $(selectbox).append("<option value='"+ item_obj.cd + "'>" + item_obj.name + "</option>");
                  }
                  
                  
               } 
               
               $(selectbox).val(selvalue);
           },
           error:function(request,status,error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); }
      });  
};


//selectComCombo(comtype, combo_name, type, searchkey,selvalue)   
//protype    상품 구분     빈값이면 전체 상품
//combo_name   select id
//type    sel : 선택   all : 전체

function selectGoodComCombo(protype, combo_name, type, selvalue){
      
      console.log("selectComCombo Start !!!!!!!!!!!!!! ");
      
      var selectbox = document.getElementById(combo_name);
      
      var data = {
            "protype" : protype
         };   
      
      $(selectbox).find("option").remove();
            
      $.ajax({ 
           type: "POST",  
           url: "/system/selectGoodComCombo.do", 
           dataType: "json",  
           data : data,
           success: function(data)
           {             
              
              var json_obj = $.parseJSON(JSON.stringify(data));//parse JSON 
              var jsonstr = json_obj.list;
              console.log("jsonstr : " + jsonstr);
              
              var jsonstr_obj = $.parseJSON(JSON.stringify(jsonstr));//parse JSON 
              var listLen = jsonstr_obj.length;
      
              if(type == "all") {
                 $(selectbox).append("<option value=''>전체</option>");
              }           
              
              if(type == "sel") {
                $(selectbox).append("<option value=''>선택</option>");
              }
              console.log(" selvalue : " + selvalue);
               for(var i=0; i<listLen; i++)
               {       
                  var eleString = JSON.stringify(jsonstr_obj[i]);
                  var item_obj = $.parseJSON(eleString);//parse JSON
              
                  if(selvalue != null && selvalue != null && selvalue != "") {
                     if(selvalue == item_obj.dtl_cod) {
                        console.log(" item_obj.cd : " + item_obj.cd);
                        
                        $(selectbox).append("<option value='"+ item_obj.cd + "' selected>" + item_obj.name + "</option>");
                     } else {
                        $(selectbox).append("<option value='"+ item_obj.cd + "'>" + item_obj.name + "</option>");
                     }
                  } else {
                     $(selectbox).append("<option value='"+ item_obj.cd + "'>" + item_obj.name + "</option>");
                  }
                  
                  
               } 
               
               $(selectbox).val(selvalue);
           },
           error:function(request,status,error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); }
      });  
};