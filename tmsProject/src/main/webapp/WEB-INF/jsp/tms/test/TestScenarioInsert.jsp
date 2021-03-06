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
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<validator:javascript formName="testScenarioVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">


function insertTestScenarioImpl(){
	
	var inputTestscenarioId = $("#testscenarioIdDuplicationCheck").val();
	
	/* 특수문자 포함여부 체크 */
	var stringRegx = /[~!@\#$%<>^&*\()\-=+_\’]/gi; 
	var isValid = true; 
    if(stringRegx.test(inputTestscenarioId)) { 
       isValid = false;
       swal("테스트시나리오ID에 특수문자는 사용할 수 없습니다.");
     } 
	     
	   if(isValid){
	
	 $.ajax({
	   	 type :"POST"
	   	,url  : "<c:url value='/tms/test/checkTestScenarioIdDuplication.do'/>"
	   	,dataType : "json"
	   	,data : {testscenarioId:inputTestscenarioId}
	   	,success :  function(result){
	   		
	   		if(!result){
	   			swal("중복된 테스트시나리오ID 입니다.")
	   		} else {
	   			
	   			if (!validateTestScenarioVO(document.testScenarioVO)){
	   		        return;
	   		    }
	   		    
	   			swal({
	   				text: '<spring:message code="common.regist.msg" />'
	   				,buttons : true
	   			})
	   			.then((result) => {
	   				if(result) {
	   					document.testScenarioVO.action = "<c:url value='/tms/test/insertTestScenarioImpl.do'/>";
		   		   	    document.testScenarioVO.submit();  
	   				}else {
	   						
	   				}
	   			});
	   			
	   			
	   		}
	   	}
	   	, error :  function(request,status,error){
	   		 swal("에러");
		         swal("code:"+request.status+"\n"+"error:"+error);
	   	}
	   		
	   });
	 
	 }
	
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
							<li><strong>테스트시나리오 등록</strong></li>
                        </ul>
                    </div>
                </div>
              
                <div id="page_info"><div id="page_info_align"></div></div>      
                <br> 
               <div id="search_field_loc" style="font-family:'Malgun Gothic';"><h2><strong>테스트시나리오 등록</strong></h2></div>
                        
                              
             <form:form commandName="testScenarioVO" name="testScenarioVO" method="post" action="<c:url value='/tms/test/insertTestScenarioImpl.do'/>">          
                 <input type="hidden" name="testcaseGb" value="${testcaseGb}"/>
                 <div id="border" class="modify_user" >
                        <table>
                        
                        	<tr>
                             	<th width="20%" height="23"  nowrap="nowrap"><label for="testcaseId"><spring:message code="tms.test.testcaseId" /></label>
                             	<img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                                </th>
								<td width="20%" >
									<c:out value="${testcaseId}" ></c:out>
									<input type="hidden" name="testcaseId" value="${testcaseId}"/>
                            	</td>
                            	
                            	<th width="20%" height="23"  nowrap="nowrap"><label for="testcaseContent"><spring:message code="tms.test.testcaseContent" /></label>
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                                </th>
                                <td width="40%" nowrap >
                                	<c:out value="${testcaseContent}" ></c:out>
                                </td>
                            </tr>
                            <tr>
                                <th width="20%" height="23"  nowrap="nowrap"><label for="testscenarioId"><spring:message code="tms.test.testscenarioId" /></label>
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                                </th>
                                <td width="20%" nowrap >
                                  <input id="testscenarioIdDuplicationCheck" name="testscenarioId" type="text" style="width:90%;" >
                                  <br/><form:errors path="testscenarioId" />
                                </td>
                                
                                <th width="20%" height="23"  nowrap="nowrap"><label for="testscenarioOrd"><spring:message code="tms.test.testscenarioOrd" /></label>
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                                </th>
                                <td width="40%" nowrap >
                                	<input id="testscenarioOrd" name="testscenarioOrd" type="text" style="width:50%;"   >
                                	<br/><form:errors path="testscenarioOrd" /> 
                                </td>
                            </tr>
                            
                             <tr>
                             	<th width="20%" height="23"  nowrap="nowrap"><label for="testscenarioContent"><spring:message code="tms.test.testscenarioContent" /></label>
                                </th>
								<td width="80%" colspan="3">
                            		<textarea type="textarea" rows="5" style="width:100%" id="testscenarioContent" name="testscenarioContent"></textarea>
                            		<br/><form:errors path="testscenarioContent" />
                            	</td>
                            </tr>
                            
                            <tr>
                            	<th width="20%" height="23"  nowrap="nowrap"><label for="expectedResult"><spring:message code="tms.test.expectedResult" /></label>
                            	<img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                                </th>
                                <td width="80%" colspan="3">
                                	<textarea type="textarea" rows="5" style="width:100%" id="expectedResult" name="expectedResult"></textarea>
                            	</td>
                            </tr>
                            
                            <tr>
                             	<th width="20%" height="23"  nowrap="nowrap"><label for="testCondition"><spring:message code="tms.test.testCondition" /></label>
                                </th>
								<td width="80%" colspan="3">
                                	<textarea type="textarea" rows="2" style="width:100%" id="testCondition" name="testCondition"></textarea>
                                	<br/><form:errors path="testCondition" /> 
                            	</td>
                            </tr>
                        </table>
                    </div>
             	
			</form:form>             	
             	
             		<div class="tmsTestButton" >
	                    <ul>        
	           				<li>
								<div class="buttons">
				   					<a href="#" onclick="insertTestScenarioImpl(); return false;"><spring:message code="button.save" /></a>
				   					<a href= "<c:url value="/tms/test/insertTestScenario.do" />"><spring:message code="button.reset" /></a>
				   					<a href="<c:url value='/tms/test/selectTestCaseWithScenario.do?testcaseId=${testcaseId}'/>" ><spring:message code="button.list" /></a>
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