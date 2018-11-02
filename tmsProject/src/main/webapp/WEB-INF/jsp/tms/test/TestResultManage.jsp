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
<%@ page import ="egovframework.com.cmm.LoginVO" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >

<title>테스트케이스 상세</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="testScenarioResultUpdate" staticJavascript="false" xhtml="true" cdata="false"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>


window.onload = function(){
	 	var checkField = document.testScenarioList.checkField;
    	
    	if(checkField === null || typeof checkField === 'undefined'){
    	} else {
    		var firstTr = (checkField.length > 1) ? checkField[0].parentNode.parentNode : checkField.parentNode.parentNode;
    		$(firstTr).children("td").css( "background-color", "rgba(0, 0, 0, 0.08)" );
			$(firstTr).children("td").css( "color", "#666666" );
    	}
}

function deleteTestCase() {
	
	if (confirm('<spring:message code="common.delete.msg" />')) {
    	document.testCaseVO.action = "<c:url value='/tms/test/deleteTestCaseImpl.do'/>";
   	 	document.testCaseVO.submit();       
    }
}
	var testscenarioId = ""; //전역변수

function testScenarioResultForm(target) {
	testscenarioId = scenarioId;
	var tbody = target.parentNode;
	var trs = tbody.getElementsByTagName('tr');
	for ( var i = 0; i < trs.length; i++ ) {
	if ( trs[i] != target ) {
		$(trs[i]).children("td").css( "background-color", "#ffffff" );
		$(trs[i]).children("td").css( "color", "#666666" );
		} else {
			$(trs[i]).children("td").css( "background-color", "rgba(0, 0, 0, 0.08)" );
			$(trs[i]).children("td").css( "color", "#666666" );
	}}  
	
	var scenarioId = $(target).children("td")[0].children.testscenarioId.value
	var resultContent = $(target).children("td")[0].children.testResultContent.value
	var resultYn = $(target).children("td")[0].children.testResultYn.value
	document.testScenarioResultInsert.testscenarioId.value = scenarioId;
	document.testScenarioResultInsert.testResultContent.value = resultContent;
	
	if(resultYn != null && resultYn.length > 0){
		$('input:radio[name=testResultYn]:radio[value='+ resultYn +']').prop("checked",true);
	}
}

function updateTestScenarioResult () {
	
	if(document.testScenarioResultInsert.testscenarioId.value == ""){
		alert("결과를 등록할 시나리오가 존재하지 않습니다.");
	} else {
	    if (confirm('<spring:message code="common.save.msg" />')) {
	    	document.testScenarioResultInsert.action = "<c:url value='/tms/test/updateTestScenarioResultImpl.do'/>";
	        document.testScenarioResultInsert.submit();      
	    }
	}
}

function insertDefect() {
	location.href = "<c:url value='/tms/defect/insertDefect.do?testscenarioId=" + testscenarioId + "'/>";
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
            <div id="content" style="font-family:'Malgun Gothic';">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
							<li>HOME</li>
							<li>&gt;</li>
							<li><c:out value='${testVoMap.testcaseGbNm}'/>&nbsp;테스트관리</li>
							<li>&gt;</li>
							<li><strong>결과 관리</strong></li>
                        </ul>
                    </div>
                </div>
              
                <div id="page_info"><div id="page_info_align"></div></div>      
                             
                             
               <form:form name="testCaseVO" method="post" action="<c:url value='/tms/test/updateTestScenarioMultiResultImpl.do'/>">           
                 
                  <div id="border" class="modify_user" >
                 		<input type="hidden" name="testcaseGb" value="${testVoMap.testcaseGbCode}" >
                        <table>
                            <tr>
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="testcaseId"><spring:message code="tms.test.testcaseId" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                               	 	<c:out value='${testVoMap.testcaseId}'/>
                               	 	<input type="hidden" name="testcaseId" value="${testVoMap.testcaseId}" >
                                </td>
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.testcaseContent" /></label>
                                </th>
                                <td width="49.8%" nowrap colspan="3">
                                 <c:out value='${testVoMap.testcaseContent}'/>
                                 <input type="hidden" name="testcaseContent" value="${testVoMap.testcaseContent}" >
                                </td>
                            </tr>
                            
                            <tr>
                             	<th width="16.6%" height="23"  nowrap="nowrap"><label for="testcaseGb"><spring:message code="tms.test.testcaseGb" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:out value='${testVoMap.testcaseGbNm}'/>
                                </td>
                                
                                 <th width="16.6%" height="23"  nowrap="nowrap"><label for="pgNm"><spring:message code="tms.test.pgNm" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                               		<c:out value='${testVoMap.pgNm}'/>
                                </td>
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="userId"><spring:message code="tms.test.userWriterId" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:out value='${testVoMap.userNm}'/>
                                </td>
                            </tr>
                            
                            <tr>
                             
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="taskGb"><spring:message code="tms.test.taskGb" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:out value='${testVoMap.taskGbNm}'/>
                                </td>
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="enrollDt"><spring:message code="tms.test.enrollDt" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:out value='${testVoMap.enrollDt}'/>
                                </td>
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="completeDt"><spring:message code="tms.test.completeDt" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:out value='${testVoMap.completeDt}'/>
                                </td>
                            </tr>
                            
                            <tr>
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.precondition" /></label>
                                </th>
                                <td width="83%" nowrap colspan="5">
                                   <c:out value='${testVoMap.precondition}'/>
                                   <input type="hidden" name="precondition" value="${testVoMap.precondition}" >
                                </td>
                            </tr>
                
	                		 <tr>
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.firstTest" /></label>
                                </th>
                                <td width="16.6%" nowrap >
									<c:out value="${testVoMap.firstTestResultYn}"></c:out>
                                </td>
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.secondTest" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                               		<c:out value="${testVoMap.secondTestResultYn}"></c:out>
                                </td>
                                  <th width="16.6%" height="23"  nowrap="nowrap"><label for="completeYn"><spring:message code="tms.test.completeYn" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:out value="${testVoMap.completeYn}"></c:out>
                                </td>
                            </tr>
                            
                        </table>
                    </div>
                   </form:form>
                    <br>
                
                	<form:form style="visibility:visible; margin-top:20px;" commandName="testScenarioList" name="testScenarioList" method="post" action="/tms/test/updateTestScenarioResultImpl.do">           
					<div id="border" class="modify_user" style="height:200px; width:92%; overflow:auto;" >
						
                        <table>
                        	<colgroup>
		        				<col width="4%"/>
		        				<col width="28%"/>
		        				<col width="16%"/>
		        				<col width="25%"/>
		        				<col width="10%"/>
		        				<col width="7%"/>
		        				<col width="6%"/>
	        				</colgroup>
                        
                            <tr>
                                <th height="23" rowspan="2"><label for="nttSj"><spring:message code="tms.test.ord" /></label>
                                </th>
                                <th height="23" rowspan="2"><label for="nttSj"><spring:message code="tms.test.testscenarioContent" /></label>
                                </th>
                                <th height="23" rowspan="2"><label for="nttSj"><spring:message code="tms.test.testCondition" /></label>
                                </th>
                                <th height="23" rowspan="2"><label for="nttSj"><spring:message code="tms.test.expectedResult" /></label>
                                </th>
                                <th height="23" colspan="3"><label for="nttSj"><spring:message code="tms.test.testResultYn" /></label>
                                </th>
                            </tr>
                            
                            <tr>
                            	<th><spring:message code="tms.test.testDt" /></th>
                            	<th><spring:message code="tms.test.userTestId" /></th>
                            	<th><spring:message code="tms.test.result" /></th>
                            </tr>
                            
                            <tbody>
                            <c:forEach var="result" items="${testScenarioList}" varStatus="status">
        			
		            			<tr onclick="testScenarioResultForm(this);">
							    	<td align="center" class="listtd"><c:out value="${result.testscenarioOrd}"/>&nbsp;
							    		<input type="hidden" name="checkField" class="check2" title="선택"/>
							       		<input type="hidden" name="checkMenuNo"  value="<c:out value='${result.testscenarioId}'/>"/>
							       		<input type="hidden" name="testscenarioId" value="${result.testscenarioId}"/>
		            					<input type="hidden" name="testResultContent" value="${result.testResultContent}"/>
		            					<input type="hidden" name="testResultYn" value="${result.testResultYn}"/>
							    	</td>
		            				<td align="center" class="listtd">
			            				<div>
			            					<a href="#" >
			            					<strong><c:out value="${result.testscenarioContent}"/></strong>
			            					</a>
			            				</div>
			            				<input class="checkScenarioId" type="hidden" value="<c:out value='${result.testscenarioId}'/>"/>
		            				</td>
		            				<td align="center"  class="listtd">
			            				<div >
			            					<c:out value="${result.testCondition}"/>
			            				</div>
		            				</td>
		            				<td align="center" class="listtd">
		            					<div >
		            						<c:out value="${result.expectedResult}"/>
		            					</div>
		            				</td>
		            				<td align="center" class="listtd">
			            				<div >
			            					<c:out value="${result.testDt}"/>
			            				</div>
		            				</td>
		            				<td align="center"  class="listtd" title="${result.userTestId}"><c:out value="${result.userTestNm}"/>&nbsp;</td>
		            				<td align="center"  class="listtd">
		            					<c:out value="${result.testResultYn}"/>
		            				</td>
		            			</tr>
        					</c:forEach>
        					</tbody>
                        </table>
                    </div>
                    </form:form>
				
			<form:form style="visibility:visible; margin-top:20px;" commandName="testScenarioVO" name="testScenarioResultInsert" method="post" action="/tms/test/updateTestScenarioResultImpl.do">           
					
								<%
									LoginVO loginVO = (LoginVO) session.getAttribute("LoginVO");
										if (loginVO == null) {
								%>

								<%
									} else {
								%>
								<c:set var="loginId" value="<%=loginVO.getId()%>" />
									<%
								}
								%>
					
					
					<div id="border" class="modify_user" >
						<input type="hidden" name="testscenarioId" value="${testScenarioList[0].testscenarioId}">
						<input type="hidden" name="testcaseId" value="${testVoMap.testcaseId}">
						<input type="hidden" name="userTestId" value="${loginId}"/>
						
                        <table>
                        	<colgroup>
		        				<col width="180"/>
		        				<col width="100"/>
	        				</colgroup>
                        
                            <tr>
                                <th height="23"  nowrap="nowrap" ><label for="nttSj"><spring:message code="tms.test.testResultContent" /></label>
                                </th>
                                <th height="23"  nowrap="nowrap" ><label for="nttSj"><spring:message code="tms.test.testResultYn" /></label>
                                </th>
                            </tr>
                            
	            			<tr>
                                <td>
                            		<textarea type="textarea" rows="3" style="width:100%" id="testResultContent" name="testResultContent" maxlength ="800"><c:out value="${testScenarioList[0].testResultContent}" /></textarea>
                            		<br/><form:errors path="testResultContent" />
                            	</td>
                            	
	            				<td align="center" class="listtd">
	            					<input type="radio" name="testResultYn" value="P" <c:if test="${testScenarioList[0].testResultYn == 'P'}">checked="checked"</c:if>>Pass&nbsp;
	  								<input type="radio" name="testResultYn" value="F" <c:if test="${testScenarioList[0].testResultYn == 'F'}">checked="checked"</c:if>>Fail&nbsp;
	  							</td>
	            			</tr>
                            
                        </table>
                    </div>

				<div class="tmsTestButton" >
				
	                    <ul>        
	           				<li>
								<div class="buttons">
	                                <a href="#" onclick="updateTestScenarioResult(); return false;"><spring:message code="button.save" /></a>
	                                <a href="<c:url value='/tms/test/selectTestResultList.do?testcaseGb=${testVoMap.testcaseGbCode }'/>"><spring:message code="button.list" /></a>
	                                <a href="#" onclick="insertDefect(); return false;" style="float:right;">결함등록</a>
								</div>	  				  			
		  					</li>             
	                    </ul>        
                </div>
				

			</form:form>
				
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