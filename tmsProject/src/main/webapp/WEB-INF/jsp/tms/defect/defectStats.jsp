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
<script type="text/javascript" src="<c:url value='/js/Chart.min.js' />" ></script>
<script type="text/javascript">
    function myFunction(){
    	var ctx = document.getElementById(document.getElementById('taskByActionProgressionTaskGb').value);
    	console.log(document.getElementById('taskByActionProgressionTaskGb').value);
    	var myDoughnutChart = new Chart(ctx, {
    		type : 'doughnut',
    		data : {
    			  labels: ['완료건수','미완료건수'],
    				datasets : [ {
    					data : [document.getElementById('taskByActionProgressionTaskA5Cnt').value,
    					        document.getElementById('taskByActionProgressionTaskTotCnt').value-document.getElementById('taskByActionProgressionTaskA5Cnt').value],
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
    
window.onload = function() {
	

		/** */
		var taskByActionProgressionChart;
		function addData(taskNmList, taskTotCntList, colorArray) {
			console.log(taskNmList.length);
			/* for(var i=0;i<taskNmList.length; i++) {
				taskByActionProgressionChart.data.datasets[i].label=taskNmList[i];
				var num =[];
				num.push(taskTotCntList[i]);
				taskByActionProgressionChart.data.datasets[i].data=num;
				taskByActionProgressionChart.data.datasets[i].backgroundColor=colorArray[i];
				taskByActionProgressionChart.update();
			} */
			taskByActionProgressionChart.data.datasets[0].label = 'good';
			taskByActionProgressionChart.data.datasets[0].data = [ 45 ];
			taskByActionProgressionChart.data.datasets[0].backgroundColor = '#00B3E6';
			taskByActionProgressionChart.data.datasets[1].label = 'BYE';
			taskByActionProgressionChart.data.datasets[1].data = [ 55 ];
			taskByActionProgressionChart.data.datasets[1].backgroundColor = '#FF6633';
			taskByActionProgressionChart.update();
		}

		var colorArray = [ '#FF6633', '#FFB399', '#FF33FF', '#FFFF99',
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

		var taskByActionProgression = JSON.parse('${taskByActionProgression}');
		var defectStatsActionStAll = JSON.parse('${defectStats.actionStAll}');
		var taskByActionProgressionTaskNm = new Array();
		var taskByActionProgressionTaskTotCnt = new Array();
		for (var i = 0; i < taskByActionProgression.length; i++) {
			taskByActionProgressionTaskNm
					.push(taskByActionProgression[i].taskNm);
			taskByActionProgressionTaskTotCnt
					.push(parseInt(taskByActionProgression[i].taskTotCnt
							/ defectStatsActionStAll * 100));
		}
		console.log(taskByActionProgressionTaskTotCnt[0]);
		var ctx2 = document.getElementById('taskByActionProgression');
		taskByActionProgressionChart = new Chart(ctx2, {
			type : 'horizontalBar',
			data : {
				barThickness : '0.9',
				datasets : [ {
					label : '',
					data : [],
					backgroundColor : '#66E64D'
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
		/*  addData(taskByActionProgressionTaskNm, taskByActionProgressionTaskTotCnt, colorArray); */

		/*  */
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
			taskByActionStCntActionStA1.push(taskByActionStCnt[i].actionStA1
					/ taskByActionStCnt[i].actionStAll * 100);
			taskByActionStCntActionStA2.push(taskByActionStCnt[i].actionStA2
					/ taskByActionStCnt[i].actionStAll * 100);
			taskByActionStCntActionStA3.push(taskByActionStCnt[i].actionStA3
					/ taskByActionStCnt[i].actionStAll * 100);
			taskByActionStCntActionStA4.push(taskByActionStCnt[i].actionStA4
					/ taskByActionStCnt[i].actionStAll * 100);
			taskByActionStCntActionStA5.push(taskByActionStCnt[i].actionStA5
					/ taskByActionStCnt[i].actionStAll * 100);
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
             <h3><strong>조치율</strong></h3>
             
                 	<%-- 총 : <c:out value="${defectStats.actionStAll}"/> 
                 	완료 : <c:out value="${defectStats.actionStA5}"/>
                 	미완료 : <c:out value="${defectStats.actionStAll - defectStats.actionStA5}"/> --%>
                 	
               		 <div style="float:right;">
	                     	<strong><c:out value="${defectStats.actionStA5}"></c:out>&nbsp;/&nbsp;<c:out value="${defectStats.actionStAll}"></c:out></strong>
					</div>
                		<fmt:parseNumber var="actionProgression" integerOnly="true" value="${defectStats.actionStA5 / defectStats.actionStAll * 100}"/>
               		 <div class="progress">
					    <div class="progress-bar" style="width:${actionProgression}%"><strong><c:out value=" ${actionProgression}"></c:out>% </strong> </div>
					</div>
					
					<div style="float:right;">
						  <img src="<c:url value='/images/tms/icon_pop_blue.gif' />" width="10" height="10" alt="yCnt"/>&nbsp;조치건수
						  &nbsp;<img src="<c:url value='/images/tms/icon_pop_gray.gif' />" width="10" height="10" alt="totCnt"/>&nbsp;미조치건수
					</div>
            <br/>
            
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
           	<input type="hidden" id="taskByActionProgressionTaskGb" value="<c:out value="${taskByActionProgression.taskGb}"/>" />
           	<input type="hidden" id="taskByActionProgressionTaskNm" value="<c:out value="${taskByActionProgression.taskNm}"/>" /> 
           	<input type="hidden" id="taskByActionProgressionTaskA5Cnt" value="<c:out value="${taskByActionProgression.taskA5Cnt}"/>" />
           	<input type="text" id="taskByActionProgressionTaskTotCnt" value="<c:out value="${taskByActionProgression.taskTotCnt}"/>" onchange="javaScript:myFunction(); return false;"/>
            <canvas id="<c:out value="${taskByActionProgression.taskGb}"/>" width="200" height="200"></canvas>
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
            <canvas id="taskByActionProgression" width="100%" height="20"></canvas>
            
			  <br/><br/>
			 <h4><strong>업무별 상태별  결함건수</strong></h4>
			 <c:forEach var="taskByActionStCnt" items="${taskByActionStCnt}" varStatus="status">
            	<c:out value="${taskByActionStCnt.taskNm}"/> : (<c:out value="${taskByActionStCnt.actionStAll}"/>) 
            	<c:out value="${taskByActionStCnt.actionStA1}"/> / <c:out value="${taskByActionStCnt.actionStA2}"/> /
            	<c:out value="${taskByActionStCnt.actionStA3}"/> / <c:out value="${taskByActionStCnt.actionStA4}"/> /
            	<c:out value="${taskByActionStCnt.actionStA5}"/>
            	&nbsp;
            </c:forEach>
            <canvas id="taskByActionStCnt" width="100%" height="20"></canvas>
			 
			 
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