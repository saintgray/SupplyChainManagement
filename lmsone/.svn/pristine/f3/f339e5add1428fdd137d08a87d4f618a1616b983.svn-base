<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

      <div class="divEmpty">
            <div class="hiddenData">
                <span id="totalCntAward">${totalCntAward}</span>
            </div>
            <table class="col">
             <thead>
                  <tr>
                    <th scope="col">상장명</th>
                    <th scope="col">수상일자</th>
                  </tr>
                </thead>
              <tbody id="awardList">
              <c:if test="${totalCntAward eq 0 }">
                <tr>
                  <td colspan="12">데이터가 존재하지 않습니다.</td>
                </tr>
              </c:if>
              <c:set var="nRow" value="${pageSize*(currentPageAward-1)}" />
              <c:forEach items="${listAward}" var="list">
                <tr>
                    <td><a href="javascript:fSelectAward('${list.award_no}')">${list.award_nm}</a></td>
                    <td>${list.award_date}</td>
                  </tr>
                <c:set var="nRow" value="${nRow + 1}" />
              </c:forEach>
              </tbody>
            </table>
          </div>
