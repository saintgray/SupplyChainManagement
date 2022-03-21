<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
								  
								<c:if test="${examCnt eq 0 }">
									<tr>
										<td colspan="7">등록된 시험이 없습니다. ㅠ_ㅠ</td>
									</tr>
								</c:if>
								<c:if test="${examCnt > 0 }">
									<c:set var="nRow" value="${pageSize * (currentPageExam - 1)}"/>
									<c:forEach items="${examListMap}" var="examlistmap">
										<tr>
											<td>${examCnt - nRow}</td>
											<td><a href="javascript:flistExamMemberChk(1, ${examlistmap.classNo});">${examlistmap.classNm}</a></td>
											<td>${examlistmap.classStartdate} ~ ${examlistmap.classEnddate}</td>
											<td>${examlistmap.state}</td>
											<td>${examlistmap.totCnt}</td>
											<td>${examlistmap.doCnt}</td>
											<td>${examlistmap.doNotCnt}</td>
										</tr>
										<c:set var="nRow" value="${nRow + 1}" />
									</c:forEach>
								</c:if>
								
								<input type="hidden" id="examCnt" name="examCnt" value ="${examCnt}"/>
								
								
								
								
								
