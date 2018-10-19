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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/Chart.min.js' />" ></script>

<script type="text/javascript">
var taskByDefectCntChart;

function handleClick(event, array){
	alert(this.data.labels[array[0]._index]);
	$.ajax({
		type:"POST",
		url: "<c:url value='/tms/defect/selectDefectStatsByDefectCntAsyn.do'/>",
		data : {sysNm : this.data.labels[array[0]._index]},
		async: false,
		dataType : 'json',
		success : function(result){
			var taskByDefectCnt = result;
			var taskByDefectCntTaskNm = new Array();
			var taskByDefectCntTaskGbCnt = new Array();
			for (var i = 0; i < result.length; i++) {
				taskByDefectCntTaskNm.push(result[i].taskNm);
				if(result[i].taskGbCnt == 0) {
					result[i].taskGbCnt = 0.1;
				}
				taskByDefectCntTaskGbCnt.push(result[i].taskGbCnt);
			}
			
			var data = [];
			for(var i=0; i<taskByDefectCnt.length; i++) {
				data[i] = {
						datasets : [ {
							label : '결함건수',
							data : taskByDefectCntTaskGbCnt[i],
							backgroundColor : '#007BFF',
						}]
					}
			}
			console.log(taskByDefectCntChart.data);
			console.log(data);
			console.log(taskByDefectCntChart.data.datasets);
			taskByDefectCntChart.data.datasets = data;
			taskByDefectCntChart.update();
			
		},
		error : function(request,status,error){
			alert("에러");
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

		}
	});
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
		
		/** 시스템별 결함건수*/
		var sysByDefectCnt = JSON.parse('${sysByDefectCnt}');
		var sysByDefectCntSysNm = new Array();
		var sysByDefectCntSysCnt = new Array();
		for (var i = 0; i < sysByDefectCnt.length; i++) {
			sysByDefectCntSysNm.push(sysByDefectCnt[i].sysNm);
			if(sysByDefectCnt[i].sysCnt == 0) {
				sysByDefectCnt[i].sysCnt = 0.1;
			}
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
		
		/** 업무별 결함건수*/
		var taskByDefectCnt = JSON.parse('${taskByDefectCnt}');
		var taskByDefectCntTaskNm = new Array();
		var taskByDefectCntTaskGbCnt = new Array();
		for (var i = 0; i < taskByDefectCnt.length; i++) {
			taskByDefectCntTaskNm.push(taskByDefectCnt[i].taskNm);
			if(taskByDefectCnt[i].taskGbCnt == 0) {
				taskByDefectCnt[i].taskGbCnt = 0.1;
			}
			taskByDefectCntTaskGbCnt.push(taskByDefectCnt[i].taskGbCnt);
		}
		var ctx2 = document.getElementById('taskByDefectCnt');
		taskByDefectCntChart = new Chart(ctx2, {
			type : 'bar',
			data : {
				labels : taskByDefectCntTaskNm,
				barThickness : '0.9',
				datasets : [ {
					label : '결함건수',
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
			
				<font color="#727272" style="font-size:1.17em;font-weight:bold">시스템별 결함건수</font>
							<canvas id="sysByDefectCnt" width="100%" height="20"></canvas>
				
				<font color="#727272" style="font-size:1.17em;font-weight:bold">업무별 결함건수</font>
					<div id="taskByDefectCntLoc">
							<canvas id="taskByDefectCnt" width="100%" height="20"></canvas>
					</div>
				<c:forEach var="taskByDefectCnt" items="${taskByDefectCnt}" varStatus="status">
					<c:out value="${taskByDefectCnt.taskGb}"/>
					<c:out value="${taskByDefectCnt.taskNm}"/>
					<c:out value="${taskByDefectCnt.taskGbCnt}"/>
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