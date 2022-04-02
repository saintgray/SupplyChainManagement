<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>기업고객 : 주문 이력 조회 (refundRequest)</title>
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
                            <span class="btn_nav bold">주문 이력 조회</span>
                        </p>
		                  	<!-- 주문 이력 목록 테이블 -->
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
										<th scope="col">일련번호</th>
										<th scope="col">주문 수량</th>
										<th scope="col">결제 금액</th>
										<th scope="col">구매 일자</th>
										<th scope="col">배송 희망 날짜</th>
										<th scope="col">배송 상태</th>
										<th scope="col">반품 신청</th>
									</tr>
								</thead>
								<tbody id="listComnGrpCod"></tbody>
							</table>
						</div>
						<div class="paging_area"  id="comnGrpCodPagination"> </div>
							
		                   
	                   <div class="orderDetailTable">
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
									<th scope="col">체크</th>
									<th scope="col">반품 수량</th>
									<th scope="col">주문 번호</th>
									<th scope="col">장비 구분</th>
									<th scope="col">모델명</th>
									<th scope="col">제조사</th>
									<th scope="col">판매 가격</th>
									<th scope="col">주문 수량</th>
									<th scope="col">결제 금액</th>
								</tr>
							</thead>
							<tbody id="listComnGrpCod"></tbody>
						</table>
					</div>
						
						
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
