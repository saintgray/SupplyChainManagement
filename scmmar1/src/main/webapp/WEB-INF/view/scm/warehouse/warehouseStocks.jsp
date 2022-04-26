<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>창고별 재고 현황</title>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<style>


#detailArea{
	margin:20px auto;
	padding:0;
	animation:showUp .7s ease-out;
}
#whlist>tr{
	cursor:pointer;
}
#whlist>tr.blur{
	animation : blur normal 2s infinite ease-in-out;
}
@keyframes blur{
	0%{
		background-color:white;
	}
	50%{
		background-color:#fafa5f;
	}
	100%{
		background-color:white;
	}
}
@keyframes showUp{
	0%{
		opacity:0;
		transform:translateX(-100%);
	}
	100%{
		opacity:1;
		transform:translateX(0);
	}
}

</style>

</head>
<body>
<form id="myForm" action=""  method="">
    <input type="hidden" name="selfrpcd" id="selfrpcd" value="">
    <input type="hidden" name="selfrpnm" id="selfrpnm" value="">
	
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
								class="btn_nav bold">Sample</span> <span class="btn_nav bold">창고별 재고 현황</span> 
								<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>창고별 재고 현황</span> 
							<span class="fr">
							     <select id="searchgrouptype"  name="searchgrouptype" style="width: 150px;">
							            <option value="" >전체</option>
							    		<option value="0" >창고 명</option>
							    		<option value="1" >제품 명</option>
							     </select> 
							     <input type="text" id="searchtext">
	                              <a class="btnType blue" id="btnSearchGrpcod" name="btn" style="cursor: pointer;"><span onclick="search()" >검  색</span></a>
	                              <a href= ""class="btnType blue" id="btnSearchGrpcod" name="btn" style="cursor: pointer;"><span >초기화</span></a>
	                             
							</span>
    
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<thead>
									<tr>
										<th scope="col">창고 코드</th>
										<th scope="col">창고명</th>
										<th scope="col">총 재고량</th>
										<th scope="col">지역</th>
										<th scope="col">주소</th>
									</tr>
								</thead>
								<tbody id="whlist"></tbody>
							</table>
						</div>
						<div class="paging_area"  id="comnGrpCodPagination"> </div>
					</div>

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>



<!-- DECREPATED -->
<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 800px;">

		<dl>
			<dt>
				<strong>제고 입/출 내역</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					
					<tbody>
						<tr>
							<th >제품 번호</th>
							<th >제품 명</th>
							<th >입고 량</th>
							<th >출고 량</th>
						</tr>
						<tr>
							<td><input type="text" id="sales_id" readonly="readonly" style="text-align: center; border: none;"></td>
							<td><input type="text" id="sales_nm" readonly="readonly" style="text-align: center; border: none;"></td>
							<td><input type="text" id="insal" readonly="readonly" style="text-align: center; border: none;"></td>
							<td><input type="text" id="outsal" readonly="readonly" style="text-align: center; border: none;"></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span >취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	
</form>
</body>
<%@ include file="/WEB-INF/view/scm/warehouse/pageset/warehouseStocksPageset.jsp" %>
</html>