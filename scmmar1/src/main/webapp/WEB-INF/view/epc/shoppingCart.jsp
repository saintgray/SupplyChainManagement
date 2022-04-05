<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>기업고객 : 장바구니 목록 (Shopping Cart)</title>
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
                                <!-- 주문 이력 목록 테이블 -->
                                <div class="cartListMain">
                                    <table class="col">
                                        <caption>caption</caption>
                                        <colgroup>
                                            <col width="5%">
                                            <!--선택-->
                                            <col width="20%">
                                            <!--사진-->
                                            <col width="15%">
                                            <!--모델명-->
                                            <col width="15%">
                                            <!--가격-->
                                            <col width="10%">
                                            <!--수량-->
                                            <col width="15%">
                                            <!--총 금액-->
                                            <col width="15%">
                                            <!--납품 희망 일자-->
                                            <col width="5%">
                                            <!--삭제-->
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
                                        <tbody id="cartListBody"></tbody>
                                    </table>
                                </div>
                                <div class="paging_area" id="comnGrpCodPagination"> </div>
                                <!-- end of div#content -->
                                <div id="paymentInfo" style="text-align: right; padding-top: 2rem;">
                                    <div><span>장바구니 총액</span></div>
                                    <div><span>_________________</span></div>
                                    <div><span>합계 금액</span><span id="cartTotal">290000</span></div>
                                    <div><span><button>입금하기</button></span></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>


                <!-- footer 영역 -->
                -- footer
                <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
                footer --
            </div>

            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    listCartTable();
                    linkEvents();
                });

                function listCartTable() {
                    $.ajax({
                        url: 'getShoppingCartList',
                        method: 'get',
                        success: function(result) {
                            addRowsToCartTable(result);
                        }
                    });
                }

                function linkEvents() {
                    linkRowChboxClickEvent();
                    linkRowCntChangeEvent();
                    linkRowDeleteBtnEvent();
                }

                function addRowsToCartTable(list) {
                    console.log(list);
                    const tbody = document.querySelector('tbody#cartListBody');
                    while (tbody.firstChild) { //$(tbody).empty(); => js
                        tbody.removeChile(tbody.firstChild);
                    }
                    list.forEach((item, index) => {
                        const newRow = document.createElement('tr');
                        newRow.setAttribute('row-num', index)
                        newRow.appendChild(newCell('input', 'checkbox', 'chbox'));
                        newRow.appendChild(newCell('img', item.photo, 'photo'));
                        newRow.appendChild(newCell('text', item.model_nm, 'modelNm'));
                        newRow.appendChild(newCell('text', item.price, 'unitPrice'));
                        newRow.appendChild(newCell('input', 'number', 'purCnt', item.pur_cnt, ));
                        newRow.appendChild(newCell('text', item.price * item.pur_cnt, 'totalPrice'));
                        newRow.appendChild(newCell('text', item.wanteddate, 'wantedDate'));
                        newRow.appendChild(newCell('button', '삭제', 'delBtn'));
                        newRow.appendChild(newCell('input', 'hidden', 'salesId', item.sales_id));


                        document.querySelector('#cartListBody').appendChild(newRow);

                    });

                }

                function newCell(tagName, attrVal, className, val) {
                    const cell = document.createElement('td');
                    cell.classList.add(className); //cell.classList.add = "cname";  아니고, add 함수 부르면서 파라미터로 넘겨주기
                    if (tagName == 'input') {
                        const newInput = document.createElement('input');
                        newInput.classList.add(className);
                        newInput.type = attrVal;
                        if (attrVal == 'hidden') {
                            newInput.value = val;
                            return newInput;
                        }
                        cell.appendChild(newInput);
                    } else if (tagName == 'text') {
                        cell.innerHTML = attrVal;
                    } else if (tagName == 'img') {
                        const newImg = document.createElement('img');
                        // newImg.src = '/serverfile'+attrVal;
                        newImg.src = '/serverfile' + '/kakaoRyan.png';
                        cell.appendChild(newImg);
                    } else if (tagName == 'button') {
                        const btn = document.createElement('button');
                        btn.innerHTML = attrVal;
                        cell.appendChild(btn);
                    }
                    if (val) {
                        cell.value = val;
                    }
                    return cell;
                }

                function linkRowChboxClickEvent() {
                    const tbody = document.querySelector('tbody#cartListBody');
                    $(tbody).on('change', 'input[type="checkbox"]', function(e) { //addEventListener 로 바꾸면 어떻게 돼? 두 번째 파라미터 selector 부분은 어떻게 되는 거?
                        console.log('linkRowChboxClickEvent');
                        updatePayment(e);
                    });
                }

                function linkRowCntChangeEvent() {
                    console.log('linkRowCntChangeEvent');
                    const tbody = document.querySelector('tbody#cartListBody');
                    $(tbody).on('change', 'input[type="number"]', function(e) {
                        updateRowTotalPrice(e);
                        updatePayment(e);
                    });
                }

                function linkRowDeleteBtnEvent() {
                    $('tbody#cartListBody').on('click', 'tr td.delBtn', function(e) {
                        deleteCartList(e);
                    })
                }

                function updateRowTotalPrice(e) {
                    console.log('updateRowTotalPrice');
                    const row = e.currentTarget.parentNode.parentNode;
                    const cell = row.querySelector('.totalPrice'); //꼭 document에만 querySelector를 쓸 수 있는 것은 아님. 어떤 요소에 붙여서 그 하위 요소를 찾는 개념.
                    const price = row.querySelector('.unitPrice').innerHTML;
                    const cnt = row.querySelector('.purCnt>input').value;
                    cell.innerHTML = price * cnt;

                }

                function updatePayment(e) {
                    console.log('updatePayment');
                    let total = 0;
                    const tbody = document.querySelector('tbody#cartListBody');
                    //tbody.childNodes 하면 바로 하위 요소들을 리스트로 불러옴
                    tbody.childNodes.forEach((item, index) => {
                        if (item.tagName == 'TR') { //각 요소가 갖는 속성 중에 tagName 이라는 값이 있음. tr 태그일 때만 계산
                            const chTF = item.querySelector('.chbox>input').checked; //checkbox 에서 check 돼 있는지 확인하는 법 - 해당 요소가 'checked' 라는 속성을 들고 있으면 true, 없으면 false
                            console.log(chTF);
                            if (chTF) {
                                const price = item.querySelector('.unitPrice').innerHTML;
                                const cnt = item.querySelector('.purCnt>input').value;
                                total += (price * cnt);
                            }
                        }
                    });
                    const payTotal = document.querySelector('div#paymentInfo span#cartTotal');
                    payTotal.innerHTML = total;


                }


                function deleteCartList(e) {
                    console.log('deleteCartList');
                    const row = e.currentTarget.parentNode.parentNode;
                    const sales_id = row.querySelector('input.salesId').value;
                    $.ajax({
                        url: 'deleteCartItem',
                        method: 'POST',
                        data: {
                            sales_id: sales_id
                        },
                        success: listCartTable
                    });

                }
            </script>
        </body>

        </html>