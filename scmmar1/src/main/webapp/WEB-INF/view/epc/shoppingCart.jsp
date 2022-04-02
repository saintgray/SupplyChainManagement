<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>기업고객 : 장바구니 목록 (shoppingCart)</title>
    <jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>

<body>

    <div id="mask"></div>
    <div id="wrap_area">


        <!-- header 영역 -->
        -- header
        <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
        header --


        <!-- main 영역 -->
        <div id="container">
            <ul>
                <li class="lnb">
                    <!-- lnb 영역 -->
                    <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
                </li>
                <li class="contents">
                    <div class="content">
                        <p class="Location">
                            <a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
                            <span class="btn_nav bold">장바구니 목록</span>
                        </p>
                        
	                   	<!-- 장바구니 목록 테이블 -->
						<div class="divComGrpCodList">
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
										<th scope="col">선택</th>
										<th scope="col">사진</th>
										<th scope="col">모델명</th>
										<th scope="col">가격</th>
										<th scope="col">수량</th>
										<th scope="col">총 금액</th>
										<th scope="col">납품 희망 일자</th>
										<th scope="col">삭제</th>
									</tr>
								</thead>
								<tbody id="listComnGrpCod"></tbody>
							</table>
						</div>
						<div class="paging_area"  id="comnGrpCodPagination"> </div>
						
						
						<!-- end of div#content -->
                    </div>
                    
					
                </li>
            </ul>
        </div>


        <!-- footer 영역 -->
        -- footer
        <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
        footer --
    </div>
</body>

</html>