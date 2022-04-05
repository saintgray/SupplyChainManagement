<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>기업고객 : 제품 목록 (ProductList)</title>
            <jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
            <link href="${CTX_PATH}/css/epc/style.css" rel="stylesheet" type="text/css">
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
                                    <span class="btn_nav bold">제품목록</span>
                                </p>

                                <!-- 상품 검색창 -->
                                <div id="divSearchProduct">
                                    <select id="sales_type">
                                        <option>전체</option>
                                    </select>
                                    <select id="mfcomp">
                                        <option>전체</option>
                                    </select>
                                    <input type="text" class="inputTxt p15" id="schKeyword" value="test">
                                    <a href="" class="btnType blue" name="btn" id="searchProductList"><span>검색</span></a>
                                    <button onclick="" id="testBtn">run test</button>
                                </div>


                                <!-- 상품 목록 테이블 -->
                                <div id="divProductListTable">
                                    <table class="col">
                                        <caption>caption</caption>
                                        <colgroup>
                                            <col width="10%">
                                            <col width="15%">
                                            <col width="20%">
                                            <col width="15%">
                                            <col width="15%">
                                            <col width="20%">
                                        </colgroup>

                                        <thead>
                                            <tr>
                                                <th scope="col">장비 번호</th>
                                                <th scope="col">장비 구분</th>
                                                <th scope="col">모델 번호</th>
                                                <th scope="col">모델명</th>
                                                <th scope="col">제조사</th>
                                                <th scope="col">판매가격</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyProductListTable">
                                        </tbody>
                                    </table>
                                </div>
                                <!-- 페이지네이션 -->
                                <div class="paging_area" id="comnGrpCodPagination">
                                    ${pageContext.request.contextPath}

                                    <!-- 페이지네이션 끝 -->
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
                <!-- end of div#wrap_area -->
            </div>

            <div id="popProductDetail" class="layerPop layerType2 p45">
                <dl>
                    <dt>
<strong>제품 상세 보기</strong>
</dt>
                    <dd class="content">

                        <div style="text-align: right;">
                            <span name="sales_id"></span> | <span name="sales_type"></span>
                        </div>

                        <table class="row">
                            <caption>caption</caption>
                            <colgroup>
                                <col width="25%">
                                <col width="15%">
                                <col width="20%">
                                <col width="15%">
                                <col width="25%">
                            </colgroup>

                            <tbody id="tbodyProductDetail">
                                <form action="" id="formDetail">
                                    <tr>
                                        <td rowspan="3">
                                            <img id="productDetailImg">이미지
                                        </td>
                                        <th>모델 번호</th>
                                        <td colspan="1"><input type="text" class="inputTxt p100" name="model_code" /></td>
                                        <th>판매 가격</th>
                                        <td colspan="1"><input type="text" class="inputTxt p100" name="price" /></td>
                                    </tr>
                                    <tr>
                                        <th>모델명</th>
                                        <td colspan="1"><input type="text" class="inputTxt p100" name="sales_nm" /></td>
                                        <th>주문 수량</th>
                                        <td colspan="1"><input type="number" class="inputTxt p100" name="pur_cnt" /></td>
                                    </tr>
                                    <tr>
                                        <th>제조사</th>
                                        <td colspan="1"><input type="text" class="inputTxt p100" name="mfcomp" /></td>
                                        <th>납품 희망 일자</th>
                                        <td colspan="1"><input type="date" class="inputTxt p100" name="wanted_date" /></td>
                                    </tr>
                                </form>
                            </tbody>

                        </table>


                        <div class="popDetail">상세 정보</div>
                        <textarea>test message</textarea>

                        <div class="btn_areaC mt30">
                            <a href="" class="btnType blue" id="putCartProduct" name="btn"><span>장바구니에 담기</span></a>
                            <a href="" class="btnType blue" id="orderProduct" name="btn"><span>주문</span></a>
                            <a href="" class="btnType gray" id="closeProductDetail" name="btn"><span>취소</span></a>
                            <button onclick="testFunc2()" id="testbtn2">run2 test2</button>
                        </div>
                    </dd>
                </dl>
            </div>

            <script>
                $(function() {
                    $.ajax({
                        url: "getProductList",
                        method: "GET",
                        success: function(result) {
                            inputProductListRows(result);
                        }
                    });
                    linkEventFunc();
                    getSalesTypeList();
                    getMfcompList();
                });

                function testFunc() {
                    // console.log(document.querySelector('#sales_type').options['selectedIndex']);
                    // alert('test passed');
                    $.ajax({
                        url: 'orderProduct',
                        method: 'POST',
                        data: {
                            saled_id: saled_id,
                            order_cnt: order_cnt,
                            wanted_date: wanted_date
                        },
                        success: function(result) {
                            console.log(result);
                        }
                    });
                }


                function linkEventFunc() {
                    let aBtn = document.querySelectorAll('a[name="btn"]');
                    aBtn.forEach((ele) => {
                        ele.addEventListener('click', (e) => {
                            e.preventDefault();
                        });
                    });
                    // same code as above line
                    // $('a[name="btn"]').click(function(e) {
                    //     e.preventDefault();
                    // });

                    eventProductListRow();
                    eventSelectSalesTypeChange();
                    eventOrderAndCartBtn();
                    eventSearchBtn();
                    eventCloseBtn();
                }


                function plmodal(item) {
                    console.log(item);
                    console.log($('tbody#tbodyProductDetail input[name="model_code"]'));

                    $('div#popProductDetail span[name="sales_id"]').html(item.sales_id);
                    $('div#popProductDetail span[name="sales_type"]').html(item.sales_type);
                    $('tbody#tbodyProductDetail input[name="model_code"]').attr({
                        value: item.model_code
                    });
                    $('tbody#tbodyProductDetail input[name="sales_nm"]').attr({
                        value: item.sales_nm
                    });
                    $('tbody#tbodyProductDetail input[name="mfcomp"]').attr({
                        value: item.mfcomp
                    });
                    $('tbody#tbodyProductDetail input[name="price"]').attr({
                        value: item.price
                    });
                    $('img#productDetailImg').attr({
                        src: "/serverfile/kakaoRyan.png"
                    });
                    gfModalPop('#popProductDetail');
                }

                function inputProductListRows(productList) {
                    $('tbody#tbodyProductListTable').empty();
                    $.each(productList, function(index, item) {
                        let newRow = '  <tr class="rowProductList" name="' + index + '" row-num="' + index + '">';
                        newRow += '     <td name="sales_id">';
                        newRow += item.sales_id;
                        newRow += '     </td>';
                        newRow += '     <td name="sales_type">';
                        newRow += item.sales_type;
                        newRow += '     </td>';
                        newRow += '     <td name="model_code">';
                        newRow += item.model_code;
                        newRow += '     </td>';
                        newRow += '     <td name="model_nm">';
                        newRow += item.model_nm;
                        newRow += '     </td>';
                        newRow += '     <td name="mfcomp">';
                        newRow += item.mfcomp;
                        newRow += '     </td>';
                        newRow += '     <td name="price">';
                        newRow += item.price;
                        newRow += '     </td>';
                        newRow += ' </tr>';
                        $('#tbodyProductListTable').append($(newRow));
                    });
                }

                function eventProductListRow() {
                    $('tbody#tbodyProductListTable').on('click', '.rowProductList', function(e) {
                        let rowNum = e.currentTarget.attributes['row-num'].value;
                        getProductDetail(rowNum);
                    });
                }

                function eventSelectSalesTypeChange() {
                    let sel = document.querySelector('#sales_type');
                    sel.onchange = getMfcompList;
                }

                function getProductDetail(rowNum) {
                    $.ajax({
                        url: 'getProductDetail',
                        method: 'GET',
                        data: {
                            sales_id: rowNum
                        },
                        success: function(result) {
                            plmodal(result);
                        }
                    });
                }

                function getSalesTypeList() {
                    $.ajax({
                        url: 'getSalesTypeList',
                        method: 'GET',
                        success: function(result) {
                            listSelectOptionSalesType(result);
                        }
                    });
                }

                function getMfcompList() {
                    while (document.querySelector('select#mfcomp').firstChild) { //empty options in select mfcomp 
                        console.log(document.querySelector('select#mfcomp').firstChild);
                        document.querySelector('select#mfcomp').removeChild(document.querySelector('select#mfcomp').firstChild);
                    }

                    const sel = document.querySelector('select#sales_type');
                    let salesType = sel.options[sel.options.selectedIndex].value; //get selected option in select sales_type
                    if (salesType == '전체') {
                        salesType = '%';
                    }
                    $.ajax({
                        url: 'getMfcompList',
                        method: 'POST',
                        data: {
                            salesType: salesType
                        },
                        success: function(result) {
                            listSelectOptionMfcomp(result);
                        }
                    });

                }

                function listSelectOptionSalesType(list) {
                    let sel = document.querySelector('#sales_type');
                    list.forEach(function(item, index) {
                        let newOption = document.createElement('option');
                        let inner = document.createTextNode(item);
                        newOption.setAttribute('num', index);
                        newOption.appendChild(inner);
                        sel.appendChild(newOption);
                    });

                }

                function listSelectOptionMfcomp(list) {
                    let newOption = '<option>';
                    newOption += '전체';
                    newOption += '</option>';
                    $(newOption).appendTo($('select#mfcomp'));
                    $.each(list, function(index, item) {
                        let newOption = '<option>';
                        newOption += item;
                        newOption += '</option>';
                        $(newOption).appendTo($('select#mfcomp'));
                        // $('select#mfcomp').append($(newOption)); same as upper line
                    });
                }

                function eventSearchBtn() {
                    const btn = document.querySelector('a#searchProductList');
                    btn.onclick = searchProductList;
                }

                function searchProductList() {
                    const salesOpt = document.querySelector('select#sales_type').options;
                    let salesType = salesOpt[salesOpt.selectedIndex].value;
                    let mfcomp = document.querySelector('select#mfcomp').options[document.querySelector('select#mfcomp').options.selectedIndex].value;
                    const keyword = document.querySelector('input#schKeyword').value;

                    if (mfcomp == '전체') {
                        mfcomp = '%';
                    }

                    if (salesType == '전체') {
                        salesType = '%';
                    }

                    $.ajax({
                        url: 'searchProductList',
                        data: {
                            salesType: salesType,
                            mfcomp: mfcomp,
                            keyword: keyword
                        },
                        method: 'POST',
                        success: function(result) {
                            inputProductListRows(result);
                        }
                    });

                }

                function testFunc2(e) {

                    let salesId = $('div#popProductDetail span[name="sales_id"]').html();
                    let purCnt = document.querySelector('div#popProductDetail input[name="pur_cnt"]').value;
                    let wantedDate = $('div#popProductDetail input[name="wanted_date"]').val();

                    console.log(salesId);
                    console.log(purCnt);
                    console.log(wantedDate);
                }

                function eventCloseBtn() {
                    const btn = document.querySelector('a#closeProductDetail');
                    btn.onclick = gfCloseModal;

                }


                function eventOrderAndCartBtn() {
                    const cartBtn = document.querySelector('a#putCartProduct');
                    const orderBtn = document.querySelector('a#orderProduct');
                    cartBtn.onclick = orderAndCart;
                    orderBtn.onclick = orderAndCart;

                }


                function orderAndCart(e) {
                    const salesId = $('div#popProductDetail span[name="sales_id"]').html();
                    const purCnt = document.querySelector('div#popProductDetail input[name="pur_cnt"]').value;
                    const wantedDate = $('div#popProductDetail input[name="wanted_date"]').val();
                    let type = '';

                    if (!purCnt || !wantedDate) {
                        alert('수량 또는 날짜를 확인해 주세요.3');
                        return;
                    } else {
                        if (e.currentTarget.id == 'putCartProduct') {
                            type = 'cart';
                        } else if (e.currentTarget.id == 'orderProduct') {
                            type = 'order';
                        } else {
                            alert('잘못된 접근입니다.');
                            return;
                        }
                    }

                    $.ajax({
                        url: 'orderProduct',
                        method: 'POST',
                        data: {
                            saled_id: salesId,
                            pur_cnt: purCnt,
                            wanted_date: wantedDate,
                            type: type
                        },
                        success: function(result) {
                            console.log(result);
                        }
                    });

                }
            </script>
        </body>

        </html>