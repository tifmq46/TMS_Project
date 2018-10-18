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

<title>개발진척통계</title>

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

#lineStyle{
	border-bottom: solid 1px #00000054;
	border-top: solid 1px #00000054;
	background: #EFEFFB;
}

#lineStyle2{
	border-bottom: solid 1px #00000054;
	border-top: solid 1px #00000054;
	background: #E0E0F8;
}

.line{
	font-weight:bold;
}
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javaScript" language="javascript">
$(document).ready(function() {
	
	$('ul.tabs li').click(function() {
		var tab_id = $(this).attr('data-tab');
		if(!(tab_id == "tab-5")){
			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
			
			$(this).addClass('current');
			$("#" + tab_id).addClass('current');
			
			if(tab_id=="tab-1") {
					document.getElementById("StatsByUserToExcel").style.display="inline"
					document.getElementById("StatsByTaskToExcel").style.display="none"
					document.getElementById("StatsByTaskTotalToExcel").style.display="none"
			} else if(tab_id=="tab-2") {
					document.getElementById("StatsByUserToExcel").style.display="none"
					document.getElementById("StatsByTaskToExcel").style.display="inline"
					document.getElementById("StatsByTaskTotalToExcel").style.display="none"
			}else if(tab_id=="tab-3") {
					document.getElementById("StatsByUserToExcel").style.display="none"
					document.getElementById("StatsByTaskToExcel").style.display="none"
					document.getElementById("StatsByTaskTotalToExcel").style.display="inline"
			}
			
		}
	})
})

function StatsToExcel(statsGb) {
		location.href = "./StatsToExcel.do?statsGb=" + statsGb;
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
							<li>&#62;</li>
							<li>개발진척관리</li>
							<li>&gt;</li>
							<li><strong>개발진척통계</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 프로젝트 개발 기간 박스 시작-->
				<div id="search_field">
					<div id="search_field_loc"><h2><strong>개발진척통계(통계표)</strong></h2></div>
				</div>
				 <!-- 프로젝트 개발 기간 박스 끝-->
                
                <ul class="tabs">
					<li class="tab-link current" data-tab="tab-1">개발자별</li>
					<li class="tab-link" data-tab="tab-2">업무별</li>
					<li class="tab-link" data-tab="tab-3">전체</li>
					<li class="tab-link last" data-tab="tab-5" style="float:right">
					
						<div class="buttons" id="StatsByUserToExcel" style="display:inline">
								<a href="<c:url value='/tms/dev/StatsToExcel.do'/>"
									onclick="javascript:StatsToExcel('user'); return false;">엑셀 다운로드</a>
						</div>
						<div class="buttons" id="StatsByTaskToExcel" style="display:none">
							<a href="<c:url value='/tms/dev/StatsToExcel.do'/>"
								onclick="javascript:StatsToExcel('task'); return false;">엑셀 다운로드</a>
						</div>
						<div class="buttons" id="StatsByTaskTotalToExcel" style="display:none">
							<a href="<c:url value='/tms/dev/StatsToExcel.do'/>"
								onclick="javascript:StatsToExcel('taskTotal'); return false;">엑셀 다운로드</a>
						</div>
					</li>
				</ul>
                
                <div id="tab-1" class="tab-content current">
                                    
	                <h2><strong>계획</strong></h2>
	                <div class="default_tablestyle">
	                    <table summary="개발자별 계획통계 테이블입니다" cellpadding="0" cellspacing="0">
	                    <caption>계획통계(개발자별) 테이블</caption>
	           
	          			<thead>
	          			<tr>
	          				<th align="center" >개발자</th>
		          			<c:forEach var="mw" items="${monthWeek}" varStatus="status">
		                    	<th align="center">${status.count}주(${mw})</th>
		                    </c:forEach>
		                    <th align="center"><strong>합계</strong></th>
	          			</tr>
	                    </thead>
	           			
	           			<%int totSum=0; %>
	           			<c:forEach var="upl" items="${userplanList}" varStatus="status">
	           			
		                    <tr>
		                    	<td><c:out value="${upl.DevNm}" /></td>
		                    	<c:forEach begin="${begin}" end="${end}" var="i" varStatus="s">
				           			<c:set var ="t"  value="a${i}"></c:set>
				           			<td>${upl[t]}</td>
								</c:forEach>
								<td><strong>${upl.sumUserPlan}</strong></td>
								<c:set var = "totSum" value="${upl.sumUserPlan}" />
								<% totSum += (Integer)pageContext.getAttribute("totSum");
									pageContext.setAttribute("totSum", totSum);
								%>
		                    </tr>
	                    </c:forEach>
	                    <tr>
	                    	<td><strong><c:out value="합계" /></strong></td>
	                    	<c:forEach var="sum" items="${sumPlanWeek}" varStatus="status">
		                    		<td align="center"><strong>${sum}</strong></td>
		                  	</c:forEach>
		                  	<td><strong>${totSum}</strong></td>
	                    </tr>
	                    </table>
	                </div>
	                
	                <div id="search_field"> <div id="search_field_loc"></div></div>
	               
	              	<h2><strong>실적</strong></h2>
	                <div class="default_tablestyle">
	                    <table summary="개발자별 실적통계 테이블입니다" cellpadding="0" cellspacing="0">
	                    <caption>실적통계(개발자별) 테이블</caption>
	           
	          			<thead>
	          			<tr>
	          				<th align="center" >개발자</th>
		          			<c:forEach var="mw" items="${monthWeek}" varStatus="status">
		                    	<th align="center">${status.count}주(${mw})</th>
		                    </c:forEach>
		                    <th align="center"><strong>합계</strong></th>
	          			</tr>
	                    </thead>
	           			
	           			<%int totSum2=0; %>
	           			<c:forEach var="udl" items="${userDevList}" varStatus="status">
	           			
	           			
	                    <tr>
	                    	<td><c:out value="${udl.DevNm}" /></td>
	                    	<c:forEach begin="${begin}" end="${end}" var="i" varStatus="s">
			           			<c:set var ="t"  value="a${i}"></c:set>
			           			<td>${udl[t]}</td>
							</c:forEach>
							<td><strong>${udl.sumUserDev}</strong></td>
							<c:set var = "totSum2" value="${udl.sumUserDev}" />
							<% totSum2 += (Integer)pageContext.getAttribute("totSum2");
								pageContext.setAttribute("totSum2", totSum2);
							%>
	                    </tr>
	                    </c:forEach>
	            		<tr>
	                    	<td><strong><c:out value="합계" /></strong></td>
	                    	<c:forEach var="sum" items="${sumDevWeek}" varStatus="status">
		                    		<td align="center"><strong>${sum}</strong></td>
		                  	</c:forEach>
		                  	<td><strong>${totSum2}</strong></td>
	                    </tr>
	                    
	                    </table>
	                </div>
                </div>
                <div id="tab-2" class="tab-content">
                <h2><strong>계획</strong></h2>
                <div class="default_tablestyle">
                    <table summary="업무별 계획통계 테이블입니다" cellpadding="0" cellspacing="0">
                    <caption>계획통계(업무별)테이블</caption>
           
          			<thead>
	          			<tr>
	          				<th align="center" >업무</th>
		          			<c:forEach var="mw" items="${monthWeek}" varStatus="status">
		                    	<th align="center">${status.count}주(${mw})</th>
		                    </c:forEach>
		                    <th align="center"><strong>합계</strong></th>
	          			</tr>
	                </thead>
           			
           			<%int totSum3=0; %>
           			<c:forEach var="tpl" items="${taskPlanList}" varStatus="status">
	                    <tr>
	                    	<td><c:out value="${tpl.taskGbNm}" /></td>
	                    	<c:forEach begin="${begin}" end="${end}" var="i" varStatus="s">
			           			<c:set var ="t"  value="a${i}"></c:set>
			           			<td>${tpl[t]}</td>
							</c:forEach>
							<td><strong>${tpl.sumTaskPlan}</strong></td>
							<c:set var = "totSum3" value="${tpl.sumTaskPlan}" />
							<% totSum3 += (Integer)pageContext.getAttribute("totSum3");
								pageContext.setAttribute("totSum3", totSum3);
							%>
	                    </tr>
                    </c:forEach>
                    <tr>
	                    	<td><strong><c:out value="합계" /></strong></td>
	                    	<c:forEach var="sum" items="${sumPlanWeek}" varStatus="status">
		                    		<td align="center"><strong>${sum}</strong></td>
		                  	</c:forEach>
		                  	<td><strong>${totSum3}</strong></td>
	                </tr>
                    </table>
                </div>
                
                 <div id="search_field"> <div id="search_field_loc"></div></div>
                
                <h2><strong>실적</strong></h2>
                <div class="default_tablestyle">
                    <table summary="업무별 실적통계 테이블입니다" cellpadding="0" cellspacing="0">
                    <caption>실적통계(업무별)테이블</caption>
           
          			<thead>
	          			<tr>
	          				<th align="center" >개발자</th>
		          			<c:forEach var="mw" items="${monthWeek}" varStatus="status">
		                    	<th align="center">${status.count}주(${mw})</th>
		                    </c:forEach>
		                    <th align="center"><strong>합계</strong></th>
	          			</tr>
	                </thead>
           			
           			<%int totSum4=0; %>
           			<c:forEach var="tdl" items="${taskDevList}" varStatus="status">
	                    <tr>
	                    	<td><c:out value="${tdl.taskGbNm}" /></td>
	                    	<c:forEach begin="${begin}" end="${end}" var="i" varStatus="s">
			           			<c:set var ="t"  value="a${i}"></c:set>
			           			<td>${tdl[t]}</td>
							</c:forEach>
							<td><strong>${tdl.sumTaskDev}</strong></td>
							<c:set var = "totSum4" value="${tdl.sumTaskDev}" />
							<% totSum4 += (Integer)pageContext.getAttribute("totSum4");
								pageContext.setAttribute("totSum4", totSum4);
							%>
	                    </tr>
                    </c:forEach>
            		<tr>
	                   	<td><strong><c:out value="합계" /></strong></td>
	                   	<c:forEach var="sum" items="${sumDevWeek}" varStatus="status">
		                   		<td align="center"><strong>${sum}</strong></td>
		                </c:forEach>
		                <td><strong>${totSum4}</strong></td>
	                </tr>
                    
                    </table>
                </div>
                 </div>
                 
                 <div id="tab-3" class="tab-content">
	                 <div class="default_tablestyle">
	                    <table summary="전체 통계 테이블입니다" cellpadding="0" cellspacing="0">
	                    <caption>통계 테이블</caption>
	           
	          			<thead>
	          				<tr>
		          				<th align="center" rowspan="2">시스템구분</th>
			          			<th align="center" rowspan="2">업무구분</th>
			                    <th align="center" rowspan="2">총 본수</th>
			                    <th align="center" colspan="3" class='line'>금주 계획대비 실적</th>
			                    <th align="center" colspan="3" class='line'>금주 누적계획대비 실적</th>
			                    <th align="center" colspan="2" class='line'>전체 진척률</th>
		          			</tr>
		          			<tr>
			                    <th align="center" >계획</th>
			                    <th align="center" >실적</th>
			                    <th align="center" class='line'>진척률</th>
			                    <th align="center" >계획</th>
			                    <th align="center" >실적</th>
			                    <th align="center" class='line'>진척률</th>
			                    <th align="center" >실적</th>
			                    <th align="center" class='line'>진척률</th>
		          			</tr>
		                </thead>
	           			
	           			<c:forEach var="t" items="${totalTable}" varStatus="status">
		                    <tr>
		                    
		                    	
		                    	<c:choose>
			                    	<c:when test="${t.taskNm eq '소계' && t.sysNm ne '합계'}">
			                    		<td id='lineStyle'><strong><c:out value="${t.sysNm}" /></strong></td>
			                    		<td id='lineStyle'><strong><c:out value="${t.taskNm}" /></strong></td>
			                    		<td id='lineStyle'><strong><c:out value="${t.totCnt}" /></strong></td>
			                    		<td id='lineStyle'><strong><c:out value="${t.tp}" /></strong></td>
			                    		<td id='lineStyle'><strong><c:out value="${t.td}" /></strong></td>
			                    		<td id='lineStyle'><strong><c:out value="${t.tr}" /></strong></td>
			                    		<td id='lineStyle'><strong><c:out value="${t.ap}" /></strong></td>
			                    		<td id='lineStyle'><strong><c:out value="${t.ad}" /></strong></td>
			                    		<td id='lineStyle'><strong><c:out value="${t.ar}" /></strong></td>
			                    		<td id='lineStyle'><strong><c:out value="${t.totD}" /></strong></td>
			                    		<td id='lineStyle'><strong><c:out value="${t.tot}" /></strong></td>
			                    	</c:when>
			                    	<c:when test="${t.sysNm eq '합계'}">
			                    		<td id='lineStyle2'><strong><c:out value="${t.sysNm}" /></strong></td>
			                    		<td id='lineStyle2'><strong><c:out value="${t.taskNm}" /></strong></td>
			                    		<td id='lineStyle2'><strong><c:out value="${t.totCnt}" /></strong></td>
			                    		<td id='lineStyle2'><strong><c:out value="${t.tp}" /></strong></td>
			                    		<td id='lineStyle2'><strong><c:out value="${t.td}" /></strong></td>
			                    		<td id='lineStyle2'><strong><c:out value="${t.tr}" /></strong></td>
			                    		<td id='lineStyle2'><strong><c:out value="${t.ap}" /></strong></td>
			                    		<td id='lineStyle2'><strong><c:out value="${t.ad}" /></strong></td>
			                    		<td id='lineStyle2'><strong><c:out value="${t.ar}" /></strong></td>
			                    		<td id='lineStyle2'><strong><c:out value="${t.totD}" /></strong></td>
			                    		<td id='lineStyle2'><strong><c:out value="${t.tot}" /></strong></td>
			                    	</c:when>
			                    	<c:otherwise>
			                    		<td><c:out value="${t.sysNm}" /></td>
			                    		<td><c:out value="${t.taskNm}" /></td>	
			                    		<td><c:out value="${t.totCnt}" /></td>
				                    	<td><c:out value="${t.tp}" /></td>
				                    	<td><c:out value="${t.td}" /></td>
				                    	<td><c:out value="${t.tr}" /></td>
				                    	<td><c:out value="${t.ap}" /></td>
				                    	<td><c:out value="${t.ad}" /></td>
				                    	<td><c:out value="${t.ar}" /></td>
				                    	<td><c:out value="${t.totD}" /></td>
				                    	<td><c:out value="${t.tot}" /></td>
			                    	</c:otherwise>
		                    	</c:choose>
		                    	
		                    </tr>
	                    </c:forEach>
	                    </table>
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