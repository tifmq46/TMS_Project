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

<title>단위 테스트 시나리오 목록 조회</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">

function fn_egov_select_testCaseList(pageNo){
    document.listForm.pageIndex.value = pageNo; 
    document.listForm.action = "<c:url value='/tms/test/selectTestScenarioList.do?testcaseGb=TC1'/>";
    document.listForm.submit();  
}

function searchFileNm() {
    window.open("<c:url value='/sym/prm/TmsProgramListSearch.do'/>",'','width=800,height=600');
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
		    	alert("삭제할 테스트시나리오를 선택하여주시기바랍니다.");
		    } else {
		    	if (confirm('<spring:message code="common.delete.msg" />')) {
		    		document.testScenarioVO.checkedMenuNoForDel.value=checkMenuNos;
		 		    document.testScenarioVO.action = "<c:url value='/tms/test/deleteMultiTestScenario.do'/>";
		 		    document.testScenarioVO.submit(); 
		    	}
		    }
}

var testcaseGb ="";
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
    	alert("한개의 테스트시나리오만 선택하여주시기바랍니다.");
    } else if(checkedCount < 1) {
    	alert("수정할 테스트시나리오를 선택하여주시기바랍니다.");
    } else {
    	 document.testScenarioVO.action = "<c:url value='/tms/test/selectTestScenario.do?testscenarioId=" +  checkMenuNos + "'/>";
		 document.testScenarioVO.submit();
    }
}


function selectTestScenarioOnScenarioListPg(caseId,caseGb){
	
    $.ajax({
    	
   	 type :"POST"
   	,url  : "<c:url value='/tms/test/selectTestScenarioOnScenarioListPg.do'/>"
   	,dataType : "json"
   	,data : {testcaseId:caseId, testcaseGb:caseGb}
   	,success :  function(result){
   		
   		testcaseGb = result.testVoMap.testcaseGbCode;
   		$("#testScenarioListAjaxTbody").empty();
   		$("#testCaseAjaxTbody").empty();
   		$("#paging_div").empty();
   		$("#testScenarioListAjaxButtons").empty();
   		
   		var testCaseStr = "";

   		testCaseStr += "<td align='center' class='listtd' ><strong>1</strong></td>";      
   		testCaseStr += "<td align='left' class='listtd'>" + result.testVoMap.testcaseId + "</td>";
   		testCaseStr += "<td align='left' class='listtd'>";
   		testCaseStr += "<a href='<c:url value='/tms/test/selectTestScenarioList.do?testcaseGb=" + result.testVoMap.testcaseGbCode + "'/>' >";
   		testCaseStr += "<strong>" + result.testVoMap.testcaseContent +"</strong>";
   		testCaseStr += "</a>";
   		testCaseStr += "</td>";
   		testCaseStr += "<td align='center' class='listtd'>" + result.testVoMap.userNm +"</td>";
   		testCaseStr += "<td align='center' class='listtd'>" + result.testVoMap.taskGbNm + "</td>";
   		testCaseStr += "<td align='center' class='listtd'>" + result.testVoMap.enrollDt + "</td>";
   		testCaseStr += "<td align='center' class='listtd'>" + result.testVoMap.completeYn + "</td>";
   		testCaseStr += "</tr>";
   		$("#testCaseAjaxTbody").append(testCaseStr);
   		
   		document.testScenarioVO.testcaseGb.value= result.testVoMap.testcaseGbCode;
   		
   		var buttonsStr = "";
   		
   		buttonsStr += "<ul>";       
   		buttonsStr += "<li>";
   		buttonsStr += "<div class='buttons'>";
   		buttonsStr += "<a href= '<c:url value='/tms/test/insertTestScenario.do?testcaseGb=" + result.testVoMap.testcaseGbCode + "&amp;testcaseId=" + result.testVoMap.testcaseId + "'/>'><spring:message code='button.create' /></a>";
   		buttonsStr += "<a href='#LINK' onclick='selectTestScenario(); return false;'><spring:message code='button.update' /></a>";
   		buttonsStr += "<a href='#LINK' onclick='fDeleteMenuList(); return false;'><spring:message code='button.delete' /></a>";
   		buttonsStr += "<a href='<c:url value='/tms/test/selectTestScenarioList.do?testcaseGb=" + result.testVoMap.testcaseGbCode + "'/>' ><spring:message code='button.list' /></a>";
   		buttonsStr += "</div>";				  			
   		buttonsStr += "</li>";            
   		buttonsStr += "</ul>";      
   		$("#testScenarioListAjaxButtons").append(buttonsStr);
   		
   		$.each(result.testScenarioList, function(index,item){
   			
   			var str = "";
	   			
	   			str += "<tr>";
	   			str += "<td align='center' class='listtd' style='padding-left:2px; '>";
	   			str += "<input type='checkbox' name='checkField' class='check2' title='선택'/>";
	   			str += "<input name='checkMenuNo' type='hidden' value='" + item.testscenarioId +"'/>";
	   			str += "</td>";
	   			str += "<td align='center' class='listtd' >" + item.testscenarioOrd +"</td>";
	   			str += "<td align='center' class='listtd' >";
	   			str += "<a href= '<c:url value='/tms/test/selectTestScenario.do?testscenarioId=" + item.testscenarioId + "&amp;testcaseGb=" +result.testcaseGb+  "'/>'>";
	   			str += "<strong>" + item.testscenarioContent + "</strong>";
	   			str += "</a>";
	   			str += "</td>";
	   			str += "<td align='center' class='listtd' >";
	   			str += item.testCondition;
	   			str += "</td>";
	   			str += "<td align='center' class='listtd' >";
	   			str += item.expectedResult;
	   			str += "</td>";
	   			str += "</tr>";
	   				
	   			$("#testScenarioListAjaxTbody").append(str);
   		});
    		$("#testScenarioAjaxTable").toggle();
   		
   		
   	}
   	, error :  function(request,status,error){
   		 alert("에러");
	         alert("code:"+request.status+"\n"+"error:"+error);
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
            <div id="content">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
							<li>HOME</li>
							<li>&gt;</li>
							<li>테스트관리</li>
							<li>&gt;</li>
							<li>단위 테스트 관리</li>
							<li>&gt;</li>
							<li><strong>시나리오 관리</strong></li>
                        </ul>
                    </div>
                </div>
    
    		 <br>
              <div id="search_field_loc"><h2><strong>단위 테스트 시나리오 관리</strong></h2></div>
              
		         <form:form commandName="searchVO" name="listForm" method="post" action="/tms/test/selectTestCaseList.do">   
                <!-- 검색 필드 박스 시작 -->
					<div id="search_field">
					
					  	<fieldset><legend>조건정보 영역</legend>	
					  	
				  	 	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					  	 
					  	<div class="sf_start">
					  		<ul id="search_first_ul">
					  		
					  			<li><label for="searchByTestcaseId"><spring:message code="tms.test.testcaseId" /></label></li>
					  			<li><input type="text" name="searchByTestcaseId" id="searchByTestcaseId" value="<c:out value='${searchVO.searchByTestcaseId}'/>" /></li>
					  			
					  			<li><label for="searchByPgId"><spring:message code="tms.test.pgId" /></label></li>
					  			<li><input type="text" name="searchByPgId" id="TmsProgrmFileNm_pg_id"  value="<c:out value='${searchVO.searchByPgId}'/>"/>
					  			<a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
	                			<img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a>
					  			</li>
					  			
					  		</ul>	
					  		
					  		<ul id="search_second_ul">
					  			<li><label for="searchByTaskGb"><spring:message code="tms.test.taskGb" /></label></li>
					  			
								<li>
									<select name="searchByTaskGb" id="searchByTaskGb">
										<option value="">전체</option>
										<c:forEach var="cmCode" items="${taskGbCode}">
										<option value="${cmCode.code}"  <c:if test="${searchVO.searchByTaskGb == cmCode.code}">selected="selected"</c:if>>${cmCode.codeNm}</option>
										</c:forEach>
									</select>						
					  			</li>
					  			
					  			
					  			<li><label for="searchByResultYn"><spring:message code="tms.test.completeYn" /></label></li>
					  			<li>
									<select name="searchByResultYn" id="searchByResultYn">
										<option value="">전체</option>
										<c:forEach var="cmCode" items="${resultYnCode}">
										<option value="${cmCode.code}"  <c:if test="${searchVO.searchByResultYn == cmCode.code}">selected="selected"</c:if> >${cmCode.codeNm}</option>
										</c:forEach>
									</select>							
					  			</li>
					  			
					  			
					  			<li>
									<div class="buttons" style="float:right;">
									    
                                        <a href="<c:url value='/tms/test/selectTestCaseList.do'/>" onclick="fn_egov_select_testCaseList('1'); return false;"><img src="<c:url value='/images/img_search.gif' />" alt="search" />
										<spring:message code="button.inquire" /></a>
									</div>	  				  			
					  			</li> 
					  			
					  		</ul>		
					  				
						</div>			
						</fieldset>
						
					</div>
 					</form:form>
				<!-- //검색 필드 박스 끝 -->
                

                <div id="page_info"><div id="page_info_align"></div></div>     
                
                
                <div class="default_tablestyle">
              	<table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
                <caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
              
              
             		 <colgroup>
             		 	<col width="6%"/>
        				<col width="12%"/> 
        				<col width="49%"/>
        				<col width="6%"/>
        				<col width="10%"/>
        				<col width="9%"/>
        				<col width="8%"/>
        			</colgroup>
        			
        			<thead>
        			<tr>
        			    <th align="center"><spring:message code="tms.test.no" /></th>
        			    <th align="center"><spring:message code="tms.test.testcaseId" /></th>
        			    <th align="center"><spring:message code="tms.test.testcaseContent" /></th>
        			    <th align="center"><spring:message code="tms.test.userWriterId" /></th>
        				<th align="center"><spring:message code="tms.test.taskGb" /></th>
			        	<th align="center"><spring:message code="tms.test.enrollDt" /></th>
        				<th align="center"><spring:message code="tms.test.completeYn" /></th>
        			</tr>
        			</thead>
        			
        			<tbody id="testCaseAjaxTbody">
	        			<c:forEach var="result" items="${testCaseList}" varStatus="status">
	        				<input type="hidden" name="pgId" value="<c:out value='${result.pgId}'/>">
	            			<tr>
	            			    <td align="center" class="listtd" ><strong><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></strong></td>          
	            				<td align="left" class="listtd"><c:out value="${result.testcaseId}"/></td>
	            				<td align="left" class="listtd">
	            					<a href="<c:url value='/tms/test/selectTestCaseWithScenario.do?testcaseId=${result.testcaseId}' />">
		            					<strong><c:out value="${result.testcaseContent}"/></strong>
		            				</a>
	            				</td>
	            				<td align="center" class="listtd"><c:out value="${result.userNm}"/>&nbsp;</td>
	            				<td align="center" class="listtd"><c:out value="${result.taskGbNm}"/>&nbsp;</td>
	            				<td align="center" class="listtd"><c:out value="${result.enrollDt}"/>&nbsp;</td>
	            				<td align="center" class="listtd"><c:out value="${result.completeYn}"/>&nbsp;</td>
	            			</tr>
	        			</c:forEach>
        			</tbody>
              </table>        
           </div>


            <!-- 페이지 네비게이션 시작 -->
           <div id="paging_div">
               <ul class="paging_align">
                  <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_testCaseList"  />
               </ul>
           </div>                          
           <!-- //페이지 네비게이션 끝 -->  	



           <form:form commandName="testScenarioVO" name="testScenarioVO" method="post" action="/tms/test/deleteMultiTestScenario.do">           

				<div id="testScenarioAjaxTable" class="default_tablestyle" style="display:none; margin-top:20px; height:300px; width:100%; overflow:auto;">
	              	
	              	<input name="checkedMenuNoForDel" type="hidden" />
	              	<input name="testcaseGb" type="hidden" />
	              	<table border="0" bordercolor="#81B1D5"  cellpadding="1" cellspacing="1" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
	                <caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
	              
	              		<colgroup>
	             		 	<col width="5%" >
	             		 	<col width="5%"/>
	        				<col width="30%"/> 
	        				<col width="30%"/>
	        				<col width="30%"/>
	        			</colgroup>
	              			
	        			<thead>
	    					<tr style="background-color:#a8c9e247;">
	    						<th height="23"  nowrap="nowrap" scope="col" class="f_field" nowrap="nowrap">
	                        		<input type="checkbox" name="checkAll" class="check2" onclick="javascript:fCheckAll();" title="전체선택"/>
	                        	</th>
	                            <th height="23"  nowrap="nowrap" ><label for="nttSj"><spring:message code="tms.test.ord" /></label>
	                            </th>
	                            <th height="23"  nowrap="nowrap" ><label for="nttSj"><spring:message code="tms.test.testscenarioContent" /></label>
	                            </th>
	                            <th height="23"  nowrap="nowrap" ><label for="nttSj"><spring:message code="tms.test.testCondition" /></label>
	                            </th>
	                            <th height="23"  nowrap="nowrap" ><label for="nttSj"><spring:message code="tms.test.expectedResult" /></label>
	                            </th>
	    					</tr>
	        			</thead>
	        			
	        			<tbody id="testScenarioListAjaxTbody">
	        			
	        			</tbody>
	        			
	              </table>   
	              
	              <div id="testScenarioListAjaxButtons"  class="tmsTestButton" >
		                      
	               </div>     
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