<%--
  Class Name : EgovLoginPolicyList.jsp
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
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css" >

<script type="text/javascript">
   
    function fn_egov_select_viewDefect(){
        document.frm.action = "<c:url value='/tms/defect/selectDefectCurrent.do'/>";
        document.frm.submit();      
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
							<li>결함관리</li>
							<li>&gt;</li>
							<li><strong>결함처리통계</strong></li>
                        </ul>
                    </div>
                </div>
     
              
                
              <!-- 검색 필드 박스 시작 -->
				<div id="search_field">
					<div id="search_field_loc"><h2><strong>결함처리통계</strong></h2></div>
					
					
				</div>
				<!-- //검색 필드 박스 끝 -->
             <h4><strong>조치율</strong></h4>
             
                 	총 : <c:out value="${defectStats.actionStAll}"/> 
                 	완료 : <c:out value="${defectStats.actionStA5}"/>
                 	미완료 : <c:out value="${defectStats.actionStAll - defectStats.actionStA5}"/>
                 	
                 	<fmt:parseNumber var="actionProgression" integerOnly="true" value="${defectStats.actionStA5 / defectStats.actionStAll * 100}"/>
                 	<%-- ${actionProgression}% --%>
                 	진행률 : <div class="progress"><div class="progress-bar" style="width:${actionProgression}%"> <strong><c:out value=" ${actionProgression}"></c:out>%</strong></div></div>
                 
            <br/>
            <h4><strong>상태별 결함건수</strong></h4>
            <table width="120%">
            <tr>
            	<td width="16.6%" align="center"> 전체건수 <br/><c:out value="${defectStats.actionStAll}"/>  </td>
            	<td width="16.6%" align="center"> 대기 <br/><c:out value="${defectStats.actionStA1}"/>  </td>
            	<td width="16.6%" align="center"> 조치중 <br/><c:out value="${defectStats.actionStA2}"/>  </td>
            	<td width="16.6%" align="center"> 조치완료 <br/><c:out value="${defectStats.actionStA3}"/>  </td>
            	<td width="16.6%" align="center"> 재요청 <br/><c:out value="${defectStats.actionStA4}"/>  </td>
            	<td width="16.6%" align="center"> 최종완료 <br/><c:out value="${defectStats.actionStA5}"/>  </td>
            </tr>
            </table>
			
			<br/><br/>
			<h4><strong>일자별 등록건수, 조치건수</strong></h4>
			<c:forEach var="dayByDefectCnt" items="${dayByDefectCnt}" varStatus="status">
            	<c:out value="${dayByDefectCnt.days}"/> : <c:out value="${dayByDefectCnt.enrollDtCnt}"/> | <c:out value="${dayByDefectCnt.actionDtCnt}"/>
            	&nbsp;
            </c:forEach>
			<h4><strong>월별 등록건수, 조치건수</strong></h4>
			<c:forEach var="monthByDefectCnt" items="${monthByDefectCnt}" varStatus="status">
            	<c:out value="${monthByDefectCnt.months}"/> : <c:out value="${monthByDefectCnt.enrollMonthDtCnt}"/> | <c:out value="${monthByDefectCnt.actionMonthDtCnt}"/>
            	&nbsp;
            </c:forEach>
            <br/><br/>
            <h4><strong>업무별 조치율</strong></h4>
            	전체: <c:out value="${defectStats.actionStA5}"/>	/ <c:out value="${defectStats.actionStAll}"/> 
           			 <fmt:parseNumber var="actionProgression" integerOnly="true" value="${defectStats.actionStA5 / defectStats.actionStAll * 100}"/>
                 	진행률 : <strong><c:out value=" ${actionProgression}"></c:out>%</strong>
            
            <c:forEach var="taskByActionProgression" items="${taskByActionProgression}" varStatus="status">
            	<c:out value="${taskByActionProgression.taskNm}"/> : <c:out value="${taskByActionProgression.taskA5Cnt}"/> / <c:out value="${taskByActionProgression.taskTotCnt}"/>
            	&nbsp;
            	 <c:if test="${taskByActionProgression.taskTotCnt != 0}">
            	 (<fmt:parseNumber var="actionProgression" integerOnly="true" value="${taskByActionProgression.taskA5Cnt / taskByActionProgression.taskTotCnt * 100}"/>
                 	<strong><c:out value=" ${actionProgression}"></c:out>%</strong>)&nbsp;
                 	</c:if>
            </c:forEach>
            <br/><br/>
			 <h4><strong>업무별 전체결함건수</strong></h4>
			 <c:forEach var="taskByActionProgression" items="${taskByActionProgression}" varStatus="status">
            	<c:out value="${taskByActionProgression.taskNm}"/> : <c:out value="${taskByActionProgression.taskTotCnt}"/>
            	&nbsp;
            	 <c:if test="${taskByActionProgression.taskTotCnt != 0}">
            	 (<fmt:parseNumber var="actionProgression" integerOnly="true" value="${taskByActionProgression.taskTotCnt / defectStats.actionStAll * 100}"/>
                 	<strong><c:out value=" ${actionProgression}"></c:out>%</strong>)&nbsp;
                 	</c:if>
            </c:forEach>
			  <br/><br/>
			 <h4><strong>업무별 상태별  결함건수</strong></h4>
			 <c:forEach var="taskByActionStCnt" items="${taskByActionStCnt}" varStatus="status">
            	<c:out value="${taskByActionStCnt.taskNm}"/> : (<c:out value="${taskByActionStCnt.actionStAll}"/>) 
            	<c:out value="${taskByActionStCnt.actionStA1}"/> / <c:out value="${taskByActionStCnt.actionStA2}"/> /
            	<c:out value="${taskByActionStCnt.actionStA3}"/> / <c:out value="${taskByActionStCnt.actionStA4}"/> /
            	<c:out value="${taskByActionStCnt.actionStA5}"/>
            	&nbsp;
            </c:forEach>
			 
			 
			 <br/><br/>
			 <h4><strong>업무별 유형별 결함건수</strong></h4>
			 <c:forEach var="taskByDefectGbCnt" items="${taskByDefectGbCnt}" varStatus="status">
            	<c:out value="${taskByDefectGbCnt.taskNm}"/> : <c:out value="${taskByDefectGbCnt.defectGbD1}"/> / 
            	<c:out value="${taskByDefectGbCnt.defectGbD2}"/> / <c:out value="${taskByDefectGbCnt.defectGbD3}"/> /
            	<c:out value="${taskByDefectGbCnt.defectGbD4}"/>
            	&nbsp;
            </c:forEach>
			 
			 
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