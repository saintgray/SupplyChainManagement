<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>기업임원</title>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">

	//페이징 설정 
	var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
	var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수



</script>
</head>
<body>

<!-- 모달 배경 -->
<div id="mask"></div>

<div id="wrap_area">
	<!-- Header area -->
	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
	
	<!-- Content area -->
	<div id="container">
		
		<ul>
			<li class="lnb">
				<!-- lnb area -->
				<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
			
			</li>
			<li class="contents">
				<div class="content">
				
					<p class="Location">
						<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
						<span class="btn_nav bold">매출현황</span> 
						<span class="btn_nav bold">매출 현황</span> 
						<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
					</p>
<!--검색창  -->
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>

                           <td width="50" height="25" style="font-size: 100%">기업고객명</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="text" style="width: 120px" id="title" name="title"></td>                     
                           <td width="50" height="25" style="font-size: 100%">작성일</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px" id="from_date" name="from_date"></td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px" id="to_date" name="to_date"></td>
                           <td width="110" height="60" style="font-size: 120%">
                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>검  색</span></a></td> 
                            <!-- <input type="button" value="검  색  " id="searchBtn" name="btn" class="test_btn1" 
                              style="border-collapse: collapse; border: 0px gray solid; background-color: #50bcdf; width: 70px; color: white"/> -->
                        </tr>
                     </table>    
						
						
						<div class="divSelesStatusList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="50px">
						                   <col width="200px">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">기업고객명</th>
							              <th scope="col">매출액</th>
									</tr>
								</thead>
								<tbody id="divSelesStatusList"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
							</div>
											
						</div>

		
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

</body>
</html>