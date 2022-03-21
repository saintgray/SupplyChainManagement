<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
					<div class="divEmpty">
						<div class="hiddenData">
							  <span id="examCnt">${examCnt}</span>
							  <span id="examMaxqNo">${examMaxqNo}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">문제 번호</th>
									<th scope="col">문제</th>
									<th scope="col">정답</th>
									<th scope="col">①</th>
									<th scope="col">②</th>
									<th scope="col">③</th>
									<th scope="col">④</th>
									<th scope="col">수정</th>
								</tr>
							</thead>
							<tbody id="listExam">
							<c:if test="${examCnt eq 0 }">
								<tr>
									<td colspan="8">등록된 문항이 없습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize * (currentPageExam - 1)}" />
							<c:forEach items="${listExamModel}" var="examlist">
								<tr>
									<td>${examlist.qNo}</td>
									<td style="text-align:left; word-break:break-all;">${examlist.qContent}</td>
									<td>${examlist.qSolution}</td>
									<td style="text-align:left; word-break:break-all;">${examlist.qOne}</td>
									<td style="text-align:left; word-break:break-all;">${examlist.qTwo}</td>
									<td style="text-align:left; word-break:break-all;">${examlist.qThree}</td>
									<td style="text-align:left; word-break:break-all;">${examlist.qFour}</td>
									<%-- <td><a class="btnType3 color1" href="javascript:fPopModalQuestion(${examlist.exClassNo}, ${examlist.qNo}, '${examlist.qType}');"><span>수정</span></a></td> --%>
									<td><a class="btnType3 color1" href="javascript:chkMemberCnt(${examlist.exClassNo}, ${examlist.qNo}, '${examlist.qType}');"><span>수정</span></a></td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
								
								
								
								
								
