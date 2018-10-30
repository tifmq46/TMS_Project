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

window.onload = function() {
		
		/** 일자별 결함 등록건수 조치건수*/
		var dayByDefectCnt = JSON.parse('${dayByDefectCnt}');
		var dayByDefectCntDays = new Array();
		var dayByDefectCntEnrollDtCnt = new Array();
		var dayByDefectCntActionDtCnt = new Array();
		var dayByDefectCntAccumulCnt = new Array();
		for (var i = 0; i < dayByDefectCnt.length; i++) {
			dayByDefectCntDays.push(dayByDefectCnt[i].days);
			dayByDefectCntEnrollDtCnt.push(dayByDefectCnt[i].enrollDtCnt);
			dayByDefectCntActionDtCnt.push(dayByDefectCnt[i].actionDtCnt);
			dayByDefectCntAccumulCnt.push(dayByDefectCnt[i].accumulCnt);
		}
		var ctx1 = document.getElementById('dayByDefectCnt');
		var dayByDefectCntChart = new Chart(ctx1, {
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
				}, {
					label : '누적건수',
					data : dayByDefectCntAccumulCnt,
					type : 'line',
					fill : false,
					borderColor : '#97BBCD'
				}]
			},
			options : {
				scales:{
					yAxes:[{
						ticks:{
							beginAtZero:true
						}	
					}],
					xAxes: [{
			            barPercentage: 0.9
			        }]
				},
			animation: {
			      duration: 0,
			      onComplete: function() {
			        var chartInstance = this.chart,
			        ctx = chartInstance.ctx;
			        ctx.fillStyle = 'rgba(0, 123, 255, 1)';
			        ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
			        ctx.textAlign = 'center';
			        ctx.textBaseline = 'bottom';

			        this.data.datasets.forEach(function(dataset, i) {
			          var type = dataset.type;
			          if(type != 'line') {
				          var meta = chartInstance.controller.getDatasetMeta(i);
				          meta.data.forEach(function(bar, index) {
				            var data = dataset.data[index];
				            if(data != 0){
					            ctx.fillText(data, bar._model.x, bar._model.y - 5);
				            }
				          });
			          }
			        });
			      }
			    },
			}
		});

		/** 사용자별 결함건수*/
		var userByDefectCnt = JSON.parse('${userByDefectCnt}');
		var userByDefectCntUserNm = new Array();
		var userByDefectCntDefectAll = new Array();
		var userByDefectCntActionA3All = new Array();
		for (var i = 0; i < userByDefectCnt.length; i++) {
			userByDefectCntUserNm.push(userByDefectCnt[i].userNm);
			userByDefectCntDefectAll.push(userByDefectCnt[i].defectCnt);
			userByDefectCntActionA3All.push(userByDefectCnt[i].actionA3Cnt);
		}
		var ctx3 = document.getElementById('userByDefectCnt');
		var userByDefectCntChart = new Chart(ctx3, {
			type : 'bar',
			data : {
				labels : userByDefectCntUserNm,
				barThickness : '0.9',
				datasets : [ {
					label : '결함건수',
					data : userByDefectCntDefectAll,
					backgroundColor : '#007BFF',
				},
				{
					label : '조치건수',
					data : userByDefectCntActionA3All,
					backgroundColor : '#00B3E6',
				}]
			},
			options : {
				scales:{
					yAxes:[{
						ticks:{
							beginAtZero:true
						}	
					}],
					xAxes: [{
			            barPercentage: 0.9
			        }]
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
							<li><strong>결함처리통계</strong></li>
                        </ul>
                    </div>
                </div>
     		<div id="search_field" style="font-family:'Malgun Gothic';">
					<div id="search_field_loc"><h2><strong>결함처리통계 (대시보드1)</strong></h2></div>
			</div>
			<br/><br/><br/><br/><br/><br/>
			
			<div class="recentBoardList" class="col-md-6" style="width:500px; margin-bottom:30px !important	; font-family:'Malgun Gothic';">
    			<div class="widget">
    				<div class="widget-header">
    					<div class="header-name" style="margin:10px;">
	    					조치율
	    					&nbsp;
						<font style="font-weight:bold">( 전체 <c:out value="${defectStats.actionStAll}"/>건 중 </font> 
						<font style="font-weight:bold" color="#007BFF" ><c:out value="${defectStats.actionStA3}"/></font>
						<font style="font-weight:bold">건 완료 )</font> 
    					</div>
    				</div>
    				
						<table width="100%">
							<tr>
								<td width="90%">
									<fmt:parseNumber var="actionProgression" integerOnly="true"
											value="${defectStats.actionStA3 / defectStats.actionStAll * 100}" />
									<div class="progress" style="height: 2rem;">
										<div class="progress-bar" style="width:${actionProgression}%">
											<font style="font-size: 15px; font-weight: bolder">
											<c:out value=" ${actionProgression}"></c:out>% </font>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td align="right">
									<img src="<c:url value='/images/tms/icon_pop_blue.gif' />"
										width="10" height="10" alt="yCnt" />&nbsp;조치율
								</td>
							</tr>
						</table>
    			</div>    	  
    			
    		</div>
			
			<div class="recentBoardList" class="col-md-6" style="width:500px; margin-bottom:30px !important	; font-family:'Malgun Gothic';">
    			<div class="widget">
    				<div class="widget-header">
    					<div class="header-name" style="margin:10px;">
	    					상태별 결함건수
    				</div>
    			</div>
    				
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
						</tr>
					</table>
    			</div>    
    		</div>
			
			<div class="recentBoardList" class="col-md-6" style="width:500px; margin-bottom:30px !important	; font-family:'Malgun Gothic';">
    			<div class="widget">
    				<div class="widget-header">
    					<div class="header-name" style="margin:10px;">
	    					사용자별 결함건수 / 조치건수
    					</div>
    				</div>
    				
					<canvas id="userByDefectCnt" width="100%" height="20"></canvas>
    			</div>    	  
    			
    		</div>
			
			<div class="recentBoardList" class="col-md-6" style="width:500px; margin-bottom:30px !important	; font-family:'Malgun Gothic';">
    			<div class="widget">
    				<div class="widget-header">
    					<div class="header-name" style="margin:10px;">
	    					일자별 등록건수 / 조치건수
    					</div>
    				</div>
    				
					<canvas id="dayByDefectCnt" width="100%" height="20"></canvas>
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