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

<title>테스트 시나리오 상세</title>
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

function fCheckAll() {
    var checkField = document.testScenarioVO.checkField;
    if(document.testScenarioVO.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}

/* ********************************************************
 * 멀티삭제 처리 함수
 ******************************************************** */
function fDeleteMenuList() {
	
	
	var checkField = document.testScenarioVO.checkField;
    var menuNo = document.testScenarioVO.checkMenuNo;
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
                checkedCount++;
            }
        }
    }   

    if(checkedCount < 1) {
    	swal("삭제할 테스트시나리오를 선택하여주시기바랍니다.");
    } else {
    	swal({
    		text: '<spring:message code="common.delete.msg" />'
    		,buttons : true
    	})
    	.then((result) => {
    		if(result) {
    			document.testScenarioVO.checkedMenuNoForDel.value=checkMenuNos;
     		    document.testScenarioVO.action = "<c:url value='/tms/test/deleteMultiTestScenario.do'/>";
     		    document.testScenarioVO.submit(); 
    		}else {
    				
    		}
    	});
    }
   
}

function selectTestScenario() {
	
	var checkField = document.testScenarioVO.checkField;
    var menuNo = document.testScenarioVO.checkMenuNo;
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
                checkedCount++;
            }
        }
    }   
    if(checkedCount > 1){
    	swal("한개의 테스트시나리오만 선택하여주시기바랍니다.");
    } else if(checkedCount < 1) {
    	swal("수정할 테스트시나리오를 선택하여주시기바랍니다.");
    } else {
    	 document.testScenarioVO.action = "<c:url value='/tms/test/selectTestScenario.do?testscenarioId=" +  checkMenuNos + "'/>";
		 document.testScenarioVO.submit();
    }
}


function selectTestScenarioDetail(scenarioId) {
	 document.testScenarioVO.action = "<c:url value='/tms/test/selectTestScenario.do?testscenarioId=" +  scenarioId + "'/>";
	 document.testScenarioVO.submit();
}

function insertTestScenario(){
	document.testCaseVO.action = "<c:url value='/tms/test/insertTestScenario.do'/>";
	document.testCaseVO.submit();       
}

</script>

</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

<!-- 전체 레이어 시작 -->

<c:if test="${!empty message and fn:length(message) > 0}">
	<script type="text/javascript"> swal("${message}");</script>
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
							<li><strong>테스트 시나리오 상세</strong></li>
                        </ul>
                    </div>
                </div>
              
                <div id="page_info"><div id="page_info_align"></div></div>      
                             
                             
               <form:form commandName="testCaseVO" name="testCaseVO" method="post" action="/tms/test/updateTestCaseImpl.do">           
                 
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
                                	<c:out value='${testVoMap.completeYn}'/>
                                </td>
                            </tr>
                            
                        </table>
                    </div>
                    
                    <br>
                	</form:form>
                	
                	<div style="width:91%; ">
                	<span style="float:right; margin-bottom:5px;"><strong>총 ${scenarioCnt}개</strong></span>
                	</div>
                	
                	<form:form commandName="testScenarioVO" name="testScenarioVO" method="post" action="/tms/test/deleteMultiTestScenario.do">           
					<div id="border" class="modify_user" style="height:320px; width:92%; overflow:auto;">
						<input type="hidden" name="testcaseId" value="${testVoMap.testcaseId}" >
						<input type="hidden" name="testcaseContent" value="${testVoMap.testcaseContent}" >
						<input name="checkedMenuNoForDel" type="hidden" />
						
                        <table>
                        
	                        <colgroup>
		             		 	<col width="4%"/>
		        				<col width="11%"/> 
		        				<col width="43%"/>
		        				<col width="16%"/>
		        				<col width="26%"/>
        					</colgroup>
        					
                            <tr>
                            	<th height="23"  nowrap="nowrap" scope="col" class="f_field" nowrap="nowrap">
                            		<input type="checkbox" name="checkAll" class="check2" onclick="javascript:fCheckAll();" title="전체선택"/>
                            	</th>
                                <th height="23"  nowrap="nowrap" ><label for="nttSj"><spring:message code="tms.test.testscenarioIdSrt" /></label>
                                </th>
                                <th height="23"  nowrap="nowrap" ><label for="nttSj"><spring:message code="tms.test.testscenarioContent" /></label>
                                </th>
                                <th height="23"  nowrap="nowrap" ><label for="nttSj"><spring:message code="tms.test.testCondition" /></label>
                                </th>
                                <th height="23"  nowrap="nowrap" ><label for="nttSj"><spring:message code="tms.test.expectedResult" /></label>
                                </th>
                            </tr>
                            
                            <c:forEach var="result" items="${testScenarioList}" varStatus="status">
        			
		            			<tr>
			            			<td align="center" class="listtd" style="padding-left:2px; ">
							       		<input type="checkbox" name="checkField" class="check2" title="선택"/>
							       		<input name="checkMenuNo" type="hidden" value="<c:out value='${result.testscenarioId}'/>"/>
							    	</td>
							    	<td align="center" class="listtd" >
							    		<c:out value="${result.testscenarioId}"/>&nbsp;
							    	</td>
							    	
		            				<td align="left" class="listtd" >
	            						<a href="#LINK" onclick="selectTestScenarioDetail('${result.testscenarioId}'); return false;">
			            				<strong><c:out value="${result.testscenarioContent}"/></strong>
			            				</a>
		            				</td>
	            					<td align="left" class="listtd" >
	            						<c:out value="${result.testCondition}"/>&nbsp;
	            					</td>
	            					
	            					<td align="left" class="listtd" >
	            						<c:out value="${result.expectedResult}"/>&nbsp;
	            					</td>
		            			</tr>
        			</c:forEach>
                            
                        </table>
                    </div>

             	
             		<div class="tmsTestButton" >
	                    <ul>        
	           				<li>
								<div class="buttons">
				   					<a href="#LINK" onclick="insertTestScenario(); return false;"><spring:message code="button.create" /></a>
				   					<a href="#LINK" onclick="selectTestScenario(); return false;"><spring:message code="button.update" /></a>
									<a href="#LINK" onclick="fDeleteMenuList(); return false;"><spring:message code="button.delete" /></a>
									<a href= "<c:url value='/tms/test/selectTestScenarioList.do?testcaseGb=${testVoMap.testcaseGbCode} '/>"><spring:message code="button.list" /></a>
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