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

<title>테스트케이스 목록 조회</title>

<script type="text/javaScript" language="javascript" defer="defer">


function fn_egov_select_testCaseList(pageNo){
    document.listForm.pageIndex.value = pageNo; 
    document.listForm.action = "<c:url value='/tms/test/selectTestCaseList.do'/>";
    document.listForm.submit();  
}


function insertTestScenarioImpl(){
    document.insertForm.action = "<c:url value='/tms/test/insertTestScenarioImpl.do'/>";
    document.insertForm.submit();  
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
            <div id="content">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
							<li>HOME</li>
							<li>&gt;</li>
							<li>테스트관리</li>
							<li>&gt;</li>
							<li><strong>테스트시나리오 등록</strong></li>
                        </ul>
                    </div>
                </div>
              
                <div id="page_info"><div id="page_info_align"></div></div>      
                <br> 
               <div id="search_field_loc"><h2><strong>테스트시나리오 등록</strong></h2></div>
                        
                              
             <form:form commandName="testScenarioVO" name="insertForm" method="post" action="<c:url value='/tms/test/insertTestScenarioImpl.do'/>">          
                        
                 <div id="border" class="modify_user" >
                      <table>
                      
                      	<form:hidden path="userTestId" value="${userTestId}"/>
                         <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="testcaseId"> 
                                    	<spring:message code="tms.test.testcaseId" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/></th>
                                <td width="80%" nowrap colspan="3">
                                    <c:out value="${testcaseId}" ></c:out>
                                	<form:hidden path="testcaseId" value="${testcaseId}"/>
                                </td>
                          </tr>
                          <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="testscenarioId"> 
                                    	<spring:message code="tms.test.testscenarioId" />
                                    </label>
                                	<img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                               </th>
                                <td width="80%" nowrap colspan="3">
                                    <form:input title="게시판명입력" path="testscenarioId" size="60" cssStyle="width:50%" />
                                </td>
                          </tr>
                          <tr> 
                            <th height="23" class="required_text" >
                                <label for="testscenarioOrd">
                                	<spring:message code="tms.test.testscenarioOrd" />
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td colspan="3">
                                <form:input title="게시판명입력" path="testscenarioOrd" size="60" cssStyle="width:50%" value=""/>
                            </td>
                          </tr>
                          
                           <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="testCondition"> 
                                    	<spring:message code="tms.test.testCondition" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/></th>
                                <td width="80%" nowrap colspan="3">
                                    <form:input title="게시판명입력" path="testCondition" size="30" cssStyle="width:100%" />
                                </td>
                          </tr>
                          <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="testscenarioContent"> 
                                    	<spring:message code="tms.test.testscenarioContent" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/></th>
                                <td colspan="3">
                               	<form:textarea title="게시판소개입력" path="testscenarioContent" cols="75" rows="4" cssStyle="width:100%" />
                            	</td>
                          </tr>
                          <tr> 
                            <th height="23" class="required_text" >
                                <label for="expectedResult">
                                	<spring:message code="tms.test.expectedResult" />
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td colspan="3">
                               <form:textarea title="게시판소개입력" path="expectedResult" cols="75" rows="4" cssStyle="width:100%" />
                            </td>
                          </tr>
                        
                       </table>
                    </div>
             	
			</form:form>             	
             	
             		<div class="tmsTestButton" >
	                    <ul>        
	           				<li>
								<div class="buttons" style="float:right;">
				   					<a onclick="insertTestScenarioImpl(); return false;"><spring:message code="button.create" /></a>
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