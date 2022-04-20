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
                <input type="hidden" name="action" id="currentPageProductList" value="${currentPageProductList}">

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
                                    <input type="text" class="inputTxt p15" id="schKeyword" value="" placeholder="검색어를 입력해 주세요.">
                                    <a href="" class="btnType blue" name="btn" id="searchProductList"><span>검색</span></a>
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
                                <div class="paging_area" id="productListPagination">
                                    ${pageContext.request.contextPath}

                                    <!-- 페이지네이션 끝 -->
                                </div>


                                <!-- end of div#content -->
                            </div>

                        </li>
                    </ul>
                </div>


                <!-- footer 영역 -->
                <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
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
                                            <img id="productDetailImg" style="width: 100%; height: auto;">이미지
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
                                        <td colspan="1"><input type="number" min="1" class="inputTxt p100" name="pur_cnt" /></td>
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
                        <textarea></textarea>

                        <div class="btn_areaC mt30">
                            <a href="" class="btnType blue" id="putCartProduct" name="btn"><span>장바구니에 담기</span></a>
                            <a href="" class="btnType blue" id="orderProduct" name="btn"><span>주문</span></a>
                            <a href="" class="btnType gray" id="closeProductDetail" name="btn"><span>취소</span></a>
                        </div>
                    </dd>
                </dl>
            </div>

            <script>
                const pageSizeProductList = 5
                const pageBlockSizeProductList = 5;

                $(function() {
                    getProductList();
                    getSalesTypeList();
                    getMfcompList();
                    linkEventFunc();
                });


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
                    console.log('plmodal');
                    console.log(item);
                    $('div#popProductDetail span[name="sales_id"]').html(item.sales_id);
                    $('div#popProductDetail span[name="sales_type"]').html(item.sales_type);
                    $('tbody#tbodyProductDetail input[name="model_code"]').val(item.model_code);
                    $('tbody#tbodyProductDetail input[name="sales_nm"]').val(item.sales_nm);
                    $('tbody#tbodyProductDetail input[name="mfcomp"]').val(item.mfcomp);
                    $('tbody#tbodyProductDetail input[name="price"]').val(item.price.toLocaleString());
                    $('tbody#tbodyProductDetail input[name="pur_cnt"]').val(1);
                    $('tbody#tbodyProductDetail input[name="wanted_date"]').val(dateFormatter(new Date()));
                    $('div#popProductDetail textarea').html(item.info);
                    $('img#productDetailImg').attr({
                        src: item.file_server_path ? item.file_server_path : "/serverfile/kakaoRyan.png"
                    });

                    const inputList = $('tbody#tbodyProductDetail').find('input');
                    inputList.each((index, item) => {
                        if (item.type == 'text') {
                            item.disabled = true;
                        }
                    });
                    document.querySelector('div#popProductDetail textarea').disabled = true;
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
                        newRow += item.price.toLocaleString(); //with decimal comma 
                        newRow += '     </td>';
                        newRow += ' </tr>';
                        $('#tbodyProductListTable').append($(newRow));
                        console.log('newRow');
                        console.log(newRow);
                    });

                }

                function eventProductListRow() {
                    $('tbody#tbodyProductListTable').on('click', '.rowProductList', function(e) {
                        let rowNum = e.currentTarget.attributes['row-num'].value;
                        const salesID = $(e.currentTarget).find('td[name="sales_id"]').html();
                        console.log('salesID');
                        console.log(salesID);
                        getProductDetail(rowNum);
                    });
                }

                function eventSelectSalesTypeChange() {
                    let sel = document.querySelector('#sales_type');
                    sel.onchange = getMfcompList;
                }

                function getProductDetail(rowNum) {
                    const row = document.querySelector('tr[row-num="' + rowNum + '"]');
                    const salesID = row.querySelector('td[name="sales_id"]').innerText;
                    console.log('salesID');
                    console.log(salesID);
                    $.ajax({
                        url: 'getProductDetail',
                        method: 'POST',
                        data: {
                            sales_id: salesID
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

                function dateFormatter(now) {
                    const year = now.getFullYear() < 10 ? '0' + now.getFullYear() : now.getFullYear();
                    const month = now.getMonth() + 1 < 10 ? '0' + (now.getMonth() + 1) : (now.getMonth() + 1);
                    const day = now.getDate() < 10 ? '0' + now.getDate() : now.getDate();
                    return year + '-' + month + '-' + day;
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
                    btn.onclick = getProductList;
                }

                function pageMoveFunc(currentPage) {
                    document.querySelector('#currentPageProductList').value = currentPage;
                    getProductList();
                }

                function getProductList() {
                    const salesOpt = document.querySelector('select#sales_type').options;
                    let salesType = salesOpt[salesOpt.selectedIndex].value;
                    let mfcomp = document.querySelector('select#mfcomp').options[document.querySelector('select#mfcomp').options.selectedIndex].value;
                    let keyword = document.querySelector('input#schKeyword').value;
                    const currentPagePL = $('#currentPageProductList').val();
                    if (mfcomp == '전체') {
                        mfcomp = '%';
                    }

                    if (salesType == '전체') {
                        salesType = '%';
                    }

                    if (keyword == '') {
                        keyword = '%';
                    }

                    $.ajax({
                        url: 'getProductList',
                        data: {
                            salesType: salesType,
                            mfcomp: mfcomp,
                            keywordProductList: keyword,
                            currentPage: currentPagePL,
                            pageBlockSize: pageSizeProductList,
                        },
                        method: 'POST',
                        success: function(result) {
                            console.log('getProductList');
                            console.log(result);
                            inputProductListRows(result.list);
                            createPaginationDiv(currentPagePL, result.totalCntProductList);
                        }
                    });

                }

                function eventCloseBtn() {
                    const btn = document.querySelector('a#closeProductDetail');
                    btn.onclick = gfCloseModal;
                    //esc 누를 시에 모달 창 닫기
                    document.addEventListener('keydown', function(e) {
                        if (e.keyCode == '27') {
                            gfCloseModal();
                        }
                    });
                }


                function eventOrderAndCartBtn() {
                    const cartBtn = document.querySelector('a#putCartProduct');
                    const orderBtn = document.querySelector('a#orderProduct');
                    cartBtn.onclick = orderAndCart;
                    orderBtn.onclick = orderAndCart;

                }

                function createPaginationDiv(currentPage, totalCnt) {
                    const paginationHtml = getPaginationHtml(
                        currentPage,
                        totalCnt,
                        pageSizeProductList,
                        pageBlockSizeProductList,
                        'pageMoveFunc');
                    $("#productListPagination").empty().append(paginationHtml);
                }

                function orderAndCart(e) {
                    const salesId = $('div#popProductDetail span[name="sales_id"]').html();
                    const purCnt = document.querySelector('div#popProductDetail input[name="pur_cnt"]').value;
                    const wantedDate = $('div#popProductDetail input[name="wanted_date"]').val();
                    let type = '';
                    const existCheckType = {
                        doesntExist: -1,
                        salesExistDateDifferent: 0,
                        alreadyExist: 1
                    };
                    let existCheck = existCheckType.doesntExist;
                    // existCheck 설명
                    // -1 : doesnt exist
                    // 0 : same product diffrent date
                    // 1 : same product same date

                    const now = new Date();
                    const wanted = new Date(wantedDate);


                    if (wanted < now.addDays(3)) {
                        alert('최소 3일 후부터 선택해주세요.');
                        return;
                    } else if (purCnt < 1) {
                        alert('수량을 확인해 주세요.');

                    } else {
                        if (e.currentTarget.id == 'putCartProduct') {
                            if (!confirm('장바구니에 추가하시겠습니까?')) {
                                return;
                            }
                            type = 'cart';
                        } else if (e.currentTarget.id == 'orderProduct') {
                            if (!confirm('주문하시겠습니까?')) {
                                return;
                            }
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
                            sales_id: salesId,
                            pur_cnt: purCnt,
                            wanted_date: wantedDate,
                            type: type
                        },
                        success: function(result) {
                            switch (result) {
                                case existCheckType.doesntExist:
                                    console.log('상품 없고 날짜 없고');
                                case existCheckType.salesExistDateDifferent:
                                    console.log('상품 있고 날짜 없고');
                                    alert('상품을 장바구니에 추가했습니다.');
                                    break;
                                case existCheckType.alreadyExist:
                                    console.log('상품 있고 날짜 있고');
                                    alert('상품 주문 개수를 추가했습니다.');
                                    break;
                            }
                            gfCloseModal();
                            getProductList(1);
                            console.log(result);
                        }
                    });
                }

                Date.prototype.addDays = function(days) {
                    const date = new Date(this.valueOf());
                    date.setDate(date.getDate() + days);
                    return date;
                }
            </script>
        </body>

        </html>