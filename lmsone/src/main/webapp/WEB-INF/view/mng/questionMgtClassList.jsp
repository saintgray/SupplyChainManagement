<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
								  
								<c:if test="${classCnt eq 0 }">
									<tr>
										<td colspan="4">등록된 강의가 없습니다. ㅠ_ㅠ</td>
									</tr>
								</c:if>
								<c:if test="${classCnt > 0 }">
									<c:set var="nRow" value="${pageSize * (currentPageClass - 1)}"/>
									<c:forEach items="${listClassModel}" var="classlist">
										<tr>
											<td>${classCnt - nRow}</td>
											<td>${classlist.classNo}</td>
											<td style="text-align:left;"><a href="javascript:flistExam(1, ${classlist.classNo}, 'init')">${classlist.classNm}</a></td>
											<td>${classlist.classStartdate} ~ ${classlist.classEnddate}</td>
										</tr>
										<c:set var="nRow" value="${nRow + 1}" />
									</c:forEach>
								</c:if>
								
								<input type="hidden" id="classCnt" name="classCnt" value ="${classCnt}"/>
								
								
								
								
								
