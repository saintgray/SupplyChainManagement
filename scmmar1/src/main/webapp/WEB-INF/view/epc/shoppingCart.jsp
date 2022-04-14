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
                <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>


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
                                            <col width="3%">
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
                                            <col width="7%">
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
                                <div class="paging_area" id="shoppingCartPagination"> </div>
                                <!-- end of div#content -->
                                <div id="paymentInfo" style="text-align: right; padding-top: 2rem;">
                                    <div><span>장바구니 총액</span></div>
                                    <div><span>_________________</span></div>
                                    <div><span>합계 금액</span><span id="cartTotal">290000</span></div>
                                    <div><a name="btn" class="btnType blue" id="payTotal"><span>주문하기</span></a></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>


                <!-- footer 영역 -->
                <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
            </div>

            <script>
                const pageBlockSizeCartList = 5;
                const pageSizeCartList = 5;
                document.addEventListener('DOMContentLoaded', function() {
                    listCartTable();
                    linkEvents();

                });

                function listCartTable(currentPage) {
                    currentPage = currentPage || 1;
                    $.ajax({
                        url: 'getShoppingCartList',
                        method: 'get',
                        data: {
                            currentPage: currentPage,
                            pageBlockSize: pageBlockSizeCartList
                        },
                        success: function(result) {
                            console.log(result);
                            addRowsToCartTable(result.cartList);
                            createPaginationDiv(currentPage, result.totalCountCartList);
                            updatePayment();
                        }
                    });
                }

                function linkEvents() {
                    //$(document).on('click', 'a.btnType', function(){});
                    document.addEventListener('click', (e) => {
                        console.log("DOMLoaded click event");
                        console.log(e);
                        if (e.target.parentNode.tagName == 'a' && e.target.parentNode.classList.contains('btnType')) {
                            e.preventDefault();
                        }
                    });
                    linkRowChboxClickEvent();
                    linkRowCntChangeEvent();
                    linkRowDeleteBtnEvent();
                    linkPayTotalBtnEvent();
                }

                function addRowsToCartTable(list) {
                    console.log(list);
                    const tbody = document.querySelector('tbody#cartListBody');
                    //$(tbody).empty(); 를 vjs로 바꾼 것
                    while (tbody.firstChild) {
                        tbody.removeChild(tbody.firstChild);
                    }
                    //서버로부터 받아온 리스트 안에서 row를 하나씩 꺼내오기
                    list.forEach((item, index) => {
                        console.log(index + "번째 item");
                        console.log(item);
                        //row 생성 + 속성 부여
                        const newRow = document.createElement('tr');
                        newRow.setAttribute('row-num', index);

                        //row에 column 하나씩 추가
                        newRow.appendChild(createNewCell('checkbox', 'chbox'));
                        newRow.appendChild(createNewCell('img', 'photo', '', {
                            attrName: 'src',
                            attrVal: '/serverfile' + '/kakaoRyan.png'
                        }));
                        // newRow.appendChild(createNewCell('img', 'photo','', {attrName:'src', attrVal:'/serverfile' + item.photo}));
                        newRow.appendChild(createNewCell('text', 'modelNm', item.model_nm));
                        newRow.appendChild(createNewCell('text', 'unitPrice', item.price));
                        newRow.appendChild(createNewCell('number', 'purCnt', item.pur_cnt));
                        newRow.appendChild(createNewCell('text', 'totalPrice', item.price * item.pur_cnt));
                        newRow.appendChild(createNewCell('date', 'wantedDate', item.wanteddate));
                        newRow.appendChild(createNewCell('button', 'delBtn', '삭제'));
                        newRow.appendChild(createNewCell('hidden', 'salesId', item.sales_id));
                        console.log('try4');

                        document.querySelector('#cartListBody').appendChild(newRow);

                    });

                }

                function createNewCell(typeName, className, val, attrInfo) {
                    const cell = document.createElement('td');
                    cell.classList.add(className);
                    //cell.classList.add = "cname";  아니고, add 함수 부르면서 파라미터로 넘겨주기

                    let newInput = document.createElement('input');
                    newInput.type = typeName;
                    if (typeName == 'date') {
                        console.log(newInput.value = val.substring(0, 10));
                        newInput.value = val.substring(0, 10);
                    } else if (val) {
                        newInput.value = val;
                    }
                    //순서가 엄청 중요. img 태그라면 <input>이 아니라 <img>로 요소를 생성해야 하는데, 어느 시점에서 생성할 것인가. 
                    //type과 value까지 넣어준 뒤에, 나중에 보니까 img라면 새로 생성하기. class 는 어쨌든 넣어줘야 하니까, 최대한 마지막에
                    if (typeName == 'img') {
                        newInput = document.createElement('img');
                    }
                    if (attrInfo) {
                        newInput.setAttribute(attrInfo.attrName, attrInfo.attrVal);
                    }
                    //class 넣어주기
                    newInput.classList.add(className);
                    if (typeName == 'img') {
                        newInput.classList.add('w150');
                    } else if (typeName == 'button') {
                        newInput.classList.add('p100');
                    } else if (typeName == 'number') {
                        newInput.setAttribute('min', '0');
                    } else {
                        newInput.classList.add('inputTxt');
                        newInput.classList.add('p92');
                    }
                    //disabled 속성 추가
                    if (typeName == 'text') {
                        newInput.disabled = true;
                    }
                    if (typeName == 'hidden') {
                        return newInput;
                    } else {
                        cell.appendChild(newInput);
                        return cell;
                    }
                }

                function linkRowChboxClickEvent() {
                    const tbody = document.querySelector('tbody#cartListBody');

                    //addEventListener 로 바꾸면 어떻게 돼? 두 번째 파라미터 selector 부분은 어떻게 되는 거?
                    $(tbody).on('change', 'input[type="checkbox"]', function(e) {
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

                function linkPayTotalBtnEvent() {
                    document.querySelector('a#payTotal').addEventListener('click', payTotal);
                }

                function updateRowTotalPrice(e) {
                    console.log('updateRowTotalPrice');
                    const row = e.currentTarget.parentNode.parentNode;
                    const cell = row.querySelector('.totalPrice'); //꼭 document에만 querySelector를 쓸 수 있는 것은 아님. 어떤 요소에 붙여서 그 하위 요소를 찾는 개념.
                    const price = row.querySelector('input.unitPrice').value;
                    const cnt = row.querySelector('input.purCnt').value;
                    cell.value = price * cnt;

                }

                function updatePayment(e) {
                    console.log('updatePayment');
                    let total = 0;
                    const tbody = document.querySelector('tbody#cartListBody');
                    //tbody.childNodes 하면 바로 하위 요소들을 리스트로 불러옴
                    tbody.childNodes.forEach((item, index) => {
                        if (item.tagName == 'TR') { //각 요소가 갖는 속성 중에 tagName 이라는 값이 있음. tr 태그일 때만 계산
                            const chTF = item.querySelector('input.chbox').checked; //checkbox 에서 check 돼 있는지 확인하는 법 - 해당 요소가 'checked' 라는 속성을 들고 있으면 true, 없으면 false
                            console.log(chTF);
                            if (chTF) {
                                const price = item.querySelector('input.unitPrice').value;
                                const cnt = item.querySelector('input.purCnt').value;
                                total += (price * cnt);
                            }
                        }
                    });
                    const payTotal = document.querySelector('div#paymentInfo span#cartTotal');
                    payTotal.innerHTML = total;


                }

                function createPaginationDiv(currentPage, totalCountCartList) {
                    const paginationHtml = getPaginationHtml(
                        currentPage,
                        totalCountCartList,
                        pageSizeCartList,
                        pageBlockSizeCartList,
                        'listCartTable');
                    $("#shoppingCartPagination").empty().append(paginationHtml);
                }


                function deleteCartList(e) {
                    console.log('deleteCartList');
                    if (!confirm('장바구니 목록에서 삭제하시겠습니까?')) {
                        return;
                    }
                    const row = e.currentTarget.parentNode.parentNode;
                    const sales_id = row.querySelector('input.salesId').value;
                    $.ajax({
                        url: 'deleteCartItem',
                        method: 'POST',
                        data: {
                            sales_id: sales_id
                        },
                        success: function(result) {
                            listCartTable();
                        }
                    });

                }

                function payTotal() {
                    console.log('paytotal');
                    let dataList = [];
                    const tbChild = document.querySelector('tbody#cartListBody').childNodes;
                    tbChild.forEach(function(item, index) {
                        if (item.tagName == 'TR') {
                            const chbox = item.querySelector('td.chbox input[type="checkbox"]');
                            if (chbox.checked) {
                                const cnt = item.querySelector('input.purCnt').value;
                                const wanted_date = item.querySelector('input.wantedDate').value;
                                const sales_id = item.querySelector('input.salesId').value;

                                dataList.push({
                                    pur_cnt: cnt,
                                    wanted_date: wanted_date,
                                    sales_id: sales_id
                                });
                            }
                        }
                    });
                    console.log(dataList);

                    if (dataList.length < 1) {
                        alert('주문할 상품을 선택해 주세요');
                        return;
                    } else if (!confirm('입금하시겠습니까?')) {
                        return;
                    } else {
                        $.ajax({
                            url: 'payCart',
                            data: {
                                param: JSON.stringify(dataList)
                            },
                            method: 'POST',
                            success: function(result) {
                                console.log('ajax pay succ');
                                listCartTable();
                            }
                        });
                    }
                }
            </script>
        </body>

        </html>