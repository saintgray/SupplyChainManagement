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

	//페이징 설정
	var pageSize = 5;
	var pageBlockSize = 5;
	

	$(function(){
		
		//만족도 조회
		 StaSer(1); 
		
		
	});
	// 검색기능
	function board_search() {
		$('#fstartDate').val($('#startDate').val()); 
		$('#fendDate').val($('#endDate').val());     
		StaSer(1);
        
  }	
	function StaSer(currentPage){	
        console.log("currentPage : " + currentPage);       
		currentPage = currentPage || 1; 
        $.ajax({
        	url : "/sta/paging.do",
        	type:"post",
        	data : {
        		currentPage : currentPage
            	, 	pageSize : pageSize
            	,	class_startdate : $('#fstartDate').val()
            	,  class_enddate : $('#fendDate').val() 
        	},
        	success : function(map) {
				
				// 기존 목록 삭제
				$('#liststa').empty();
				var list = map.liststaModel;
				var str = "";
				$.each(list,function(i){
					str+="<tr><td>"+list[i].class_no+"</td>";
					str+="<td>"+"<a href=" + '"javascript:selectSatisfaction(' + "'" +list[i].class_no + "'" +')">'+list[i].name+"</a></td>";
					str+="<td>"+list[i].date+"</td>";
					str+="<td>"+list[i].subject+"</td>";
					str+="<td>"+list[i].totall+"</td>";
					str+="<td>"+list[i].avgg+"</td>";
					str+="<td>"+list[i].maxx+"</td>";
					str+="<td>"+list[i].minn+"</td></tr>";
					
				})
				
				// 신규 목록 생성
				$("#liststa").append(str);
				$("#totalCnt").val(map.countlist);
				var totalCnt = $("#totalCnt").val();
				var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize, 'StaSer');
				console.log("paginationHtml : " + paginationHtml);
				$("#StaPagination").empty().append( paginationHtml );
				
				// 현재 페이지 설정
				$("#currentPageSta").val(currentPage);
			},
			error : function(e) {
				alert("ajax오류")
			}
        	
        })
        
	}    
	
	function selectSatisfaction(class_no){

		$.ajax({
			url : "selectSatisfaction.do",
			type: "post",
			data : {
				class_no : class_no 
			},
			success : function(map) {
				var searchname = map.searchname;
				var searchavgg = map.searchavgg;
				var searchmaxx = map.searchmaxx;
				var searchminn = map.searchminn;
				
				
				drawVisualization(searchname, searchavgg, searchmaxx, searchminn);
			},
			error : function(e) {
				alert("통신오류")
			}
			
			
		})
	}
	
	
	
	
	/* ------------------------------------------------------------------------------- */

    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawVisualization);

    function drawVisualization(searchname, searchavgg, searchmaxx, searchminn) {

      
      var data = google.visualization.arrayToDataTable([
        ['과정명', '평균', '최대점수', '최소점수'],
        [searchname, searchavgg, searchmaxx, searchminn]
      ]);

      var options = {
        title : searchname,
        vAxis: {title: '점수', maxValue:5, minValue:0},
        hAxis: {title: '과정명'},
        seriesType: 'bars'
      /*   series: {5: {type: 'line'}} */
      };

      var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
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
								class="btn_nav bold">통계</span> <span class="btn_nav bold">만족도</span>							  							
						</p>
						<p class="conTitle mt50">
                        <span>만족도</span> <span class="fr"> 
                           <span class="btn_nav bold">기간:</span>&emsp; 
                           <input type="date" name="startDate" id="startDate" style="font-size: 18px" /> ~ 
                           <input type="date" name="endDate" id="endDate" style="font-size: 18px" /> &emsp; 
                           <input type="hidden" id="fstartDate">
                           <input type="hidden" id="fendDate">
                           <a onclick="board_search()" class="btnType blue" id="board_search" name="btn" style="cursor: pointer;"><span>검 색</span></a>
                        </span>
                     </p>
						<div class="divsta">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="20%">
									<col width="8%">
									<col width="8%">
									<col width="8%">
									<col width="8%">
									<col width="8%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">과정명</th>
										<th scope="col">기간</th>
										<th scope="col">대상자수</th>
										<th scope="col">총점수</th>
										<th scope="col">평균</th>
										<th scope="col">최대점수</th>
										<th scope="col">최소점수</th>
									</tr>
								</thead>
								<tbody id="liststa">
									<c:if test="${totalCnt eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.
									
									</td>
								</tr>
							</c:if>
							
				
							<c:if test="${totalCnt > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
								<c:forEach items="${liststaModel}" var="list">
									<tr>
										<td>${list.class_no }</td>
										<td><a href="javascript:selectSatisfaction('${list.class_no}')">${list.name}</a></td>	
										<td>${list.date}</td>
										<td>${list.subject}</td>
										<td>${list.totall}</td>
										<td>${list.avgg }</td>
										<td>${list.maxx }</td>
										<td>${list.minn }</td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
								</tbody>
							</table>
						</div>
						<div class="paging_area"  id="StaPagination" > 
						</div>
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