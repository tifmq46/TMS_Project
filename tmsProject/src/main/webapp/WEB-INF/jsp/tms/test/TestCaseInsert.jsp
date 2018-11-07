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

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<validator:javascript formName="testCaseVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">


window.onload = function(){
	
	document.getElementById('testcaseGb').onchange =  function(){
		var testcaseGbValue = $("#testcaseGb").val();
		$("#taskGbFormTd").empty();
		var str = ""
		if(testcaseGbValue == 'TC1'){
			str += "<input type='text' readonly='readonly' id='TmsProgrmFileNm_task_gb'  size='62' style='width:20%' />";
			$("#taskGbFormTd").append(str);
		}  else {
			$("#TmsProgrmFileNm_pg_id").val(null);
			$("#TmsProgrmFileNm_pg_nm").val(null);
			str += "<select name='taskGb' id='TmsProgrmFileNm_task_gb_code' ><c:forEach var='cmCode' items='${taskGbCode}'><option value='${cmCode.code}'>${cmCode.codeNm}</option></c:forEach></select>";
			$("#taskGbFormTd").append(str);
		} 
	};
};
 
 
function insertTestCaseImpl(){
	
	if($("#testcaseGb").val() == 'TC1' && $("#TmsProgrmFileNm_pg_id").val() == ""){
		swal('단위 테스트케이스 등록시 화면ID를 선택해야합니다.')
	} else {
	var inputTestcaseId = $("#testcaseIdDuplicationCheck").val();
	
	/* 특수문자 포함여부 체크 */
	var stringRegx = /[~!@\#$%<>^&*\()\-=+_\’]/gi; 
	var isValid = true; 
    if(stringRegx.test(inputTestcaseId)) { 
       isValid = false;
       swal("테스트케이스ID에 특수문자는 사용할 수 없습니다.");
     } 
	     
	   if(isValid){
		   $("#TmsProgrmFileNm_task_gb_code option").attr("disabled", "");
		   $.ajax({
			   	 type :"POST"
			   	,url  : "<c:url value='/tms/test/checkTestCaseIdDuplication.do'/>"
			   	,dataType : "json"
			   	,data : {testcaseId:inputTestcaseId}
			   	,success :  function(result){
			   		
			   		if(!result){
			   			swal("중복된 테스트케이스ID 입니다.")
			   		} else {
			   			
			   			if (!validateTestCaseVO(document.testCaseVO)){
			   		        return;
			   		    }
			   		    
			   			swal({
			   				text: '등록하시겠습니까?'
			   				,buttons : true
			   			})
			   			.then((result) => {
			   				if(result) {
			   					
			   					document.testCaseVO.action = "<c:url value='/tms/test/insertTestCaseImpl.do'/>";
				   		        document.testCaseVO.submit();  
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
	   } else {
		   
	   }
	     
	}
	
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
            <div id="content" style="font-family:'Malgun Gothic';">
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
              
              
              
                <div id="page_info"><div id="page_info_align" style="font-family:'Malgun Gothic';"></div></div>      
                <br>
               <div id="search_field_loc"><h2><strong>테스트케이스 등록</strong></h2></div>
                        
                              
             <form:form commandName="testCaseVO" name="testCaseVO" method="post" >          
                        
                 <div id="border" class="modify_user" >
                      <table>
                      
                      	<tr>
                              <th width="30%" height="23" class="required_text" nowrap >
                                    <label for="testcaseGb"> 
                                    	<spring:message code="tms.test.testcaseGb" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                               </th>
                                <td width="80%" nowrap colspan="3">
                                
	                                <select name="testcaseGb" id="testcaseGb" >
										<c:forEach var="cmCode" items="${tcGbCode}">
										<option value="${cmCode.code}">${cmCode.codeNm}</option>
										</c:forEach>
									</select>
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
                                    <form:input id="testcaseIdDuplicationCheck" type="text" title="게시판명입력" path="testcaseId"  cssStyle="width:20%" />
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
                                    <form:input type="text" title="게시판명입력" path="testcaseContent" cssStyle="width:99%" />
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
                                <form:input type="text"  readonly="true" title="게시판명입력" path="pgId" id="TmsProgrmFileNm_pg_id"  size="60" cssStyle="width:20%" />
                           		<a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
	                			<img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a>
                            </td>
                          </tr>
                           <tr> 
                            <th height="23" class="required_text" >
                                <label for="pgNm">
                                	<spring:message code="tms.test.pgNm" />
                                </label>    
                            </th>
                            <td colspan="3">
                                <form:input type="text" title="게시판명입력" path="" readonly="true" id="TmsProgrmFileNm_pg_nm"  size="60" cssStyle="width:20%" />
                            </td>
                          </tr>
                          <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="taskGb"> 
                                    	<spring:message code="tms.test.taskGb" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/></th>
                                <td width="80%" nowrap colspan="3" id="taskGbFormTd">
									<input type='text' title='게시판명입력' readonly="readonly" id='TmsProgrmFileNm_task_gb'  size='62' style='width:20%' />
                                </td>
                          </tr>
                          
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
					
                           <tr>
                              <th width="20%" height="23" class="required_text" nowrap >
                                    <label for="userId"> 
                                    	<spring:message code="tms.test.userWriterRealId" />
                                    </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/></th>
                                <td width="80%" nowrap colspan="3">
                                    <form:input type="text" readonly="true" path="userId" value="${loginId}" title="게시판명입력" id="TmsProgrmFileNm_user_real_id" size="30" cssStyle="width:20%"/>
                                    <form:hidden title="게시판명입력" path="" id="TmsProgrmFileNm_user_dev_id" />
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
                               <form:textarea type="textarea" title="게시판소개입력" path="precondition" cols="75" rows="4" cssStyle="width:100%" />
                            	<br/><form:errors path="precondition" />
                            </td>
                          </tr>
                         	<form:hidden path=""  id="TmsProgrmFileNm_sys_gb"/>
                         	<form:hidden path=""  id="TmsProgrmFileNm_pg_full"/>
                         	<form:hidden path="taskGb"  id="TmsProgrmFileNm_task_gb_code"/>
                       </table>
                    </div>
             	
			</form:form>             	
             	
             		<div class="tmsTestButton" >
	                    <ul>        
	           				<li>
								<div class="buttons">
				   					<a href="#" onclick="insertTestCaseImpl(); return false;"><spring:message code="button.save" /></a>
				   					<a href= "<c:url value="/tms/test/insertTestCase.do" />"><spring:message code="button.reset" /></a>
				   					<a href="javascript:history.go(-1);"><spring:message code="button.list" /></a>
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