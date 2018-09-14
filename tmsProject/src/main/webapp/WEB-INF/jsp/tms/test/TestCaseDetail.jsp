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
<link href="<c:url value='/'/>css/test/common.css" rel="stylesheet" type="text/css" >

<title>테스트케이스 목록 조회</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>


function selecTestCaseList(pageNo){
    document.listForm.pageIndex.value = pageNo; 
    document.listForm.action = "<c:url value='/tms/test/selectTestCaseList.do'/>";
    document.listForm.submit();  
}

function updateTestCase(){
	
	 document.updateForm.action = "<c:url value='/tms/test/updateTestCaseImpl.do'/>";
	 document.updateForm.submit();  
	
	
}


</script>

</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

<!-- 전체 레이어 시작 -->


<div id="wrap">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <div id="topnavi"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>
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
							<li><strong>테스트케이스 상세</strong></li>
                        </ul>
                    </div>
                </div>
              
                <div id="page_info"><div id="page_info_align"></div></div>      
                             
                             
               <form:form commandName="testCaseVO" name="updateForm" method="post" action="/tms/test/updateTestCaseImpl.do">           
                             
                 <div id="border" class="modify_user" >
                        <table>
                            <tr>
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.testcaseId" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                               	 	<c:out value='${testVoMap.testcaseId}'/>
                                 	<input type="hidden" name="testcaseId" value="${testVoMap.testcaseId}" />
                                </td>
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.pgId" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                               		<c:out value='${testVoMap.pgId}'/>
                                </td>
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.pgNm" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                               		<c:out value='${testVoMap.pgNm}'/>
                                </td> 
                            </tr>
                            
                            <tr>
                             	<th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.testcaseGb" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:out value='${testVoMap.testcaseGbNm}'/>
                                </td>
                                
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.taskGb" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:out value='${testVoMap.taskGbNm}'/>
                                </td>
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.userWriterId" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:out value='${testVoMap.userNm}'/>
                                  <input type="hidden" name="userId" value="${testVoMap.userId}" />
                                </td>
                            </tr>
                            
                            <tr>
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.enrollDt" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:out value='${testVoMap.enrollDt}'/>
                                </td>
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.completeDt" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:out value='${testVoMap.completeDt}'/>
                                </td>
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.completeYn" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:out value='${testVoMap.completeYn}'/>
                                </td>
                            </tr>
                            
                            <tr>
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.precondition" /></label>
                                </th>
                                <td width="83%" nowrap colspan="5">
                                   <textarea rows="3" style="width:100%" id="precondition" name="precondition"><c:out value='${testVoMap.precondition}'/></textarea>
                                </td>
                            </tr>
                            
                            
                            <tr>
                            	<th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.testcaseContent" /></label>
                                </th>
                                <td width="83%" nowrap colspan="5">
                                  <textarea rows="3"  style="width:100%" id="testcaseContent" name="testcaseContent"><c:out value='${testVoMap.testcaseContent}'/></textarea>
                                </td>
                            </tr>
                
                
	                		 <tr>
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.firstTestResultYn" /></label>
                                </th>
                                <td width="16.6%" nowrap >
									<c:choose>
                                		<c:when test="${testVoMap.firstTestResultYn == 'Y'}">
	                                		<input type="radio" name="firstTestResultYn" value="Y" checked>Y
	  										&nbsp;<input type="radio" name="firstTestResultYn" value="N">N
                                		</c:when>
                                		
                                		<c:when test="${testVoMap.firstTestResultYn == 'N'}">
	                                		<input type="radio" name="firstTestResultYn" value="Y" >Y
	  										&nbsp;<input type="radio" name="firstTestResultYn" value="N" checked>N
                                		</c:when>
                                		
                                		<c:otherwise>
                                			<input type="radio" name="firstTestResultYn" value="Y">Y
	  										&nbsp;<input type="radio" name="firstTestResultYn" value="N">N
                                		</c:otherwise>
                                	</c:choose>
                                </td>
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.secondTestResultYn" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                               		<c:choose>
                                		<c:when test="${testVoMap.secondTestResultYn == 'Y'}">
	                                		<input type="radio" name="secondTestResultYn" value="Y" checked>Y
	  										&nbsp;<input type="radio" name="secondTestResultYn" value="N">N
                                		</c:when>
                                		
                                		<c:when test="${testVoMap.secondTestResultYn == 'N'}">
	                                		<input type="radio" name="secondTestResultYn" value="Y" >Y
	  										&nbsp;<input type="radio" name="secondTestResultYn" value="N" checked>N
                                		</c:when>
                                		
                                		<c:otherwise>
                                			<input type="radio" name="secondTestResultYn" value="Y">Y
	  										&nbsp;<input type="radio" name="secondTestResultYn" value="N">N
                                		</c:otherwise>
                                	</c:choose>
                                </td>
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.thirdTestResultYn" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                               	<c:choose>
                                		<c:when test="${testVoMap.thirdTestResultYn == 'Y'}">
	                                		<input type="radio" name="thirdTestResultYn" value="Y" checked>Y
	  										&nbsp;<input type="radio" name="thirdTestResultYn" value="N">N
                                		</c:when>
                                		
                                		<c:when test="${testVoMap.thirdTestResultYn == 'N'}">
	                                		<input type="radio" name="thirdTestResultYn" value="Y" >Y
	  										&nbsp;<input type="radio" name="thirdTestResultYn" value="N" checked>N
                                		</c:when>
                                		
                                		<c:otherwise>
                                			<input type="radio" name="thirdTestResultYn" value="Y">Y
	  										&nbsp;<input type="radio" name="thirdTestResultYn" value="N">N
                                		</c:otherwise>
                                	</c:choose>
                                </td> 
                            </tr>
                            
                        </table>
                    </div>
                    
                    <div class="tmsTestButton" style="margin-bottom:30px;">
	                  	<ul>        
	           				<li>
								<div id="buttonDiv" class="buttons" style="float:right;">
	                                <a href="#" onclick="updateTestCase(); return false;"><spring:message code="button.update" /> </a>
				   					<a href="<c:url value='/tms/test/deleteTestCaseImpl.do?testcaseId=${testVoMap.testcaseId}&amp;testcaseGb=${testVoMap.testcaseGbCode}'/>"><spring:message code="button.delete" /></a>
								</div>	  				  			
		  					</li>             
	                    </ul>   
                	</div>
                
                	</form:form>
                

  					 <div id="border" class="modify_user" >
                        <table>
                            <tr>
                                <th width="15%" height="23"  nowrap="nowrap" rowspan="2"><label for="nttSj"><spring:message code="tms.test.testscenarioId" /></label>
                                </th>
                                <th width="5%" height="23"  nowrap="nowrap" rowspan="2"><label for="nttSj"><spring:message code="tms.test.testscenarioOrd" /></label>
                                </th>
                                <th width="30%" height="23"  nowrap="nowrap" rowspan="2"><label for="nttSj"><spring:message code="tms.test.testscenarioContent" /></label>
                                </th>
                                <th width="20%" height="23"  nowrap="nowrap" rowspan="2"><label for="nttSj"><spring:message code="tms.test.testCondition" /></label>
                                </th>
                                <th width="20%" height="23"  nowrap="nowrap" rowspan="2"><label for="nttSj"><spring:message code="tms.test.expectedResult" /></label>
                                </th>
                                <th width="25%" height="23"  nowrap="nowrap" colspan="2"><label for="nttSj"><spring:message code="tms.test.resultYn" /></label>
                                </th>
                            </tr>
                            
                            <tr>
                            	<th><spring:message code="tms.test.userTestId" /></th>
                            	<th><spring:message code="tms.test.result" /></th>
                            </tr>
                            
                            <c:forEach var="result" items="${testScenarioList}" varStatus="status">
        			
		            			<tr>
		            				<td align="center" class="listtd">
			            				<a href= "<c:url value='/tms/test/selectTestScenario.do?testscenarioId=${result.testscenarioId}'/>">
			            				<strong><c:out value="${result.testscenarioId}"/></strong>
			            				</a>
		            				</td>
		            				<td align="center" class="listtd"><c:out value="${result.testscenarioOrd}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.testscenarioContent}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.testCondition}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.expectedResult}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.userTestId}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.testResultYn}"/>&nbsp;</td>
		            			</tr>
        			</c:forEach>
                            
                        </table>
                    </div>

             	
             		<div class="tmsTestButton" >
	                    <ul>        
	           				<li>
								<div class="buttons" style="float:right;">
				   					<a href= "<c:url value='/tms/test/insertTestScenario.do?userId=${testVoMap.userId}&amp;testcaseId=${testVoMap.testcaseId} '/>"><spring:message code="button.create" /></a>
								</div>	  				  			
		  					</li>             
	                    </ul>        
                   </div>      




                <!-- 페이지 네비게이션 시작 -->
                <c:if test="${!empty loginPolicyVO.pageIndex }">
                    <div id="paging_div">
                        <ul class="paging_align">
                       <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
                        </ul>
                    </div>
                <!-- //페이지 네비게이션 끝 -->
                </c:if>



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