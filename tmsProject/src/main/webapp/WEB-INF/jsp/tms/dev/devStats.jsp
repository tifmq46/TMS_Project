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
	
	/** 시스템별  전체 진척률 시작 --------------------------*/
	var totalProgramCnt = JSON.parse('${progressRateTotal.cntA}');
	var totalPerfCnt = JSON.parse('${progressRateTotal.cntB}');
	var totalPercent = JSON.parse('${progressRateTotal.rate}');
	
	var sysByProgressRate = JSON.parse('${sysByProgressRate}');
	var sysByProgressSysGb = new Array();
	var sysByProgressSysNm = new Array();
	var sysByProgressRateCnta = new Array();
	var sysByProgressRateCntb = new Array();
	var sysByProgressRateRate = new Array();
	for (var i = 0; i < sysByProgressRate.length; i++) {
		sysByProgressSysGb.push(sysByProgressRate[i].sysGb);
		sysByProgressSysNm.push(sysByProgressRate[i].sysNm);
		if(sysByProgressRate[i].cntA == 0){
			sysByProgressRate[i].cntA = 0.1;
		}
		sysByProgressRateCnta.push(sysByProgressRate[i].cntA);
		sysByProgressRateCntb.push(sysByProgressRate[i].cntB);
		sysByProgressRateRate.push(sysByProgressRate[i].rate);
	}
	
	// 전체 그래프
	var ctx1 = document.getElementById('progressRateTotal');
	var myDoughnutChart = new Chart(ctx1, {
		type : 'doughnut',
		data : {

				labels: ['완료건수','미완료건수'],
				datasets : [ {
					label : ['sysGb'],
					data : [totalPerfCnt,
					        totalProgramCnt-totalPerfCnt],
					backgroundColor : ['#007bff','#e9ecef']
				},]
			},
			options : {
				legend:{
					display:false
				},
				rotation: 1 * Math.PI,
		        circumference: 1 * Math.PI,
				percentageInnerCutout : 50,
				responsive:false
				,onClick:handleClick
				}
		});
	// 시스템별 그래프
	 for ( var j = 0; j < sysByProgressSysNm.length; j++) {
	var ctx = document.getElementById(sysByProgressSysGb[j]);
	var myDoughnutChart = new Chart(ctx, {
    	type : 'doughnut',
    	data : {
    		  labels: ['완료건수','미완료건수'],
    			datasets : [ {
    				label : [sysByProgressSysGb[j]],
    				data : [sysByProgressRateCntb[j],
    				        sysByProgressRateCnta[j]-sysByProgressRateCntb[j]],
    				backgroundColor : ['#007bff','#e9ecef']
    			},]
    		},
    		options : {
    			legend: {
					display:false
				},
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
    			 ,onClick:handleClick 
    			}
    	});
	}
	
	// 업무별 그래프
		var taskByProgressRate = JSON.parse('${taskByProgressRate}');
		var taskByProgressRateCnta = new Array();
		var taskByProgressRateCntb = new Array();
		var sysGbTaskGb = new Array();
		for (var i = 0; i < taskByProgressRate.length; i++) {
			if(taskByProgressRate[i].cntA == 0){
				taskByProgressRate[i].cntA = 0.1;
			}
			taskByProgressRateCnta.push(taskByProgressRate[i].cntA);
			taskByProgressRateCntb.push(taskByProgressRate[i].cntB);
			sysGbTaskGb.push(taskByProgressRate[i].sysGb+taskByProgressRate[i].taskGb);
		}
		for ( var j = 0; j < taskByProgressRate.length; j++) {
		var ctx = document.getElementById(sysGbTaskGb[j]);
		var myDoughnutChart = new Chart(ctx, {
	    	type : 'doughnut',
	    	data : {
	    		  labels: ['완료건수','미완료건수'],
	    			datasets : [ {
	    				data : [taskByProgressRateCntb[j],
	    				        taskByProgressRateCnta[j]-taskByProgressRateCntb[j]],
	    				backgroundColor : ['#007bff','#e9ecef']
	    			},]
	    		},
	    		options : {
	    			legend: {
						display:false
					},
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
	
	$('html').scrollTop(0);
}

function handleClick(event, array){
	var temp= this.data.datasets[0].label[0];
	$.ajax({
		type:"POST",
		url: "<c:url value='/tms/dev/selectDevStatsAsyn.do'/>",
		data : {sysGb : this.data.datasets[0].label[0]},
		async: false,
		dataType : 'json',
		success : function(result){
			$("#taskByProgressRateLoc").empty();
			var str = "";
			str += "<br/><table>";
			str += "<tr>";
			if(result.length == 0) {
				str += "<td>";
				str += "<div class='default_tablestyle'>";
				str += "<table class='table table-search-head table-size-th4' style='height:215px; font-family:'Malgun Gothic';'><tr><td>";
				str += "자료가 없습니다.";
				str += "</td></tr></table></div></td>";
			} else {
				$.each(result, function(index,item){
				str += "<td>";
				if(temp == "sysGb") {
					str += "<br/>&nbsp;&nbsp;<canvas id='" + item.sysGb + item.taskGb + "'";
				} else {
					str += "<br/><br/>&nbsp;&nbsp;<canvas id='" + item.taskGb + "'";
				}
				str += "width='180' height='120' style='display:inline !important;'>";
				str += "</canvas>"
				str += "</td>";
				});
			}
			str += "</tr>";
			str += "<tr>";
			$.each(result, function(index,item){
				str += "<td align='center' valign='middle'>";
				str += "<div style='font-size:15px; font-weight:bolder;'>";
				str += "<font color='#007BFF'>&nbsp;&nbsp;" + item.cntB;
				str += "</font>";
				str += " / " + item.cntA;
				str += "(" + item.rate + "%)<br/>";
				if(temp == "sysGb") {
					str += item.sysNm + "(" + item.taskNm + ")";
				} else {
					str += item.taskNm;
				}
				str += "</div></td>";
			});
			str += "</tr>";
			str += "</table><br/><br/></div>";
			$("#taskByProgressRateLoc").append(str);
			
			var taskByProgressRate = result;
			var taskByProgressRateCnta = new Array();
			var taskByProgressRateCntb = new Array();
			if(temp == "sysGb") {
				var sysGbTaskGb = new Array();
			} else {
				var taskGb = new Array();
			}
			for (var i = 0; i < taskByProgressRate.length; i++) {
				if(taskByProgressRate[i].cntA == 0) {
					taskByProgressRate[i].cntA = 0.1;
				}
				taskByProgressRateCnta.push(taskByProgressRate[i].cntA);
				taskByProgressRateCntb.push(taskByProgressRate[i].cntB);
				if(temp == "sysGb") {
					sysGbTaskGb.push(taskByProgressRate[i].sysGb+taskByProgressRate[i].taskGb);
				} else {
					taskGb.push(taskByProgressRate[i].taskGb);
				}
			}
			for ( var j = 0; j < taskByProgressRate.length; j++) {
			if(temp == "sysGb") {
				var ctx = document.getElementById(sysGbTaskGb[j]);
			} else {
				var ctx = document.getElementById(taskGb[j]);
			}
			var myDoughnutChart = new Chart(ctx, {
		    	type : 'doughnut',
		    	data : {
		    		  labels: ['완료건수','미완료건수'],
		    			datasets : [ {
		    				data : [taskByProgressRateCntb[j],
		    				        taskByProgressRateCnta[j]-taskByProgressRateCntb[j]],
		    				backgroundColor : ['#007bff','#e9ecef']
		    			},]
		    		},
		    		options : {
		    			legend: {
							display:false
						},
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
		},
		error : function(request,status,error){
			alert("에러");
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

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
                    <div id="cur_loc_align" style="font-family:'Malgun Gothic';">
                        <ul>
							<li>HOME</li>
							<li>&#62;</li>
							<li>개발진척관리</li>
							<li>&gt;</li>
							<li><strong>개발진척통계</strong></li>
                        </ul>
                    </div>
                </div>
                <div id="search_field" style="font-family:'Malgun Gothic';">
	                <div id="search_field_loc"><h2><strong>개발진척통계</strong></h2></div>  
				</div>
				<br/><br/><br/><br/><br/>
				
				<div class="recentBoardList" class="col-md-6" style="width:500px; margin-bottom:30px !important	; font-family:'Malgun Gothic';">
    				<div class="widget">
    					<div class="widget-header">
    						<div class="header-name" style="margin:10px;">
	    						<img src="<c:url value='/images/bl_circle.gif' />" width="5" height="5" alt="dot" style="vertical-align:super" />&nbsp;시스템별 진척률
    						</div>
    					</div>
    					<div class="widget-content" style="overflow:auto;  overflow-y:hidden;">
    						<br/><br/>
	            			<table>
	            				<tr>
	            					<td>&nbsp;&nbsp;
	            						<canvas id="progressRateTotal" width="250" height="120" style="display: inline !important;"></canvas>
	             					</td>
	            					<c:forEach var="sysByProgressRate" items="${sysByProgressRate}" varStatus="status">
	            					<td>&nbsp;&nbsp;
	            						<canvas id="<c:out value="${sysByProgressRate.sysGb}"/>"  
	            							width="180" height="120" style="display: inline !important;"></canvas>
									</td>            
	            					</c:forEach>
	            				</tr>
								<tr>
	            					<td align="center" valign="middle">
	             						<div style="font-size:15px; font-weight:bolder;">
		            						<font color="#007BFF">&nbsp;&nbsp;<c:out value="${progressRateTotal.cntB}"/></font>	/ <c:out value="${progressRateTotal.cntA}"/> 
		                 					(<c:out value=" ${progressRateTotal.rate}"></c:out>%)
		                 					<br/>전체
	             						</div>
	            					</td>
	            					<c:forEach var="sysByProgressRate" items="${sysByProgressRate}" varStatus="status">
	            					<td align="center" valign="middle">
	            						<div style="font-size:15px; font-weight:bolder;">
	            							<font color="#007BFF"><c:out value="${sysByProgressRate.cntB}"/></font> / 
	            							<c:out value="${sysByProgressRate.cntA}"/>
	                 						(<c:out value=" ${sysByProgressRate.rate}"></c:out>%)
	                 						<br/><c:out value="${sysByProgressRate.sysNm}"/>
	                 					</div>
	            					</td>
	            					</c:forEach>
	            				</tr>
	            			</table><br/><br/>
            			</div>
    				</div>    	  
    			
    			</div>
    			
    	
			<div class="recentBoardList" class="col-md-6" style="width:500px; margin-bottom:30px !important	; font-family:'Malgun Gothic';">
    			<div class="widget">
    				<div class="widget-header">
    					<div class="header-name" style="margin:10px;">
	    					<img src="<c:url value='/images/bl_circle.gif' />" width="5" height="5" alt="dot" style="vertical-align:super" />&nbsp;업무별 진척률
    					</div>
    				</div>
					<div style="overflow:auto; overflow-y:hidden;">
					<div id="taskByProgressRateLoc" ><br/><br/>
						<table>
							<tr>
								<c:forEach var="taskByProgressRate" items="${taskByProgressRate}" varStatus="status">
									<td>
										&nbsp;&nbsp;<canvas	id="<c:out value="${taskByProgressRate.sysGb}"/><c:out value="${taskByProgressRate.taskGb}"/>"
										width="180" height="120" style="display: inline !important;"></canvas>
									</td>
								</c:forEach>
								<c:if test="${fn:length(taskByProgressRate) == 0 }">
									<td>
									<div class="default_tablestyle">
										<table class="table table-search-head table-size-th4" style="height:215px; font-family:'Malgun Gothic';">
										<tr>
										<td>
										자료가 없습니다.
										</td>
										</tr>
										</table>
									</div>
									</td>
								</c:if>
							</tr>
							<tr>
								<c:forEach var="taskByProgressRate" items="${taskByProgressRate}" varStatus="status">
								<td align="center" valign="middle">
									<div style="font-size: 15px; font-weight: bolder;">
										<font color="#007BFF">&nbsp;&nbsp;<c:out value="${taskByProgressRate.cntB}" /></font> /
										<c:out value="${taskByProgressRate.cntA}" />
										(<c:out value=" ${taskByProgressRate.rate}"/>%)
										<br/><c:out value="${taskByProgressRate.sysNm}"/>(<c:out value="${taskByProgressRate.taskNm}"/>)
									</div>
									</td>
								</c:forEach>
							</tr>
						</table><br/><br/>
						</div>
            		</div>
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