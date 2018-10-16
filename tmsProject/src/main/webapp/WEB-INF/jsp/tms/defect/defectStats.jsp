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
<style type="text/css">
.carousel {
    position: relative;
     margin-top: 0px;
}

.carousel-inner {
    position: relative;
    overflow: hidden;
    width: 100%;
}

.carousel-open:checked + .carousel-item {
    position: relative;
    opacity: 100;
}

.carousel-item {
    position: absolute;
    opacity: 0;
    -webkit-transition: opacity 0.6s ease-out;
    transition: opacity 0.6s ease-out;
}

.carousel-control {
    background: rgba(0, 0, 0, 0.28);
    border-radius: 50%;
    color: #fff;
    cursor: pointer;
    display: none;
    font-size: 40px;
    height: 40px;
    line-height: 42px;
    position: absolute;
    top: 50%;
    -webkit-transform: translate(0, -50%);
    cursor: pointer;
    -ms-transform: translate(0, -50%);
    transform: translate(0, -50%);
    text-align: center;
    width: 40px;
    z-index: 10;
}

.carousel-control.prev {
    left: 0.1%;
}

.carousel-control.next {
    right: 0.1%;
}

.carousel-control:hover {
    background: rgba(0, 0, 0, 0.8);
    color: #aaaaaa;
}

#carousel-1:checked ~ .control-1,
#carousel-2:checked ~ .control-2,
#carousel-3:checked ~ .control-3 {
    display: block;
}

.carousel-indicators {
	list-style: none;
    margin: 0;
    padding: 0;
    position: absolute;
    bottom: 2%;
    left: 0;
    right: 0;
    text-align: center;
    z-index: 10;
}

.carousel-indicators li {
    display: inline-block;
    margin: 0 5px;
}

.carousel-bullet {
    color: #aaaaaa;
    cursor: pointer;
    display: block;
    font-size: 35px;
}

.carousel-bullet:hover {
    color: #aaaaaa;
}

#carousel-1:checked ~ .control-1 ~ .carousel-indicators li:nth-child(1) .carousel-bullet,
#carousel-2:checked ~ .control-2 ~ .carousel-indicators li:nth-child(2) .carousel-bullet,
#carousel-3:checked ~ .control-3 ~ .carousel-indicators li:nth-child(3) .carousel-bullet {
    color: #007bff;
}

#title {
    width: 100%;
    position: absolute;
    padding: 0px;
    margin: 0px auto;
    text-align: center;
    font-size: 27px;
    color: rgba(255, 255, 255, 1);
    font-family: 'Open Sans', sans-serif;
    z-index: 9999;
    text-shadow: 0px 1px 2px rgba(0, 0, 0, 0.33), -1px 0px 2px rgba(255, 255, 255, 0);
}
</style>
<script type="text/javascript">
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
	
		var colorArray = [ '#DAE9F4', '#9DC3C1', '#00B3E6', '#008C9E',
		                   '#007BFF', '#FFB399', '#FF33FF', '#FFFF99',
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
		
		/** 업무별 전체 결함현황*/
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
		var sum = 0;
		for (var i = 0; i < taskByActionProgression.length; i++) {
			taskByActionProgressionTaskNm.push(taskByActionProgression[i].taskNm);
			if(i == taskByActionProgression.length-1) {
				taskByActionProgressionTaskTotCnt.push((100 - sum).toFixed(1));
			} else {
				sum = sum + parseFloat((taskByActionProgression[i].taskTotCnt / defectStatsActionStAll* 100).toFixed(1));
				taskByActionProgressionTaskTotCnt.push((taskByActionProgression[i].taskTotCnt
						/ defectStatsActionStAll* 100).toFixed(1));
			}
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
						stacked : true,
						display : true,
						ticks:{
							min: 0,
		                    max: 100
						}
					} ],
					yAxes : [ {
						stacked : true
					} ]
				},
				tooltips: {
					callbacks: {
					label: function(tooltipItem, data) {
						console.log(tooltipItem.index);
					            var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
					            var label = data.datasets[tooltipItem.datasetIndex].label;
					            if(parseInt(value) == value) {
					            	value = parseInt(value);
					            }
					            return label + ' : ' + value +'%';
					          }
						}
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
		
		sum = 0;
		for (var i = 0; i < taskByActionStCnt.length; i++) {
			taskByActionStCntTaskNm.push(taskByActionStCnt[i].taskNm);
			taskByActionStCntActionStAll.push(taskByActionStCnt[i].actionStAll);
			
			var pre = 0;
			sum = parseFloat((taskByActionStCnt[i].actionStA1	/ taskByActionStCnt[i].actionStAll * 100).toFixed(1)) +
				parseFloat((taskByActionStCnt[i].actionStA2	/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
			if( sum > 100) {
				pre = parseFloat((taskByActionStCnt[i].actionStA1	/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
				taskByActionStCntActionStA1.push(pre.toFixed(1));
				taskByActionStCntActionStA2.push((100 - pre).toFixed(1));
				taskByActionStCntActionStA3.push((taskByActionStCnt[i].actionStA3
						/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
				taskByActionStCntActionStA4.push((taskByActionStCnt[i].actionStA4
						/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
				taskByActionStCntActionStA5.push((taskByActionStCnt[i].actionStA5
						/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
			} else {
				pre = sum;
				sum = sum + parseFloat((taskByActionStCnt[i].actionStA3	/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
				if(sum > 100) {
					taskByActionStCntActionStA1.push((taskByActionStCnt[i].actionStA1
							/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
					taskByActionStCntActionStA2.push((taskByActionStCnt[i].actionStA2
							/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
					taskByActionStCntActionStA3.push((100 - pre).toFixed(1));
					taskByActionStCntActionStA4.push((taskByActionStCnt[i].actionStA4
							/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
					taskByActionStCntActionStA5.push((taskByActionStCnt[i].actionStA5
							/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
				} else {
					pre = sum;
					sum = sum + parseFloat((taskByActionStCnt[i].actionStA4	/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
					if(sum > 100) {
						taskByActionStCntActionStA1.push((taskByActionStCnt[i].actionStA1
								/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
						taskByActionStCntActionStA2.push((taskByActionStCnt[i].actionStA2
								/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
						taskByActionStCntActionStA3.push((taskByActionStCnt[i].actionStA3
								/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
						taskByActionStCntActionStA4.push((100 - pre).toFixed(1));
						taskByActionStCntActionStA5.push((taskByActionStCnt[i].actionStA5
								/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
					} else {
						pre = sum;
						sum = sum + parseFloat((taskByActionStCnt[i].actionStA5	/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
						if(sum > 100) {
							taskByActionStCntActionStA1.push((taskByActionStCnt[i].actionStA1
									/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
							taskByActionStCntActionStA2.push((taskByActionStCnt[i].actionStA2
									/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
							taskByActionStCntActionStA3.push((taskByActionStCnt[i].actionStA3
									/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
							taskByActionStCntActionStA4.push((taskByActionStCnt[i].actionStA4
									/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
							taskByActionStCntActionStA5.push((100 - pre).toFixed(1));
						} else {
							taskByActionStCntActionStA1.push((taskByActionStCnt[i].actionStA1
									/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
							taskByActionStCntActionStA2.push((taskByActionStCnt[i].actionStA2
									/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
							taskByActionStCntActionStA3.push((taskByActionStCnt[i].actionStA3
									/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
							taskByActionStCntActionStA4.push((taskByActionStCnt[i].actionStA4
									/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
							taskByActionStCntActionStA5.push((taskByActionStCnt[i].actionStA5
									/ taskByActionStCnt[i].actionStAll * 100).toFixed(1));
						}
					}
				}
			}
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
					backgroundColor : '#CC3C39',
				}, {
					label : '최종완료',
					data : taskByActionStCntActionStA5,
					backgroundColor : colorArray[4],
				}, ]
			},
			options : {
				scales : {
					xAxes : [ {
						stacked : true,
						display : true,
						ticks:{
							min: 0,
		                    max: 100
						}
					} ],
					yAxes : [ {
						stacked : true
					} ]
				},
				tooltips: {
					callbacks: {
					label: function(tooltipItem, data) {
						console.log(tooltipItem.index);
					            var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
					            var label = data.datasets[tooltipItem.datasetIndex].label;
					            if(parseInt(value) == value) {
					            	value = parseInt(value);
					            }
					            return label + ' : ' + value +'%';
					          }
						}
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
		
		sum = 0;
		for (var i = 0; i < taskByDefectGbCnt.length; i++) {
			taskByDefectGbCntTaskNm.push(taskByDefectGbCnt[i].taskNm);
			taskByDefectGbCntDefectGbAll.push(taskByDefectGbCnt[i].defectGbAll);
			
			var pre = 0;
			sum = parseFloat((taskByDefectGbCnt[i].defectGbD1 / taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1)) +
				parseFloat((taskByDefectGbCnt[i].defectGbD2 / taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
			if(sum > 100) {
				pre = parseFloat((taskByDefectGbCnt[i].defectGbD1 / taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
				taskByDefectGbCntDefectGbD1.push(pre.toFixed(1));
				taskByDefectGbCntDefectGbD2.push((100 - pre).toFixed(1));
				taskByDefectGbCntDefectGbD3.push((taskByDefectGbCnt[i].defectGbD3
						/ taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
				taskByDefectGbCntDefectGbD4.push((taskByDefectGbCnt[i].defectGbD4
						/ taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
			} else {
				pre = sum;
				sum = sum + parseFloat((taskByDefectGbCnt[i].defectGbD3 / taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
				if(sum > 100) {
					taskByDefectGbCntDefectGbD1.push((taskByDefectGbCnt[i].defectGbD1
							/ taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
					taskByDefectGbCntDefectGbD2.push((taskByDefectGbCnt[i].defectGbD2
							/ taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
					taskByDefectGbCntDefectGbD3.push((100 - pre).toFixed(1));
					taskByDefectGbCntDefectGbD4.push((taskByDefectGbCnt[i].defectGbD4
							/ taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
				} else {
					pre = sum;
					sum = sum + parseFloat((taskByDefectGbCnt[i].defectGbD4 / taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
					if(sum > 100) {
						taskByDefectGbCntDefectGbD1.push((taskByDefectGbCnt[i].defectGbD1
								/ taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
						taskByDefectGbCntDefectGbD2.push((taskByDefectGbCnt[i].defectGbD2
								/ taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
						taskByDefectGbCntDefectGbD3.push((taskByDefectGbCnt[i].defectGbD3
								/ taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
						taskByDefectGbCntDefectGbD4.push((100 - pre).toFixed(1));
					} else {
						taskByDefectGbCntDefectGbD1.push((taskByDefectGbCnt[i].defectGbD1
								/ taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
						taskByDefectGbCntDefectGbD2.push((taskByDefectGbCnt[i].defectGbD2
								/ taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
						taskByDefectGbCntDefectGbD3.push((taskByDefectGbCnt[i].defectGbD3
								/ taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
						taskByDefectGbCntDefectGbD4.push((taskByDefectGbCnt[i].defectGbD4
								/ taskByDefectGbCnt[i].defectGbAll * 100).toFixed(1));
					}
				}
			}
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
						stacked : true,
						display : true,
						ticks:{
							min: 0,
		                    max: 100
						}
					} ],
					yAxes : [ {
						stacked : true
					} ]
				},
				tooltips: {
					callbacks: {
					label: function(tooltipItem, data) {
						console.log(tooltipItem.index);
					            var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
					            var label = data.datasets[tooltipItem.datasetIndex].label;
					            if(parseInt(value) == value) {
					            	value = parseInt(value);
					            }
					            return label + ' : ' + value +'%';
					          }
						}
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
			if(dayByDefectCnt[i].enrollDtCnt == 0){
				dayByDefectCnt[i].enrollDtCnt = 0.1;
			}
			if(dayByDefectCnt[i].actionDtCnt == 0){
				dayByDefectCnt[i].actionDtCnt = 0.1;
			}
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
			},
			options : {
				tooltips: {
					callbacks: {
					label: function(tooltipItem, data) {
						console.log(tooltipItem.index);
					            var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
					            var label = data.datasets[tooltipItem.datasetIndex].label;
					            if (value === 0.1) {
					            	value = 0;
					            }

					            return label + ' : ' + value;
					          }
						}
					}
			}
		});
		
		/** 월별 결함 등록건수 조치건수*/
		var monthByDefectCnt = JSON.parse('${monthByDefectCnt}');
		var monthByDefectCntMonths = new Array();
		var monthByDefectCntEnrollMonthDtCnt = new Array();
		var monthByDefectCntActionMonthDtCnt = new Array();
		for (var i = 0; i < monthByDefectCnt.length; i++) {
			monthByDefectCntMonths.push(monthByDefectCnt[i].months+'월');
			if(monthByDefectCnt[i].enrollMonthDtCnt == 0){
				monthByDefectCnt[i].enrollMonthDtCnt = 0.1;
			}
			if(monthByDefectCnt[i].actionMonthDtCnt == 0){
				monthByDefectCnt[i].actionMonthDtCnt = 0.1;
			}
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
			},
			options : {
				tooltips: {
					callbacks: {
					label: function(tooltipItem, data) {
						console.log(tooltipItem.index);
					            var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
					            var label = data.datasets[tooltipItem.datasetIndex].label;
					            if (value === 0.1) {
					            	value = 0;
					            }

					            return label + ' : ' + value;
					          }
						}
					}
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

				<div class="carousel">
					<div class="carousel-inner">
						<input class="carousel-open" type="radio" id="carousel-1"
							name="carousel" aria-hidden="true" hidden="" checked="checked">
						<div class="carousel-item">
							<h3>
								<strong>조치율</strong>
							</h3>
							<table width="100%">
								<tr>
									<td width="90%">
									<fmt:parseNumber var="actionProgression" integerOnly="true"
											value="${defectStats.actionStA5 / defectStats.actionStAll * 100}" />
										<div class="progress" style="height: 2rem;">
											<div class="progress-bar" style="width:${actionProgression}%">
												<font style="font-size: 15px; font-weight: bolder">
												<c:out value=" ${actionProgression}"></c:out>% </font>
											</div>
										</div>
										</td>
									<td width="10%"><font size="3px" style="font-weight: bold">
											<c:out value="${defectStats.actionStA5}"></c:out>&nbsp;/&nbsp;<c:out
												value="${defectStats.actionStAll}"></c:out>
									</font>
									</td>
								</tr>
								<tr>
									<td align="right">
									<img src="<c:url value='/images/tms/icon_pop_blue.gif' />"
										width="10" height="10" alt="yCnt" />&nbsp;조치율 &nbsp;
									<img src="<c:url value='/images/tms/icon_pop_gray.gif' />"
										width="10" height="10" alt="totCnt" />&nbsp;미조치율
										</td>
									<td></td>
								</tr>
							</table>
							
							<h3>
								<strong>상태별 결함건수</strong>
							</h3>
							<table width="100%" cellspacing="10" height="80px">
								<tr>
									<td width="16.6%" align="center" bgcolor="#CC3C39">
									<font color="#FFFFFF" size="3" style="font-weight: bold"> 전체건수 <br />
										<c:out value="${defectStats.actionStAll}" />
									</font></td>
									<td width="16.6%" align="center" bgcolor="#007BFF">
									<font color="#FFFFFF" size="3" style="font-weight: bold"> 대기 <br />
										<c:out value="${defectStats.actionStA1}" />
									</font>
									</td>
									<td width="16.6%" align="center" bgcolor="#007BFF">
									<font color="#FFFFFF" size="3" style="font-weight: bold"> 조치중 <br />
										<c:out value="${defectStats.actionStA2}" />
									</font>
									</td>
									<td width="16.6%" align="center" bgcolor="#007BFF">
									<font color="#FFFFFF" size="3" style="font-weight: bold"> 조치완료 <br />
										<c:out value="${defectStats.actionStA3}" />
									</font>
									</td>
									<td width="16.6%" align="center" bgcolor="#007BFF">
									<font color="#FFFFFF" size="3" style="font-weight: bold"> 재요청 <br />
										<c:out value="${defectStats.actionStA4}" />
									</font>
									</td>
									<td width="16.6%" align="center" bgcolor="#007BFF">
									<font color="#FFFFFF" size="3" style="font-weight: bold"> 최종완료 <br />
										<c:out value="${defectStats.actionStA5}" />
									</font>
									</td>
								</tr>
							</table>

							<div id="dayByDefectCntTitle" >
								<h3>
									<strong>일자별 등록건수, 조치건수</strong>
								</h3>
							<canvas id="dayByDefectCnt" width="100%" height="20"></canvas>
							</div>
							
							<div id="monthByDefectCntTitle" >
								<h3>
									<strong>월별 등록건수, 조치건수</strong>
								</h3>
							<canvas id="monthByDefectCnt" width="100%" height="20" ></canvas>
							</div>
						<br/><br/><br/><br/><br/><br/><br/>
						</div>
						
						<input class="carousel-open" type="radio" id="carousel-2"
							name="carousel" aria-hidden="true" hidden="">
						<div class="carousel-item">
							<h3>
								<strong>업무별 조치율</strong>
							</h3>
							<div
								style="overflow: auto; white-space: nowrap; overflow-y: hidden;">
								<table>
									<tr>
										<td>&nbsp;&nbsp;
										<canvas id="taskByAllProgression" width="200" height="200" style="display: inline !important;"></canvas>&nbsp;&nbsp;
										</td>
										<c:forEach var="taskByActionProgression"
											items="${taskByActionProgression}" varStatus="status">
											<td>
											<canvas	id="<c:out value="${taskByActionProgression.taskGb}"/>"
													width="180" height="180" style="display: inline !important;"></canvas>&nbsp;&nbsp;</td>
										</c:forEach>
										<br/>
									</tr>

									<tr>
										<td align="center" valign="middle">
											<div style="font-size: 15px; font-weight: bolder;">
												<font color="#007BFF"><c:out value="${defectStats.actionStA5}" /></font> /
												<c:out value="${defectStats.actionStAll}" />
												<fmt:parseNumber var="actionProgression" integerOnly="true"
													value="${defectStats.actionStA5 / defectStats.actionStAll * 100}" />
												(
												<c:out value=" ${actionProgression}"></c:out>
												%) <br /> 전체 <br />
											</div>
										</td>
										<c:forEach var="taskByActionProgression"
											items="${taskByActionProgression}" varStatus="status">
											<td align="center" valign="middle">
												<div style="font-size: 13px; font-weight: bolder;">
													<font color="#007BFF"><c:out
															value="${taskByActionProgression.taskA5Cnt}" /></font> /
													<c:out value="${taskByActionProgression.taskTotCnt}" />
													<c:if test="${taskByActionProgression.taskTotCnt != 0}">
            										 (<fmt:parseNumber var="actionProgression" integerOnly="true"
															value="${taskByActionProgression.taskA5Cnt / taskByActionProgression.taskTotCnt * 100}" />
														<c:out value=" ${actionProgression}"></c:out>%)
               									  </c:if>
													<br />
													<c:out value="${taskByActionProgression.taskNm}" />
													<br />
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
									<strong><font size=2>(단위:%)</font></strong></td>
								</tr>
							</table>
							<canvas id="taskByActionProgression" width="100%" height="15"></canvas>
							<br/><br/>
							
							<div align="right">
								<select id="taskBySelectBoxStats" style="width: 12%; text-align-last: center;"
									onChange="javascript:taskBySelectBoxChange();">
									<option value="1" selected="selected">상태별</option>
									<option value="2">유형별</option>
								</select>
							</div>
							
							<div id="taskByActionStCntTitle" style="display: inline">
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
							</div>
							<canvas id="taskByActionStCnt" width="100%" height="20"	style="display:inline"></canvas>
						
							<div id="taskByDefectGbCntTitle" style="display: none">
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
							</div>
							<canvas id="taskByDefectGbCnt" width="100%" height="20"	style="display:none"></canvas>
						<br/><br/><br/><br/><br/><br/><br/>
						</div>
						<label for="carousel-2" class="carousel-control next control-1">›</label>
						<label for="carousel-1" class="carousel-control prev control-2">‹</label>
						<label for="carousel-2" class="carousel-control prev control-1">‹</label>
						<label for="carousel-1" class="carousel-control next control-2">›</label>
						<ol class="carousel-indicators">
							<li><label for="carousel-1" class="carousel-bullet">•</label>
							</li>
							<li><label for="carousel-2" class="carousel-bullet">•</label>
							</li>
						</ol>
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