<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
					<div class="divEmpty">
						<div class="hiddenData">
							  <span id="examMemCnt">${examMemCnt}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">학생명</th>
									<th scope="col">시험 유형</th>
									<th scope="col">점수</th>
									<th scope="col">상태</th>
								</tr>
							</thead>
							<tbody id="listExamMember">
							<c:if test="${examMemCnt eq 0 }">
								<tr>
									<td colspan="5">응시자가 없습니다. '_';</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize * (currentPageExamMember - 1)}" />
							<c:forEach items="${examMemMap}" var="exammemlist">
								<tr>
									<td>${examMemCnt - nRow}</td>
									<td style="text-align:left;">${exammemlist.name}</td>
									<td>${exammemlist.examType}</td>
									<td>${exammemlist.score}</td>
									<td>${exammemlist.state}</td>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>
								
								
								
								
								
