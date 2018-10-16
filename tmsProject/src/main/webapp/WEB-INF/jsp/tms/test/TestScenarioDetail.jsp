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

<title>테스트시나리오 상세</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="testScenarioUpdate" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">


function updateTestScenario(){
	
	if (!validateTestScenarioUpdate(document.testScenarioVO)){
        return;
    }
    if (confirm('<spring:message code="common.update.msg" />')) {
    	document.testScenarioVO.action = "<c:url value='/tms/test/updateTestScenarioImpl.do'/>";
   	 	document.testScenarioVO.submit();      
    }
}

function deleteTestScenario() {
	
	 if (confirm('<spring:message code="common.delete.msg" />')) {
	    	document.testScenarioVO.action = "<c:url value='/tms/test/deleteTestScenarioImpl.do'/>";
	   	 	document.testScenarioVO.submit();      
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
							<li>테스트관리</li>
							<li>&gt;</li>
							<li><strong>테스트시나리오 상세</strong></li>
                        </ul>
                    </div>
                </div>
              
                <div id="page_info"><div id="page_info_align"></div></div>      
                             
                        
             <form:form commandName="testScenarioVO" name="testScenarioVO" method="post" action="/tms/test/updateTestScenarioImpl.do">          

                 <div id="border" class="modify_user" >
                        <table>
                           	<tr>
                             	<th width="25%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.testcaseId" /></label>
                             	<img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                                </th>
								<td width="75%" colspan="3">
									<c:out value="${testScenarioVO.testcaseId}" ></c:out>
									<input type="hidden" name="testcaseId" value="${testScenarioVO.testcaseId}" />
                            	</td>
                            </tr>
                        
                            <tr>
                                <th width="25%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.testscenarioId" /></label>
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                                </th>
                                <td width="25%" nowrap >
                                  <c:out value='${testScenarioVO.testscenarioId}'/>
                                  <input type="hidden" name="testscenarioId" value="${testScenarioVO.testscenarioId}" />
                                </td>
                                
                                <th width="25%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.testscenarioOrd" /></label>
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                                </th>
                                <td width="25%" nowrap >
                                	<input id="testscenarioOrd" name="testscenarioOrd" type="text" size="25" value="<c:out value='${testScenarioVO.testscenarioOrd}'/>" > 
                                </td>
                            </tr>
                            
                             <tr>
                             	<th width="25%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.testCondition" /></label>
                                </th>
								<td width="75%" colspan="3">
                                	<textarea type="textarea" rows="2" style="width:100%" id="testCondition" name="testCondition"><c:out value='${testScenarioVO.testCondition}'/></textarea>
                            	</td>
                            </tr>
                            
                            
                            <tr>
                             	<th width="25%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.testscenarioContent" /></label>
                             	<img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                                </th>
								<td width="75%" colspan="3">
                            		<textarea type="textarea" rows="5" style="width:100%" id="testscenarioContent" name="testscenarioContent"><c:out value='${testScenarioVO.testscenarioContent}'/></textarea>
                            	</td>
                            </tr>
                            
                            <tr>
                            	<th width="25%" height="23"  nowrap="nowrap"><label for="nttSj"><spring:message code="tms.test.expectedResult" /></label>
                            	<img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                                </th>
                                <td width="75%" colspan="3">
                                	<textarea type="textarea" rows="5" style="width:100%" id="expectedResult" name="expectedResult"><c:out value='${testScenarioVO.expectedResult}'/></textarea>
                            	</td>
                            </tr>
                            
                        </table>
                    </div>
                    
                	</form:form>        
                    
                    <div class="tmsTestButton">
	                  	<ul>        
	           				<li>
								<div class="buttons">
	                                <a href="#" onclick="updateTestScenario(); return false;"><spring:message code="button.save" /></a>
				   					<a href="#" onclick="fDeleteMenuList(); return false;"><spring:message code="button.delete" /></a>
				   					<a href="<c:url value='/tms/test/selectTestScenarioList.do?testcaseGb=${testcaseGb}'/>"><spring:message code="button.list" /></a>
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