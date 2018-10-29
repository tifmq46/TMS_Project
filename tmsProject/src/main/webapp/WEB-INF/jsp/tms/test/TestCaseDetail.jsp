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
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="testCaseUpdate" staticJavascript="false" xhtml="true" cdata="false"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>



function updateTestCase(){
	
	if (!validateTestCaseUpdate(document.testCaseVO)){
        return;
    }
		swal({
			text: '<spring:message code="common.update.msg" />'
			,buttons : true
		})
		.then((result) => {
			if(result) {
				
				document.testCaseVO.action = "<c:url value='/tms/test/updateTestCaseImpl.do'/>";
		   	 	document.testCaseVO.submit();
			}else {
				
			}
		});
}

function deleteTestCase() {
	
	swal({
		text: '<spring:message code="common.delete.msg" />'
		,buttons : true
	})
	.then((result) => {
		if(result) {
			 
			document.testCaseVO.action = "<c:url value='/tms/test/deleteTestCaseImpl.do'/>";
	   	 	document.testCaseVO.submit(); 
		}else {
			
		}
	});
	
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
							<li>테스트관리</li>
							<li>&gt;</li>
							<li><strong>테스트케이스 상세</strong></li>
                        </ul>
                    </div>
                </div>
              
                <div id="page_info"><div id="page_info_align"></div></div>      
                             
                             
               <form:form commandName="testCaseVO" name="testCaseVO" method="post" action="/tms/test/updateTestCaseImpl.do">           
                 
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
                                	<c:out value='${testVoMap.testcaseGbNm}'/>
                                	<input type="hidden" name="testcaseGb" value="${testVoMap.testcaseGbCode}">
									<br/><form:errors path="testcaseGb" />
                                </td>
                          </tr>
                         <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="testcaseId"> 
                                    	<spring:message code="tms.test.testcaseId" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/></th>
                                <td width="80%" nowrap colspan="3">
                                    <c:out value='${testVoMap.testcaseId}'/>
                                    <input type="hidden" name="testcaseId" value="${testVoMap.testcaseId}" >
                                    <br/><form:errors path="testcaseId" /> 
                                </td>
                          </tr>
                          <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="testcaseContent"> 
                                    	<spring:message code="tms.test.testcaseContent" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/></th>
                                <td width="50%" nowrap colspan="3">
                                      <input type="text" title="게시판명입력" name="testcaseContent" style="width:99%" value="${testVoMap.testcaseContent}"/>
                                    <br/><form:errors path="testcaseContent" />
                                </td>
                          </tr>
                          <tr> 
                            <th height="23" class="required_text" >
                                <label for="pgId">
                                	<spring:message code="tms.test.pgId" />
                                </label>    
                            </th>
                            <td colspan="3">
                           		 <c:out value='${testVoMap.pgId}'/>
                            </td>
                          </tr>
                           <tr> 
                            <th height="23" class="required_text" >
                                <label for="pgNm">
                                	<spring:message code="tms.test.pgNm" />
                                </label>    
                            </th>
                            <td colspan="3">
                            	<c:out value='${testVoMap.pgNm}'/>
                            </td>
                          </tr>
                          <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="taskGb"> 
                                    	<spring:message code="tms.test.taskGb" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/></th>
                                <td width="80%" nowrap colspan="3">
                                	<c:out value='${testVoMap.taskGbNm}'/>
									<br/><form:errors path="taskGb" />
                                </td>
                          </tr>
                           <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="userId"> 
                                    	<spring:message code="tms.test.userWriterId" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/></th>
                                <td width="80%" nowrap colspan="3">
                                	<c:out value='${testVoMap.userNm}'/>
                                    <br/><form:errors path="userId" />
                                </td> 
                          </tr>
                          <tr> 
                            <th height="23" class="required_text" >
                                <label for="precondition">
                                	<spring:message code="tms.test.precondition" />
                                </label>    
                            </th>
                            <td colspan="3">
                            	 <textarea type="textarea" rows="3" style="width:100%"  name="precondition"><c:out value='${testVoMap.precondition}'/></textarea>
                            	<br/><form:errors path="precondition" />
                            </td>
                          </tr>
                           <tr> 
                            <th height="23" class="required_text" >
                                <label for="enrollDt">
                                	<spring:message code="tms.test.enrollDt" />
                                </label>    
                            </th>
                            <td colspan="3">
                            	<c:out value='${testVoMap.enrollDt}'/>
                            	<br/><form:errors path="enrollDt" />
                            </td>
                          </tr>
                       </table>
                    </div>
                    
                    <div class="tmsTestButton" style="margin-bottom:30px;">
	                  	<ul>        
	           				<li>
								<div id="buttonDiv" class="buttons">
	                                <a href="#" onclick="updateTestCase(); return false;"><spring:message code="button.save" /> </a>
	                                <a href="#" onclick="deleteTestCase(); return false;"><spring:message code="button.delete" /> </a>
	                                <a href="<c:url value='/tms/test/selectTestCaseList.do?testcaseGb=${testVoMap.testcaseGbCode}'/>"><spring:message code="button.list" /> </a>
								</div>	  				  			
		  					</li>             
	                    </ul>   
                	</div>
                	</form:form>
                


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