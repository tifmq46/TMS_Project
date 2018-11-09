<%--
  Class Name : TestCaseList.jsp
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

<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >
<link href="<c:url value='/'/>css/test/chartist.min.css" rel="stylesheet" type="text/css" >
<title>테스트 통계</title>
<script type="text/javascript" src="<c:url value='/js/chartist.min.js' />" ></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/Chart.min.js' />" ></script>

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

</style>

<script type="text/javaScript" language="javascript" defer="defer">

var taskByTestcaseCntChart;
var taskByTestcaseCntChartTtc;

function handleClick(event, array){
	$("#sysNmLabel").empty();
	$("#sysNmLabel").html(this.data.labels[array[0]._index]);
	
   $.ajax({
      type:"POST",
      url: "<c:url value='/tms/test/selectTestCaseStatsListByTaskGb.do'/>",
      data : {sysNm : this.data.labels[array[0]._index], testcaseGb : 'TC1'},
      dataType : 'json',
      success : function(result){
    	  
         var taskByTestcaseCnt = result;
         var taskByTestcaseCntTaskNm = new Array();
         var taskByTestcaseCntTaskGbCnt = new Array();
         var taskByTestcaseCntCompleteYCnt = new Array();
         for (var i = 0; i < taskByTestcaseCnt.length; i++) {
            taskByTestcaseCntTaskNm.push(taskByTestcaseCnt[i].taskNm);
            taskByTestcaseCntTaskGbCnt.push(taskByTestcaseCnt[i].taskGbCnt);
            taskByTestcaseCntCompleteYCnt.push(taskByTestcaseCnt[i].completeYCnt);
         }
         var data = taskByTestcaseCntChart.config.data;
         console.log(data)
         data.datasets[0].data = taskByTestcaseCntTaskGbCnt;
         data.datasets[1].data = taskByTestcaseCntCompleteYCnt;
         data.labels = taskByTestcaseCntTaskNm;
         taskByTestcaseCntChart.update();
         
      },
      error : function(request,status,error){
         alert("에러");
         alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

      }
   });
}



function handleClickTtc(event, array){

	$("#sysNmLabelTtc").empty();
	$("#sysNmLabelTtc").html(this.data.labels[array[0]._index]);
	
   $.ajax({
      type:"POST",
      url: "<c:url value='/tms/test/selectTestCaseStatsListByTaskGb.do'/>",
      data : {sysNm : this.data.labels[array[0]._index], testcaseGb : 'TC2'},
      dataType : 'json',
      success : function(result){
    	  
         var taskByTestcaseCntTtc = result;
         var taskByTestcaseCntTaskNmTtc = new Array();
         var taskByTestcaseCntTaskGbCntTtc = new Array();
         var taskByTestcaseCntCompleteYCntTtc = new Array();
         for (var i = 0; i < taskByTestcaseCntTtc.length; i++) {
            taskByTestcaseCntTaskNmTtc.push(taskByTestcaseCntTtc[i].taskNm);
            taskByTestcaseCntTaskGbCntTtc.push(taskByTestcaseCntTtc[i].taskGbCnt);
            taskByTestcaseCntCompleteYCntTtc.push(taskByTestcaseCntTtc[i].completeYCnt);
         }
         var data = taskByTestcaseCntChartTtc.config.data;
         console.log(data)
         data.datasets[0].data = taskByTestcaseCntTaskGbCntTtc;
         data.datasets[1].data = taskByTestcaseCntCompleteYCntTtc;
         data.labels = taskByTestcaseCntTaskNmTtc;
         taskByTestcaseCntChartTtc.update();
         
      },
      error : function(request,status,error){
         alert("에러");
         alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

      }
   });
	
	
	
}



window.onload = function() {
	
	$('ul.tabs li').click(function() {
		var tab_id = $(this).attr('data-tab');
		if(!(tab_id == "tab-3")){
			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
			
			$(this).addClass('current');
			$("#" + tab_id).addClass('current');
			
		}
	})
	
	
	   
    /** 시스템별 단위테스트 케이스건수*/
    var sysByTestcaseCnt = JSON.parse('${tcStatsBySysGb}');
    var sysByTestcaseCntSysNm = new Array();
    var sysByTestcaseCntSysCnt = new Array();
    var sysByTestcaseCntCompleteYCnt = new Array();
    for (var i = 0; i < sysByTestcaseCnt.length; i++) {
       sysByTestcaseCntSysNm.push(sysByTestcaseCnt[i].sysNm);
       sysByTestcaseCntSysCnt.push(sysByTestcaseCnt[i].sysCnt);
       sysByTestcaseCntCompleteYCnt.push(sysByTestcaseCnt[i].completeYCnt);
    }
    var ctx1 = document.getElementById('sysByTestcaseCnt');
    var sysByTestcaseCntChart = new Chart(ctx1, {
       type : 'bar',
       data : {
          labels : sysByTestcaseCntSysNm,
          barThickness : '0.2',
          datasets : [ {
             label : '테스트 케이스 건수',
             data : sysByTestcaseCntSysCnt,
             backgroundColor : '#e9ecef',
          }, {
				label : '완료 건수',
				data : sysByTestcaseCntCompleteYCnt,
				backgroundColor : '#007bff',
			}]
       },
       options : {
          tooltips: {
             callbacks: {
             label: function(tooltipItem, data) {
                         var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
                         var label = data.datasets[tooltipItem.datasetIndex].label;
                         if (value === 0.1) {
                            value = 0;
                         }

                         return label + ' : ' + value;
                       }
                }
             }
          ,onClick:handleClick
          ,legend: {
				display: false,
			},
			scales:{
				yAxes:[{
					ticks:{
						suggestedMax: sysByTestcaseCntSysCnt[0]+1,
						beginAtZero:true
					}	
				}],
				xAxes: [{
		            barPercentage: 0.8
		        }]
			},
			animation: {
			      duration: 700,
			      onComplete: function() {
			        var chartInstance = this.chart,
			        ctx = chartInstance.ctx;
			        ctx.fillStyle = 'rgba(0, 123, 255, 1)';
			        ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
			        ctx.textAlign = 'center';
			        ctx.textBaseline = 'bottom';

			        this.data.datasets.forEach(function(dataset, i) {
				          var meta = chartInstance.controller.getDatasetMeta(i);
				          meta.data.forEach(function(bar, index) {
				            var data = dataset.data[index];
				            if(data != 0){
					            ctx.fillText(data, bar._model.x, bar._model.y - 5);
				            }
				          });
			        });
			      }
			    }
       }
    });
    
    
    /** 시스템별 통합테스트 케이스건수*/
    var sysByTestcaseCntTtc = JSON.parse('${tcStatsBySysGbTtc}');
    var sysByTestcaseCntSysNmTtc = new Array();
    var sysByTestcaseCntSysCntTtc = new Array();
    var sysByTestcaseCntCompleteYCntTtc = new Array();
    for (var i = 0; i < sysByTestcaseCntTtc.length; i++) {
       sysByTestcaseCntSysNmTtc.push(sysByTestcaseCntTtc[i].sysNm);
       sysByTestcaseCntSysCntTtc.push(sysByTestcaseCntTtc[i].sysCnt);
       sysByTestcaseCntCompleteYCntTtc.push(sysByTestcaseCntTtc[i].completeYCnt);
    }
    var ctx2 = document.getElementById('sysByTestcaseCntTtc');
    var sysByTestcaseCntChartTtc = new Chart(ctx2, {
       type : 'bar',
       data : {
          labels : sysByTestcaseCntSysNmTtc,
          barThickness : '0.2',
          datasets : [ {
             label : '테스트 케이스 건수',
             data : sysByTestcaseCntSysCntTtc,
             backgroundColor : '#e9ecef',
          }, {
				label : '완료 건수',
				data : sysByTestcaseCntCompleteYCntTtc,
				backgroundColor : '#007bff',
			}]
       },
       options : {
          tooltips: {
             callbacks: {
             label: function(tooltipItem, data) {
                         var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
                         var label = data.datasets[tooltipItem.datasetIndex].label;
                         if (value === 0.1) {
                            value = 0;
                         }

                         return label + ' : ' + value;
                       }
                }
             }
          ,onClick:handleClickTtc
          ,		legend: {
				display: false,
			},
			scales:{
				yAxes:[{
					ticks:{
						suggestedMax: sysByTestcaseCntSysCntTtc[0]+1,
						beginAtZero:true
					}	
				}],
				xAxes: [{
		            barPercentage: 0.8
		        }]
			},
			animation: {
			      duration: 700,
			      onComplete: function() {
			        var chartInstance = this.chart,
			        ctx = chartInstance.ctx;
			        ctx.fillStyle = 'rgba(0, 123, 255, 1)';
			        ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
			        ctx.textAlign = 'center';
			        ctx.textBaseline = 'bottom';

			        this.data.datasets.forEach(function(dataset, i) {
				          var meta = chartInstance.controller.getDatasetMeta(i);
				          meta.data.forEach(function(bar, index) {
				            var data = dataset.data[index];
				            if(data != 0){
					            ctx.fillText(data, bar._model.x, bar._model.y - 5);
				            }
				          });
			        });
			      }
			    }
       }
    });
    
    
    /** 업무별 단위테스트 케이스건수*/
    var taskByTestcaseCnt = JSON.parse('${taskByTestcaseCnt}');
    var taskByTestcaseCntTaskNm = new Array();
    var taskByTestcaseCntTaskGbCnt = new Array();
    var taskByTestcaseCntcompleteYCnt = new Array();
    for (var i = 0; i < taskByTestcaseCnt.length; i++) {
       taskByTestcaseCntTaskNm.push(taskByTestcaseCnt[i].taskNm);
       taskByTestcaseCntTaskGbCnt.push(taskByTestcaseCnt[i].taskGbCnt);
       taskByTestcaseCntcompleteYCnt.push(taskByTestcaseCnt[i].completeYCnt);
       
    }
    var ctx3 = document.getElementById('taskByTestcaseCnt');
    taskByTestcaseCntChart = new Chart(ctx3, {
       type : 'bar',
       data : {
          labels : taskByTestcaseCntTaskNm,
          barThickness : '0.9',
          datasets : [ {
             label : '테스트 케이스 건수',
             data : taskByTestcaseCntTaskGbCnt,
             backgroundColor : '#e9ecef',
          }, {
				label : '완료 건수',
				data : taskByTestcaseCntcompleteYCnt,
				backgroundColor : '#007bff',
			}]
       },
       options : {
          tooltips: {
             callbacks: {
             label: function(tooltipItem, data) {
                         var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
                         var label = data.datasets[tooltipItem.datasetIndex].label;
                         if (value === 0.1) {
                            value = 0;
                         }
                         return label + ' : ' + value;
                       }
                }
             }
    	,				legend: {
			display: false,
		},
		scales:{
			yAxes:[{
				ticks:{
					suggestedMax: taskByTestcaseCntTaskGbCnt[0]+1,
					beginAtZero:true
				}	
			}],
			xAxes: [{
	            barPercentage: 0.8
	        }]
		},
		animation: {
		      duration: 700,
		      onComplete: function() {
		        var chartInstance = this.chart,
		        ctx = chartInstance.ctx;
		        ctx.fillStyle = 'rgba(0, 123, 255, 1)';
		        ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
		        ctx.textAlign = 'center';
		        ctx.textBaseline = 'bottom';

		        this.data.datasets.forEach(function(dataset, i) {
			          var meta = chartInstance.controller.getDatasetMeta(i);
			          meta.data.forEach(function(bar, index) {
			            var data = dataset.data[index];
			            if(data != 0){
				            ctx.fillText(data, bar._model.x, bar._model.y - 5);
			            }
			          });
		        });
		      }
		    }   
	       
       
       }
    });
    
    
    /** 업무별 통합테스트 케이스건수*/
    var taskByTestcaseCntTtc = JSON.parse('${taskByTestcaseCntTtc}');
    var taskByTestcaseCntTaskNmTtc = new Array();
    var taskByTestcaseCntTaskGbCntTtc = new Array();
    var taskByTestcaseCntcompleteYCntTtc = new Array();
    for (var i = 0; i < taskByTestcaseCntTtc.length; i++) {
       taskByTestcaseCntTaskNmTtc.push(taskByTestcaseCntTtc[i].taskNm);
       taskByTestcaseCntTaskGbCntTtc.push(taskByTestcaseCntTtc[i].taskGbCnt);
       taskByTestcaseCntcompleteYCntTtc.push(taskByTestcaseCntTtc[i].completeYCnt);
       
    }
       var ctx4 = document.getElementById('taskByTestcaseCntTtc');
       taskByTestcaseCntChartTtc = new Chart(ctx4, {
          type : 'bar',
          data : {
             labels : taskByTestcaseCntTaskNmTtc,
             barThickness : '0.9',
             datasets : [ {
                label : '테스트 케이스 건수',
                data : taskByTestcaseCntTaskGbCntTtc,
                backgroundColor : '#e9ecef',
             }, {
   				label : '완료 건수',
   				data : taskByTestcaseCntcompleteYCntTtc,
   				backgroundColor : '#007bff',
   			}]
          },
       
       
       options : {
          tooltips: {
             callbacks: {
             label: function(tooltipItem, data) {
                         var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
                         var label = data.datasets[tooltipItem.datasetIndex].label;
                         if (value === 0.1) {
                            value = 0;
                         }
                         return label + ' : ' + value;
                       }
                }
             }
       , 				legend: {
			display: false,
		},
		scales:{
			yAxes:[{
				ticks:{
					suggestedMax: taskByTestcaseCntTaskGbCntTtc[0]+1,
					beginAtZero:true
				}	
			}],
			xAxes: [{
	            barPercentage: 0.8
	        }]
		},
		animation: {
		      duration: 700,
		      onComplete: function() {
		        var chartInstance = this.chart,
		        ctx = chartInstance.ctx;
		        ctx.fillStyle = 'rgba(0, 123, 255, 1)';
		        ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
		        ctx.textAlign = 'center';
		        ctx.textBaseline = 'bottom';

		        this.data.datasets.forEach(function(dataset, i) {
			          var meta = chartInstance.controller.getDatasetMeta(i);
			          meta.data.forEach(function(bar, index) {
			            var data = dataset.data[index];
			            if(data != 0){
				            ctx.fillText(data, bar._model.x, bar._model.y - 5);
			            }
			          });
		        });
		      }
		    }
       }
    });
			
} //window.onload
			
	
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
            <div id="content" style="font-family:'Malgun Gothic';">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
							<li>HOME</li>
							<li>&gt;</li>
							<li>테스트관리</li>
							<li>&gt;</li>
							<li><strong>테스트통계</strong></li>
                        </ul>
                    </div>
                </div>
              
                <br/> <br/>
				<div id="search_field" style="font-family:'Malgun Gothic';">
					<div id="search_field_loc">
						<h2>
							<strong>테스트 통계 (대시보드)</strong>
						</h2>
					</div>
				</div>
				<br/><br/><br/><br/> 
                             
               <ul class="tabs">
					<li class="tab-link current" data-tab="tab-1">단위</li>
					<li class="tab-link" data-tab="tab-2">통합</li>
				</ul>                   
                             
          <div id="tab-1" class="tab-content current">                   
			<div class="recentBoardList" id="board1" class="col-md-6" style="width:500px; margin-bottom:30px !important	; font-family:'Malgun Gothic';">
    			<div class="widget">
    				<div class="widget-header">
    					<div class="header-name" style="margin:10px;">
                      		<span style="font-size:20px; font-weight: bold;">단위테스트 현황</span>&nbsp;
                      		
    					</div>
    					
    					<div id="progress_bar_utc" class="progess_bar_section" >                      	
                      		<div style="float:right;">
	                      		<fmt:parseNumber var="tc1_yCnt" value="${testCaseStatsMapTC1.yCnt}" type="number"  integerOnly="true" ></fmt:parseNumber>
	                      		<fmt:parseNumber var="tc1_totCnt" value="${testCaseStatsMapTC1.totCnt}" type="number"  integerOnly="true" ></fmt:parseNumber>
	                      
		                    	<c:choose>
	                   				<c:when test="${tc1_totCnt eq '0'}">
	                   					<c:set var="tc1_Pct"  value="0"></c:set>
	                   				</c:when>
	                   		
	                   				<c:otherwise>
	                   					<fmt:parseNumber var="tc1_Pct" value="${(tc1_yCnt/tc1_totCnt)*100}" type="number"  integerOnly="true" ></fmt:parseNumber>
	                   				</c:otherwise>
	                   			</c:choose>
							</div>
						
                      		<div class="progress">
						    	<div class="progress-bar" style="width:${tc1_Pct}%"> <span style="font-size:20px;"><c:out value=" ${tc1_Pct}"></c:out>%</span></div>
							</div>
						</div>
    				</div>

				
					<div id="detail_bar_utc" class="progess_bar_section" >
				
                  		<div class="progess_bar_section" style="font-size:15px; font-weight: bold;">
                  		
                  		<div class="header-name" style="margin:10px;">
	    					<img src="<c:url value='/images/bl_circle.gif' />" width="5" height="5" alt="dot" style="vertical-align:super" />&nbsp;시스템별 단위테스트 현황 (단위:수)
    					</div>
	                  		<canvas id="sysByTestcaseCnt" width="100%" height="18"></canvas>
                  		</div>
                 
                  		<div class="progess_bar_section" style="font-size:15px; font-weight: bold;">
	                   		
	                   		<div class="header-name" style="margin:10px;">
	    					<img src="<c:url value='/images/bl_circle.gif' />" width="5" height="5" alt="dot" style="vertical-align:super" />&nbsp;업무별 단위테스트 현황 (단위:수) - <span id="sysNmLabel" >전체</span>
    						</div>
	                   		
	                  		<canvas id="taskByTestcaseCnt" width="100%" height="30"></canvas>
                  		</div>
					</div>
					
					
    			</div>    	  
    			
    		</div>            
    	</div>	

          <!-- 통합테스트 -->   
          <div id="tab-2" class="tab-content">       
			<div class="recentBoardList" id="board2" class="col-md-6" style="width:500px; margin-bottom:30px !important	; font-family:'Malgun Gothic';">
    			<div class="widget">
    				<div class="widget-header">
    					<div class="header-name" style="margin:10px;">
                			<span style="font-size:20px; font-weight: bold;">통합테스트 현황</span>&nbsp;
    					</div>
    					
                  		<div id="progress_bar_ttc" class="progess_bar_section" >
                 
                 			<div style="float:right;">
                      			<fmt:parseNumber var="tc2_yCnt" value="${testCaseStatsMapTC2.yCnt}" type="number"  integerOnly="true" ></fmt:parseNumber>
	                      		<fmt:parseNumber var="tc2_totCnt" value="${testCaseStatsMapTC2.totCnt}" type="number"  integerOnly="true" ></fmt:parseNumber>
	                      	
	                      		<c:choose>
	                   				<c:when test="${tc2_totCnt eq '0'}">
	                   					<c:set var="tc2_Pct"  value="0"></c:set>
	                   				</c:when>
	                   		
	                   				<c:otherwise>
	                   					<fmt:parseNumber var="tc2_Pct" value="${(tc2_yCnt/tc2_totCnt)*100}" type="number"  integerOnly="true" ></fmt:parseNumber>
	                   				</c:otherwise>
	                   			</c:choose>
	                      	
							</div>
                 
                      	
                      		<div class="progress">
						    	<div class="progress-bar" style="width:${tc2_Pct}%"><span style="font-size:20px;"><c:out value=" ${tc2_Pct}"></c:out>%</span> </div>
							</div>
						
                 		</div>    					
    				</div>
    				
    				<div id="detail_bar_ttc" class="progess_bar_section" >
				
                  		<div class="progess_bar_section" style="font-size:15px; font-weight: bold;">
                  		
                  		<div class="header-name" style="margin:10px;">
	    					<img src="<c:url value='/images/bl_circle.gif' />" width="5" height="5" alt="dot" style="vertical-align:super" />&nbsp;시스템별 통합테스트 현황 (단위:수)
    					</div>
	                  		<canvas id="sysByTestcaseCntTtc" width="100%" height="18"></canvas>
                  		</div>
                 
                  		<div class="progess_bar_section" style="font-size:15px; font-weight: bold;">
	                   		<div class="header-name" style="margin:10px;">
	    					<img src="<c:url value='/images/bl_circle.gif' />" width="5" height="5" alt="dot" style="vertical-align:super" />&nbsp;업무별 통합테스트 현황 (단위:수) - <span id="sysNmLabelTtc" >전체</span>
    						</div>
	                  		<canvas id="taskByTestcaseCntTtc" width="100%" height="30"></canvas>
                  		</div>
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