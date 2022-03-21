<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>

<input type="hidden" id="userType" name="userType" value="${session.Scope.userType}" /> 

    <div id="wrap_area">

        <h2 class="hidden">header 영역</h2>
        <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

        <h2 class="hidden">컨텐츠 영역</h2>
        <div id="container">
            <ul>
                <li class="lnb">
                    <!-- lnb 영역 -->
                    <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
                    <!--// lnb 영역 -->
                </li>
                <li class="contents">
                    <!-- contents -->
                    <h3 class="hidden">contents 영역</h3> <!-- content -->
                    <div class="content">

                        <p class="Location">
                            <a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
                            <span class="btn_nav bold">강의관리</span> <span class="btn_nav bold">강의피드백</span>
                            <a href="/lec/lectureFeedback.do" class="btn_set refresh">새로고침</a>
                        </p>

                        <p class="conTitle">
                        	<br>
                            <select id="searchkey" name="searchkey" >
                            	<option value="A">강사명</option>
                            	<option value="B">학생명</option>                            
                            </select>
                            &nbsp;
                            <input type="text" id="sname" name="sname" value="" size="15px" >
                            &emsp;&emsp;&emsp;&emsp;
                            <span>기간</span>
                            &nbsp;
                   			<input type="text" search="inputTxt p100" name="search_startdate" id="search_startdate" value="" size="10px" />
                   			&nbsp;
                   			<span> ~ </span>
                   			&nbsp;
                   			<input type="text" search="inputTxt p100" name="search_enddate" id="search_enddate" value="" size="10px" />
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;                          
                            <a href="javascript:feedbackList();" class="btnType blue" id="list_search"> <span>검색</span></a>
                        </p>

                        <div class="divFeedbackList">
                            <table class="col">
                                <caption>caption</caption>
                                <colgroup>
                                	<col width="8%">
                                    <col width="8%">
									<col width="30%">
									<col width="10%">
									<col width="12%">
									<col width="12%">
									<col width="8%">
									<col width="8%">
                                </colgroup>

                                <thead>
                                    <tr>
                                        <th scope="col">평가번호</th>
                                        <th scope="col">강의번호</th>
										<th scope="col">강의명</th>
										<th scope="col">종료일</th>
										<th scope="col">강사명</th>
										<th scope="col">학생명</th>
										<th scope="col">강의실</th>
										<th scope="col">점수</th>
                                    </tr>
                                </thead>
                                <tbody id="feedbackList"></tbody>
                            </table>
                        </div>

                        <div class="paging_area" id="pagingnavi"></div>


                        <table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="collapse; border: 1px #50bcdf;">
                            <tr style="border: 0px; border-color: blue">
                                <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                                <td width="50" height="25" style="font-size: 100%; text-align: left; padding-right: 25px;">
                            </tr>
                        </table>
                    </div>

                    <h3 class="hidden">풋터 영역</h3>
                    <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
                </li>
            </ul>
        </div>
    </div>
</body>
</html>

<jsp:include page="/WEB-INF/view/lec/feedbackListModal.jsp"></jsp:include>