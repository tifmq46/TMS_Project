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
<link href="<c:url value='/'/>css/test/chartist.min.css" rel="stylesheet" type="text/css" >
<title>테스트 통계</title>
<script type="text/javascript" src="<c:url value='/js/chartist.min.js' />" ></script>
<script type="text/javaScript" language="javascript" defer="defer">


function selectTestStatsTable(pageNo){
    document.listForm.pageIndex.value = pageNo; 
    document.listForm.action = "<c:url value='/tms/test/selectTestStatsTable.do'/>";
    document.listForm.submit();  
}

function statsToExel(testcaseGb) {
	location.href = "./statsToExcel.do?testcaseGb=" + testcaseGb;
	/* location.href = "<c:url value='/tms/test/statsToExcel.do?" + testcaseGb + "'/>"; */
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
							<li><strong>테스트통계</strong></li>
                        </ul>
                    </div>
                </div>
              
                <div id="page_info"><div id="page_info_align"></div></div>      
                             
                             
                <form:form commandName="searchVO" name="listForm" method="post" action="/tms/test/selectTestCurrent.do">   
                <!-- 검색 필드 박스 시작 -->
					<div id="search_field">
						
					  	<fieldset><legend>조건정보 영역</legend>	
					  	
				  	 	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					  	 
					  	<div class="sf_start">
							
							<table style="width:100%;padding-bottom:10px;padding-left:10px;padding-top:10px;">
                    		<colgroup>
                  			  <col width="12%"/> 
                  			  <col width="13.4%"/> 
                  			  <col width="7%"/> 
                  			  <col width="13.4%"/> 
                  			  <col width="7%"/> 
                  			  <col width="13.4%"/> 
                  			  <col width="7%"/> 
                  			  <col width="13.4%"/> 
                  			  <col width="13.4%"/> 
      			        	</colgroup>
      			        <tr>
      			        <td style="font-weight:bold;color:#666666;font-size:110%;">
      			        <spring:message code="tms.test.testcaseGb" />
      			        </td>
      			        <td >
									<select name="searchByTestcaseGb" id="searchByTestcaseGb" style="width:90%;text-align-last:center;" value="<c:out value='${searchVO.searchByTestcaseGb}'/>" >
										<c:forEach var="cmCode" items="${tcGbCode}">
										<option value="${cmCode.code}"  <c:if test="${searchVO.searchByTestcaseGb == cmCode.code}">selected="selected"</c:if> >${cmCode.codeNm}</option>
										</c:forEach>
									</select>						
      			        </td>
      			        <td colspan="7">
									<div class="buttons" style="float:right;">
									    
	                                       <a href="#" onclick="selectTestStatsTable('1'); return false;"><img src="<c:url value='/images/img_search.gif' />" alt="search" />
											<spring:message code="button.inquire" /></a>
											
											<a href="#" onclick="statsToExel('${searchVO.searchByTestcaseGb}'); return false;">엑셀 다운로드</a>
									</div>	  				  			
      			        </td>
      			        </tr>
      			        </table>
					  		
					  		
					  		
						</div>			
						</fieldset>
						 		
					</div>
				</form:form>
				<!-- //검색 필드 박스 끝 -->             
                             
                             
                
                <div class="default_tablestyle">
                
              	<table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
	              	<colgroup>
	        				<col width="10%"/>
	        				<col width="10%"/>
	        				
	        				<c:if test="${searchVO.searchByTestcaseGb == 'TC1'}">
	        				<col width="10%"/>
	        				</c:if>
	        				
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
        				<th align="center" rowspan="2">시스템구분</th>
        				<th align="center" rowspan="2">업무구분</th>
        				
        				
        				<c:if test="${searchVO.searchByTestcaseGb == 'TC1'}">
        					<th align="center" rowspan="2">프로그램 본수</th>
        				</c:if>
        				
        				<th align="center" rowspan="2">테스트케이스 개수</th>
			        	<th align="center" colspan="3">테스트 진행</th>
			        	<th align="center" rowspan="2">진행률(%)</th>
			        	<th align="center" colspan="3">테스트 결과</th>
			        	<th align="center" rowspan="2">완료율(%)</th>
        			</tr>
        			
        			<tr>
			        	<th align="center">미진행</th>
			        	<th align="center">1차</th>
			        	<th align="center">2차</th>
			        	<th align="center">완료</th>
			        	<th align="center">미완료</th>
			        	<th align="center">합계</th>
        			</tr>
        			
        			<c:forEach var="result" items="${testStatsTable}" varStatus="status">
        			
            			<tr>
            			
            				<c:choose>
            					<c:when test="${result.sysGb eq '합계'}">
            						<td align="center" class="listtd" style="border-bottom: solid 1px #00000054;"><strong><c:out value="${result.sysGb}"/></strong>&nbsp;</td>
            					</c:when>
            				
            					<c:otherwise>
									<td align="center" class="listtd"><c:out value="${result.sysGb}"/>&nbsp;</td>            					
            					</c:otherwise>
            				</c:choose>
            				
            				<c:choose>
            					<c:when test="${result.taskGb eq '소계'}">
            						<td align="center" class="listtd" style="border-bottom: solid 1px #00000054;"><strong><c:out value="${result.taskGb}"/></strong>&nbsp;</td>
            						
            						
            						<c:if test="${searchVO.searchByTestcaseGb == 'TC1'}">
									<td align="center" class="listtd" style="border-bottom: solid 1px #00000054;"><strong><c:out value="${result.pgCnt}"/></strong>&nbsp;</td> 
									</c:if>
									
		            				<td align="center" class="listtd" style="border-bottom: solid 1px #00000054;"><strong><c:out value="${result.tcWriteYCnt}"/></strong>&nbsp;</td> 
		            				<td align="center" class="listtd" style="border-bottom: solid 1px #00000054;"><strong><c:out value="${result.notTestCnt}"/></strong>&nbsp;</td>
		            				<td align="center" class="listtd" style="border-bottom: solid 1px #00000054;"><strong><c:out value="${result.firstTestCnt}"/></strong>&nbsp;</td>
		            				<td align="center" class="listtd" style="border-bottom: solid 1px #00000054;"><strong><c:out value="${result.secondTestCnt}"/></strong>&nbsp;</td>
		            				<td align="center" class="listtd" style="border-bottom: solid 1px #00000054;"><strong><c:out value="${result.tcProgressPct}"/></strong>&nbsp;</td>
		            				<td align="center" class="listtd" style="border-bottom: solid 1px #00000054;"><strong><c:out value="${result.tcResultYCnt}"/></strong>&nbsp;</td>
		            				<td align="center" class="listtd" style="border-bottom: solid 1px #00000054;"><strong><c:out value="${result.tcResultNCnt}"/></strong>&nbsp;</td>
		            				<td align="center" class="listtd" style="border-bottom: solid 1px #00000054;"><strong><c:out value="${result.tcWriteYCnt}"/></strong>&nbsp;</td>
		            				<td align="center" class="listtd" style="border-bottom: solid 1px #00000054;"><strong><c:out value="${result.tcResultPct}"/></strong>&nbsp;</td>
            					
            					</c:when>
            				
            					<c:otherwise>
									<td align="center" class="listtd"><c:out value="${result.taskGb}"/>&nbsp;</td>
									
									<c:if test="${searchVO.searchByTestcaseGb == 'TC1'}">
									<td align="center" class="listtd"><c:out value="${result.pgCnt}"/>&nbsp;</td> 
									</c:if>
									
		            				<td align="center" class="listtd"><c:out value="${result.tcWriteYCnt}"/>&nbsp;</td> 
		            				<td align="center" class="listtd"><c:out value="${result.notTestCnt}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.firstTestCnt}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.secondTestCnt}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.tcProgressPct}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.tcResultYCnt}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.tcResultNCnt}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.tcWriteYCnt}"/>&nbsp;</td>
		            				<td align="center" class="listtd"><c:out value="${result.tcResultPct}"/>&nbsp;</td>
            					</c:otherwise>
            				</c:choose>
            				
            				
            				
            			</tr>
        			</c:forEach>
        			 
              </table>        
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