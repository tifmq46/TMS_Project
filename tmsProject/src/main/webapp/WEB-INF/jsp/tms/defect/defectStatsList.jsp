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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css" >

<title>로그인정책 목록조회</title>

<script type="text/javascript">

	function selectBoxChange() {
		var selectBoxId = document.getElementById("selectBoxStats");
		var selectBoxValue = selectBoxId.options[selectBoxId.selectedIndex].value;
		
		if(selectBoxValue == 1) {
			document.getElementById("StatsByTask").style.display="inline"
			document.getElementById("StatsByPg").style.display="none"
			document.getElementById("StatsByUserTest").style.display="none"
			document.getElementById("StatsByUserDev").style.display="none"
		} else if (selectBoxValue == 2) {
			document.getElementById("StatsByTask").style.display="none"
			document.getElementById("StatsByPg").style.display="inline"
			document.getElementById("StatsByUserTest").style.display="none"
			document.getElementById("StatsByUserDev").style.display="none"
		} else if (selectBoxValue == 3) {
			document.getElementById("StatsByTask").style.display="none"
			document.getElementById("StatsByPg").style.display="none"
			document.getElementById("StatsByUserTest").style.display="inline"
			document.getElementById("StatsByUserDev").style.display="none"
		} else {
			document.getElementById("StatsByTask").style.display="none"
			document.getElementById("StatsByPg").style.display="none"
			document.getElementById("StatsByUserTest").style.display="none"
			document.getElementById("StatsByUserDev").style.display="inline"
		}
	}
	
	function StatsToExcel(statsGb) {
		alert(statsGb);
		alert("'C://TMS_통계자료// 경로에 다운되었습니다.");
		location.href="./StatsToExcel.do?statsGb="+statsGb; 
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
							<li><strong>결함처리통계(표)</strong></li>
                        </ul>
                    </div>
                </div>
     		<br/>
     		<br/>
            <div id="search_field">
					<div id="search_field_loc"><h2><strong>결함처리통계(표)</strong></h2></div>
			</div>
     		<div align="right">
     		<select id="selectBoxStats" style="width:12%;text-align-last:center;" onChange="javascript:selectBoxChange();">
				<option value="1" selected="selected" >업무별</option>
				<option value="2" >화면별</option>
				<option value="3" >테스터별</option>
				<option value="4" >조치자별</option>
			</select>
			</div>
			
			<div id="StatsByTask" style="display:inline;">
     		<h3><strong>업무별</strong></h3>
     		<div class="default_tablestyle">
     		<table border="0" width="120%" border="0" cellpadding="0" cellspacing="0" summary="업무별 통계(표) 테이블">
                 <caption style="visibility:hidden">업무별 통계(표) 테이블</caption>
              
              
              <colgroup>
        				<col width="14%"/> 
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        	</colgroup>
        			<tr>
        				<th align="center">구분</th>
        				<th align="center">상태/유형별</th>
        				<th align="center">오류</th>
        				<th align="center">개선</th>
        				<th align="center">문의</th>
        				<th align="center">기타</th>
        				<th align="center">합계</th>
        			</tr>
        	
        	 <c:forEach var="taskGbByStats" items="${taskGbByStats}" varStatus="status">
					<tr>
					<c:if test="${taskGbByStats.actionSt eq 'A1'}">
						<td rowspan="6"><c:out value="${taskGbByStats.taskNm}"/></td>
					</c:if>
							<td><c:out value="${taskGbByStats.actionNm}"/></td>
							<td>${taskGbByStats.defectGbD1}</td>
							<td>${taskGbByStats.defectGbD2}</td>
							<td>${taskGbByStats.defectGbD3}</td>
							<td>${taskGbByStats.defectGbD4}</td>
							<td>${taskGbByStats.rowSum}</td>
					</tr>
					<c:if test="${taskGbByStats.actionSt eq 'A5'}">
						<tr>
						<td><strong>합계</strong></td>
						<td><strong><c:out value="${taskGbByStats.d1Sum}"/></strong></td>
						<td><strong><c:out value="${taskGbByStats.d2Sum}"/></strong></td>
						<td><strong><c:out value="${taskGbByStats.d3Sum}"/></strong></td>
						<td><strong><c:out value="${taskGbByStats.d4Sum}"/></strong></td>
						<td><strong><c:out value="${taskGbByStats.totalRowSum}"/></strong></td>
					</tr>
					</c:if>
				</c:forEach> 
        	</table>
        	</div>
        	<form name="taskForm" id="taskForm">
        		<input type="hidden" name="task" value="task"/>
        		<div class="buttons" id="StatsByTaskToExcel" style="float:right; margin-top:10px;">
						<a href="<c:url value='/tms/defect/StatsToExcel.do'/>" onclick="javascript:StatsToExcel('task'); return false;" >엑셀</a>
				</div>
			</form>
        	</div>
        	
        	<div id="StatsByPg" style="display:none;">
        	<h3><strong>화면별</strong></h3>
        	<div class="default_tablestyle">
     		<table border="0" width="120%" border="0" cellpadding="0" cellspacing="0" summary="화면별 통계(표) 테이블">
                 <caption style="visibility:hidden">화면별 통계(표) 테이블</caption>
              <colgroup>
        				<col width="14%"/> 
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        	</colgroup>
        			<tr>
        				<th align="center">구분</th>
        				<th align="center">상태/유형별</th>
        				<th align="center">오류</th>
        				<th align="center">개선</th>
        				<th align="center">문의</th>
        				<th align="center">기타</th>
        				<th align="center">합계</th>
        			</tr>
        	
        	 <c:forEach var="pgIdByStats" items="${pgIdByStats}" varStatus="status">
					<tr>
					<c:if test="${pgIdByStats.actionSt eq 'A1'}">
						<td rowspan="6"><c:out value="${pgIdByStats.pgNm}"/></td>
					</c:if>
							<td><c:out value="${pgIdByStats.actionNm}"/></td>
							<td>${pgIdByStats.defectGbD1}</td>
							<td>${pgIdByStats.defectGbD2}</td>
							<td>${pgIdByStats.defectGbD3}</td>
							<td>${pgIdByStats.defectGbD4}</td>
							<td>${pgIdByStats.rowSum}</td>
					</tr>
					<c:if test="${pgIdByStats.actionSt eq 'A5'}">
						<tr>
						<td><strong>합계</strong></td>
						<td><strong><c:out value="${pgIdByStats.d1Sum}"/></strong></td>
						<td><strong><c:out value="${pgIdByStats.d2Sum}"/></strong></td>
						<td><strong><c:out value="${pgIdByStats.d3Sum}"/></strong></td>
						<td><strong><c:out value="${pgIdByStats.d4Sum}"/></strong></td>
						<td><strong><c:out value="${pgIdByStats.totalRowSum}"/></strong></td>
					</tr>
					</c:if>
				</c:forEach> 
        	</table>
        	</div>
        	<div class="buttons" id="StatsByPgToExcel" style="float:right; margin-top:10px;">
						<a href="<c:url value='/tms/defect/StatsToExcel.do'/>" onclick="javascript:StatsToExcel('pg'); return false;" >엑셀</a>
			</div>
        	</div>
        	
        	<div id="StatsByUserTest" style="display:none;">
        	<h3><strong>테스터별</strong></h3>
        	<div class="default_tablestyle">
     		<table border="0" width="120%" border="0" cellpadding="0" cellspacing="0" summary="테스터별 통계(표) 테이블">
                 <caption style="visibility:hidden">테스터별 통계(표) 테이블</caption>
              
              
              <colgroup>
        				<col width="14%"/> 
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        	</colgroup>
        			<tr>
        				<th align="center">구분</th>
        				<th align="center">상태/유형별</th>
        				<th align="center">오류</th>
        				<th align="center">개선</th>
        				<th align="center">문의</th>
        				<th align="center">기타</th>
        				<th align="center">합계</th>
        			</tr>
        	
        	 <c:forEach var="userTestByStats" items="${userTestByStats}" varStatus="status">
					<tr>
					<c:if test="${userTestByStats.actionSt eq 'A1'}">
						<td rowspan="6"><c:out value="${userTestByStats.userTestNm}"/></td>
					</c:if>
							<td><c:out value="${userTestByStats.actionNm}"/></td>
							<td>${userTestByStats.defectGbD1}</td>
							<td>${userTestByStats.defectGbD2}</td>
							<td>${userTestByStats.defectGbD3}</td>
							<td>${userTestByStats.defectGbD4}</td>
							<td>${userTestByStats.rowSum}</td>
					</tr>
					<c:if test="${userTestByStats.actionSt eq 'A5'}">
						<tr>
						<td><strong>합계</strong></td>
						<td><strong><c:out value="${userTestByStats.d1Sum}"/></strong></td>
						<td><strong><c:out value="${userTestByStats.d2Sum}"/></strong></td>
						<td><strong><c:out value="${userTestByStats.d3Sum}"/></strong></td>
						<td><strong><c:out value="${userTestByStats.d4Sum}"/></strong></td>
						<td><strong><c:out value="${userTestByStats.totalRowSum}"/></strong></td>
					</tr>
					</c:if>
				</c:forEach> 
        	</table>
        	</div>
        	<br/>
        	<div class="buttons" id="StatsByUserTestToExcel" style="float:right; margin-top:10px;">
						<a href="<c:url value='/tms/defect/StatsToExcel.do'/>" onclick="javascript:StatsToExcel('userTest'); return false;" >엑셀</a>
			</div>
        	</div>
        	
        	<div id="StatsByUserDev" style="display:none;">
        	<h3><strong>조치자별</strong></h3>
        	<div class="default_tablestyle">
     		<table border="0" width="120%" border="0" cellpadding="0" cellspacing="0" summary="조치자별 통계(표) 테이블">
                 <caption style="visibility:hidden">조치자별 통계(표) 테이블</caption>
              
              
              <colgroup>
        				<col width="14%"/> 
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        				<col width="14%"/>
        	</colgroup>
        			<tr>
        				<th align="center">구분</th>
        				<th align="center">상태/유형별</th>
        				<th align="center">오류</th>
        				<th align="center">개선</th>
        				<th align="center">문의</th>
        				<th align="center">기타</th>
        				<th align="center">합계</th>
        			</tr>
        	
        	 <c:forEach var="userDevByStats" items="${userDevByStats}" varStatus="status">
					<tr>
					<c:if test="${userDevByStats.actionSt eq 'A1'}">
						<td rowspan="6"><c:out value="${userDevByStats.userDevNm}"/></td>
					</c:if>
							<td><c:out value="${userDevByStats.actionNm}"/></td>
							<td>${userDevByStats.defectGbD1}</td>
							<td>${userDevByStats.defectGbD2}</td>
							<td>${userDevByStats.defectGbD3}</td>
							<td>${userDevByStats.defectGbD4}</td>
							<td>${userDevByStats.rowSum}</td>
					</tr>
					<c:if test="${userDevByStats.actionSt eq 'A5'}">
						<tr>
						<td><strong>합계</strong></td>
						<td><strong><c:out value="${userDevByStats.d1Sum}"/></strong></td>
						<td><strong><c:out value="${userDevByStats.d2Sum}"/></strong></td>
						<td><strong><c:out value="${userDevByStats.d3Sum}"/></strong></td>
						<td><strong><c:out value="${userDevByStats.d4Sum}"/></strong></td>
						<td><strong><c:out value="${userDevByStats.totalRowSum}"/></strong></td>
					</tr>
					</c:if>
				</c:forEach> 
        	</table>
        	</div>
        	<div class="buttons" id="StatsByUserDevToExcel" style="float:right; margin-top:10px;">
				<a href="<c:url value='/tms/defect/StatsToExcel.do'/>" onclick="javascript:StatsToExcel('userDev'); return false;" >엑셀</a>
			</div>
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