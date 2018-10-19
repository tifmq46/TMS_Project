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

function devPlanStatsBySelectBoxChange() {
	var selectBoxId = document.getElementById("devPlanStatsBySelectBox");
	var selectBoxValue = selectBoxId.options[selectBoxId.selectedIndex].value;
	
	if(selectBoxValue == 1) {
		document.getElementById("devPlanStatsByAll").style.display="inline";
		document.getElementById("devPlanStatsByThisWeek").style.display="none";
		document.getElementById("devPlanStatsByAccumulate").style.display="none";
		document.getElementById("taskTotalByStats").style.display="inline";
		document.getElementById("taskThisWeekByStats").style.display="none";
		document.getElementById("taskAccumulateByStats").style.display="none";
	} else if (selectBoxValue == 2) {
		document.getElementById("devPlanStatsByAll").style.display="none";
		document.getElementById("devPlanStatsByThisWeek").style.display="inline";
		document.getElementById("devPlanStatsByAccumulate").style.display="none";
		document.getElementById("taskTotalByStats").style.display="none";
		document.getElementById("taskThisWeekByStats").style.display="inline";
		document.getElementById("taskAccumulateByStats").style.display="none";
	} else {
		document.getElementById("devPlanStatsByAll").style.display="none";
		document.getElementById("devPlanStatsByThisWeek").style.display="none";
		document.getElementById("devPlanStatsByAccumulate").style.display="inline";
		document.getElementById("taskTotalByStats").style.display="none";
		document.getElementById("taskThisWeekByStats").style.display="none";
		document.getElementById("taskAccumulateByStats").style.display="inline";
	}
}

window.onload = function() {
	
	/** 시스템별  전체 진척률 시작 --------------------------*/
	var hashTotalByStats = JSON.parse('${hashTotalByStats}');
	var sysTotalByStats = JSON.parse('${sysTotalByStats}');
	var sysTotalByStatsSysGb = new Array();
	var sysTotalByStatsCnta = new Array();
	var sysTotalByStatsCntb = new Array();
	for (var i = 0; i < sysTotalByStats.length; i++) {
		if(sysTotalByStats[i].CNTA == 0){
			sysTotalByStats[i].CNTA = 0.1;
		}
		sysTotalByStatsSysGb.push(sysTotalByStats[i].SYS_GB);
		sysTotalByStatsCnta.push(sysTotalByStats[i].CNTA);
		sysTotalByStatsCntb.push(sysTotalByStats[i].CNTB);
	}
	// 전체 그래프
	var ctx1 = document.getElementById('hashTotalByStats');
	var myDoughnutChart = new Chart(ctx1, {
		type : 'doughnut',
		data : {
			  labels: ['완료건수','미완료건수'],
				datasets : [ {
					data : [hashTotalByStats[0].CNTB,
					        hashTotalByStats[0].CNTA-hashTotalByStats[0].CNTB],
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
					            return label + ' : ' + value;
					          }
						}
					}
				}
		});
	// 시스템별 그래프
	for ( var j = 0; j < sysTotalByStatsSysGb.length; j++) {
		var chartId = "sysTotal" + sysTotalByStatsSysGb[j];
		var ctx2 = document.getElementById(chartId);
		var myDoughnutChart = new Chart(ctx2, {
    		type : 'doughnut',
    		data : {
    			  labels: ['완료건수','미완료건수'],
    				datasets : [ {
    					data : [sysTotalByStatsCntb[j],
    					        sysTotalByStatsCnta[j]-sysTotalByStatsCntb[j]],
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
    					            return label + ' : ' + value;
    					          }
    						}
    					}
    				}
    		});
	}
	/** 시스템별  전체 진척률 끝 --------------------------*/
	
	/** 업무별  전체 진척률 시작 --------------------------*/
	var taskTotalByStats = JSON.parse('${taskTotalByStats}');
	var taskTotalByStatsTaskNm = new Array();
	var taskTotalByStatsR = new Array();
	for (var i = 0; i < taskTotalByStats.length; i++) {
		taskTotalByStatsTaskNm.push(taskTotalByStats[i].TASK_NM);
		if(taskTotalByStats[i].R == 0) {
			taskTotalByStats[i].R = 0.1;
		}
		taskTotalByStatsR.push(taskTotalByStats[i].R);
	}
	var ctx3 = document.getElementById('taskTotalByStats');
	var taskTotalByStatsChart = new Chart(ctx3, {
		type : 'bar',
		data : {
			labels : taskTotalByStatsTaskNm,
			barThickness : '0.9',
			datasets : [ {
				label : '진척률',
				data : taskTotalByStatsR,
				backgroundColor : '#007BFF',
			}]
		},
		options : {
			legend: {
				position : 'bottom'
			},
			tooltips: {
				callbacks: {
				label: function(tooltipItem, data) {
						var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
		            	var label = data.datasets[tooltipItem.datasetIndex].label;
				            if (value === 0.1) {
				            	value = 0;
				            }
				            return label + ' : ' + value+'%';
				          }
					}
				}
		}
	});
	/** 업무별  전체 진척률 끝 --------------------------*/
	
	/** 시스템별  금주 진척률 시작 --------------------------*/
	var hashThisWeekByStats = JSON.parse('${hashThisWeekByStats}');
	var sysThisWeekByStats = JSON.parse('${sysThisWeekByStats}');
	var sysThisWeekByStatsSysGb = new Array();
	var sysThisWeekByStatsCnta = new Array();
	var sysThisWeekByStatsCntb = new Array();
	for (var i = 0; i < sysThisWeekByStats.length; i++) {
		if(sysThisWeekByStats[i].CNTA == 0){
			sysThisWeekByStats[i].CNTA = 0.1;
		}
		sysThisWeekByStatsSysGb.push(sysThisWeekByStats[i].SYS_GB);
		sysThisWeekByStatsCnta.push(sysThisWeekByStats[i].CNTA);
		sysThisWeekByStatsCntb.push(sysThisWeekByStats[i].CNTB);
	}
	// 전체 그래프
	var ctx4 = document.getElementById('hashThisWeekByStats');
	var myDoughnutChart = new Chart(ctx4, {
		type : 'doughnut',
		data : {
			  labels: ['완료건수','미완료건수'],
				datasets : [ {
					data : [hashThisWeekByStats[0].CNTB,
					        hashThisWeekByStats[0].CNTA-hashThisWeekByStats[0].CNTB],
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
					            return label + ' : ' + value;
					          }
						}
					}
				}
		});
	// 시스템별 그래프
	for ( var j = 0; j < sysThisWeekByStatsSysGb.length; j++) {
		var chartId = "sysThisWeek" + sysThisWeekByStatsSysGb[j];
		var ctx5 = document.getElementById(chartId);
		var myDoughnutChart = new Chart(ctx5, {
    		type : 'doughnut',
    		data : {
    			  labels: ['완료건수','미완료건수'],
    				datasets : [ {
    					data : [sysThisWeekByStatsCntb[j],
    					        sysThisWeekByStatsCnta[j]-sysThisWeekByStatsCntb[j]],
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
    					            return label + ' : ' + value;
    					          }
    						}
    					}
    				}
    		});
	}
	/** 시스템별  금주 진척률 끝 --------------------------*/
	
	/** 업무별  금주 진척률 시작 --------------------------*/
	var taskThisWeekByStats = JSON.parse('${taskThisWeekByStats}');
	var taskThisWeekByStatsTaskNm = new Array();
	var taskThisWeekByStatsR = new Array();
	for (var i = 0; i < taskThisWeekByStats.length; i++) {
		taskThisWeekByStatsTaskNm.push(taskThisWeekByStats[i].TASK_NM);
		if(taskThisWeekByStats[i].R == 0) {
			taskThisWeekByStats[i].R = 0.1;
		}
		taskThisWeekByStatsR.push(taskThisWeekByStats[i].R);
	}
	var ctx6 = document.getElementById('taskThisWeekByStats');
	var taskThisWeekByStatsChart = new Chart(ctx6, {
		type : 'bar',
		data : {
			labels : taskThisWeekByStatsTaskNm,
			barThickness : '0.9',
			datasets : [ {
				label : '진척률',
				data : taskThisWeekByStatsR,
				backgroundColor : '#007BFF',
			}]
		},
		options : {
			legend: {
				position : 'bottom'
			},
			tooltips: {
				callbacks: {
				label: function(tooltipItem, data) {
						var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
		            	var label = data.datasets[tooltipItem.datasetIndex].label;
				            if (value === 0.1) {
				            	value = 0;
				            }
				            return label + ' : ' + value+'%';
				          }
					}
				}
		}
	});
	/** 업무별  금주 진척률 끝 --------------------------*/
	
	/** 시스템별  누적 진척률 시작 --------------------------*/
	var hashAccumulateByStats = JSON.parse('${hashAccumulateByStats}');
	var sysAccumulateByStats = JSON.parse('${sysAccumulateByStats}');
	var sysAccumulateByStatsSysGb = new Array();
	var sysAccumulateByStatsCnta = new Array();
	var sysAccumulateByStatsCntb = new Array();
	for (var i = 0; i < sysAccumulateByStats.length; i++) {
		if(sysAccumulateByStats[i].CNTA == 0){
			sysAccumulateByStats[i].CNTA = 0.1;
		}
		sysAccumulateByStatsSysGb.push(sysAccumulateByStats[i].SYS_GB);
		sysAccumulateByStatsCnta.push(sysAccumulateByStats[i].CNTA);
		sysAccumulateByStatsCntb.push(sysAccumulateByStats[i].CNTB);
	}
	// 전체 그래프
	var ctx7 = document.getElementById('hashAccumulateByStats');
	var myDoughnutChart = new Chart(ctx7, {
		type : 'doughnut',
		data : {
			  labels: ['완료건수','미완료건수'],
				datasets : [ {
					data : [hashAccumulateByStats[0].CNTB,
					        hashAccumulateByStats[0].CNTA-hashAccumulateByStats[0].CNTB],
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
					            return label + ' : ' + value;
					          }
						}
					}
				}
		});
	// 시스템별 그래프
	for ( var j = 0; j < sysAccumulateByStatsSysGb.length; j++) {
		var chartId = "sysAccumulate" + sysAccumulateByStatsSysGb[j];
		var ctx8 = document.getElementById(chartId);
		var myDoughnutChart = new Chart(ctx8, {
    		type : 'doughnut',
    		data : {
    			  labels: ['완료건수','미완료건수'],
    				datasets : [ {
    					data : [sysAccumulateByStatsCntb[j],
    					        sysAccumulateByStatsCnta[j]-sysAccumulateByStatsCntb[j]],
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
    					            return label + ' : ' + value;
    					          }
    						}
    					}
    				}
    		});
	}
	/** 시스템별  누적 진척률 끝 --------------------------*/
	
	/** 업무별  누적 진척률 시작 --------------------------*/
	var taskAccumulateByStats = JSON.parse('${taskAccumulateByStats}');
	var taskAccumulateByStatsTaskNm = new Array();
	var taskAccumulateByStatsR = new Array();
	for (var i = 0; i < taskAccumulateByStats.length; i++) {
		taskAccumulateByStatsTaskNm.push(taskAccumulateByStats[i].TASK_NM);
		if(taskAccumulateByStats[i].R == 0) {
			taskAccumulateByStats[i].R = 0.1;
		}
		taskAccumulateByStatsR.push(taskAccumulateByStats[i].R);
	}
	var ctx9 = document.getElementById('taskAccumulateByStats');
	var taskAccumulateByStatsChart = new Chart(ctx9, {
		type : 'bar',
		data : {
			labels : taskAccumulateByStatsTaskNm,
			barThickness : '0.9',
			datasets : [ {
				label : '진척률',
				data : taskAccumulateByStatsR,
				backgroundColor : '#007BFF',
			}]
		},
		options : {
			legend: {
				position : 'bottom'
			},
			tooltips: {
				callbacks: {
				label: function(tooltipItem, data) {
						var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
		            	var label = data.datasets[tooltipItem.datasetIndex].label;
				            if (value === 0.1) {
				            	value = 0;
				            }
				            return label + ' : ' + value+'%';
				          }
					}
				}
		}
	});
	/** 업무별  누적 진척률 끝 --------------------------*/
	
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
							<li>&#62;</li>
							<li>개발진척관리</li>
							<li>&gt;</li>
							<li><strong>개발진척통계</strong></li>
                        </ul>
                    </div>
                </div>
               <div id="search_field">
	                <div id="search_field_loc"><h2><strong>개발진척통계</strong></h2></div>  
				</div>
				<br/><br/>
             <div align="right">
						<select id=devPlanStatsBySelectBox style="width: 12%; text-align-last: center;"
							onChange="javascript:devPlanStatsBySelectBoxChange();">
							<option value="1" selected="selected">전체</option>
							<option value="2">금주</option>
							<option value="3">누적</option>
						</select>
			</div>
			
			<div id="devPlanStatsByAll" style="display:inline">
             <h3><strong>시스템별 전체 진척률</strong></h3>
      		 <div style="overflow:auto; white-space:nowrap; overflow-y:hidden;">
            <table>
            <tr>
            <td>
             &nbsp;&nbsp;<canvas id="hashTotalByStats" width="200" height="200" style="display: inline !important;"></canvas>&nbsp;&nbsp;
             </td>
            <c:forEach var="sysTotalByStats" items="${sysTotalByStats}" varStatus="status">
            <td>
            <canvas id="<c:out value="sysTotal${sysTotalByStats.SYS_GB}"/>"  width="180" height="180" style="display: inline !important;"></canvas>&nbsp;&nbsp;
			</td>            
            </c:forEach>
            <br/>
            </tr>
            
            <tr>
            <td align="center" valign="middle">
            <div style="font-size:15px; font-weight:bolder;">
            	<font color="#007BFF"><c:out value="${hashTotalByStats[0].CNTB}"/></font>	/ <c:out value="${hashTotalByStats[0].CNTA}"/> 
                 (<c:out value=" ${hashTotalByStats[0].R}"></c:out>%)
                 	<br/>
                 	전체
                 	<br/>
             </div>
            </td>
            <c:forEach var="sysTotalByStats" items="${sysTotalByStats}" varStatus="status">
            <td align="center" valign="middle">
            	<div style="font-size:13px; font-weight:bolder;">
            	<font color="#007BFF"><c:out value="${sysTotalByStats.CNTB}"/></font> / <c:out value="${sysTotalByStats.CNTA}"/>
                 	(<c:out value=" ${sysTotalByStats.R}"></c:out>%)
                 <br/>
					<c:out value="${sysTotalByStats.SYS_NM}"/>
                 <br/>
                 </div>
            </td>
            </c:forEach>
            </tr>
            </table>
            </div>
             <h3><strong>업무별 전체 진척률</strong></h3>
			</div>
            
			<canvas id="taskTotalByStats" width="100%" height="20" style="display:inline"></canvas>
			
			<div id="devPlanStatsByThisWeek" style="display:none">
			<h3><strong>시스템별 금주 진척률</strong></h3>
      		 <div style="overflow:auto; white-space:nowrap; overflow-y:hidden;">
            <table>
            <tr>
            <td>
             &nbsp;&nbsp;<canvas id="hashThisWeekByStats" width="200" height="200" style="display: inline !important;"></canvas>&nbsp;&nbsp;
             </td>
            <c:forEach var="sysThisWeekByStats" items="${sysThisWeekByStats}" varStatus="status">
            <td>
            <canvas id="<c:out value="sysThisWeek${sysThisWeekByStats.SYS_GB}"/>"  width="180" height="180" style="display: inline !important;"></canvas>&nbsp;&nbsp;
			</td>            
            </c:forEach>
            <br/>
            </tr>
            
            <tr>
            <td align="center" valign="middle">
            <div style="font-size:15px; font-weight:bolder;">
            	<font color="#007BFF"><c:out value="${hashThisWeekByStats[0].CNTB}"/></font>	/ <c:out value="${hashThisWeekByStats[0].CNTA}"/> 
                 (<c:out value=" ${hashThisWeekByStats[0].R}"></c:out>%)
                 	<br/>
                 	전체
                 	<br/>
             </div>
            </td>
            <c:forEach var="sysThisWeekByStats" items="${sysThisWeekByStats}" varStatus="status">
            <td align="center" valign="middle">
            	<div style="font-size:13px; font-weight:bolder;">
            	<font color="#007BFF"><c:out value="${sysThisWeekByStats.CNTB}"/></font> / <c:out value="${sysThisWeekByStats.CNTA}"/>
                 	(<c:out value=" ${sysThisWeekByStats.R}"></c:out>%)
                 <br/>
					<c:out value="${sysThisWeekByStats.SYS_NM}"/>
                 <br/>
                 </div>
            </td>
            </c:forEach>
            </tr>
            </table>
            </div>
             <h3><strong>업무별 금주 진척률</strong></h3>
            </div>
            
			<canvas id="taskThisWeekByStats" width="100%" height="20" style="display:none"></canvas>   
            
            <div id="devPlanStatsByAccumulate" style="display:none">
            <h3><strong>시스템별 누적 진척률</strong></h3>
      		 <div style="overflow:auto; white-space:nowrap; overflow-y:hidden;">
            <table>
            <tr>
            <td>
             &nbsp;&nbsp;<canvas id="hashAccumulateByStats" width="200" height="200" style="display: inline !important;"></canvas>&nbsp;&nbsp;
             </td>
            <c:forEach var="sysAccumulateByStats" items="${sysAccumulateByStats}" varStatus="status">
            <td>
            <canvas id="<c:out value="sysAccumulate${sysAccumulateByStats.SYS_GB}"/>"  width="180" height="180" style="display: inline !important;"></canvas>&nbsp;&nbsp;
			</td>            
            </c:forEach>
            <br/>
            </tr>
            
            <tr>
            <td align="center" valign="middle">
            <div style="font-size:15px; font-weight:bolder;">
            	<font color="#007BFF"><c:out value="${hashAccumulateByStats[0].CNTB}"/></font>	/ <c:out value="${hashAccumulateByStats[0].CNTA}"/> 
                 (<c:out value=" ${hashAccumulateByStats[0].R}"></c:out>%)
                 	<br/>
                 	전체
                 	<br/>
             </div>
            </td>
            <c:forEach var="sysAccumulateByStats" items="${sysAccumulateByStats}" varStatus="status">
            <td align="center" valign="middle">
            	<div style="font-size:13px; font-weight:bolder;">
            	<font color="#007BFF"><c:out value="${sysAccumulateByStats.CNTB}"/></font> / <c:out value="${sysAccumulateByStats.CNTA}"/>
                 	(<c:out value=" ${sysAccumulateByStats.R}"></c:out>%)
                 <br/>
					<c:out value="${sysAccumulateByStats.SYS_NM}"/>
                 <br/>
                 </div>
            </td>
            </c:forEach>
            </tr>
            </table>
            </div>
             <h3><strong>업무별 누적 진척률</strong></h3>
            </div>
            
			<canvas id="taskAccumulateByStats" width="100%" height="20" style="display:none"></canvas>   
            
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