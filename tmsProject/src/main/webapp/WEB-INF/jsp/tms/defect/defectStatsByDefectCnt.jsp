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
<title>결함처리통계(대시보드2)</title>
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css" >
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/Chart.min.js' />" ></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
var taskByDefectCntChart;

function handleClick(event, array){
	var sysNm = this.data.labels[array[0]._index];
	$.ajax({
		type:"POST",
		url: "<c:url value='/tms/defect/selectDefectStatsByDefectCntAsyn.do'/>",
		data : {sysNm : this.data.labels[array[0]._index]},
		async: false,
		dataType : 'json',
		success : function(result){
			var taskByDefectCnt = result;
			if(sysNm == "전체") {
				var taskByDefectCntConcatNm = new Array();
			} else {
				var taskByDefectCntTaskNm = new Array();
			}
			var taskByDefectCntTaskGbCnt = new Array();
			for (var i = 0; i < taskByDefectCnt.length; i++) {
				if(sysNm == "전체") {
					taskByDefectCntConcatNm.push(taskByDefectCnt[i].sysNm+"("+taskByDefectCnt[i].taskNm+")");
				} else {
					taskByDefectCntTaskNm.push(taskByDefectCnt[i].taskNm);
				}
				taskByDefectCntTaskGbCnt.push(taskByDefectCnt[i].taskGbCnt);
			}
			var data = taskByDefectCntChart.config.data;
			data.datasets[0].data = taskByDefectCntTaskGbCnt;
			if(sysNm == "전체") {
				data.labels = taskByDefectCntConcatNm;
			} else {
				data.labels = taskByDefectCntTaskNm;
			}
			taskByDefectCntChart.config.options.scales.yAxes[0].ticks.suggestedMax = taskByDefectCntTaskGbCnt[0]+1;
			taskByDefectCntChart.update();
			
		},
		error : function(request,status,error){
			swal("에러");
			swal("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

		}
	});
}
window.onload = function() {
	
		/** 시스템별 결함건수*/
		var sysByDefectCnt = JSON.parse('${sysByDefectCnt}');
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
					label : '결함건수',
					data : sysByDefectCntSysCnt,
					backgroundColor : '#007BFF',
				}]
			},
			options : {
				onClick:handleClick,
				legend: {
					display: false,
				},
				scales:{
					yAxes:[{
						ticks:{
							suggestedMax: sysByDefectCntSysCnt[0]+1,
							beginAtZero:true
						}	
					}],
					xAxes: [{
			            barPercentage: 0.7
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

		/** 업무별 결함건수*/
		var taskByDefectCnt = JSON.parse('${taskByDefectCnt}');
		var taskByDefectCntConcatNm = new Array();
		var taskByDefectCntTaskGbCnt = new Array();
		for (var i = 0; i < taskByDefectCnt.length; i++) {
			taskByDefectCntConcatNm.push(taskByDefectCnt[i].sysNm+"("+taskByDefectCnt[i].taskNm+")");
			taskByDefectCntTaskGbCnt.push(taskByDefectCnt[i].taskGbCnt);
		}
		var ctx2 = document.getElementById('taskByDefectCnt');
		taskByDefectCntChart = new Chart(ctx2, {
			type : 'bar',
			data : {
				labels : taskByDefectCntConcatNm,
				barThickness : '0.9',
				datasets : [ {
					label : '결함건수',
					data : taskByDefectCntTaskGbCnt,
					backgroundColor : '#007BFF',
				}]
			},
			options : {
				legend: {
					display: false,
				},
				scales:{
					yAxes:[{
						ticks:{
							suggestedMax:taskByDefectCntTaskGbCnt[0]+1,
							beginAtZero:true
						}	
					}],
					xAxes: [{
			            barPercentage: 0.7
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
            <div id="content" style="font-family:'Malgun Gothic';">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
							<li>HOME</li>
							<li>&gt;</li>
							<li>결함관리</li>
							<li>&gt;</li>
							<li>결함처리통계</li>
							<li>&gt;</li>
							<li><strong>대시보드2</strong></li>
                        </ul>
                    </div>
                </div>
     		<div id="search_field" style="font-family:'Malgun Gothic';">
					<div id="search_field_loc"><h2><strong>결함처리통계 (대시보드2)</strong></h2></div>
			</div>
			<br/><br/><br/><br/><br/>
			
			
			<div class="recentBoardList" class="col-md-6" style="width:500px; margin-bottom:30px !important	; font-family:'Malgun Gothic';">
    			<div class="widget">
    				<div class="widget-header">
    					<div class="header-name" style="margin:10px;">
	    					<img src="<c:url value='/images/bl_circle.gif' />" width="5" height="5" alt="dot" style="vertical-align:super" />&nbsp;시스템별 결함건수
    					</div>
    				</div>
    				<div class="widget-content" style="overflow:auto; overflow-y:hidden;">
					<canvas id="sysByDefectCnt" width="100%" height="20" style="padding-top:30px"></canvas>
					</div>
    			</div>    	  
    			
    		</div>
			
			<div class="recentBoardList" class="col-md-6" style="width:500px; margin-bottom:30px !important	; font-family:'Malgun Gothic';">
    			<div class="widget">
    				<div class="widget-header">
    					<div class="header-name" style="margin:10px;">
	    					<img src="<c:url value='/images/bl_circle.gif' />" width="5" height="5" alt="dot" style="vertical-align:super" />&nbsp;업무별 결함건수
    					</div>
    				</div>
    				<div class="widget-content" style="overflow:auto; overflow-y:hidden;">
    				<div id="taskByActionCntLoc" >
						<canvas id="taskByDefectCnt" width="100%" height="20" style="padding-top:30px"></canvas>
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