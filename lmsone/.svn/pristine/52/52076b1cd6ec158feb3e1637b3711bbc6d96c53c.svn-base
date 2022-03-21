<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 공통 코드 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<!-- 구글차트조회 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- sweet swal import -->

<script type="text/javascript">

	// 검색기능
	function board_search() {
		//var startdate = $('#fstartDate').val($('#startDate').val()); // 2022-01-01
		//var enddate = $('#fendDate').val($('#endDate').val()); // 2022-12-31
		
		var startdate = $('#startDate').val();
		var enddate = $('#endDate').val();
		console.log(startdate + " " + enddate);
		fstudentlist(startdate, enddate); // fstudentlist(2022-01-01, 2022-12-31)
        
  }	

	function fstudentlist(startdate, enddate){ // fstudentlist(2022-01-01, 2022-12-31)

		console.log(startdate + " " + enddate);		
		
		$.ajax({
			url : "/sta/graph.do",
			type: "post",
			dataType : "json",
			async : true,
			data : {
				startdate : startdate, // 2022-01-01
				enddate : enddate // 2022-12-31
			},
			success : function(dt) {
						
				console.log("+++dt : " + JSON.stringify(dt.studentlist));
				
				var list = dt.studentlist;
				//var list = {'class_startdate' :'class_startdate'
					//			  ,'cnt':'cnt'};
								
				console.log(JSON.stringify(list));
				
			 	$.each(list, function(key, value){
				    console.log('key:' + key + ' / ' + 'class_startdate:' + value.class_startdate + ' / ' + 'cnt:' + value.cnt);
				}); 
			
				
				 
				/* for(var i  = 0; i<dt.studentlist.length(); i++){
					
					list =  dt.studentlist[i] // map - > array
					
				} */
				
				drawChart(list);
			 
			},
			
			error : function(e) {
				alert("통신오류")
			}
			
			
		})
	}
	
	
	
	
	// ------------------------------------------------------------------------------- 

      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart(list) {
    	  var data = new google.visualization.DataTable();
    	  data.addColumn('string', '수강년도');
    	  data.addColumn('number', '수강년월');

    	  for (var i = 0; i < list.length; i++) {
    	       data.addRow([list[i].class_startdate, list[i].cnt]);
    	  }
     	  
/*         var data = google.visualization.arrayToDataTable([
          ['수강년도', '인원수'],
          
          [list.class_startdate[class_startdate] ,list[cnt]],
                      

        ]);  */


        var options = {
          title: '수강인원',
          curveType: 'function',
          legend: { position: 'bottom' }
        };

        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

        chart.draw(data, options);
      }
        
	 
      
        
  


</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageSta" value="1">
	<input type="hidden" name="action" id="action" value="">
<!-- 	<input type="text" id=""> -->
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
								class="btn_nav bold">통계</span> <span class="btn_nav bold">수강인원</span>							  							
						</p>
						<p class="conTitle mt50">
                        <span>수강인원</span> <span class="fr"> 
                           <span class="btn_nav bold">기간:</span>&emsp;                           
                           <input type="month" name="startDate" id="startDate" style="font-size: 18px" /> ~ 
                           <input type="month" name="endDate" id="endDate" style="font-size: 18px" /> &emsp; 
                           <input type="hidden" id="fstartDate">
                           <input type="hidden" id="fendDate">
                           <a onclick="javascript:board_search();" class="btnType blue" id="board_search" name="btn" style="cursor: pointer;"><span>검 색</span></a>
                        </span>
                     </p>
						<div class="divsta">
						<div id="curve_chart" style="width: 900px; height: 500px"></div>
					
							<input type="hidden" id="totalCnt" name="totalCnt" value ="${totalCnt}"/>	
					<!--// content -->
						 <div id="chart_div" style="width: 900px; height: 500px;"></div>
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>



</form>
</body>
</html>