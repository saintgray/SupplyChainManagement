<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
								  
								<c:if test="${texamCnt eq 0 }">
									<tr>
										<td colspan="6">수강 중인 과목이 없습니다. '_'?</td>
									</tr>
								</c:if>
								<c:if test="${texamCnt > 0 }">
									<c:set var="nRow" value="${pageSize * (currentPageTexam - 1)}"/>
									<c:forEach items="${listTexamMap}" var="texamlistmap">
										<tr>
											<td>${texamCnt - nRow}</td>
											<td>${texamlistmap.classNo}</td>
											<td style="text-align:left;">${texamlistmap.classNm}</td>
											<td>${texamlistmap.classStartdate} ~ ${texamlistmap.classEnddate}</td>
											<td>${texamlistmap.state}</td>
											<c:if test="${texamlistmap.state eq '진행중' && texamlistmap.isNullA eq 'T' && texamlistmap.isNullB eq 'T' && texamlistmap.isNullC eq 'T'}">
												<td><a class="btnType3 color1" href="javascript:ftakeExamChk(${texamlistmap.classNo});"><span>응시</span></a></td>
											</c:if>
											<c:if test="${texamlistmap.state eq '진행중' && (texamlistmap.isNullA eq 'F' || texamlistmap.isNullB eq 'F' || texamlistmap.isNullC eq 'F')}">
												<td><span class="font_red"><strong>미출제</strong></span></td>
											</c:if>
											<c:if test="${texamlistmap.state eq '종료'}">
												<td>-</td>
											</c:if>
										</tr>
										<c:set var="nRow" value="${nRow + 1}" />
									</c:forEach>
								</c:if>
								
								<input type="hidden" id="texamCnt" name="texamCnt" value ="${texamCnt}"/>
								
								
								
								
								
