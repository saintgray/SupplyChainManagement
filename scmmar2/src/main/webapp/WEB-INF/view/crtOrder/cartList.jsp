
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${empty cartList}">
	<tr>
		<td colspan="9">장바구니에 담긴 상품이 없습니다.</td>
	</tr>
</c:if>

<c:if test="${not empty cartList}">
	<c:forEach items="${cartList}" var="list" varStatus="i">

		<tr>

			<td>
				<form id="myForm" action="" method="">
					<input type="checkbox" name="choicepd" id="choicepd"> <input
						type="hidden" name="cartno" value="${list.cartno}"> <input
						type="hidden" name="orderamount" value="${list.cartamount}">
					<input type="hidden" name="oddtcnt" id="oddtcnt"
						value="${list.cartcnt}" /> <input type="hidden" name="pdcode"
						value="${list.pdcode}" /> <input type="hidden" name="pdmdno"
						value="${list.pdmdno}" /> <input type="hidden" name="pdno"
						value="${list.pdno}" /> <input type="hidden" name="orderamountAll"
						value="" /> <input type="hidden" name="ordercntAll" value="" /> <input
						type="hidden" name="oddthopedate" value="">
				</form>
			</td>
			<td><img style="width: 120px; height: 120px;" id="f-photo-image" src="${list.file_server_path}"></td>
			<td id="pdmdnm">${list.pdmdnm}</td>
			<td><input type="hidden" name="pdmdprice" id="pdmdprice"
				value="${list.pdmdprice}">${list.pdmdprice}</td>
			<td name="orderamountTr"><input type="number" min="1"
				id="ordercnt" name="ordercnt" value="${list.cartcnt}"
				onchange="changeAmount(this);"> <input type="hidden"
				name="orderamount" id="orderamount" value="${list.cartamount}">
			</td>
			<td>${list.pdmdprice * list.cartcnt}</td>
			<td name="carthopedateTr"><input class="datetype"
				style="width: 120px" id="carthopedate${i.count }"
				name="carthopedate" readonly value="${list.carthopedate}"></td>
			<td><button type="button" onclick="fDeleteCart('${list.cartno}');" class="btnDeleteCart blue"><span>삭제</span></button></td>

		</tr>
		<script>
											 $.datepicker.setDefaults($.datepicker.regional['ko']); 
										 	    $("#carthopedate${i.count }").datepicker({
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
										 	         minDate:0,
										 	      });
										 		
												$("[name=choicepd]").click(function(){
											 		var tot = 0 ;
											 		$("[name=choicepd]:checked").each(function(e){ 			
											 			var val = $(this).parent().parent().parent().find("[name=orderamountTr]").find("#orderamount").val();
											 			tot += Number(val);		
											 		});
											 		$("#totPrice").html(tot);
											 	});
												
											
												
											</script>
	</c:forEach>
</c:if>