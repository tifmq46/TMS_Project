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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >

<title>테스트 현황</title>

<script type="text/javaScript" language="javascript" defer="defer">


function selectTestCurrent(pageNo){
    document.listForm.pageIndex.value = pageNo; 
    document.listForm.action = "<c:url value='/tms/test/selectTestCurrent.do'/>";
    document.listForm.submit();  
}

function currentToExel(pageNo) {
	
	var gb = document.listForm.searchByTestcaseGb.value;
	
	document.listForm.pageIndex.value = pageNo; 
    document.listForm.action = "<c:url value='/tms/test/currentToExcel.do?testGb="+gb+"'/>"
    document.listForm.submit(); 
}

</script>

</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

<!-- 전체 레이어 시작 -->


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
            <div id="content" style="font-family:'Malgun Gothic';">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
							<li>HOME</li>
							<li>&gt;</li>
							<li>테스트관리</li>
							<li>&gt;</li>
							<li><strong>테스트 현황</strong></li>
                        </ul>
                    </div>
                </div>
    
    		 <br>
              
		        <form:form commandName="searchVO" name="listForm" method="post" action="/tms/test/selectTestCurrent.do">   
                <!-- 검색 필드 박스 시작 -->
                
                	<form:hidden path=""  id="TmsProgrmFileNm_user_dev_id"/>
                    <form:hidden path=""  id="TmsProgrmFileNm_pg_nm"/>
                    <form:hidden path=""  id="TmsProgrmFileNm_pg_full"/>
                    <form:hidden path=""  id="TmsProgrmFileNm_sys_gb"/>
                    <form:hidden path=""  id="TmsProgrmFileNm_task_gb"/>
                    <form:hidden path=""  id="TmsProgrmFileNm_task_gb_code"/>
                    <form:hidden path=""  id="TmsProgrmFileNm_user_real_id"/>
                
					<div id="search_field" style="font-family:'Malgun Gothic';">
              <div id="search_field_loc">
              <h2><strong>
              <c:if test="${searchVO.searchByTestcaseGb eq 'TC1'}">단위</c:if>
              <c:if test="${searchVO.searchByTestcaseGb eq 'TC2'}">통합</c:if>
              	테스트 현황</strong></h2>
              </div>
						
					  	<fieldset><legend>조건정보 영역</legend>	
					  	
				  	 	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					  	 
					  	<div class="sf_start">
				
						<table style="width:100%;padding-bottom:10px;padding-left:10px;padding-top:10px;">
                    		<colgroup>
                  			  <col width="12%"/> 
                  			  <col width="12.8%"/> 
                  			  <col width="10%"/> 
                  			  <col width="12.8%"/> 
                  			  <col width="7%"/> 
                  			  <col width="12.8%"/> 
                  			  <col width="12.8%"/> 
                  			  <col width="7%"/> 
                   			  <col width="12.8%"/>
      			        	</colgroup>
      			        <tr>
      			        <td style="font-weight:bold;color:#666666;font-size:110%;">
      			        <spring:message code="tms.test.testGb" />
      			        </td>
      			        <td>
      			        <select name="searchByTestcaseGb" id="searchByTestcaseGb"  style="width:82%;text-align-last:center;" value="<c:out value='${searchVO.searchByTestcaseGb}'/>" >
										<c:forEach var="cmCode" items="${tcGbCode}">
										<option value="${cmCode.code}"  <c:if test="${searchVO.searchByTestcaseGb == cmCode.code}">selected="selected"</c:if> >${cmCode.codeNm}</option>
										</c:forEach>
									</select>
      			        </td>
      			        <td style="font-weight:bold;color:#666666;font-size:110%;">
      			        <spring:message code="tms.test.testcaseId" />
      			        </td>
      			        <td>
					  			<input type="text" name="searchByTestcaseId" id="searchByTestcaseId" size="15"  style="width:80%;text-align:center;"  value="<c:out value='${searchVO.searchByTestcaseId}'/>" />
      			        </td>
				  				<c:if test="${testCurrent[0].pgId != '' && testCurrent[0].pgId ne null }">
									<td style="font-weight:bold;color:#666666;font-size:110%;"><spring:message code="tms.test.pgId" /></td>
						  			<td>
							  			<input type="text" name="searchByPgId" id="TmsProgrmFileNm_pg_id"  style="width:80%;text-align:center;" value="<c:out value='${searchVO.searchByPgId}'/>"/>
							  			<a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
			                			<img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a>
      			        			</td>
					  			</c:if>
      			        		<c:if test="${testCurrent[0].pgId == '' && testCurrent[0].pgId eq null }">
									<td></td>
						  			<td></td>
					  			</c:if>
      			        <td colspan="3" style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">
      			        	<div style="float:right;">
      			        		<input type="radio" name="asOf" value="testcaseId" onclick="selectTestCurrent('1');" <c:if test="${searchVO.asOf == 'testcaseId'}">checked="checked"</c:if>/>&nbsp;<label><spring:message code="tms.test.testcaseId" /></label>&nbsp;&nbsp;
      			        		<input type="radio" name="asOf" value="pgId" onclick="selectTestCurrent('1');" <c:if test="${searchVO.asOf == 'pgId'}">checked="checked"</c:if>/>&nbsp;<label><spring:message code="tms.test.pgId" /></label> &nbsp;
      			       		</div>
      			        </td>
      			        
      			         <td></td>
      			         <td></td>
      			        </tr>
      			        
      			        
      			        <tr>
      			        <td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">
      			        <spring:message code="tms.test.taskGb" />
      			        </td>
      			        <td style="padding-top:15px;">
      			        <select name="searchByTaskGb" id="searchByTaskGb" style="width:82%;text-align-last:center;" value="<c:out value='${searchVO.searchByTaskGb}'/>">
										<option value="">전체</option>
										<c:forEach var="cmCode" items="${taskGbCode}">
										<option value="${cmCode.codeNm}" <c:if test="${searchVO.searchByTaskGb == cmCode.codeNm}">selected="selected"</c:if>>${cmCode.codeNm}</option>
										</c:forEach>
									</select>	
      			        </td>
      			        <td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">
      			        <spring:message code="tms.test.userWriterId" />
      			        </td>
      			        <td style="padding-top:15px;">
      			        <input type="text" name="searchByUserDevId" list="userAllList" autocomplete="off" id="searchByUserDevId"  style="width:80%;text-align:center;"  value="<c:out value='${searchVO.searchByUserDevId}'/>"/>
      			        <datalist id="userAllList">
									    <c:forEach var="userList" items="${userList}" varStatus="status">
									    	<option value="<c:out value="${userList.userNm}"/>"  style="text-align:center;"></option>
									    </c:forEach>
					        	</datalist>
      			        </td>
      			        <td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">
      			        <spring:message code="tms.test.completeYn" />
      			        </td>
      			        <td style="padding-top:15px;">
      			        <select name="searchByResultYn" id="searchByResultYn" style="width:82%;text-align-last:center;" value="<c:out value='${searchVO.searchByResultYn}'/>">
										<option value="">전체</option>
										<c:forEach var="cmCode" items="${resultYnCode}">
										<option value="${cmCode.code}" <c:if test="${searchVO.searchByResultYn == cmCode.code}">selected="selected"</c:if> >${cmCode.codeNm}</option>
										</c:forEach>
									</select>	
      			        </td>
      			        
      			        <td colspan="3" style="padding-top:15px;" >
      			        	<div class="buttons" style="float:right;">
	                            <a href="#LINK" onclick="selectTestCurrent('1'); return false;"><img src="<c:url value='/images/img_search.gif' />" alt="search" />
								<spring:message code="button.inquire" /></a>
								<a href="#LINK" onclick="currentToExel('${searchVO.pageIndex}'); return false;"><spring:message code="tms.test.exelDownload" /></a>
							</div> 
      			        </td>
      			        
      			        <td></td>
      			        <td></td>
      			        
      			        </tr>
      			        </table>
					  				
						</div>			
						</fieldset>
						 		
					</div>
				</form:form>
				<!-- //검색 필드 박스 끝 -->
                

                <div id="page_info"><div id="page_info_align"></div></div>     
                
                
                <div class="default_tablestyle">
                
                  
           			<fmt:parseNumber var="tc1_yCnt" value="${selectTestCurrentCnt.yCnt}" type="number"  integerOnly="true" ></fmt:parseNumber>
                   	<fmt:parseNumber var="tc1_totCnt" value="${selectTestCurrentCnt.totCnt}" type="number"  integerOnly="true" ></fmt:parseNumber>
                   	
                   	<c:choose>
                   		<c:when test="${tc1_totCnt eq '0'}">
                   			<c:set var="testPct"  value="0"></c:set>
                   		</c:when>
                   		
                   		<c:otherwise>
                   			<fmt:parseNumber var="testPct" value="${(tc1_yCnt/tc1_totCnt)*100}" type="number"  integerOnly="true" ></fmt:parseNumber>
                   		</c:otherwise>
                   	</c:choose>
                 
                  <table width="80%" cellspacing="0" summary="총 건수, 완료건수, 미완료, 진행률 표시하는 테이블">
	                 <caption style="visibility:hidden">총 건수, 완료건수, 미완료, 진행률 표시하는 테이블</caption>
	                 
	                 <tr>
	                 	<td align="right" width="80" style="font-size:15px; font-weight:bolder">진행률 : 
	                 	<td style="font-size:15px; font-weight:bolder">
	                 			<div class="progress" style="height: 1.5rem;"><div class="progress-bar" style="width:${testPct}%" > <strong><c:out value=" ${testPct}"></c:out>%</strong></div></div>
	                 	</td>
	                 	<td align="center" width="180" style="font-size:15px; font-weight:bolder">총 프로그램 본수 : <c:out value="${selectTestCurrentCnt.totCnt}"></c:out></td>
	                  	<td align="center" width="180" style="font-size:15px; font-weight:bolder">테스트케이스 수 : <c:out value="${selectTestCurrentCnt.testcaseCnt}"></c:out></td>
	                 	<td align="center" width="80" style="font-size:15px; font-weight:bolder">완료 : <c:out value="${selectTestCurrentCnt.yCnt}"></c:out></td>
	                 	<td align="right" width="80" style="font-size:15px; font-weight:bolder">미완료 : <c:out value="${selectTestCurrentCnt.nCnt}"></c:out></td>
	                 </tr>        
             	</table>
             	
                 
	                
              	<table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
	              	
	              	<!-- 화면ID 기준으로 검색 -->
	              	<c:if test="${searchVO.asOf == 'pgId'}">
	              	<colgroup>
	              			<col width="35"/>
	              		<c:if test="${testCurrent[0].pgId != '' && testCurrent[0].pgId ne null }"> 
 					        <col width="52"/>
 					        <col width="70"/> 
        				</c:if>
	        				<col width="45"/>
	        				<col width="55"/>
	        				<col width="210"/>
	        				<col width="32"/>
	        				<col width="25"/>
	        				<col width="25"/>
	        				<col width="35"/>
	        		</colgroup>
        			<tr>
        			
        				<th align="center" rowspan="2"><spring:message code="tms.test.no" /></th>
        				
        				<c:if test="${testCurrent[0].pgId != '' && testCurrent[0].pgId ne null }"> 
        					<th align="center" rowspan="2"><spring:message code="tms.test.pgId" /></th>
        					<th align="center" rowspan="2" ><spring:message code="tms.test.pgNm" /></th>
        				</c:if>
        				
        				<th align="center" rowspan="2"><spring:message code="tms.test.taskGb" /></th>
        				<th align="center" rowspan="2"><spring:message code="tms.test.testcaseId" /></th>
        				<th align="center" rowspan="2"><spring:message code="tms.test.testcaseContent" /></th>
        				<th align="center" rowspan="2"><spring:message code="tms.test.userWriterId" /></th>
			        	<th align="center" colspan="2"><spring:message code="tms.test.testLevel" /></th>
        				<th align="center" rowspan="2"><spring:message code="tms.test.completeYn" /></th>
        			</tr>
        			
        			<tr>
        				<th align="center"><spring:message code="tms.test.firstTest" /></th>
			        	<th align="center"><spring:message code="tms.test.secondTest" /></th>
        			</tr>
        			
        			<c:forEach var="result" items="${testCurrent}" varStatus="status">
        			
            			<tr>
            				<td align="center" class="listtd" ><strong><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></strong></td>  
            				<c:if test="${result.pgId != '' && result.pgId ne null}"> 
	        					<td align="left" class="listtd"><c:out value="${result.pgId}"/>&nbsp;</td>
	        					<td align="left" class="listtd" title="${result.pgNm}"><c:out value="${result.pgNm}"/>&nbsp;</td>
	        				</c:if>
	        				
            				<td align="center" class="listtd"><c:out value="${result.taskGbNm}"/>&nbsp;</td>
            				<td align="left" class="listtd"><c:out value="${result.testcaseId}"/>&nbsp;</td>
            				<td align="left" class="listtd" title="${result.testcaseContent}">
            					<font color="#0F438A" style="font-weight:bold"><c:out value="${result.testcaseContent}"/>&nbsp;</font>
            				</td>
            				<td align="center" class="listtd" title="${result.userId}"><c:out value="${result.userNm}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.firstTestResultYn}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.secondTestResultYn}"/>&nbsp;</td>
            				<td align="center" class="listtd">
            					<font color="#0F438A" style="font-weight:bold"><c:out value="${result.completeYn}"/>&nbsp; </font>
            				</td>
            			</tr>
        			</c:forEach>
	              	
	              	
	              	</c:if>
	              	
	              	<!-- 테스트케이스 ID 기준으로 검색 -->
	              	<c:if test="${searchVO.asOf == 'testcaseId'}">
	              	
	              		<colgroup>
	              			<col width="35"/>
	              			<col width="75"/>
	              			<col width="280"/>
	              			<col width="33"/>
	              			<col width="60"/>
	              		<c:if test="${testCurrent[0].pgId != '' && testCurrent[0].pgId ne null }"> 
 					        <col width="67"/> 
 					        <col width="100"/>
        				</c:if>
	        				<col width="30"/>
	        				<col width="30"/>
	        				<col width="45"/>
	        		</colgroup>
        			<tr>
        			
        				<th align="center" rowspan="2"><spring:message code="tms.test.no" /></th>
        				<th align="center" rowspan="2"><spring:message code="tms.test.testcaseId" /></th>
        				<th align="center" rowspan="2"><spring:message code="tms.test.testcaseContent" /></th>
        				<th align="center" rowspan="2"><spring:message code="tms.test.userWriterId" /></th>
        				<th align="center" rowspan="2"><spring:message code="tms.test.taskGb" /></th>
        				<c:if test="${testCurrent[0].pgId != '' && testCurrent[0].pgId ne null }"> 
	        				<th align="center" rowspan="2"><spring:message code="tms.test.pgId" /></th>
	        				<th align="center" rowspan="2" ><spring:message code="tms.test.pgNm" /></th>
        				</c:if>
			        	<th align="center" colspan="2"><spring:message code="tms.test.testLevel" /></th>
        				<th align="center" rowspan="2"><spring:message code="tms.test.completeYn" /></th>
        			</tr>
        			<tr>
        				<th align="center"><spring:message code="tms.test.firstTest" /></th>
			        	<th align="center"><spring:message code="tms.test.secondTest" /></th>
        			</tr>
        			
        			<c:forEach var="result" items="${testCurrent}" varStatus="status">
        			
            			<tr>
            				<td align="center" class="listtd" ><strong><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></strong></td>  
            				
            				<td align="left" class="listtd"><c:out value="${result.testcaseId}"/>&nbsp;</td>
            				<td align="left" class="listtd" title="${result.testcaseContent}">
	            				<font color="#0F438A" style="font-weight:bold"><c:out value="${result.testcaseContent}"/>&nbsp;</font>
            				</td>
            				<td align="center" class="listtd" title="${result.userId}"><c:out value="${result.userNm}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.taskGbNm}"/>&nbsp;</td>
            				<c:if test="${result.pgId != '' && result.pgId ne null}"> 
	        					<td align="left" class="listtd"><c:out value="${result.pgId}"/>&nbsp;</td>
	        					<td align="left" class="listtd" title="${result.pgNm}"><c:out value="${result.pgNm}"/>&nbsp;</td>
	        				</c:if>
            				<td align="center" class="listtd"><c:out value="${result.firstTestResultYn}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.secondTestResultYn}"/>&nbsp;</td>
            				<td align="center" class="listtd">
            					<font color="#0F438A" style="font-weight:bold"><c:out value="${result.completeYn}"/>&nbsp;</font>
            				</td>
            			</tr>
        			</c:forEach>
	              	
	              	</c:if>
	              	
              </table>        
           </div>
           
            <!-- 페이지 네비게이션 시작 -->
           <div id="paging_div">
               <ul class="paging_align">
                  <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="selectTestCurrent"  />
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