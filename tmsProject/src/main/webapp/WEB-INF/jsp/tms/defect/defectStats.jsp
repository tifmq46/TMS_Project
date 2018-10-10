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
<title>결함처리통계(그래프)</title>
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css" >
<script type="text/javascript" src="<c:url value='/js/Chart.min.js' />" ></script>
<script type="text/javascript">

function selectBoxChange() {
	var selectBoxId = document.getElementById("selectBoxStats");
	var selectBoxValue = selectBoxId.options[selectBoxId.selectedIndex].value;
	
	if(selectBoxValue == 1) {
		document.getElementById("dayByDefectCntTitle").style.display="inline"
		document.getElementById("dayByDefectCnt").style.display="inline"
		document.getElementById("monthByDefectCntTitle").style.display="none"
		document.getElementById("monthByDefectCnt").style.display="none"
	} else if (selectBoxValue == 2) {
		document.getElementById("dayByDefectCntTitle").style.display="none"
		document.getElementById("dayByDefectCnt").style.display="none"
		document.getElementById("monthByDefectCntTitle").style.display="inline"
		document.getElementById("monthByDefectCnt").style.display="inline"
	} 
}

function taskBySelectBoxChange() {
	var selectBoxId = document.getElementById("taskBySelectBoxStats");
	var selectBoxValue = selectBoxId.options[selectBoxId.selectedIndex].value;
	
	if(selectBoxValue == 1) {
		document.getElementById("taskByActionStCntTitle").style.display="inline"
		document.getElementById("taskByActionStCnt").style.display="inline"
		document.getElementById("taskByDefectGbCntTitle").style.display="none"
		document.getElementById("taskByDefectGbCnt").style.display="none"
	} else if (selectBoxValue == 2) {
		document.getElementById("taskByActionStCntTitle").style.display="none"
		document.getElementById("taskByActionStCnt").style.display="none"
		document.getElementById("taskByDefectGbCntTitle").style.display="inline"
		document.getElementById("taskByDefectGbCnt").style.display="inline"
	} 
}

window.onload = function() {
	
	
		var colorArray = [ '#B7BDD6', '#98D5DC', '#3765A4', '#D57C86', '#007bff',
		                   '#FF6633', '#FFB399', '#FF33FF', '#FFFF99',
				'#00B3E6', '#E6B333', '#3366E6', '#999966', '#99FF99',
				'#B34D4D', '#80B300', '#809900', '#E6B3B3', '#6680B3',
				'#66991A', '#FF99E6', '#CCFF1A', '#FF1A66', '#E6331A',
				'#33FFCC', '#66994D', '#B366CC', '#4D8000', '#B33300',
				'#CC80CC', '#66664D', '#991AFF', '#E666FF', '#4DB3FF',
				'#1AB399', '#E666B3', '#33991A', '#CC9999', '#B3B31A',
				'#00E680', '#4D8066', '#809980', '#E6FF80', '#1AFF33',
				'#999933', '#FF3380', '#CCCC00', '#66E64D', '#4D80CC',
				'#9900B3', '#E64D66', '#4DB380', '#FF4D4D', '#99E6E6',
				'#6666FF' ];
		
		/** 업무별 조치율 */
		var taskByActionProgression = JSON.parse('${taskByActionProgression}');
		var defectStatsActionStAll = JSON.parse('${defectStats.actionStAll}');
		var defectStatsActionStA5 = JSON.parse('${defectStats.actionStA5}');
		var taskByActionProgressionTaskNm1 = new Array();
		var taskByActionProgressionTaskGb = new Array();
		var taskByActionProgressionTaskTotCnt1 = new Array();
		var taskByActionProgressionTaskA5Cnt = new Array();
		for (var i = 0; i < taskByActionProgression.length; i++) {
			taskByActionProgressionTaskNm1.push(taskByActionProgression[i].taskNm);
			taskByActionProgressionTaskGb.push(taskByActionProgression[i].taskGb);
			taskByActionProgressionTaskTotCnt1.push(taskByActionProgression[i].taskTotCnt);
			taskByActionProgressionTaskA5Cnt.push(taskByActionProgression[i].taskA5Cnt);
		}
		
		var ctx = document.getElementById('taskByAllProgression');
		var myDoughnutChart = new Chart(ctx, {
    		type : 'doughnut',
    		data : {
    			  labels: ['완료건수','미완료건수'],
    				datasets : [ {
    					data : [defectStatsActionStA5,
    					        defectStatsActionStAll-defectStatsActionStA5],
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
		
		for ( var j = 0; j < taskByActionProgressionTaskGb.length; j++) {
			var ctx = document.getElementById(taskByActionProgressionTaskGb[j]);
			var myDoughnutChart = new Chart(ctx, {
	    		type : 'doughnut',
	    		data : {
	    			  labels: ['완료건수','미완료건수'],
	    				datasets : [ {
	    					data : [taskByActionProgressionTaskA5Cnt[j],
	    					        taskByActionProgressionTaskTotCnt1[j]-taskByActionProgressionTaskA5Cnt[j]],
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
		
		/** 업무별 전체 결함건수*/
		function addData(taskNmList, taskTotCntList, colorArray) {
			var dataSetValue = [];
			for(var i=0; i<taskNmList.length; i++) {
				dataSetValue[i] = {
						label : [taskNmList[i]],
						data : [taskTotCntList[i]],
						backgroundColor : [colorArray[i]]
				}
			}
			taskByActionProgressionChart.data.datasets = dataSetValue;
			taskByActionProgressionChart.update();
		}
		
		var taskByActionProgressionChart;
/* 		var taskByActionProgression = JSON.parse('${taskByActionProgression}'); */
	    var taskByActionProgressionTaskNm = new Array();
		var taskByActionProgressionTaskTotCnt = new Array();
/* 		var defectStatsActionStAll = JSON.parse('${defectStats.actionStAll}'); */
		for (var i = 0; i < taskByActionProgression.length; i++) {
			taskByActionProgressionTaskNm.push(taskByActionProgression[i].taskNm);
			taskByActionProgressionTaskTotCnt.push(parseInt(taskByActionProgression[i].taskTotCnt
					/ defectStatsActionStAll* 100));
		}
		var ctx2 = document.getElementById('taskByActionProgression');
		taskByActionProgressionChart = new Chart(ctx2, {
			type : 'horizontalBar',
			data : {
				datasets : [ {
					label : [],
					data : [],
					backgroundColor : '#66E64D'
				}]
			},
			options : {
				scales : {
					xAxes : [ {
						stacked : true
					} ],
					yAxes : [ {
						stacked : true
					} ]
				}
			}
		});
		addData(taskByActionProgressionTaskNm, taskByActionProgressionTaskTotCnt, colorArray);
		
		/* 업무별 상태별 결함건수 */
		var taskByActionStCnt = JSON.parse('${taskByActionStCnt}');
		var taskByActionStCntTaskNm = new Array();
		var taskByActionStCntActionStAll = new Array();
		var taskByActionStCntActionStA1 = new Array();
		var taskByActionStCntActionStA2 = new Array();
		var taskByActionStCntActionStA3 = new Array();
		var taskByActionStCntActionStA4 = new Array();
		var taskByActionStCntActionStA5 = new Array();
		for (var i = 0; i < taskByActionStCnt.length; i++) {
			taskByActionStCntTaskNm.push(taskByActionStCnt[i].taskNm);
			taskByActionStCntActionStAll.push(taskByActionStCnt[i].actionStAll);
			taskByActionStCntActionStA1.push(parseInt(taskByActionStCnt[i].actionStA1
					/ taskByActionStCnt[i].actionStAll * 100));
			taskByActionStCntActionStA2.push(parseInt(taskByActionStCnt[i].actionStA2
					/ taskByActionStCnt[i].actionStAll * 100));
			taskByActionStCntActionStA3.push(parseInt(taskByActionStCnt[i].actionStA3
					/ taskByActionStCnt[i].actionStAll * 100));
			taskByActionStCntActionStA4.push(parseInt(taskByActionStCnt[i].actionStA4
					/ taskByActionStCnt[i].actionStAll * 100));
			taskByActionStCntActionStA5.push(parseInt(taskByActionStCnt[i].actionStA5
					/ taskByActionStCnt[i].actionStAll * 100));
		}
		var ctx3 = document.getElementById('taskByActionStCnt');
		var taskByActionStCntChart = new Chart(ctx3, {
			type : 'horizontalBar',
			data : {
				labels : taskByActionStCntTaskNm,
				barThickness : '0.9',
				datasets : [ {
					label : '대기',
					data : taskByActionStCntActionStA1,
					backgroundColor : colorArray[0],
				}, {
					label : '조치중',
					data : taskByActionStCntActionStA2,
					backgroundColor : colorArray[1],
				}, {
					label : '조치완료',
					data : taskByActionStCntActionStA3,
					backgroundColor : colorArray[2],
				}, {
					label : '재요청',
					data : taskByActionStCntActionStA4,
					backgroundColor : colorArray[3],
				}, {
					label : '최종완료',
					data : taskByActionStCntActionStA5,
					backgroundColor : colorArray[4],
				}, ]
			},
			options : {
				scales : {
					xAxes : [ {
						stacked : true
					} ],
					yAxes : [ {
						stacked : true
					} ]
				}
			}
		});
		
		/* 업무별 유형별 결함건수 */
		var taskByDefectGbCnt = JSON.parse('${taskByDefectGbCnt}');
		var taskByDefectGbCntTaskNm = new Array();
		var taskByDefectGbCntDefectGbAll = new Array();
		var taskByDefectGbCntDefectGbD1 = new Array();
		var taskByDefectGbCntDefectGbD2 = new Array();
		var taskByDefectGbCntDefectGbD3 = new Array();
		var taskByDefectGbCntDefectGbD4 = new Array();
		for (var i = 0; i < taskByDefectGbCnt.length; i++) {
			taskByDefectGbCntTaskNm.push(taskByDefectGbCnt[i].taskNm);
			taskByDefectGbCntDefectGbAll.push(taskByDefectGbCnt[i].defectGbAll);
			taskByDefectGbCntDefectGbD1.push(parseInt(taskByDefectGbCnt[i].defectGbD1
					/ taskByDefectGbCnt[i].defectGbAll * 100));
			taskByDefectGbCntDefectGbD2.push(parseInt(taskByDefectGbCnt[i].defectGbD2
					/ taskByDefectGbCnt[i].defectGbAll * 100));
			taskByDefectGbCntDefectGbD3.push(parseInt(taskByDefectGbCnt[i].defectGbD3
					/ taskByDefectGbCnt[i].defectGbAll * 100));
			taskByDefectGbCntDefectGbD4.push(parseInt(taskByDefectGbCnt[i].defectGbD4
					/ taskByDefectGbCnt[i].defectGbAll * 100));
		}
		var ctx4 = document.getElementById('taskByDefectGbCnt');
		var taskByDefectGbCntChart = new Chart(ctx4, {
			type : 'horizontalBar',
			data : {
				labels : taskByDefectGbCntTaskNm,
				barThickness : '0.9',
				datasets : [ {
					label : '오류',
					data : taskByDefectGbCntDefectGbD1,
					backgroundColor : colorArray[0],
				}, {
					label : '개선',
					data : taskByDefectGbCntDefectGbD2,
					backgroundColor : colorArray[1],
				}, {
					label : '협의필요',
					data : taskByDefectGbCntDefectGbD3,
					backgroundColor : colorArray[2],
				}, {
					label : '기타',
					data : taskByDefectGbCntDefectGbD4,
					backgroundColor : colorArray[3],
				},]
			},
			options : {
				scales : {
					xAxes : [ {
						stacked : true
					} ],
					yAxes : [ {
						stacked : true
					} ]
				}
			}
		});
		
		/** 일자별 결함 등록건수 조치건수*/
		var dayByDefectCnt = JSON.parse('${dayByDefectCnt}');
		var dayByDefectCntDays = new Array();
		var dayByDefectCntEnrollDtCnt = new Array();
		var dayByDefectCntActionDtCnt = new Array();
		for (var i = 0; i < dayByDefectCnt.length; i++) {
			dayByDefectCntDays.push(dayByDefectCnt[i].days);
			dayByDefectCntEnrollDtCnt.push(dayByDefectCnt[i].enrollDtCnt);
			dayByDefectCntActionDtCnt.push(dayByDefectCnt[i].actionDtCnt);
		}
		var ctx5 = document.getElementById('dayByDefectCnt');
		var dayByDefectCntChart = new Chart(ctx5, {
			type : 'bar',
			data : {
				labels : dayByDefectCntDays,
				barThickness : '0.9',
				datasets : [ {
					label : '등록건수',
					data : dayByDefectCntEnrollDtCnt,
					backgroundColor : '#007BFF',
				}, {
					label : '조치건수',
					data : dayByDefectCntActionDtCnt,
					backgroundColor : '#00B3E6',
				}]
			}
		});
		
		/** 월별 결함 등록건수 조치건수*/
		var monthByDefectCnt = JSON.parse('${monthByDefectCnt}');
		var monthByDefectCntMonths = new Array();
		var monthByDefectCntEnrollMonthDtCnt = new Array();
		var monthByDefectCntActionMonthDtCnt = new Array();
		for (var i = 0; i < monthByDefectCnt.length; i++) {
			monthByDefectCntMonths.push(monthByDefectCnt[i].months+'월');
			monthByDefectCntEnrollMonthDtCnt.push(monthByDefectCnt[i].enrollMonthDtCnt);
			monthByDefectCntActionMonthDtCnt.push(monthByDefectCnt[i].actionMonthDtCnt);
		}
		var ctx6 = document.getElementById('monthByDefectCnt');
		var monthByDefectCntChart = new Chart(ctx6, {
			type : 'bar',
			data : {
				labels : monthByDefectCntMonths,
				barThickness : '0.9',
				datasets : [ {
					label : '등록건수',
					data : monthByDefectCntEnrollMonthDtCnt,
					backgroundColor : '#007BFF',
				}, {
					label : '조치건수',
					data : monthByDefectCntActionMonthDtCnt,
					backgroundColor : '#00B3E6',
				}]
			}
		});
		
		$('html').scrollTop(0);
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
     		<div id="search_field">
					<div id="search_field_loc"><h2><strong>결함처리통계(그래프)</strong></h2></div>
			</div>
			<br/>
             <h3><strong>조치율</strong></h3>
             
                 	<%-- 총 : <c:out value="${defectStats.actionStAll}"/> 
                 	완료 : <c:out value="${defectStats.actionStA5}"/>
                 	미완료 : <c:out value="${defectStats.actionStAll - defectStats.actionStA5}"/> --%>
				<table width="100%">
					<tr>
						<td width="90%">
						<fmt:parseNumber var="actionProgression" integerOnly="true"
								value="${defectStats.actionStA5 / defectStats.actionStAll * 100}" />
							<div class="progress" style="height: 2rem;">
								<div class="progress-bar" style="width:${actionProgression}%">
									<font style="font-size: 15px; font-weight: bolder"><c:out
											value=" ${actionProgression}"></c:out>% </font>
								</div>
							</div></td>
						<td width="10%">
						<font size="3px" style="font-weight:bold">
								<c:out value="${defectStats.actionStA5}"></c:out>&nbsp;/&nbsp;<c:out
										value="${defectStats.actionStAll}"></c:out>
						</font>
						</td>
					</tr>
					<tr>
						<td align="right">
						<img
							src="<c:url value='/images/tms/icon_pop_blue.gif' />" width="10"
							height="10" alt="yCnt" />&nbsp;조치율 &nbsp;<img
							src="<c:url value='/images/tms/icon_pop_gray.gif' />" width="10"
							height="10" alt="totCnt" />&nbsp;미조치율
						</td>
						<td></td>
					</tr>
				</table>
            
            <h3><strong>상태별 결함건수</strong></h3>
            <table width="100%" cellspacing = "10" height="80px" >
            <tr>
            	<td width="16.6%" align="center" bgcolor="#CC3C39"><font color="#FFFFFF" size="3" style="font-weight:bold" > 전체건수 <br/><c:out value="${defectStats.actionStAll}"/></font></td>
            	<td width="16.6%" align="center" bgcolor="#007BFF"><font color="#FFFFFF" size="3" style="font-weight:bold" > 대기 <br/><c:out value="${defectStats.actionStA1}"/></font></td>
            	<td width="16.6%" align="center" bgcolor="#007BFF"><font color="#FFFFFF" size="3" style="font-weight:bold" > 조치중 <br/><c:out value="${defectStats.actionStA2}"/></font></td>
            	<td width="16.6%" align="center" bgcolor="#007BFF"><font color="#FFFFFF" size="3" style="font-weight:bold" > 조치완료 <br/><c:out value="${defectStats.actionStA3}"/></font></td>
            	<td width="16.6%" align="center" bgcolor="#007BFF"><font color="#FFFFFF" size="3" style="font-weight:bold" > 재요청 <br/><c:out value="${defectStats.actionStA4}"/></font></td>
            	<td width="16.6%" align="center" bgcolor="#007BFF"><font color="#FFFFFF" size="3" style="font-weight:bold" > 최종완료 <br/><c:out value="${defectStats.actionStA5}"/></font></td>
            </tr>
            </table>
            <br/>
			<div id="dayByDefectCntTitle" style="display:inline">
			<h3><strong>일자별 등록건수, 조치건수</strong></h3>
			<%-- <c:forEach var="dayByDefectCnt" items="${dayByDefectCnt}" varStatus="status">
            	<c:out value="${dayByDefectCnt.days}"/> : <c:out value="${dayByDefectCnt.enrollDtCnt}"/> | <c:out value="${dayByDefectCnt.actionDtCnt}"/>
            	&nbsp;
            </c:forEach> --%>
			</div>
            <div id="monthByDefectCntTitle" style="display:none">
			<h3><strong>월별 등록건수, 조치건수</strong></h3>
			<%-- <c:forEach var="monthByDefectCnt" items="${monthByDefectCnt}" varStatus="status">
            	<c:out value="${monthByDefectCnt.months}"/> : <c:out value="${monthByDefectCnt.enrollMonthDtCnt}"/> | <c:out value="${monthByDefectCnt.actionMonthDtCnt}"/>
            	&nbsp;
            </c:forEach> --%>
            </div>
			<div align="right">
			<select id="selectBoxStats" style="width:12%;text-align-last:center;" onChange="javascript:selectBoxChange();">
				<option value="1" selected="selected" >일자별</option>
				<option value="2" >월별</option>
			</select>
			</div>
            <canvas id="dayByDefectCnt" width="100%" height="20" style="display:inline"></canvas>
            <canvas id="monthByDefectCnt" width="100%" height="20" style="display:none"></canvas>
            <br/><br/>
            <h3><strong>업무별 조치율</strong></h3>
            <div style="overflow:auto; white-space:nowrap; overflow-y:hidden;">
            <table>
            <tr>
            <td>
            &nbsp;&nbsp;<canvas id="taskByAllProgression" width="200" height="200" style="display: inline !important;"></canvas>&nbsp;&nbsp;
            </td>
            <c:forEach var="taskByActionProgression" items="${taskByActionProgression}" varStatus="status">
            <td>
            <canvas id="<c:out value="${taskByActionProgression.taskGb}"/>"  width="180" height="180" style="display: inline !important;"></canvas>&nbsp;&nbsp;
			</td>            
            </c:forEach>
            <br/>
            <tr>
            <td align="center" valign="middle">
            <div style="font-size:15px; font-weight:bolder;">
            	<font color="#007BFF"><c:out value="${defectStats.actionStA5}"/></font>	/ <c:out value="${defectStats.actionStAll}"/> 
           			 <fmt:parseNumber var="actionProgression" integerOnly="true" value="${defectStats.actionStA5 / defectStats.actionStAll * 100}"/>
                 (<c:out value=" ${actionProgression}"></c:out>%)
                 	<br/>
                 	전체
                 	<br/>
             </div>
            </td>
            <c:forEach var="taskByActionProgression" items="${taskByActionProgression}" varStatus="status">
            <td align="center" valign="middle">
            	<div style="font-size:13px; font-weight:bolder;">
            	<font color="#007BFF"><c:out value="${taskByActionProgression.taskA5Cnt}"/></font> / <c:out value="${taskByActionProgression.taskTotCnt}"/>
            	 <c:if test="${taskByActionProgression.taskTotCnt != 0}">
            	 (<fmt:parseNumber var="actionProgression" integerOnly="true" value="${taskByActionProgression.taskA5Cnt / taskByActionProgression.taskTotCnt * 100}"/>
                 	<c:out value=" ${actionProgression}"></c:out>%)
                 </c:if>
                 <br/>
					<c:out value="${taskByActionProgression.taskNm}"/>
                 <br/>
                 </div>
            </td>
            </c:forEach>
            </tr>
            </table>
            </div>
            
            
            <br/><br/>
            <table width="100%">
            <tr>
            <td width="90%" valign="middle">
			 <strong><font size=3>업무별 전체 결함현황</font></strong>
            </td>
            <td width="10%" align="center" valign="middle">
            <strong><font size=2>(단위:%)</font></strong>
            </td>
            </tr>
            </table>
			 <%-- <c:forEach var="taskByActionProgression" items="${taskByActionProgression}" varStatus="status">
            	<c:out value="${taskByActionProgression.taskNm}"/> : <c:out value="${taskByActionProgression.taskTotCnt}"/>
            	&nbsp;
            	 <c:if test="${taskByActionProgression.taskTotCnt != 0}">
            	 (<fmt:parseNumber var="actionProgression" integerOnly="true" value="${taskByActionProgression.taskTotCnt / defectStats.actionStAll * 100}"/>
                 	<strong><c:out value=" ${actionProgression}"></c:out>%</strong>)&nbsp;
                 	</c:if>
            </c:forEach> --%>
            <canvas id="taskByActionProgression" width="100%" height="15"></canvas>
			  <br/><br/>
			  
			  <div align="right">
			<select id="taskBySelectBoxStats" style="width:12%;text-align-last:center;" onChange="javascript:taskBySelectBoxChange();">
				<option value="1" selected="selected" >상태별</option>
				<option value="2" >유형별</option>
			</select>
			</div>
			<div id="taskByActionStCntTitle" style="display:inline">
			<table width="100%">
            <tr>
            <td width="90%" valign="middle">
			 <strong><font size=3>업무별/상태별 결함현황</font></strong>
            </td>
            <td width="10%" align="center" valign="middle">
            <strong><font size=2>(단위:%)</font></strong>
            </td>
            </tr>
            </table>
			<%--  <c:forEach var="taskByActionStCnt" items="${taskByActionStCnt}" varStatus="status">
            	<c:out value="${taskByActionStCnt.taskNm}"/> : (<c:out value="${taskByActionStCnt.actionStAll}"/>) 
            	<c:out value="${taskByActionStCnt.actionStA1}"/> / <c:out value="${taskByActionStCnt.actionStA2}"/> /
            	<c:out value="${taskByActionStCnt.actionStA3}"/> / <c:out value="${taskByActionStCnt.actionStA4}"/> /
            	<c:out value="${taskByActionStCnt.actionStA5}"/>
            	&nbsp;
            </c:forEach> --%>
			</div>
            <canvas id="taskByActionStCnt" width="100%" height="20" style="display:inline"></canvas>
			<div id="taskByDefectGbCntTitle" style="display:none">
			<table width="100%">
            <tr>
            <td width="90%" valign="middle">
			 <strong><font size=3>업무별/유형별 결함현황</font></strong>
            </td>
            <td width="10%" align="center" valign="middle">
            <strong><font size=2>(단위:%)</font></strong>
            </td>
            </tr>
            </table>
			<%--  <c:forEach var="taskByDefectGbCnt" items="${taskByDefectGbCnt}" varStatus="status">
            	<c:out value="${taskByDefectGbCnt.taskNm}"/> : <c:out value="${taskByDefectGbCnt.defectGbD1}"/> / 
            	<c:out value="${taskByDefectGbCnt.defectGbD2}"/> / <c:out value="${taskByDefectGbCnt.defectGbD3}"/> /
            	<c:out value="${taskByDefectGbCnt.defectGbD4}"/>
            	&nbsp;
            </c:forEach> --%>
			</div>
            <canvas id="taskByDefectGbCnt" width="100%" height="20" style="display:none"></canvas>
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