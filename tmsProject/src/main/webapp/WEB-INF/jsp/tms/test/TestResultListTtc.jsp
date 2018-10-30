<%--
  Class Name : TestCaseList.jsp
  Description : EgovLoginPolicyList 화면
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01   lee.m.j            최초 생성
     2011.08.31   JJY       경량환경 버전 생성

    author   : 공통서비스 개발팀 lee.m.j
    since    : 2009.02.01
--%>
<%@ page import="egovframework.com.cmm.LoginVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >

<title>통합 테스트 결과 목록 조회</title>

<script type="text/javaScript" language="javascript" defer="defer">

function fn_egov_select_testCaseList(pageNo){
    document.listForm.pageIndex.value = pageNo; 
    document.listForm.action = "<c:url value='/tms/test/selectTestResultList.do?testcaseGb=TC2'/>";
    document.listForm.submit();  
}

function searchFileNm() {
    window.open("<c:url value='/sym/prm/TmsProgramListSearch.do'/>",'','width=800,height=600');
}


</script>

</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

<!-- 전체 레이어 시작 -->

<c:if test="${!empty message and fn:length(message) > 0}">
	<script type="text/javascript"> alert("${message}");</script>
</c:if>


<div id="wrap">
    <!-- header 시작 -->
    <div id="topnavi" style="margin : 0;"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>
    <!-- //header 끝 -->
    <!-- container 시작 -->
    <div id="container">
        <!-- 좌측메뉴 시작 -->
        <div id="leftmenu"><c:import url="/sym/mms/EgovMainMenuLeft.do" /></div>
        <!-- //좌측메뉴 끝 -->
            <!-- 현재위치 네비게이션 시작 -->
            <div id="content">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
							<li>HOME</li>
							<li>&gt;</li>
							<li>테스트관리</li>
							<li>&gt;</li>
							<li>통합 테스트 관리</li>
							<li>&gt;</li>
							<li><strong>결과 관리</strong></li>
                        </ul>
                    </div>
                </div>
    
    		 <br>
    		 
              
		         <form:form commandName="searchVO" name="listForm" method="post" action="/tms/test/selectTestCaseList.do">   
                <!-- 검색 필드 박스 시작 -->
					<div id="search_field">
              <div id="search_field_loc"><h2><strong>통합 테스트 결과 관리</strong></h2></div>
					
					  	<fieldset><legend>조건정보 영역</legend>	
					  	
				  	 	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					  	 
					  	<div class="sf_start">
					  	<table style="width:100%;padding-bottom:10px;padding-left:10px;padding-top:10px;">
                    		<colgroup>
                  			  <col width="10%"/> 
                  			  <col width="13.8%"/> 
                  			  <col width="7%"/> 
                  			  <col width="13.8%"/> 
                  			  <col width="7%"/> 
                  			  <col width="13.8%"/> 
                  			  <col width="7%"/> 
                  			  <col width="13.8%"/> 
                  			  <col width="13.8%"/> 
      			        	</colgroup>
      			        <tr>
      			        	<td style="font-weight:bold;color:#666666;font-size:110%;">
      			        	<spring:message code="tms.test.testcaseId" />
      			        	</td>
      			        	<td>
					  			<input type="text" name="searchByTestcaseId" id="searchByTestcaseId" style="width:80%;text-align:center;" value="<c:out value='${searchVO.searchByTestcaseId}'/>" />
      			        	</td>
      			        	<td style="font-weight:bold;color:#666666;font-size:110%;">
      			        	<spring:message code="tms.test.taskGb" />					  			
      			        	</td>
      			        	<td>
									<select name="searchByTaskGb" id="searchByTaskGb" style="width:90%;text-align-last:center;">
										<option value="">전체</option>
										<c:forEach var="cmCode" items="${taskGbCode}">
										<option value="${cmCode.code}"  <c:if test="${searchVO.searchByTaskGb == cmCode.code}">selected="selected"</c:if>>${cmCode.codeNm}</option>
										</c:forEach>
									</select>						
      			        	</td>
	      			        <td style="font-weight:bold;color:#666666;font-size:110%;">
						  			<spring:message code="tms.test.userWriterId" />
	      			        </td>
	      			        <td>
						  			<input type="text" name="searchByUserDevId" id="searchByUserDevId" list="userAllList" autocomplete="off" style="width:80%;text-align:center;" value="<c:out value='${searchVO.searchByUserDevId}'/>" />
      			        		<datalist id="userAllList">
									    <c:forEach var="userList" items="${userList}" varStatus="status">
									    	<option value="<c:out value="${userList.userNm}"/>"  style="text-align:center;"></option>
									    </c:forEach>
					        	</datalist>
	      			        </td>
       			        	<td colspan="3">
      			        	</td>
      			        </tr>
      			        <tr>
      			        <td style="padding-top:15px; font-weight:bold;color:#666666;font-size:110%;">
      			   		  <spring:message code="tms.test.completeYn" />
      			        </td>
      			        <td style="padding-top:15px;">
									<select name="searchByResultYn" id="searchByResultYn" style="width:82%;text-align-last:center;">
										<option value="">전체</option>
										<c:forEach var="cmCode" items="${resultYnCode}">
										<option value="${cmCode.code}"  <c:if test="${searchVO.searchByResultYn == cmCode.code}">selected="selected"</c:if> >${cmCode.codeNm}</option>
										</c:forEach>
									</select>							
      			        </td>
      			        <td style="padding-top:15px; font-weight:bold;color:#666666;font-size:110%;">등록일자
      			        </td>
      			        <td colspan="3" style="padding-top:15px;">
		                        	<input type="date" name="searchByStartDt" id="searchByStartDt" size="15" style="text-align:center;" value="<c:out value='${ST_date}'/>"/>&nbsp;<img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
		                          &nbsp;~&nbsp;<input type="date" name="searchByEndDt" id="searchByEndDt" size="15" style="text-align:center;" value="<c:out value='${EN_date}'/>"/>&nbsp;<img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
      			        </td>
      			        <td colspan="3" style="padding-top:15px;">
									<div class="buttons" style="float:right;">
									    
                                        <a href="<c:url value='/tms/test/selectTestCaseList.do'/>" onclick="fn_egov_select_testCaseList('1'); return false;"><img src="<c:url value='/images/img_search.gif' />" alt="search" />
										<spring:message code="button.inquire" /></a>
									</div>	  				  			
      			        </td>
      			        </tr>
      			        </table>
					  				
						</div>			
						</fieldset>
						
					</div>
 					</form:form>
				<!-- //검색 필드 박스 끝 -->
                

                <div id="page_info"><div id="page_info_align"></div></div>     
                
                <div class="default_tablestyle">
              	<table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
                <caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
              
              
             		 <colgroup>
             		 	<col width="5%"/>
        				<col width="9%"/> 
        				<col width="467%"/>
        				<col width="5%"/>
        				<col width="9%"/>
        				<col width="7%"/>
        				<col width="6%"/>
        				<col width="6%"/>
        				<col width="7%"/>
        			</colgroup>
        			<tr>
        			    <th align="center"><spring:message code="tms.test.no" /></th>
        			    <th align="center"><spring:message code="tms.test.testcaseId" /></th>
        			    <th align="center"><spring:message code="tms.test.testcaseContent" /></th>
        			    <th align="center"><spring:message code="tms.test.userWriterId" /></th>
        				<th align="center"><spring:message code="tms.test.taskGb" /></th>
			        	<th align="center"><spring:message code="tms.test.enrollDt" /></th>
			        	<th align="center"><spring:message code="tms.test.firstTest" /></th>
			        	<th align="center"><spring:message code="tms.test.secondTest" /></th>
        				<th align="center"><spring:message code="tms.test.completeYn" /></th>
        			</tr>
        			
        			<c:forEach var="result" items="${testCaseList}" varStatus="status">
        				<input type="hidden" name="pgId" value="<c:out value="${result.pgId}"/>">
            			<tr>
            			    <td align="center" class="listtd" ><strong><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></strong></td>          
            				<td align="left" class="listtd"><c:out value="${result.testcaseId}"/></td>
            				<td align="left" class="listtd">
            					<a href= "<c:url value='/tms/test/selectTestResult.do?testcaseId=${result.testcaseId}'/>">
	            					<strong><c:out value="${result.testcaseContent}"/></strong>
	            				</a>
            				</td>
            				<td align="center" class="listtd"><c:out value="${result.userNm}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.taskGbNm}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.enrollDt}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.firstTestResultYn}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.secondTestResultYn}"/>&nbsp;</td>
            				
            				<c:choose>
            					<c:when test="${result.completeYn == 'Y' }">
            						<td align="center" class="listtd" style="background-color:#007bff;">
            						<font color="#ffffff" style="font-weight:bold"><c:out value="${result.completeYn}"/>&nbsp;</font>
            						</td>
            					</c:when>
            					
            					<c:when test="${result.completeYn == 'N' }">
            						<td align="center" class="listtd" style="background-color:#CC3C39;">
            						<font color="#ffffff" style="font-weight:bold"><c:out value="${result.completeYn}"/>&nbsp;</font>
            						</td>
            					</c:when>
            					
            					<c:otherwise>
            						<td align="center" class="listtd" style="background-color:#007bff;">
            						<font style="font-weight:bold"><c:out value="${result.completeYn}"/>&nbsp;</font>
            						</td>
            					</c:otherwise>
            				</c:choose>
            				
            			</tr>
        			</c:forEach>
              </table>        
           </div>

            <!-- 페이지 네비게이션 시작 -->
           <div id="paging_div">
               <ul class="paging_align">
                  <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_testCaseList"  />
               </ul>
           </div>                          
           <!-- //페이지 네비게이션 끝 -->  
 		
            </div>
            <!-- //content 끝 -->
        </div>
        <!-- //container 끝 -->
        
        
        <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
    </div>
    <!-- //전체 레이어 끝 -->
    
    
    
 </body>
</html>