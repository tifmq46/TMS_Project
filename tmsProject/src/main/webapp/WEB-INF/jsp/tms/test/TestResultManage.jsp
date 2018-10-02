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

<title>테스트케이스 상세</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>

function updateTestCase(){
	
    if (confirm('<spring:message code="common.update.msg" />')) {
    	document.testCaseVO.action = "<c:url value='/tms/test/updateTestCaseImpl.do'/>";
   	 	document.testCaseVO.submit();  
    }
}


/* ********************************************************
 * 멀티삭제 처리 함수
 ******************************************************** */
function fDeleteMenuList() {
    var checkField = document.menuManageForm.checkField;
    var menuNo = document.menuManageForm.checkMenuNo;
    var checkMenuNos = "";
    var checkedCount = 0;
    if(checkField) {

        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkMenuNos += ((checkedCount==0? "" : ",") + menuNo[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkMenuNos = menuNo.value;
            }
        }
    }   

    document.menuManageForm.checkedMenuNoForDel.value=checkMenuNos;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageListDelete.do'/>";
    document.menuManageForm.submit(); 
}


function UpdateScenarioResultAll() {
	
	 if (confirm('<spring:message code="common.update.msg" />')) {
	
	var updateScenarioCount = $('.checkScenarioId').length;
	var updateArray = new Array();
	 
	$('.checkScenarioId').each(function(){
		var updateScenarioId 	= $(this).val();
		var updateScenarioValue = document.getElementById(updateScenarioId).value;
		var updateScenarioData	= new Object();
		
		updateScenarioData.testscenarioId 	= updateScenarioId;
		updateScenarioData.testResultYn 	= updateScenarioValue;
		updateArray.push(updateScenarioData);
	});
	
	document.testScenarioVO.updateScenarioDataJson.value = JSON.stringify(updateArray);
	document.testScenarioVO.action = "<c:url value='/tms/test/updateTestScenarioMultiResultImpl.do'/>";
	document.testScenarioVO.submit(); 

	 }
}

function deleteTestCase() {
	
	if (confirm('<spring:message code="common.delete.msg" />')) {
    	document.testCaseVO.action = "<c:url value='/tms/test/deleteTestCaseImpl.do'/>";
   	 	document.testCaseVO.submit();       
    }
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
							<li><c:out value='${testVoMap.testcaseGbNm}'/>&nbsp;테스트관리</li>
							<li>&gt;</li>
							<li><strong>결과 관리</strong></li>
                        </ul>
                    </div>
                </div>
              
                <div id="page_info"><div id="page_info_align"></div></div>      
                             
                             
               <form:form commandName="testCaseVO" name="testCaseVO" method="post" action="<c:url value='/tms/test/updateTestCaseImpl.do'/>">           
                 
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
                                
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.secondTest" /></label>
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
                              <%--   
                                <th width="16.6%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.thirdTest" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:out value="${testVoMap.thirdTestResultYn}"></c:out>
                                </td> 
                                 --%>
                                  <th width="16.6%" height="23"  nowrap="nowrap"><label for="completeYn"><spring:message code="tms.test.completeYn" /></label>
                                </th>
                                <td width="16.6%" nowrap >
                                	<c:choose>
                                		<c:when test="${testVoMap.completeYn == 'Y'}">
	                                		<input type="radio" name="completeYn" value="Y" checked>Y
	  										&nbsp;<input type="radio" name="completeYn" value="N">N
                                		</c:when>
                                		
                                		<c:when test="${testVoMap.completeYn == 'N'}">
	                                		<input type="radio" name="completeYn" value="Y" >Y
	  										&nbsp;<input type="radio" name="completeYn" value="N" checked>N
                                		</c:when>
                                		
                                		<c:otherwise>
                                			<input type="radio" name="completeYn" value="Y">Y
	  										&nbsp;<input type="radio" name="completeYn" value="N">N
                                		</c:otherwise>
                                	</c:choose>
                                </td>
                            </tr>
                            
                        </table>
                    </div>
                    
                    <br>
                	</form:form>
                
                   <form:form commandName="testScenarioVO" name="testScenarioVO" method="post" action="<c:url value='/tms/test/updateTestScenarioMultiResultImpl.do'/>">           
					<div id="border" class="modify_user" style="height:200px; width:92%; overflow:auto; " >
						
						<input type="hidden" name="testcaseId" value="${testVoMap.testcaseId}" >
						<input type="hidden" name="updateScenarioDataJson" >
                        <table>
                        	<colgroup>
		        				<col width="40"/>
		        				<col width="180"/>
		        				<col width="100"/>
		        				<col width="180"/>
		        				<col width="120"/>
		        				<col width="60"/>
		        				<col width="60"/>
	        				</colgroup>
                        
                            <tr>
                                <th height="23"  nowrap="nowrap" rowspan="2"><label for="nttSj"><spring:message code="tms.test.ord" /></label>
                                </th>
                                <th height="23"  nowrap="nowrap" rowspan="2"><label for="nttSj"><spring:message code="tms.test.testscenarioContent" /></label>
                                </th>
                                <th height="23"  nowrap="nowrap" rowspan="2"><label for="nttSj"><spring:message code="tms.test.testCondition" /></label>
                                </th>
                                <th height="23"  nowrap="nowrap" rowspan="2"><label for="nttSj"><spring:message code="tms.test.expectedResult" /></label>
                                </th>
                                <th height="23"  nowrap="nowrap" rowspan="2"><label for="nttSj"><spring:message code="tms.test.testResultYn" /></label>
                                </th>
                                <th height="23"  nowrap="nowrap" colspan="2"><label for="nttSj"><spring:message code="tms.test.testResultYn" /></label>
                                </th>
                            </tr>
                            
                            <tr>
                            	<th><spring:message code="tms.test.userTestId" /></th>
                            	<th><spring:message code="tms.test.result" /></th>
                            </tr>
                            
                            <c:forEach var="result" items="${testScenarioList}" varStatus="status">
        			
		            			<tr>
							    	<td align="center" class="listtd"><c:out value="${result.testscenarioOrd}"/>&nbsp;</td>
		            				<td align="center" class="listtd">
	            						<a href= "<c:url value='/tms/test/selectTestScenarioResult.do?testscenarioId=${result.testscenarioId}'/>">
			            				<strong><c:out value="${result.testscenarioContent}"/></strong>
			            				</a>
			            				<input class="checkScenarioId" type="hidden" value="<c:out value='${result.testscenarioId}'/>"/>
		            				</td>
		            				<td align="center" class="listtd"><c:out value="${result.testCondition}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.expectedResult}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.testResultContent}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.userTestId}"/>&nbsp;</td>
		            				<td align="center" class="listtd">
		            					<select name="testResultYn" id="<c:out value='${result.testscenarioId}'/>" >
           									<option value="">없음</option>
           									<option value="P" <c:if test="${result.testResultYn == 'P'}">selected="selected"</c:if>>Pass</option>
           									<option value="F" <c:if test="${result.testResultYn == 'F'}">selected="selected"</c:if>>Fail</option>
		            					</select>	
		            				</td>
		            			</tr>
        					</c:forEach>
                        </table>
                    </div>
				</form:form>
				
					<div class="tmsTestButton" >
	                    <ul>        
	           				<li>
								<div class="buttons">
	                                <a href="#" onclick="UpdateScenarioResultAll(); return false;"><spring:message code="button.save" /> </a>
								</div>	  				  			
		  					</li>             
	                    </ul>        
                   </div>
				
				
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