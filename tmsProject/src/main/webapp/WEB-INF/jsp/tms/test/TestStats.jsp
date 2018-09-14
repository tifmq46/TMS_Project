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

<link href="<c:url value='/'/>css/test/common.css" rel="stylesheet" type="text/css" >
<link href="<c:url value='/'/>css/test/chartist.min.css" rel="stylesheet" type="text/css" >
<title>테스트 통계</title>
<script type="text/javascript" src="<c:url value='/js/chartist.min.js' />" ></script>
<script type="text/javaScript" language="javascript" defer="defer">


function fn_egov_select_testCaseList(pageNo){
    document.listForm.pageIndex.value = pageNo; 
    document.listForm.action = "<c:url value='/tms/test/selectTestCaseList.do'/>";
    document.listForm.submit();  
}


function updateTestScenario(){
	
	 document.updateForm.action = "<c:url value='/tms/test/updateTestScenarioImpl.do'/>";
	 document.updateForm.submit();  
}


window.onload = function() {
	
	
	var list = JSON.parse('${tcStatsByTaskGb}');
	console.log(list);
	var taskGbNmList = new Array();
	var testcaseTotCntList = new Array();
	var testcaseYCntList = new Array();
	
	for(var i=0; i<list.length; i++ ){
		taskGbNmList.push(list[i].taskGbNm);
		testcaseTotCntList.push(list[i].testcaseTotCnt);
		testcaseYCntList.push(list[i].testcaseYCnt);
	}

	
		var data = {
			  labels: taskGbNmList,
			    series: [
			    testcaseTotCntList,
			    testcaseYCntList
			  ]
			};

			var options = {
			  seriesBarDistance: 5
			};

			var responsiveOptions = [
			  ['screen and (min-width: 641px) and (max-width: 1024px)', {
			    seriesBarDistance: 10,
			    axisX: {
			      labelInterpolationFnc: function (value) {
			        return value;
			      }
			    }
			  }],
			  ['screen and (max-width: 640px)', {
			    seriesBarDistance: 5,
			    axisX: {
			      labelInterpolationFnc: function (value) {
			        return value[0];
			      }
			    }
			  }]
			];

			new Chartist.Bar('.ct-chart', data, options, responsiveOptions);
			}
</script>

</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

<!-- 전체 레이어 시작 -->


<div id="wrap">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <div id="topnavi"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>
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
							<li><strong>테스트통계</strong></li>
                        </ul>
                    </div>
                </div>
              
                <div id="page_info"><div id="page_info_align"></div></div>      
                             
                        

                 <div class="progess_bar_section" >
                 
                      	<strong>단위테스트 진행률   </strong>
                      	
                      	<div style="float:right;">
	                      	<c:set var="tc1_yCnt" value="${testCaseStatsMapTC1.yCnt}"></c:set>
	                      	<c:set var="tc1_totCnt" value="${testCaseStatsMapTC1.totCnt}"></c:set>
	                      	<fmt:parseNumber var="value1" value="${(tc1_yCnt/tc1_totCnt)*100}" integerOnly="true" />
	                      	<strong><c:out value="${tc1_yCnt}"></c:out>&nbsp;/&nbsp;<c:out value="${tc1_totCnt}"></c:out></strong>
						</div>
					<%-- 	
						<div>
						<c:out value=" ${value1}"></c:out>%
						</div> --%>
						
                      	 <div class="progress">
                      	 
						    <div class="progress-bar" style="width:${value1}%"> <strong><c:out value=" ${value1}"></c:out>%</strong></div>
						  </div>
						  
						  <div style="float:right;">
							  <img src="<c:url value='/images/tms/icon_pop_blue.gif' />" width="10" height="10" alt="yCnt"/>&nbsp;완료건수
							  &nbsp;<img src="<c:url value='/images/tms/icon_pop_gray.gif' />" width="10" height="10" alt="totCnt"/>&nbsp;등록건수
						  </div>
					</div>
                 
                 <div class="progess_bar_section" >
                 
                 		<div style="float:right;">
	                      	<c:set var="tc2_yCnt" value="${testCaseStatsMapTC2.yCnt}"></c:set>
	                      	<c:set var="tc2_totCnt" value="${testCaseStatsMapTC2.totCnt}"></c:set>
	                      	<fmt:parseNumber var="value2" value="${(tc2_yCnt/tc2_totCnt)*100}" integerOnly="true" />
	                      	<strong><c:out value="${tc2_yCnt}"></c:out>&nbsp;/&nbsp;<c:out value="${tc2_totCnt}"></c:out></strong>
						</div>
                 
                      	<strong>통합테스트 진행률  </strong>
                      	<div class="progress">
						    <div class="progress-bar" style="width:${value2}%"><strong><c:out value=" ${value2}"></c:out>% </strong> </div>
						 </div>
						 <div style="float:right;">
							  <img src="<c:url value='/images/tms/icon_pop_blue.gif' />" width="10" height="10" alt="yCnt"/>&nbsp;완료건수
							  &nbsp;<img src="<c:url value='/images/tms/icon_pop_gray.gif' />" width="10" height="10" alt="totCnt"/>&nbsp;등록건수
						 </div>
                 </div>
                    
                 <div class="progess_bar_section" >
                 <%-- 
                      	<strong>업무별 단위테스트 진행률 </strong>
                      	
                      	<c:forEach var="result" items="${tcStatsByTaskGb}">
                      	<div class="bar_scope">
                      		<c:out value="${result.taskGbNm}"></c:out>
                      			<div class="progress">
								    <div class="progress-bar" style="width:${(result.testcaseYCnt/result.testcaseTotCnt)*100}%"><strong><c:out value=" ${(result.testcaseYCnt/result.testcaseTotCnt)*100}"></c:out>%</strong> </div>
								 </div>
						</div>		 
                      	</c:forEach>
                      	 --%>
                      	
					    <span><strong>업무별 단위테스트 진행률</strong></span>
					    <div class="ct-chart ct-perfect-fourth"></div>
                      	 <div style="text-align: center; margin-top:10px;" >
							  <img src="<c:url value='/images/tms/icon_pop_blue.gif' />" width="10" height="10" alt="yCnt"/>&nbsp;완료건수
							  &nbsp;<img src="<c:url value='/images/tms/icon_pop_gray.gif' />" width="10" height="10" alt="totCnt"/>&nbsp;등록건수
						 </div>
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