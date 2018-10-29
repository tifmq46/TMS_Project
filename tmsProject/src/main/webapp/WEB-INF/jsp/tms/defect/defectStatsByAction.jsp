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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

function handleClick(event, array){
	var temp= this.data.datasets[0].label[0];
	$.ajax({
		type:"POST",
		url: "<c:url value='/tms/defect/selectDefectStatsByActionAsyn.do'/>",
		data : {sysGb : this.data.datasets[0].label[0]},
		async: false,
		dataType : 'json',
		success : function(result){
			$("#taskByActionCntLoc").empty();
			var str = "";
			str += "<br/><br/><div style='overflow:auto; overflow-y:hidden;'>";
			str += "<table style='border-style:inset; border-width:0.1px; border-color:rgba(0, 123, 255, 0.3);'>";
			str += "<tr></tr><tr>";
			$.each(result, function(index,item){
				str += "<td><br/><br/>&nbsp;&nbsp;";
				if(temp == "sysGb") {
					str += "<canvas id='" + item.sysGb + item.taskGb + "'"; 				
				} else {
					str += "<canvas id='" + item.taskGb + "'";
				}
				str += "width='180' height='120' style='display:inline !important;'>";
				str += "</canvas>"
				str += "</td>";
			});
			str += "</tr>";
			str += "<tr>";
			$.each(result, function(index,item){
				str += "<td align='center' valign='middle'>";
				str += "<div style='font-size:15px; font-weight:bolder;'>";
				str += "<font color='#007BFF'>&nbsp;&nbsp;" + item.actionStA3Cnt;
				str += "</font>";
				str += " / " + item.taskCnt;
				str += " ( " + item.actionPer + " %)<br/>&nbsp;&nbsp;";
				if(temp == "sysGb") {
					str += item.sysNm + "(" + item.taskNm + ")";
				} else {
					str += item.taskNm;
				}
				str += "<br/><br/><br/><br/></td>";
			});
			str += "</tr>";
			str += "</table></div><br/><br/>";
			$("#taskByActionCntLoc").append(str);
			
			var taskByActionCnt = result;
			var taskByActionCntTaskCnt = new Array();
			var taskByActionCntActionStA3Cnt = new Array();
			if(temp == "sysGb") {
				var taskByActionCntSysGbTaskGb = new Array();
			} else {
				var taskByActionCntTaskGb = new Array();
			}
			for (var i = 0; i < taskByActionCnt.length; i++) {
				if(taskByActionCnt[i].taskCnt == 0) {
					taskByActionCnt[i].taskCnt = 0.1;
				}
				taskByActionCntTaskCnt.push(taskByActionCnt[i].taskCnt);
				taskByActionCntActionStA3Cnt.push(taskByActionCnt[i].actionStA3Cnt);
				if(temp == "sysGb") {
					taskByActionCntSysGbTaskGb.push(taskByActionCnt[i].sysGb+taskByActionCnt[i].taskGb);
				} else {
					taskByActionCntTaskGb.push(taskByActionCnt[i].taskGb);
				}
			}
			for ( var j = 0; j < taskByActionCntTaskCnt.length; j++) {
			if(temp == "sysGb") {
				var ctx = document.getElementById(taskByActionCntSysGbTaskGb[j]);
			} else {
				var ctx = document.getElementById(taskByActionCntTaskGb[j]);
			}
			var myDoughnutChart = new Chart(ctx, {
		    	type : 'doughnut',
		    	data : {
		    		  labels: ['완료건수','미완료건수'],
		    			datasets : [ {
		    				data : [taskByActionCntActionStA3Cnt[j],
		    				        taskByActionCntTaskCnt[j]-taskByActionCntActionStA3Cnt[j]],
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

window.onload = function() {
		
	/** 시스템별 조치율 */
	var sysAllByActionCntSysCntAll = JSON.parse('${sysAllByActionCnt.sysCntAll}');
	var sysAllByActionCntActionStA3CntAll = JSON.parse('${sysAllByActionCnt.actionStA3CntAll}');
	var sysAllByActionCntActionPerAll = JSON.parse('${sysAllByActionCnt.actionPerAll}');
	var sysByActionCnt = JSON.parse('${sysByActionCnt}');
	var sysByActionCntSysGb = new Array();
	var sysByActionCntSysNm = new Array();
	var sysByActionCntSysCnt = new Array();
	var sysByActionCntActionStA3Cnt = new Array();
	var sysByActionCntActionPer = new Array();
	for (var i = 0; i < sysByActionCnt.length; i++) {
		sysByActionCntSysGb.push(sysByActionCnt[i].sysGb);
		sysByActionCntSysNm.push(sysByActionCnt[i].sysNm);
		if(sysByActionCnt[i].sysCnt == 0) {
			sysByActionCnt[i].sysCnt = 0.1;
		}
		sysByActionCntSysCnt.push(sysByActionCnt[i].sysCnt);
		sysByActionCntActionStA3Cnt.push(sysByActionCnt[i].actionStA3Cnt);
		sysByActionCntActionPer.push(sysByActionCnt[i].actionPer);
	}
	// 시스템별 전체 
	var ctx = document.getElementById('sysAllByActionCnt');
	var myDoughnutChart = new Chart(ctx, {
		type : 'doughnut',
		data : {
			  labels: ['완료건수','미완료건수'],
				datasets : [{
					label : ['sysGb'],
					data : [sysAllByActionCntActionStA3CntAll,
					        sysAllByActionCntSysCntAll-sysAllByActionCntActionStA3CntAll],
					backgroundColor : ['#007bff','#e9ecef']
				}]
			},
			options : {
				legend: {
					display:false
				},
				rotation: 1 * Math.PI,
		        circumference: 1 * Math.PI,
				percentageInnerCutout : 50,
				responsive:false
				,onClick:handleClick
				}
		});
	// 시스템별 조치율
	for ( var j = 0; j < sysByActionCntSysNm.length; j++) {
	var ctx = document.getElementById(sysByActionCntSysGb[j]);
	var myDoughnutChart = new Chart(ctx, {
    	type : 'doughnut',
    	data : {
    		  labels: ['완료건수','미완료건수'],
    			datasets : [ {
    				label : [sysByActionCntSysGb[j]],
    				data : [sysByActionCntActionStA3Cnt[j],
    				        sysByActionCntSysCnt[j]-sysByActionCntActionStA3Cnt[j]],
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
	
	// 업무별 조치율
	var taskByActionCnt = JSON.parse('${taskByActionCnt}');
	var taskByActionCntTaskCnt = new Array();
	var taskByActionCntActionStA3Cnt = new Array();
	var taskByActionCntSysGbTaskGb = new Array();
	for (var i = 0; i < taskByActionCnt.length; i++) {
		taskByActionCntTaskCnt.push(taskByActionCnt[i].taskCnt);
		taskByActionCntActionStA3Cnt.push(taskByActionCnt[i].actionStA3Cnt);
		taskByActionCntSysGbTaskGb.push(taskByActionCnt[i].sysGb+taskByActionCnt[i].taskGb);
	}
	for ( var j = 0; j < taskByActionCntTaskCnt.length; j++) {
	var ctx = document.getElementById(taskByActionCntSysGbTaskGb[j]);
	var myDoughnutChart = new Chart(ctx, {
    	type : 'doughnut',
    	data : {
    		  labels: ['완료건수','미완료건수'],
    			datasets : [ {
    				data : [taskByActionCntActionStA3Cnt[j],
    				        taskByActionCntTaskCnt[j]-taskByActionCntActionStA3Cnt[j]],
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
    			responsive:false
    			}
    	});
	}
	
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
					<div id="search_field_loc"><h2><strong>결함처리통계 (대시보드3)</strong></h2></div>
			</div>
			<br/><br/><br/><br/><br/><br/>
			<img src="<c:url value='/images/bl_circle.gif' />" width="5" height="5" alt="dot" style="vertical-align:super" />&nbsp;
			<font color="#727272" style="font-size:1.4em;font-weight:bold">시스템별 조치율</font>
			<br/><br/><br/><br/>
				<table>
					<tr>
						<td>&nbsp;&nbsp;
							<canvas id="sysAllByActionCnt" width="250" height="120" style="display: inline !important;"></canvas>
						</td>
						<c:forEach var="sysByActionCnt" items="${sysByActionCnt}" varStatus="status">
							<td>
								&nbsp;&nbsp;<canvas	id="<c:out value="${sysByActionCnt.sysGb}"/>"
									width="180" height="120" style="display: inline !important;"></canvas>
							</td>
						</c:forEach>
					</tr>
					<tr>
						<td align="center" valign="middle">
							<div style="font-size: 15px; font-weight: bolder;">
								<font color="#007BFF">&nbsp;&nbsp;<c:out value="${sysAllByActionCnt.actionStA3CntAll}" /></font> /
								<c:out value="${sysAllByActionCnt.sysCntAll}" />
								( <c:out value=" ${sysAllByActionCnt.actionPerAll}"/>% )
								<br/>&nbsp;&nbsp; 전체 <br/>
							</div>
						</td>
						<c:forEach var="sysByActionCnt" items="${sysByActionCnt}" varStatus="status">
						<td align="center" valign="middle">
							<div style="font-size: 15px; font-weight: bolder;">
								<font color="#007BFF">&nbsp;&nbsp;<c:out value="${sysByActionCnt.actionStA3Cnt}" /></font> /
								<c:out value="${sysByActionCnt.sysCnt}" />
								(<c:out value=" ${sysByActionCnt.actionPer}"/>%)
								<br/>&nbsp;&nbsp;<c:out value="${sysByActionCnt.sysNm}"/><br/>
							</div>
						</td>
						</c:forEach>
					</tr>
				</table>
				
				<br/><br/>
				<img src="<c:url value='/images/bl_circle.gif' />" width="5" height="5" alt="dot" style="vertical-align:super" />&nbsp;
				<font color="#727272" style="font-size:1.4em;font-weight:bold">업무별 조치율</font>
				<br/><br/>
				<div id="taskByActionCntLoc" ><br/><br/>
				 <div style="overflow:auto;  overflow-y:hidden;">
				<table style="border-style:inset; border-width:0.1px; border-color:rgba(0, 123, 255, 0.3);">
					<tr>
						<c:forEach var="taskByActionCnt" items="${taskByActionCnt}" varStatus="status">
							<td><br/><br/>
								&nbsp;&nbsp;<canvas	id="<c:out value="${taskByActionCnt.sysGb}"/><c:out value="${taskByActionCnt.taskGb}"/>"
									width="180" height="120" style="display: inline !important;"></canvas>
							</td>
						</c:forEach>
					</tr>
					<tr>
						<c:forEach var="taskByActionCnt" items="${taskByActionCnt}" varStatus="status">
						<td align="center" valign="middle">
							<div style="font-size: 15px; font-weight: bolder;">
								<font color="#007BFF">&nbsp;&nbsp;<c:out value="${taskByActionCnt.actionStA3Cnt}" /></font> /
								<c:out value="${taskByActionCnt.taskCnt}" />
								(<c:out value=" ${taskByActionCnt.actionPer}"/>%)
								<br/>&nbsp;&nbsp;<c:out value="${taskByActionCnt.sysNm}"/>(<c:out value="${taskByActionCnt.taskNm}"/>)
							</div>
							<br/><br/><br/><br/>
						</td>
						</c:forEach>
					</tr>
				</table></div>
				<br/><br/>
			</div>
			
			<br/><br/><br/><br/>
			
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