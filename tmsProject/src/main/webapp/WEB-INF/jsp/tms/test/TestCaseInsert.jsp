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

<title>테스트케이스 등록</title>

<script type="text/javaScript" language="javascript" defer="defer">


function insertTestCaseImpl(){
    document.insertForm.action = "<c:url value='/tms/test/insertTestCaseImpl.do'/>";
    document.insertForm.submit();  
}

function searchFileNm() {
    window.open("<c:url value='/sym/prm/TmsProgramListSearch.do'/>",'','width=800,height=600');
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
							<li><strong>테스트케이스 등록</strong></li>
                        </ul>
                    </div>
                </div>
              
              
              
                <div id="page_info"><div id="page_info_align"></div></div>      
                <br>
               <div id="search_field_loc"><h2><strong>테스트케이스 등록</strong></h2></div>
                        
                              
             <form:form commandName="testCaseVO" name="insertForm" method="post" >          
                        
                 <div id="border" class="modify_user" >
                      <table>
                      
                      	<tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="testcaseGb"> 
                                    	<spring:message code="tms.test.testcaseGb" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                               </th>
                                <td width="80%" nowrap colspan="3">
                                
	                                <select name="testcaseGb" id="testcaseGb">
										<c:forEach var="cmCode" items="${tcGbCode}">
										<option value="${cmCode.code}">${cmCode.codeNm}</option>
										</c:forEach>
									</select>
                                </td>
                          </tr>
                         <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="testcaseId"> 
                                    	<spring:message code="tms.test.testcaseId" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/></th>
                                <td width="80%" nowrap colspan="3">
                                    <form:input title="게시판명입력" path="testcaseId"  cssStyle="width:50%" />
                                </td>
                          </tr>
                          <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="testcaseContent"> 
                                    	<spring:message code="tms.test.testcaseContent" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/></th>
                                <td width="80%" nowrap colspan="3">
                                    <form:input title="게시판명입력" path="testcaseContent" cssStyle="width:80%" />
                                </td>
                          </tr>
                          <tr> 
                            <th height="23" class="required_text" >
                                <label for="pgId">
                                	<spring:message code="tms.test.pgId" />
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td colspan="3">
                                <form:input title="게시판명입력" path="pgId" id="TmsProgrmFileNm_pg_id"  size="60" cssStyle="width:50%" />
                           		<a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
	                			<img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a>
                            </td>
                          </tr>
                          <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="taskGb"> 
                                    	<spring:message code="tms.test.taskGb" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/></th>
                                <td width="80%" nowrap colspan="3">
                                
	                                 <select name="taskGb" id="TmsProgrmFileNm_task_gb">
										<option value="">없음</option>
										<c:forEach var="cmCode" items="${taskGbCode}">
										<option value="${cmCode.codeNm}">${cmCode.codeNm}</option>
										</c:forEach>
									</select>
                                </td>
                          </tr>
                           <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="userId"> 
                                    	<spring:message code="tms.test.userWriterId" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/></th>
                                <td width="80%" nowrap colspan="3">
                                    <form:input title="게시판명입력" path="userId" id="TmsProgrmFileNm_user_dev_id" size="30" cssStyle="width:50%"/>
                                </td>
                          </tr>
                          <tr> 
                            <th height="23" class="required_text" >
                                <label for="precondition">
                                	<spring:message code="tms.test.precondition" />
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td colspan="3">
                               <form:textarea title="게시판소개입력" path="precondition" cols="75" rows="4" cssStyle="width:100%" />
                            </td>
                          </tr>
                         	<form:hidden path=""  id="TmsProgrmFileNm_sys_gb"/>
                         	<form:hidden path=""  id="TmsProgrmFileNm_pg_nm"/>
                       </table>
                    </div>
             	
			</form:form>             	
             	
             		<div class="tmsTestButton" >
	                    <ul>        
	           				<li>
								<div class="buttons" style="float:right;">
				   					<a onclick="insertTestCaseImpl(); return false;"><spring:message code="button.create" /></a>
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