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
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>테스트 통계</title>
<script type="text/javaScript" language="javascript" defer="defer">

$(document).ready(function() {
	
	$('ul.tabs li').click(function() {
		var tab_id = $(this).attr('data-tab');
		if(!(tab_id == "tab-3")){
			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
			
			$(this).addClass('current');
			$("#" + tab_id).addClass('current');
			
			if(tab_id=="tab-1") {
					document.getElementById("StatsByUtcToExcel").style.display="inline"
					document.getElementById("StatsByTtcToExcel").style.display="none"
			} else {
					document.getElementById("StatsByUtcToExcel").style.display="none"
					document.getElementById("StatsByTtcToExcel").style.display="inline"
			}
		}
	})
})


function statsToExel(testcaseGb) {
	location.href = "./statsToExcel.do?testcaseGb=" + testcaseGb;
}

</script>


<style type="text/css">

ul.tabs {
	margin: 0px;
	padding: 0px;
	list-style: none;
	border-bottom: 1px solid #DDDDDD;
	
}

ul.tabs li {
	background: none;
	color: #727272;
	font-weight:bold;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
	border-right: 1px solid #DDDDDD;
	border-left: 1px solid #DDDDDD;
	border-top: 1px solid #DDDDDD;
}

ul.tabs li.current {
	background: #007bff;
	font-weight:bold;
	color:#ffffff;
	border-right: 1px  #DDDDDD;
	border-left: 1px  #DDDDDD;
	border-top: 1px  #DDDDDD;
}

ul.tabs li.last {
	background: #ffffff;
	font-weight:bold;
	color:#ffffff;
	border-right: 0px;
	border-left: 0px;
	border-top: 0px;
	border-bottom: 0px;
}

.tab-content {
	display: none;
	padding: 15px;
}

.tab-content.current {
	display: inherit;
	border: 1px solid #fff;
}


th,td{
	border-left : 1px solid #81B1D5;
	border-top : 1px solid #81B1D5;
}

</style>



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
							<li><strong>테스트통계</strong></li>
                        </ul>
                    </div>
                </div>
              
              	<br/> <br/>
				<div id="search_field" style="font-family:'Malgun Gothic';">
					<div id="search_field_loc">
						<h2>
							<strong>테스트 통계 (표)</strong>
						</h2>
					</div>
				</div>
				<br/><br/><br/><br/>
                             
               	<ul class="tabs">
					<li class="tab-link current" data-tab="tab-1">단위</li>
					<li class="tab-link" data-tab="tab-2">통합</li>
					<li class="tab-link last" data-tab="tab-3" style="float:right">
						<div class="buttons" id="StatsByUtcToExcel" style="display:inline">
							<a href="#" onclick="javascript:statsToExel('TC1'); return false;"><spring:message code="tms.test.exelDownload" /></a>
						</div>
						<div class="buttons" id="StatsByTtcToExcel" style="display:none">
							<a href="#" onclick="javascript:statsToExel('TC2'); return false;"><spring:message code="tms.test.exelDownload" /></a>
						</div>
					</li>
				</ul>             
                             
                <div id="tab-1" class="tab-content current">
					<div id="StatsByUtc">
	               	 <div class="default_tablestyle">
		              	<table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
			              	<colgroup>
			        				<col width="10%"/>
			        				<col width="10%"/>
			        				<col width="10%"/>
			        				<col width="12%"/>
			        				<col width="7%"/>
			        				<col width="7%"/>
			        				<col width="7%"/>
			        				<col width="8%"/>
			        				<col width="7%"/>
			        				<col width="7%"/>
			        				<col width="7%"/>
			        				<col width="8%"/>
			        		</colgroup>
		        			<tr>
		        				<th align="center" rowspan="2"><spring:message code="tms.test.sysGb" /></th>
		        				<th align="center" rowspan="2"><spring:message code="tms.test.taskGb" /></th>
		        				<th align="center" rowspan="2"><spring:message code="tms.test.pgCnt" /></th>
		        				<th align="center" rowspan="2"><spring:message code="tms.test.testcaseCnt" /></th>
					        	<th align="center" colspan="3"><spring:message code="tms.test.testProgress" /></th>
					        	<th align="center" rowspan="2"><spring:message code="tms.test.progressPct" />(%)</th>
					        	<th align="center" colspan="3"><spring:message code="tms.test.testResultYn" /></th>
					        	<th align="center" rowspan="2" class="borderLine" ><spring:message code="tms.test.completeYPct" />(%)</th>
		        			</tr>
		        			
		        			<tr>
					        	<th align="center"><spring:message code="tms.test.notStartTest" /></th>
					        	<th align="center"><spring:message code="tms.test.firstTest" /></th>
					        	<th align="center"><spring:message code="tms.test.secondTest" /></th>
					        	<th align="center"><spring:message code="tms.test.resultY" /></th>
					        	<th align="center"><spring:message code="tms.test.resultN" /></th>
					        	<th align="center"><spring:message code="tms.test.totCnt" /></th>
		        			</tr>
		        			
		        			<c:forEach var="result" items="${testStatsByUtc}" varStatus="status">
		        			
		            			<tr>	
		           					<c:choose>
		           					
		           						<c:when test="${result.sysGb eq '합계'}">
		            						<td align="center" class="lineStyle2 line"><c:out value="${result.sysGb}"/></td>            					
		            						<td align="center" class="lineStyle2 line"><c:out value="${result.taskGb}"/></td>
											<td align="center" class="lineStyle2 line"><c:out value="${result.pgCnt}"/></td> 
				            				<td align="center" class="lineStyle2 line"><c:out value="${result.tcWriteYCnt}"/></td> 
				            				<td align="center" class="lineStyle2 line"><c:out value="${result.notTestCnt}"/></td>
				            				<td align="center" class="lineStyle2 line"><c:out value="${result.firstTestCnt}"/></td>
				            				<td align="center" class="lineStyle2 line"><c:out value="${result.secondTestCnt}"/></td>
				            				<td align="center" class="lineStyle2 line"><c:out value="${result.tcProgressPct}"/></td>
				            				<td align="center" class="lineStyle2 line"><c:out value="${result.tcResultYCnt}"/></td>
				            				<td align="center" class="lineStyle2 line"><c:out value="${result.tcResultNCnt}"/></td>
				            				<td align="center" class="lineStyle2 line"><c:out value="${result.tcWriteYCnt}"/></td>
				            				<td align="center" class="borderLine lineStyle2 line"><c:out value="${result.tcResultPct}"/></td>
		           						</c:when>
		           						
		         						<c:otherwise>
			            					<c:choose>
			            						<c:when test="${result.taskGb eq '소계'}">
				            						<td align="center" class="lineStyle"><c:out value="${result.sysGb}"/></td>            					
													<td align="center" class="lineStyle"><c:out value="${result.taskGb}"/></td>
													<td align="center" class="lineStyle"><c:out value="${result.pgCnt}"/></td> 
						            				<td align="center" class="lineStyle"><c:out value="${result.tcWriteYCnt}"/></td> 
						            				<td align="center" class="lineStyle"><c:out value="${result.notTestCnt}"/></td>
						            				<td align="center" class="lineStyle"><c:out value="${result.firstTestCnt}"/></td>
						            				<td align="center" class="lineStyle"><c:out value="${result.secondTestCnt}"/></td>
						            				<td align="center" class="lineStyle"><c:out value="${result.tcProgressPct}"/></td>
						            				<td align="center" class="lineStyle"><c:out value="${result.tcResultYCnt}"/></td>
						            				<td align="center" class="lineStyle"><c:out value="${result.tcResultNCnt}"/></td>
						            				<td align="center" class="lineStyle"><c:out value="${result.tcWriteYCnt}"/></td>
						            				<td align="center" class="lineStyle borderLine"><c:out value="${result.tcResultPct}"/></td>
			           							</c:when>
			            						
			            						<c:otherwise>
				            						<td align="center" ><c:out value="${result.sysGb}"/></td>            					
													<td align="center" ><c:out value="${result.taskGb}"/></td>
													<td align="center" ><c:out value="${result.pgCnt}"/></td> 
						            				<td align="center" ><c:out value="${result.tcWriteYCnt}"/></td> 
						            				<td align="center" ><c:out value="${result.notTestCnt}"/></td>
						            				<td align="center" ><c:out value="${result.firstTestCnt}"/></td>
						            				<td align="center" ><c:out value="${result.secondTestCnt}"/></td>
						            				<td align="center" ><c:out value="${result.tcProgressPct}"/></td>
						            				<td align="center" ><c:out value="${result.tcResultYCnt}"/></td>
						            				<td align="center" ><c:out value="${result.tcResultNCnt}"/></td>
						            				<td align="center" ><c:out value="${result.tcWriteYCnt}"/></td>
						            				<td align="center" class="borderLine"><c:out value="${result.tcResultPct}"/></td>
			            						</c:otherwise>
			            					</c:choose>
		           						</c:otherwise>
		           					</c:choose>
		            			</tr>
		            			
		        			</c:forEach>
		        			 
		              </table>        
		           </div>
	           </div>    <!-- statsByUtc -->
           </div> <!-- tab-1 -->
                
          
                <div id="tab-2" class="tab-content">
					<div id="StatsByTtc">
	               	 <div class="default_tablestyle">
		              	<table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
			              	<colgroup>
			        				<col width="10%"/>
			        				<col width="10%"/>
			        				<col width="12%"/>
			        				<col width="7%"/>
			        				<col width="7%"/>
			        				<col width="7%"/>
			        				<col width="8%"/>
			        				<col width="7%"/>
			        				<col width="7%"/>
			        				<col width="7%"/>
			        				<col width="8%"/>
			        		</colgroup>
		        			<tr>
					        	<th align="center" rowspan="2"><spring:message code="tms.test.sysGb" /></th>
		        				<th align="center" rowspan="2"><spring:message code="tms.test.taskGb" /></th>
		        				<th align="center" rowspan="2"><spring:message code="tms.test.testcaseCnt" /></th>
					        	<th align="center" colspan="3"><spring:message code="tms.test.testProgress" /></th>
					        	<th align="center" rowspan="2"><spring:message code="tms.test.progressPct" />(%)</th>
					        	<th align="center" colspan="3"><spring:message code="tms.test.testResultYn" /></th>
					        	<th align="center" rowspan="2" class="borderLine" ><spring:message code="tms.test.completeYPct" />(%)</th>
		        			</tr>
		        			
		        			<tr>
					        	<th align="center"><spring:message code="tms.test.notStartTest" /></th>
					        	<th align="center"><spring:message code="tms.test.firstTest" /></th>
					        	<th align="center"><spring:message code="tms.test.secondTest" /></th>
					        	<th align="center"><spring:message code="tms.test.resultY" /></th>
					        	<th align="center"><spring:message code="tms.test.resultN" /></th>
					        	<th align="center"><spring:message code="tms.test.totCnt" /></th>
		        			</tr>
		        			
		        			<c:forEach var="result" items="${testStatsByTtc}" varStatus="status">
		        			
		            			<tr>	
		           					<c:choose>
		           					
		           						<c:when test="${result.sysGb eq '합계'}">
		            						<td align="center" class="lineStyle2"><c:out value="${result.sysGb}"/></td>            					
											<td align="center" class="lineStyle2"><c:out value="${result.taskGb}"/></td>
				            				<td align="center" class="lineStyle2"><c:out value="${result.tcWriteYCnt}"/></td> 
				            				<td align="center" class="lineStyle2"><c:out value="${result.notTestCnt}"/></td>
				            				<td align="center" class="lineStyle2"><c:out value="${result.firstTestCnt}"/></td>
				            				<td align="center" class="lineStyle2"><c:out value="${result.secondTestCnt}"/></td>
				            				<td align="center" class="lineStyle2"><c:out value="${result.tcProgressPct}"/></td>
				            				<td align="center" class="lineStyle2"><c:out value="${result.tcResultYCnt}"/></td>
				            				<td align="center" class="lineStyle2"><c:out value="${result.tcResultNCnt}"/></td>
				            				<td align="center" class="lineStyle2"><c:out value="${result.tcWriteYCnt}"/></td>
				            				<td align="center" class="borderLine lineStyle2"><c:out value="${result.tcResultPct}"/></td>
		           						</c:when>
		           						
		         						<c:otherwise>
			            					<c:choose>
			            						<c:when test="${result.taskGb eq '소계'}">
				            						<td align="center" class="lineStyle"><c:out value="${result.sysGb}"/></td>            					
													<td align="center" class="lineStyle"><c:out value="${result.taskGb}"/></td>
						            				<td align="center" class="lineStyle"><c:out value="${result.tcWriteYCnt}"/></td> 
						            				<td align="center" class="lineStyle"><c:out value="${result.notTestCnt}"/></td>
						            				<td align="center" class="lineStyle"><c:out value="${result.firstTestCnt}"/></td>
						            				<td align="center" class="lineStyle"><c:out value="${result.secondTestCnt}"/></td>
						            				<td align="center" class="lineStyle"><c:out value="${result.tcProgressPct}"/></td>
						            				<td align="center" class="lineStyle"><c:out value="${result.tcResultYCnt}"/></td>
						            				<td align="center" class="lineStyle"><c:out value="${result.tcResultNCnt}"/></td>
						            				<td align="center" class="lineStyle"><c:out value="${result.tcWriteYCnt}"/></td>
						            				<td align="center" class="lineStyle borderLine"><c:out value="${result.tcResultPct}"/></td>
			           							</c:when>
			            						
			            						<c:otherwise>
				            						<td align="center" ><c:out value="${result.sysGb}"/></td>            					
				            						<td align="center" ><c:out value="${result.taskGb}"/></td>
						            				<td align="center" ><c:out value="${result.tcWriteYCnt}"/></td> 
						            				<td align="center" ><c:out value="${result.notTestCnt}"/></td>
						            				<td align="center" ><c:out value="${result.firstTestCnt}"/></td>
						            				<td align="center" ><c:out value="${result.secondTestCnt}"/></td>
						            				<td align="center" ><c:out value="${result.tcProgressPct}"/></td>
						            				<td align="center" ><c:out value="${result.tcResultYCnt}"/></td>
						            				<td align="center" ><c:out value="${result.tcResultNCnt}"/></td>
						            				<td align="center" ><c:out value="${result.tcWriteYCnt}"/></td>
						            				<td align="center" class="borderLine"><c:out value="${result.tcResultPct}"/></td>
			            						</c:otherwise>
			            					</c:choose>
		           						</c:otherwise>
		           					</c:choose>
		            			</tr>
		            			
		        			</c:forEach>
		        			 
		              </table>        
		           </div>
	           </div>    <!-- statsByTtc -->
           </div> <!-- tab-2 -->
                
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