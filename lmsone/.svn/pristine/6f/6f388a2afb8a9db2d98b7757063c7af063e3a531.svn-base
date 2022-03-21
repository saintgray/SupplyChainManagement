<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

      <div class="divEmpty">
            <div class="hiddenData">
                <span id="totalCntUser">${totalCntUser}</span>
            </div>
            <table class="col">
             <thead>
                  <tr>
                    <th scope="col">학생명</th>
                    <th scope="col">시험 최종 점수</th>
                  </tr>
                </thead>
              <tbody id="userList">
              <c:if test="${totalCntUser eq 0 }">
                <tr>
                  <td colspan="12">데이터가 존재하지 않습니다.</td>
                </tr>
              </c:if>
              <c:set var="nRow" value="${pageSize*(currentPageUser-1)}" />
              <c:forEach items="${listUser}" var="list">
                <tr>
                    <td><a href="javascript:fSelectAwardList(1,'${list.loginID}')">${list.s_name}</a></td>
                    <td>${list.score}</td>
                  </tr>
                <c:set var="nRow" value="${nRow + 1}" />
              </c:forEach>
              </tbody>
            </table>
          </div>
