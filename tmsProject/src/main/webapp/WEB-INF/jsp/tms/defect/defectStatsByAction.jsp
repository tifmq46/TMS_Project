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
					<div id="search_field_loc"><h2><strong>결함처리통계(그래프)</strong></h2></div>
			</div>

			<font color="#727272" style="font-size:1.17em;font-weight:bold">시스템별 조치율</font>
				<table>
					<tr>
						<td>
							<canvas id="sysAllByActionCnt" width="200" height="200" style="display: inline !important;"></canvas>
						</td>
						<c:forEach var="sysByActionCnt" items="${sysByActionCnt}" varStatus="status">
							<td>
								<canvas	id="<c:out value="${sysByActionCnt.sysGb}"/>"
									width="180" height="180" style="display: inline !important;"></canvas>
							</td>
						</c:forEach>
					</tr>
					<tr>
						<td align="center" valign="middle">
							<div style="font-size: 15px; font-weight: bolder;">
								<font color="#007BFF"><c:out value="${sysAllByActionCnt.actionStA3CntAll}" /></font> /
								<c:out value="${sysAllByActionCnt.sysCntAll}" />
								(<c:out value=" ${sysAllByActionCnt.actionPerAll}"/>%)
								<br/> 전체 <br/>
							</div>
						</td>
						<c:forEach var="sysByActionCnt" items="${sysByActionCnt}" varStatus="status">
						<td align="center" valign="middle">
							<div style="font-size: 15px; font-weight: bolder;">
								<font color="#007BFF"><c:out value="${sysByActionCnt.actionStA3Cnt}" /></font> /
								<c:out value="${sysByActionCnt.sysCnt}" />
								(<c:out value=" ${sysByActionCnt.actionPer}"/>%)
								<br/><c:out value="${sysByActionCnt.sysNm}"/><br/>
							</div>
						</td>
						</c:forEach>
					</tr>
				</table>
				
				<font color="#727272" style="font-size:1.17em;font-weight:bold">업무별 조치율</font>
				<table>
					<tr>
						<td>
							
						</td>
					</tr>
					<tr>
						<td></td>
					</tr>
				</table>

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