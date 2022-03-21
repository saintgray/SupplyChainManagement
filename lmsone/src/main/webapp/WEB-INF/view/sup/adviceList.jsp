<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

      <div class="divEmpty">
            <div class="hiddenData">
                <span id="totalCntAdvice">${totalCntAdvice}</span>
            </div>
            <table class="col">
             <thead>
                  <tr>
                    <th scope="col">상담일자</th>
                    <th scope="col">상담장소</th>
                    <th scope="col">상담자</th>
                  </tr>
                </thead>
              <tbody id="adviceList">
              <c:if test="${totalCntAdvice eq 0 }">
                <tr>
                  <td colspan="12">데이터가 존재하지 않습니다.</td>
                </tr>
              </c:if>
              <c:set var="nRow" value="${pageSize*(currentPageAdvice-1)}" />
              <c:forEach items="${listAdvice}" var="list">
                <tr>
                    <td><a href="javascript:fSelectAdvice('${list.consult_no}')">${list.consult_date}</a></td>
                    <td>${list.consult_place}</td>
                    <td>${list.t_name}</td>
                  </tr>
                <c:set var="nRow" value="${nRow + 1}" />
              </c:forEach>
              </tbody>
            </table>
          </div>
