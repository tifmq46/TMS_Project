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


<script type="text/javaScript" language="javascript" defer="defer">

var taskByDefectCntChart;

function handleClick(event, array){
   $.ajax({
      type:"POST",
      url: "<c:url value='/tms/test/selectTestCaseStatsListByTaskGb.do'/>",
      data : {sysNm : this.data.labels[array[0]._index]},
      async: false,
      dataType : 'json',
      success : function(result){
         var taskByDefectCnt = result;
         var taskByDefectCntTaskNm = new Array();
         var taskByDefectCntTaskGbCnt = new Array();
         for (var i = 0; i < taskByDefectCnt.length; i++) {
            taskByDefectCntTaskNm.push(taskByDefectCnt[i].taskNm);
            taskByDefectCntTaskGbCnt.push(taskByDefectCnt[i].taskGbCnt);
         }
         var data = taskByDefectCntChart.config.data;
         data.datasets[0].data = taskByDefectCntTaskGbCnt;
         data.labels = taskByDefectCntTaskNm;
         taskByDefectCntChart.update();
         
      },
      error : function(request,status,error){
         alert("에러");
         alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

      }
   });
}



window.onload = function() {
	
	
	   
    /** 시스템별 테스트 케이스건수*/
    var sysByDefectCnt = JSON.parse('${tcStatsBySysGb}');
    var sysByDefectCntSysNm = new Array();
    var sysByDefectCntSysCnt = new Array();
    for (var i = 0; i < sysByDefectCnt.length; i++) {
       sysByDefectCntSysNm.push(sysByDefectCnt[i].sysNm);
       sysByDefectCntSysCnt.push(sysByDefectCnt[i].sysCnt);
    }
    var ctx1 = document.getElementById('sysByDefectCnt');
    var sysByDefectCntChart = new Chart(ctx1, {
       type : 'bar',
       data : {
          labels : sysByDefectCntSysNm,
          barThickness : '0.9',
          datasets : [ {
             label : '테스트 케이스 건수',
             data : sysByDefectCntSysCnt,
             backgroundColor : '#007BFF',
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
       }
    });
    
    /** 업무별 테스트 케이스건수*/
    var taskByDefectCnt = JSON.parse('${taskByDefectCnt}');
    var taskByDefectCntTaskNm = new Array();
    var taskByDefectCntTaskGbCnt = new Array();
    for (var i = 0; i < taskByDefectCnt.length; i++) {
       taskByDefectCntTaskNm.push(taskByDefectCnt[i].taskNm);
       taskByDefectCntTaskGbCnt.push(taskByDefectCnt[i].taskGbCnt);
    }
    var ctx2 = document.getElementById('taskByDefectCnt');
    taskByDefectCntChart = new Chart(ctx2, {
       type : 'bar',
       data : {
          labels : taskByDefectCntTaskNm,
          barThickness : '0.9',
          datasets : [ {
             label : '테스트 케이스 건수',
             data : taskByDefectCntTaskGbCnt,
             backgroundColor : '#007BFF',
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
       }
    });
    
	
	
	var list = JSON.parse('${tcStatsByTaskGb}');
	var taskGbNmList = new Array();
	var testcaseTotCntList = new Array();
	var testcaseYCntList = new Array();
	
	for(var i=0; i<list.length; i++ ){
		taskGbNmList.push(list[i].taskGbNm);
		testcaseTotCntList.push(list[i].testcaseTotCnt);
		testcaseYCntList.push(list[i].testcaseYCnt);
	}

	
		var data = {
			  labels: taskGbNmList,
			    series: [
			    testcaseTotCntList,
			    testcaseYCntList
			  ]
			};

		
			var options = {
			  seriesBarDistance: 5
			};

			var responsiveOptions = [
			  ['screen and (min-width: 641px) and (max-width: 1024px)', {
			    seriesBarDistance: 10,
			    axisX: {
			      labelInterpolationFnc: function (value) {
			        return value;
			      }
			    }
			  }],
			  ['screen and (max-width: 640px)', {
			    seriesBarDistance: 5,
			    axisX: {
			      labelInterpolationFnc: function (value) {
			        return value[0];
			      }
			    }
			  }]
			];

			new Chartist.Bar('.ct-chart', data, options, responsiveOptions);
			
			
			/* 단위테스트 진행상태 stacked bar */
			var ProgressStatusUtcData = JSON.parse('${ProgressStatusUtc}');
			
			var ProgressStatusUtcNotTestCnt = new Array();
			var ProgressStatusUtcFirstTestCnt = new Array();
			var ProgressStatusUtcSecondTestCnt = new Array();
			var ProgressStatusUtcCompleteYCnt = new Array();
			
			ProgressStatusUtcNotTestCnt.push(ProgressStatusUtcData.notTestCnt);
			ProgressStatusUtcFirstTestCnt.push(ProgressStatusUtcData.firstTestCnt);
			ProgressStatusUtcSecondTestCnt.push(ProgressStatusUtcData.secondTestCnt);
			ProgressStatusUtcCompleteYCnt.push(ProgressStatusUtcData.completeYCnt);
			
			var ProgressStatusUtcLength = ProgressStatusUtcData.notTestCnt + ProgressStatusUtcData.firstTestCnt + 
					ProgressStatusUtcData.secondTestCnt + ProgressStatusUtcData.completeYCnt;
			
			var ctx = document.getElementById("ProgressStatusUtcChart");
			var ProgressStatusUtcChart = new Chart(ctx, {
				  type : 'horizontalBar'
				 ,data : {
						  barThickness : '0.2'
						 
						 ,datasets : 
							[{ label : '미진행',
								data : ProgressStatusUtcNotTestCnt,
								backgroundColor : '#B7BDD6'}
							,{ label : '1차',
								data : ProgressStatusUtcFirstTestCnt,
								backgroundColor : '#98D5DC'}
							,{ label : '2차',
								data : ProgressStatusUtcSecondTestCnt,
								backgroundColor : '#3765A4'}
							,{ label : '최종완료',
								data : ProgressStatusUtcCompleteYCnt,
								backgroundColor : '#D57C86'}]
						}
				,options : {
						scales :  {
								xAxes : [
								         {stacked : true,
											display : true,
											ticks:{
											min: 0,
								            max: ProgressStatusUtcLength
								                 }
								         }
								         ]
							 	,yAxes : [
							 	          {stacked : true} 
							 	          ]
								}
							}
			});		
			
			
			/* 통합테스트 진행상태 stacked bar */
			var ProgressStatusTtcData = JSON.parse('${ProgressStatusTtc}');
			
			var ProgressStatusTtcNotTestCnt = new Array();
			var ProgressStatusTtcFirstTestCnt = new Array();
			var ProgressStatusTtcSecondTestCnt = new Array();
			var ProgressStatusTtcCompleteYCnt = new Array();
			
			ProgressStatusTtcNotTestCnt.push(ProgressStatusTtcData.notTestCnt);
			ProgressStatusTtcFirstTestCnt.push(ProgressStatusTtcData.firstTestCnt);
			ProgressStatusTtcSecondTestCnt.push(ProgressStatusTtcData.secondTestCnt);
			ProgressStatusTtcCompleteYCnt.push(ProgressStatusTtcData.completeYCnt);
			
			var ProgressStatusTtcLength = ProgressStatusTtcData.notTestCnt + ProgressStatusTtcData.firstTestCnt +
						ProgressStatusTtcData.secondTestCnt + ProgressStatusTtcData.completeYCnt;
			
			var ctx = document.getElementById("ProgressStatusTtcChart");
			var ProgressStatusTtcChart = new Chart(ctx, {
				  type : 'horizontalBar'
				 ,data : {
						  barThickness : '0.2'
						 ,datasets : 
							[{ label : '미진행',
								data : ProgressStatusTtcNotTestCnt,
								backgroundColor : '#B7BDD6'}
							,{ label : '1차',
								data : ProgressStatusTtcFirstTestCnt,
								backgroundColor : '#98D5DC'}
							,{ label : '2차',
								data : ProgressStatusTtcSecondTestCnt,
								backgroundColor : '#3765A4'}
							,{ label : '최종완료',
								data : ProgressStatusTtcCompleteYCnt,
								backgroundColor : '#D57C86'}]
						}
				,options : {
						scales : 
							 {xAxes : [ {stacked : true,
										display : true,
										ticks:{
										min: 0,
						    	        max: ProgressStatusTtcLength
						                 }
							 	}
							 	]
							 ,yAxes : [ {stacked : true} ]}
							}
			});		
			
			} //window.onload
			
			

$(document).ready(function(){
	
	$(".imageArrowUtc").click(function (){
		$('img',this).toggle();
		$("#detail_bar_utc").toggle();
			
	});
	
	$(".imageArrowTtc").click(function (){
		$('img',this).toggle();
		$("#detail_bar_ttc").toggle();
});
	
});
			
			
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
							<li>테스트관리</li>
							<li>&gt;</li>
							<li><strong>테스트통계</strong></li>
                        </ul>
                    </div>
                </div>
              
                <div id="page_info"><div id="page_info_align"></div></div>      
                             
                        

                 <div id="progress_bar_utc" class="progess_bar_section" >
                 
                      	<strong>단위테스트 완료현황</strong>&nbsp;
                      	<span class="imageArrowUtc">
	                      	<a href="#"><img src="<c:url value='/images/tms/blue_arrow_down.gif' />" width="13" height="13" alt="down"/></a>
	                      	<a href="#"><img src="<c:url value='/images/tms/blue_arrow_up.gif' />"   style="display:none;" width="13" height="13" alt="up"/></a>
                      	</span>
                      	
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
	                      
	                      	<strong><c:out value="${tc1_yCnt}"></c:out>&nbsp;/&nbsp;<c:out value="${tc1_totCnt}"></c:out></strong>
						</div>
						
                      	<div class="progress">
						    <div class="progress-bar" style="width:${tc1_Pct}%"> <strong><c:out value=" ${tc1_Pct}"></c:out>%</strong></div>
						</div>
				</div>
				
				<div id="detail_bar_utc" style="display:none;" class="progess_bar_section" >
				
				  <div class="progess_bar_section"><canvas id="ProgressStatusUtcChart" width="100%" height="14"></canvas></div>
                  <div class="progess_bar_section"><canvas id="sysByDefectCnt" width="100%" height="18"></canvas></div>
                  <div class="progess_bar_section"><canvas id="taskByDefectCnt" width="100%" height="30"></canvas></div>
                      
				</div>
                 
                
                    	
                 <div class="progess_bar_section" style="display:none;">
                      	
					    <span><strong>업무별 단위테스트 진행현황 (단위:수)</strong></span>
					    <div class="ct-chart ct-perfect-fourth"></div>
                      	 <div style="text-align: center; margin-top:10px;" >
							  <img src="<c:url value='/images/tms/icon_pop_blue.gif' />" width="10" height="10" alt="yCnt"/>&nbsp;완료건수
							  &nbsp;<img src="<c:url value='/images/tms/icon_pop_gray.gif' />" width="10" height="10" alt="totCnt"/>&nbsp;케이스 등록건수
						 </div>
                 </div>   
                 
                 
                  <div id="progress_bar_ttc" class="progess_bar_section" >
                 
                		<strong>통합테스트 완료현황</strong>&nbsp;
               			<span class="imageArrowTtc">
	                      	<a href="#"><img src="<c:url value='/images/tms/blue_arrow_down.gif' />" width="13" height="13" alt="down"/></a>
	                      	<a href="#"><img src="<c:url value='/images/tms/blue_arrow_up.gif' />"   style="display:none;" width="13" height="13" alt="up"/></a>
                      	</span>
                 
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
	                      	
	                      	<strong><c:out value="${tc2_yCnt}"></c:out>&nbsp;/&nbsp;<c:out value="${tc2_totCnt}"></c:out></strong>
						</div>
                 
                      	
                      	<div class="progress">
						    <div class="progress-bar" style="width:${tc2_Pct}%"><strong><c:out value=" ${tc2_Pct}"></c:out>% </strong> </div>
						</div>
						
                 </div>
                   
                 <div id="detail_bar_ttc" style="display:none;" class="progess_bar_section" >
                      <canvas id="ProgressStatusTtcChart" width="100%" height="14"></canvas>
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