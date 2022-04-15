<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>기업고객 : 주문 이력 조회 (refundRequest)</title>
            <jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
            <link href="${CTX_PATH}/css/epc/style.css" rel="stylesheet" type="text/css">
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
                                    <span class="btn_nav bold">주문 이력 조회</span>
                                </p>

                                <!-- 주문 이력 목록 검색 -->
                                <div id="divSearchOrderList">
                                    <div>
                                        <span>모델명: </span><input type="text" name="searchModelName" id="searchModelName" class="">
                                    </div>
                                    <div>
                                        <span>구매일자: </span>
                                        <input type="date" name="purDateStart" id="purDateStart" class=""> ~
                                        <input type="date" name="purDateEnd" id="purDateEnd" class="">
                                    </div>
                                    <div>
                                        <a href="" class="btnType blue" name="btn" id="btnSearchOrderList"><span>검색</span></a>
                                    </div>
                                </div>
                                <!-- 주문 이력 목록 테이블 -->

                                <div class="orderListContainer">
                                    <table class="col">
                                        <caption>caption</caption>
                                        <colgroup>
                                            <col width="8%">
                                            <col width="8%">
                                            <col width="19%">
                                            <col width="20%">
                                            <col width="20%">
                                            <col width="15%">
                                            <col width="10%">
                                        </colgroup>

                                        <thead>
                                            <tr>
                                                <th scope="col">주문 번호</th>
                                                <th scope="col">주문 수량</th>
                                                <th scope="col">결제 금액</th>
                                                <th scope="col">구매 일자</th>
                                                <th scope="col">배송 희망 날짜</th>
                                                <th scope="col">배송 상태</th>
                                                <th scope="col">반품 신청</th>
                                            </tr>
                                        </thead>
                                        <tbody id="orderListMain"></tbody>
                                    </table>
                                </div>
                                <div class="paging_area" id="orderListPagination"></div>


                                <div class="orderDetailContainer">
                                    <table class="col">
                                        <caption>caption</caption>
                                        <colgroup>
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="12%">
                                            <col width="13%">
                                            <col width="15%">
                                        </colgroup>

                                        <thead>
                                            <tr>
                                                <th scope="col">체크</th>
                                                <th scope="col">반품 수량</th>
                                                <th scope="col">주문 수량</th>
                                                <th scope="col">주문 번호</th>
                                                <th scope="col">장비 구분</th>
                                                <th scope="col">모델명</th>
                                                <th scope="col">제조사</th>
                                                <th scope="col">판매 가격</th>
                                                <th scope="col">결제 금액 ${item.loginID}
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="orderDetailMain"></tbody>
                                    </table>
                                    <div class="paging_area" id="orderDetailListPagination"> </div>

                                    <div style="text-align: right;">
                                        <a href="" name="btn" class="btnType2 color1" id="requestRefund"><span>반품 요청</span></a>
                                    </div>
                                </div>


                                <!-- end of div#content -->
                            </div>
                        </li>
                    </ul>
                </div>
                <input type="hidden" id="currentPageOrderList" value="${currentPageOrderList}" />
                <input type="hidden" id="currentPageOrderDetailList" value="${currentPageOrderDetailList}" />

                <!-- footer 영역 -->
                <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
            </div>

            <!-- modal 영역 -->
            <div id="popRefundinfo" class="layerPop layerType2 p45">
                <dl>
                    <dt>
<strong>반품 요청</strong>
</dt>
                    <dd class="content">
                        <table class="row">
                            <caption>caption</caption>
                            <colgroup>
                                <col width="20%">
                                <col width="20%">
                                <col width="10%">
                                <col width="50%">
                            </colgroup>

                            <tbody id="tableRefundinfo">
                                <form action="" id="formRefundinfo">
                                    <tr>
                                        <th>은행 선택</th>
                                        <td>
                                            <select class="inputTxt p100" name="bank_name"></select>
                                        </td>
                                        <th>계좌 번호</th>
                                        <td><input type="text" class="inputTxt p100" name="account_number" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <th>예금주</th>
                                        <td><input type="text" class="inputTxt p100" name="account_holder" /></td>
                                    </tr>
                                </form>
                            </tbody>

                        </table>

                        <div class="btn_areaC mt30">
                            <a href="" class="btnType blue" id="sendRefund" name="btn"><span>반품</span></a>
                            <a href="" class="btnType gray" id="closeRefundinfo" name="btn"><span>취소</span></a>
                        </div>
                    </dd>
                </dl>
            </div>

            <script>
                const pageBlockSizeOrderList = 5;
                const pageBlockSizeOrderDetailList = 5;

                const getOrderListType = {
                    ready: 0,
                    search: 1
                };

                $(document).ready(function() {
                    getOrderListTbody(getOrderListType.ready);
                    linkEvent();

                });

                function linkEvent() {
                    // $('a[name="btn"]').click(function(e) {
                    //     e.preventDefault();
                    // });
                    // $('a[name="btn"]').on('click', function(e) {    //works
                    //     e.preventDefault();
                    // });
                    $(document).on('click', 'a[name="btn"]', function(e) {
                        e.preventDefault();
                    });
                    eventReturnBtn();
                    eventSearchBtn();
                    eventRequestPopBtn();
                    eventCancelReturnBtn();
                }

                function eventReturnBtn() {
                    $('tbody#orderListMain').on('click', 'input.returnBtn', function(e) {
                        $('#currentPageOrderDetailList').val(1);
                        const row = $(e.currentTarget).parents('tr');
                        const pur_id = row.find('input#pur_id').val();
                        getOrderDetailTbody(pur_id);
                    });
                }

                function eventSearchBtn() {
                    $('#btnSearchOrderList').on('click', function() {
                        getOrderListTbody(getOrderListType.search);
                    });
                }

                function eventRequestPopBtn() {
                    //esc 누를 시에 모달 창 닫기
                    document.addEventListener('keydown', function(e) {
                        if (e.keyCode == '27') {
                            gfCloseModal();
                        }
                    });
                    $('a#requestRefund').click((e) => {
                        popRefendinfoModal();
                    });
                    $('a#closeRefundinfo').click(gfCloseModal);
                    $('a#sendRefund').click(sendRefundRequest);
                }

                function eventCancelReturnBtn() {
                    $('tbody#orderDetailMain').on('click', 'input.cancelRefund', function(e) {
                        const pid = e.currentTarget.parentNode.parentNode.querySelector('.purinf_id').value;
                        $.ajax({
                            url: 'deleteRefundinfoByPurinfID',
                            method: 'POST',
                            data: {
                                purinf_id: pid
                            },
                            success: function(result) {
                                getOrderListTbody(getOrderListType.ready);
                                console.log(result);
                            }
                        });
                    });
                }

                function pageMoveFuncOrderList(currentPage) {
                    $('#currentPageOrderList').val(currentPage);
                    getOrderListTbody(getOrderListType.search);
                }

                function pageMoveFuncOrderDetailList(currentPage) {
                    $('#currentPageOrderDetailList').val(currentPage);
                    getOrderDetailTbody($('input.purinf_id').val());
                }

                function getOrderListTbody(type) {
                    $('tbody#orderListMain').empty();
                    let data = null;
                    const currentPage = $('#currentPageOrderList').val();
                    if (type == getOrderListType.ready) {
                        data = {
                            pageBlockSize: pageBlockSizeOrderList,
                            currentPage: 1
                        };
                        console.log('ready list')
                    } else if (type == getOrderListType.search) {
                        console.log('search list')
                        data = {
                            searchKeyword: $('input#searchModelName').val() || null,
                            dateStart: $('input#purDateStart').val() || null,
                            dateEnd: $('input#purDateEnd').val() || null,
                            currentPage: currentPage,
                            pageBlockSize: pageBlockSizeOrderList
                        };
                        console.log('search param');
                        console.log(data);
                    } else {
                        return;
                    }

                    $.ajax({
                        url: 'getOrderList',
                        data: data,
                        method: 'POST',
                        success: function(result) {
                            $('tbody#orderListMain').append(result);
                            getOrderDetailTbody();
                            createPaginationDiv('orderList');
                            console.log('try1');
                            console.log(result);
                        }
                    });
                }

                function getOrderDetailTbody(purID) {
                    $('tbody#orderDetailMain').empty();
                    if (!purID) {
                        return;
                    } else {
                        const currentPage = $('#currentPageOrderDetailList').val();
                        $.ajax({
                            url: 'getOrderDetail',
                            method: 'POST',
                            data: {
                                purID: purID,
                                currentPage: currentPage,
                                pageBlockSize: pageBlockSizeOrderDetailList
                            },
                            success: function(result) {
                                console.log(result);
                                $('tbody#orderDetailMain').append(result);
                                createPaginationDiv('orderDetailList')
                            }
                        });
                    }
                }

                function popRefendinfoModal() {
                    $.ajax({
                        url: 'getBankNameList',
                        method: 'get',
                        success: function(result) {
                            console.log(result);
                            addBankNameOption(result);
                        }
                    });
                    $('div#popRefundinfo').find('select.bank_name').val(1);
                    $('div#popRefundinfo').find('input[name="account_number"]').val('');
                    $('div#popRefundinfo').find('input[name="account_holder"]').val('');
                    gfModalPop('#popRefundinfo');

                }

                function addBankNameOption(result) {
                    //기존 옵션들 지우기
                    const sel = $('select[name="bank_name"]');
                    sel.empty();
                    //옵션 추가하기
                    result.forEach(item => {
                        const newOpt = document.createElement('option');
                        $(newOpt).html(item);
                        sel.append(newOpt);
                    });
                }


                function sendRefundRequest() {
                    if (confirm("정말 반품하시겠습니까?")) {
                        console.log("ㅇㅋ 진행시켜");
                    } else {
                        console.log("ㄴㄴ 보류");
                        return;
                    }
                    //체크박스 체크된 row들의 purinf_id들만 골라서 list에 담기
                    let checkedPurinfIdList = [];
                    let checkedReturnCntList = [];
                    $('tbody#orderDetailMain>tr').each((index, item) => {
                        const isChecked = $(item).find('input[name="isRefund"]').is(':checked');
                        if (isChecked) {
                            const purinfID = $(item).find('input.purinf_id').val();
                            const returnCnt = $(item).find('input.refund_cnt').val();
                            if (returnCnt < 1) {
                                alert('반품 수량을 확인해 주세요');
                            }
                            checkedPurinfIdList.push(purinfID);
                            checkedReturnCntList.push(returnCnt);
                        }
                    });
                    if (checkedPurinfIdList.length < 1 || checkedReturnCntList.length < 1) {
                        alert('반품할 항목을 선택해 주세요.');
                        return;
                    }
                    console.log('checkedPurinfIdList');
                    console.log(checkedPurinfIdList);
                    console.log('checkedReturnCntList');
                    console.log(checkedReturnCntList);
                    //ajax 보내기
                    $.ajax({
                        url: 'sendRefundRequest',
                        method: 'POST',
                        data: {
                            bank_name: $('select[name="bank_name"]').val(),
                            account_holder: $('input[name="account_holder"]').val(),
                            account_number: parseInt($('input[name="account_number"]').val()),
                            checkedPurinfIdList: checkedPurinfIdList,
                            checkedReturnCntList: checkedReturnCntList
                        },
                        success: (result) => {
                            gfCloseModal();
                            getOrderListTbody(getOrderListType.ready);
                            console.log(result);
                        }
                    });
                    //console 에 param 출력해 보기
                    console.log('ajax param');
                    console.log({
                        bank_name: $('select[name="bank_name"]').val(),
                        account_holder: $('input[name="account_holder"]').val(),
                        account_number: $('input[name="account_number"]').val(),
                        checkedPurinfIdList: checkedPurinfIdList,
                        checkedReturnCntList: checkedReturnCntList
                    });


                }

                function createPaginationDiv(type) {
                    let pdiv = null;
                    let totalCnt = null;
                    let funcName = null;
                    let currentPage = null;
                    switch (type) {
                        case 'orderList':
                            currentPage = $('#currentPageOrderList').val();
                            pdiv = $('#orderListPagination');
                            totalCnt = $('#totalOrderListCnt').val();
                            funcName = 'pageMoveFuncOrderList';
                            break;
                        case 'orderDetailList':
                            currentPage = $('#currentPageOrderDetailList').val();
                            pdiv = $('#orderDetailListPagination');
                            totalCnt = $('#totalOrderDetailListCnt').val() || 1;
                            funcName = 'pageMoveFuncOrderDetailList';
                            break;
                    }

                    const paginationHtml = getPaginationHtml(
                        currentPage,
                        totalCnt,
                        5,
                        pageBlockSizeOrderList,
                        funcName);
                    pdiv.empty().append(paginationHtml);

                }
            </script>
        </body>

        </html>