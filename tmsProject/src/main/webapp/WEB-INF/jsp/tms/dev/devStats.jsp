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
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/Chart.min.js' />" ></script>
<script type="text/javaScript">

window.onload = function() {
	
	/** 시스템별  진척률 */
	var sysByStats = JSON.parse('${sysByStats}');
	var sysAllByStats = JSON.parse('${sysAllByStats}');
	var sysAllByStatsAchieveCnt = sysAllByStats[0].achieveAllCnt;
	var sysAllByStatsSysAll = sysAllByStats[0].sysAll;
	var sysByStatsSysGb = new Array();
	var sysByStatsAchieveCnt = new Array();
	var sysByStatsSysAll = new Array();
	for (var i = 0; i < sysByStats.length; i++) {
		sysByStatsSysGb.push(sysByStats[i].sysGb);
		sysByStatsAchieveCnt.push(sysByStats[i].achieveCnt);
		sysByStatsSysAll.push(sysByStats[i].sysAll);
	}
	// 전체 그래프
	var ctx1 = document.getElementById('sysAllByStats');
	var myDoughnutChart = new Chart(ctx1, {
		type : 'doughnut',
		data : {
			  labels: ['완료건수','미완료건수'],
				datasets : [ {
					data : [sysAllByStatsAchieveCnt,
					        sysAllByStatsSysAll-sysAllByStatsAchieveCnt],
					backgroundColor : ['#007bff','#e9ecef']
				},]
			},
			options : {
				rotation: 1 * Math.PI,
		        circumference: 1 * Math.PI,
				percentageInnerCutout : 50,
				responsive:false
				}
		});
	// 시스템별 그래프
	for ( var j = 0; j < sysByStatsSysGb.length; j++) {
		var ctx = document.getElementById(sysByStatsSysGb[j]);
		var myDoughnutChart = new Chart(ctx, {
    		type : 'doughnut',
    		data : {
    			  labels: ['완료건수','미완료건수'],
    				datasets : [ {
    					data : [sysByStatsAchieveCnt[j],
    					        sysByStatsSysAll[j]-sysByStatsAchieveCnt[j]],
    					backgroundColor : ['#007bff','#e9ecef']
    				},]
    			},
    			options : {
    				rotation: 1 * Math.PI,
    		        circumference: 1 * Math.PI,
    				percentageInnerCutout : 50,
    				responsive:false
    				}
    		});
	}
	
	/** 금주  진척률 */
	var taskThisWeekByStats = JSON.parse('${taskThisWeekByStats}');
	var taskThisWeekByStatsCnta = new Array();
	var taskThisWeekByStatsCntb = new Array();
	var taskThisWeekByStatsTaskGb = new Array();
	for (var i = 0; i < taskThisWeekByStats.length; i++) {
		if(taskThisWeekByStats[i].CNTA == 0) {
			taskThisWeekByStats[i].CNTA = 0.1;
		}
		taskThisWeekByStatsCnta.push(taskThisWeekByStats[i].CNTA);
		taskThisWeekByStatsCntb.push(taskThisWeekByStats[i].CNTB);
		taskThisWeekByStatsTaskGb.push(taskThisWeekByStats[i].TASK_GB);
	}
	for ( var j = 0; j < taskThisWeekByStatsTaskGb.length; j++) {
		var ctx = document.getElementById(taskThisWeekByStatsTaskGb[j]);
		var myDoughnutChart = new Chart(ctx, {
    		type : 'doughnut',
    		data : {
    			  labels: ['완료건수','미완료건수'],
    				datasets : [ {
    					data : [taskThisWeekByStatsCntb[j],
    					        taskThisWeekByStatsCnta[j]-taskThisWeekByStatsCntb[j]],
    					backgroundColor : ['#007bff','#e9ecef']
    				},]
    			},
    			options : {
    				rotation: 1 * Math.PI,
    		        circumference: 1 * Math.PI,
    				percentageInnerCutout : 50,
    				responsive:false,
    				tooltips: {
    					callbacks: {
    					label: function(tooltipItem, data) {
    					            var value = data.datasets[0].data[tooltipItem.index];
    					            var label = data.labels[tooltipItem.index];

    					            if (value === 0.1) {
    					            	value = 0;
    					            }

    					            return label + ': ' + value;
    					          }
    						}
    					}
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
            <div id="content">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
							<li>HOME</li>
							<li>&#62;</li>
							<li>개발진척관리</li>
							<li>&gt;</li>
							<li><strong>개발진척통계(그래프)</strong></li>
                        </ul>
                    </div>
                </div>
               <div id="search_field">
	                <div id="search_field_loc"><h2><strong>개발진척통계(그래프)</strong></h2></div>  
				</div>
				<br/><br/>
               
               <h3><strong>시스템별 진척률</strong></h3>
      		 <div style="overflow:auto; white-space:nowrap; overflow-y:hidden;">
            <table>
            <tr>
            <td>
             &nbsp;&nbsp;<canvas id="sysAllByStats" width="200" height="200" style="display: inline !important;"></canvas>&nbsp;&nbsp;
             </td>
            <c:forEach var="sysByStats" items="${sysByStats}" varStatus="status">
            <td>
            <canvas id="<c:out value="${sysByStats.sysGb}"/>"  width="180" height="180" style="display: inline !important;"></canvas>&nbsp;&nbsp;
			</td>            
            </c:forEach>
            <br/>
            </tr>
            
            <tr>
            <td align="center" valign="middle">
            <div style="font-size:15px; font-weight:bolder;">
            	<font color="#007BFF"><c:out value="${sysAllByStats[0].achieveAllCnt}"/></font>	/ <c:out value="${sysAllByStats[0].sysAll}"/> 
           			 <fmt:parseNumber var="sysAllByStatsPercentage" integerOnly="true" value="${sysAllByStats[0].achieveAllCnt / sysAllByStats[0].sysAll * 100}"/>
                 (<c:out value=" ${sysAllByStatsPercentage}"></c:out>%)
                 	<br/>
                 	전체
                 	<br/>
             </div>
            </td>
            <c:forEach var="sysByStats" items="${sysByStats}" varStatus="status">
            <td align="center" valign="middle">
            	<div style="font-size:13px; font-weight:bolder;">
            	<font color="#007BFF"><c:out value="${sysByStats.achieveCnt}"/></font> / <c:out value="${sysByStats.sysAll}"/>
            	 <c:if test="${sysByStats.sysAll != 0}">
            	 (<fmt:parseNumber var="sysByStatsPencentage" integerOnly="true" value="${sysByStats.achieveCnt / sysByStats.sysAll * 100}"/>
                 	<c:out value=" ${sysByStatsPencentage}"></c:out>%)
                 </c:if>
                 <br/>
					<c:out value="${sysByStats.sysNm}"/>
                 <br/>
                 </div>
            </td>
            </c:forEach>
            </tr>
            </table>
            </div>
            
               <h3><strong>주별 진척률</strong></h3>
      		 <div style="overflow:auto; white-space:nowrap; overflow-y:hidden;">
             <table>
            <tr>
            <c:forEach var="taskThisWeekByStats" items="${taskThisWeekByStats}" varStatus="status">
            <td>
            <canvas id="<c:out value="${taskThisWeekByStats.TASK_GB}"/>"  width="180" height="180" style="display: inline !important;"></canvas>&nbsp;&nbsp;
			</td>            
            </c:forEach>
            <br/>
            </tr>
            
            <tr>
            <c:forEach var="taskThisWeekByStats" items="${taskThisWeekByStats}" varStatus="status">
            <td align="center" valign="middle">
            	<div style="font-size:13px; font-weight:bolder;">
            	<font color="#007BFF"><c:out value="${taskThisWeekByStats.CNTB}"/></font> / <c:out value="${taskThisWeekByStats.CNTA}"/>
                 	(<c:out value=" ${taskThisWeekByStats.R}"></c:out>%)
                 <br/>
					<c:out value="${taskThisWeekByStats.TASK_NM}"/>
                 <br/>
                 </div>
            </td>
            </c:forEach>
            </tr>
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