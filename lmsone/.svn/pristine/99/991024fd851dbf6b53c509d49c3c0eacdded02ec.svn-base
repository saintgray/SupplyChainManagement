<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
								  
								<c:if test="${qlistCnt > 0 }">
									<c:set var="nRow" value="1"/>
									<c:forEach items="${qListMap}" var="qlist">
										<tr style="height:10px;"></tr>
										<tr>
											<th scope="col" width="7%" >Q${nRow}</th>
											<td colspan ="3" width="*">${qlist.question}</td>
										</tr>
										<tr>
											<th scope="col" width="7%" >
												<input type="radio" name="Q${nRow}" value="1" />&nbsp;①
											</th>
											<td width="*">${qlist.one}</td>
										</tr>
										<tr>
											<th scope="col" width="7%" >
												<input type="radio" name="Q${nRow}" value="2" />&nbsp;②
											</th>
											<td width="*">${qlist.two}</td>
										</tr>
										<tr>
											<th scope="col" width="7%" >
												<input type="radio" name="Q${nRow}" value="3" />&nbsp;③
											</th>
											<td width="*">${qlist.three}</td>
										</tr>
										<tr>
											<th scope="col" width="7%" >
												<input type="radio" name="Q${nRow}" value="4" />&nbsp;④
											</th>
											<td width="*">${qlist.four}</td>
										</tr>
										<input type="hidden" id="qNo${nRow}" name="qNo${nRow}" value ="${qlist.qNo}"/>
										<c:set var="nRow" value="${nRow + 1}" />	
									</c:forEach>
								</c:if>
								<tr style="height:40px;">
									<td colspan="2" style="text-align:center; border-width:0; border-style:none; border-color:white;"><a class="btnType3 color1" href="javascript:submitExam();"><span>제출</span></a></td>
								</tr>							
								<input type="hidden" id="qlistCnt" name="qlistCnt" value ="${qlistCnt}"/>
								
								
								
								
								
