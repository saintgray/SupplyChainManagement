
	// 페이징 설정 
	var noticePageSize = 10; // 화면에 뿌릴 데이터 수 
	var noticePageBlock = 5; // 블럭으로 잡히는 페이징처리 수
	
	// 수정시 삭제한파일 고유번호를 담은 배열객체
	var delFileList= [];
	
	// $(document).ready()
	$(function() {
		
		// init Summernote
		$('#ntc_content').summernote({
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
			width:"500",
			minWidth:"500",
			maxWidth:"500",
			height:"500",
			minHeight:"300px",
			maxHeight:"300px",  
		})
		
		
		initDatePicker();
		connectButtonEvent();
		connectLoadFileEvent();
		connectRemoveFilesEvent();
		
		selectNoticeList();
		
	});
	
	function resize(obj) {
		  obj.style.height = "1px";
		  obj.style.height = (12+obj.scrollHeight)+"px";
	}

	// 버튼 이벤트 등록 - 저장, 수정, 삭제  
	function connectButtonEvent() {
		$('.btn_areaC > button, #searchBtn').click(function(e) {
			
			e.preventDefault();
			
			switch ($(this).attr('id')) {
			case 'btnSaveNotice':
				fSaveNotice();
				break;
			case 'btnDeleteNotice':
				fDeleteNotice();
				break;
			case 'btnClose':
				fCloseModal();
				break;
			case 'btnUpdateNotice':
				fUpdateNotice();
				break;
			case 'searchBtn':
				selectNoticeList();
				break;
			}
		});
	}
	
	function connectLoadFileEvent(){
		$('#file').on('change',function(e){
			console.log(e.target.files);
			var files=e.target.files
			$(files).each(function(index, file){
				
				var prevHtml='';
				prevHtml+='<div>';
				prevHtml+='<span id='+file.lastModified+'>'+file.name+'</span>';
				prevHtml+='<img src="/images/treeview/minus.gif" class="remove"/>';
				prevHtml+='</div>'
				$('#attrfiles').append(prevHtml);
			})
		})
	}
	
	// removefile
	function connectRemoveFilesEvent(){
		$('#attrfiles').on('click','.remove',function(){
			
			console.log($(this).siblings('span').attr('id'));
			var removeTarget=$(this).siblings('span').attr('id');
			
			// 실제 input file 태그에 저장된 file 들 중 선택한 id 값(lastModified) 만 제외하고 
			// dataTransfer 객체에 추가한다.
			var files=$('#file')[0].files;
			const dataTransfer=new DataTransfer();
			Array.from(files)
				 .filter(file=>file.lastModified != removeTarget)
				 .forEach(file=>{
					dataTransfer.items.add(file); 
				 });
			// 삭제한 파일을 제외한 FileList 를 가지고 있는 dataTransfer 객체의 list를 input file 태그에 복사한다
			$('#file')[0].files=dataTransfer.files;
			
			// 미리보기에서 제거
			$(this).parent().remove();
		})
	}
	
	
	// DatePicker
 	function initDatePicker(){
 	    $.datepicker.setDefaults($.datepicker.regional['ko']); 
 	    $( "#from_date" ).datepicker({
 	         changeMonth: true, 
 	         changeYear: true,
 	         nextText: '다음 달',
 	         prevText: '이전 달', 
 	         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
 	         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
 	         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
 	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
 	         showAnim: "slide", //애니메이션을 적용한다.
 	         dateFormat: "yy-mm-dd",
 	         maxDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
 	         onClose: function( selectedDate ) {    
 	              //시작일(startDate) datepicker가 닫힐때
 	              //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
 	             $("#to_date").datepicker( "option", "minDate", selectedDate );
  
 	         }    

 	    });
 	    $( "#to_date" ).datepicker({
 	         changeMonth: true, 
 	         changeYear: true,
 	         nextText: '다음 달',
 	         prevText: '이전 달', 
 	         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
 	         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
 	         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
 	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
 	         showAnim: "slide", //애니메이션을 적용한다.
 	         dateFormat: "yy-mm-dd",                    // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
 	         onClose: function( selectedDate ) {    
 	             // 종료일(endDate) datepicker가 닫힐때
 	             // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
 	             $("#from_date").datepicker( "option", "maxDate", selectedDate );

 	         }    

 	    }); 
 	    
 	    $("#from_date").datepicker('setDate', '-3M');
 	    $("#to_date").datepicker('setDate', 'today');
 	}
 	
	// 공지사항 리스트 호출
	function selectNoticeList(currentPage) {

		currentPage = currentPage || 1;		

		var sname = $('#sname');
		var searchKey = document.getElementById("searchKey");
		var oname = searchKey.options[searchKey.selectedIndex].value;
		
		var from_date = $('#from_date');
		var to_date = $('#to_date');

		var param = {
			sname : $('#sname').val(),
			oname : oname,
			from_date : $('#from_date').val(),
			to_date : $('#to_date').val(),
			currentPage : currentPage,
			pageSize : noticePageSize,
			searchKey:searchKey.value
		}

		var resultCallback = function(data) { // 데이터를 이 함수로 넘깁시다. 
			noticeListResult(data, currentPage);
		}
		// console.log(param);
		callAjax("/scm/noticeList.do", "post", "text", true, param,resultCallback);

	}

	/* callAjax 공통 common.js 에서 퍼옴  -> 이렇게 생긴 함수입니다.  
	
	function fOnloadImg(param){
		var resultCallback = function(data) {
			fOnloadImgResult(data);
		};
		callAjax("/image/selectImgSize.do", "post", "json", false, param, resultCallback);
	 } */

	
	// 공지사항 리스트 data를 콜백함수를 통해 뿌린다.  
	function noticeListResult(data, currentPage) {

		// 일단 기존 목록을 삭제합니다. (변경시 재부팅 용)
		$("#noticeList").empty();
		//alert("데이터!!! " + data);
		//console.log("data !!!! " +  data);

		//var $data = $( $(data).html() ); // data의 .html()통해서 html구문을 끌어온다.
		//alert("데이터 찍어보자!!!! " +  $data); // object

		$("#noticeList").append(data);

		// 리스트의 총 개수를 추출합니다. 
		var totalCnt = $("#totalCnt").val(); 
		

		// * 페이지 네비게이션 생성 (만들어져있는 함수를 사용한다 -common.js)
		// function getPaginationHtml(currentPage, totalCount, pageRow, blockPage, pageFunc, exParams)
		// 파라미터를 참조합시다. 
		var list = $("#tmpList").val();
		//var listnum = $("#tmpListNum").val();
		var pagingnavi = getPaginationHtml(currentPage, totalCnt,
				noticePageSize, noticePageBlock, 'selectNoticeList', [ list ]);

		
		 
		$("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 

		// 현재 페이지 설정 
		$("#currentPage").val(currentPage);

	}

	// 공지사항 모달창 호출
	function fNoticeModal(notice_no) {

		// 신규저장 하기 버튼 클릭시 (값이 null)
		if (notice_no == null || notice_no == "") {
			// Tranjection type 설정
			//alert("넘을 찍어보자!!!!!!" + notice_no);

			$("#action").val("I"); // insert 
			/* $("#notice_no").val(""); */
			frealPopModal(notice_no); // 공지사항 초기화 
			
			//모달 팝업 모양 오픈! (빈거) _ 있는 함수 쓰는거임. 
			
			gfModalPop("#notice");
			
			
 
		} else {
			// Tranjection type 설정
			$("#action").val("U"); // update
			fdetailModal(notice_no); //번호로 -> 공지사항 상세 조회 팝업 띄우기
		}

	}

	// 공지사항 상세조회
	function fdetailModal(notice_no) {
		
		var param = {
			ntc_no : notice_no
		};
		var callback = function(data) {
			fdetailResult(data);
		};

		callAjax("/scm/detailNoticeList.do", "post", "json", true, param,callback);
	}

	// 공지사항 상세 조회 -> 콜백함수   
	function fdetailResult(data) {

		//alert("공지사항 상세 조회  33");
		if (data.resultMsg == "SUCCESS") {
			//모달 띄우기 
			gfModalPop("#notice");

			// 모달에 정보 넣기 
			frealPopModal(data.info,data.type);
		} else {
			alert("오류가 발생했습니다 잠시 후 다시 시도하세요");
		}
	}

	// 공지사항 작성 or 공지사항 상세조회,수정 모달창 호출 
	function frealPopModal(info,type) {

		if (info == "" || info == null || info == undefined) {
			
			// inserted Flag
			$("#action").val("I");

			
			var writer = $("#swriter").val();

			
			$("#loginID").attr("readonly", true);	
			$("#ntc_title, #ntc_regdate #file, #loginID").val('');

			// 삭제, 수정버튼 숨김
			$("#btnDeleteNotice, #btnUpdateNotice").hide();
			// 작성일, 작성자 숨김
			$('#r-regdate,#r-writer').hide();
			// 첨부파일 미리보기 비움
			$("#attrfiles").empty();
			// 등록버튼 활성화
			$("#btnSaveNotice").show();
			
			

		} else {

			$("#loginID").val(info.loginID).attr("readonly", true);
			$("#ntc_regdate").val(info.ntc_regdate).attr("readonly", true);
			$("#ntc_title").val(info.ntc_title);
			$('#ntc_content').summernote('code',info.ntc_content);
			
			$("#ntc_no").val(info.ntc_no); // 중요한 num 값도 숨겨서 받아온다. 		
	
			if(info.filesInfo.length!=0) {
				
				var prevHtml='';
				$(info.filesInfo).each(function(index,item){
					prevHtml+='<div>';
					prevHtml+='<span class="n_files" onclick=filedown('+item.file_no+')>'+item.file_ofname+' ,</span>';
					if(type=='A'){
						prevHtml+='<img src="/images/treeview/minus.gif" class="addDelete"/>';
					}
					prevHtml+='</div>';
				})
				$('#attrfiles').append(prevHtml);
				// $("#attrfiles").empty().append("<a href='javascript:filedown("+ fobject.ntc_no + ")'>" + fobject.file_ofname + "</a>");				                                 
			} 							
			$('#btnSaveNotice').hide();
			if(type=='A'){
				$("#btnDeleteNotice, #btnUpdateNotice").show();
			}else{
				$("#btnDeleteNotice, #btnUpdateNotice").hide();
			}
			$("#r-regdate,#r-writer").show();
		}
	}
	
	// 첨부파일 다운
	function filedown(file_no){
 	 	var params = "";
		params += "<input type='hidden' name='file_no' value='"+ file_no +"' />";
		
		jQuery("<form action='/scm/fileDown.do' method='post'>"+params+"</form>")
		.appendTo('body')
		.submit()
		.remove(); 			
	}
	
	// 팝업내 수정, 저장 validation 
	function fValidatePopup() {
		var chk = checkNotEmpty([ [ "notice_title", "제목을 입력해주세요!" ],
				                  [ "notice_content", "내용을 입력해주세요!" ] ]);
		if (!chk) {
			return;
		}
		return true;
	}

	// 공지사항 등록(저장) 
	function fSaveNotice() {
		
		if (!(fValidatePopup())) {
			return;
		}

		var callback = function(data) {
			fSaveNoticeResult(data);
		};
		
		var formData=new FormData();
		formData.append('ntc_title',$('#ntc_title').val());
		formData.append('ntc_content',$('#ntc_content').summernote('code'));
		formData.append('action',$('#action').val());
		$($('#file')[0].files).each(function(index,item){
			formData.append('files',item);
		})
		
		$.ajax({
			url : '/scm/noticeSave.do',
			type : 'post',
			data : formData,
			enctype:'multipart/form-data',
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
				}else if(xhr.status==403){
					location.href='/accessdenied.do';
				}else {
					alert('A system error has occurred.' + err);
				}
			},
			complete: function(data) {
				$.unblockUI();
			}
		});
		
	}

	// 저장 ,수정, 삭제 콜백 함수 처리 
	function fSaveNoticeResult(data) {
		console.log(data);
		var currentPage = currentPage || 1;

		if ($("#action").val() != "I") {
			currentPage = $("#currentPage").val();
		}
		
		
		if(data==1){
			var action=$('#action').val();
			if(action=='I'){
				alert('정상적으로 등록되었습니다');
			}else if(action=='U'){
				alert('정상적으로 수정되었습니다');
			}else{
				alert('정상적으로 삭제되었습니다');
			}
			$('#action').val('');
			fCloseModal();
			selectNoticeList($('.divComGrpCodList .paging strong').text());
			
		}else{
			alert('오류가 발생하였습니다. 잠시 후 다시 시도하세요');
		}
		
	}

	// 공지사항 등록 
	function fUpdateNotice() {

		
		if (!(fValidatePopup())) {
			return;
		}

		var resultCallback3 = function(data) {
			fSaveNoticeResult(data);
		};

		$("#action").val("U"); // update
		var frm = document.getElementById("myNotice");
		var dataWithFile = new FormData(frm);
		callAjaxFileUploadSetFormData("/scm/noticeUpdate.do", "PUT", "json", true, dataWithFile, resultCallback3);
	}

	// 공지사항 게시판 1건 삭제 
	function fDeleteNotice() {
		var con = confirm("정말 삭제하겠습니까? \n 삭제시 복구불가합니다.");
		if (con) {
			var resultCallback3 = function(data) {
				fSaveNoticeResult(data);
			}
			$("#action").val("D"); // delete
			callAjax("/scm/noticeDelete/"+$('#ntc_no').val(), "DELETE", "json", true, null, resultCallback3);
			
		} else {
			gfCloseModal(); // 모달 닫기
			selectNoticeList(currentPage); // 목록조회 함수 다시 출력 
			frealPopModal();// 입력폼 초기화
		}
	}
	
	function fCloseModal(){
		
		var isNewRegForm=$('#action').val()=='I';
		
		if((isNewRegForm && confirm('작성을 취소하시겠습니까?')) || !isNewRegForm){
			// 제목, 내용, 파일, 첨부파일 미리보기 전부 지우기
			$('#ntc_title,#file').val("");
			$('#ntc_content').summernote('code','');
			$('#attrfiles').empty();
			if(!isNewRegForm){
				// 전역 삭제파일 배열객체 초기화
				delFileList.length=0;
			}
			gfCloseModal(); // 모달닫기
		}
		
	}
	
	