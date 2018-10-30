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
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko">
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css">
<title>결함처리통계(표)</title>

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

th,td{
	border-left : 1px solid #81B1D5;
	border-top : 1px solid #81B1D5;
}
</style>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		$('ul.tabs li').click(function() {
			var tab_id = $(this).attr('data-tab');
			if(!(tab_id == "tab-3")){
				$('ul.tabs li').removeClass('current');
				$('.tab-content').removeClass('current');
				
				$(this).addClass('current');
				$("#" + tab_id).addClass('current');
				
				if(tab_id=="tab-1") {
						document.getElementById("StatsBySysToExcel").style.display="inline"
						document.getElementById("StatsByUserDevToExcel").style.display="none"
				} else {
						document.getElementById("StatsBySysToExcel").style.display="none"
						document.getElementById("StatsByUserDevToExcel").style.display="inline"
				}
			}
		})
	})

	function StatsToExcel(statsGb) {
		location.href = "./StatsToExcel.do?statsGb=" + statsGb;
	}
	
</script>

</head>

<body>
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

	<!-- 전체 레이어 시작 -->


	<div id="wrap">
		<!-- header 시작 -->
		<div id="topnavi" style="margin: 0;">
			<c:import url="/sym/mms/EgovMainMenuHead.do" />
		</div>
		<!-- //header 끝 -->
		<!-- container 시작 -->
		<div id="container">
			<!-- 좌측메뉴 시작 -->
			<div id="leftmenu">
				<c:import url="/sym/mms/EgovMainMenuLeft.do" />
			</div>
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
							<li><strong>통계표</strong></li>
						</ul>
					</div>
				</div>
				<br /> <br />
				<div id="search_field" style="font-family:'Malgun Gothic';">
					<div id="search_field_loc">
						<h2>
							<strong>결함처리통계 (표)</strong>
						</h2>
					</div>
				</div>
				<br/><br/><br/><br/>
				
				<ul class="tabs">
					<li class="tab-link current" data-tab="tab-1">시스템별</li>
					<li class="tab-link" data-tab="tab-2">개발자별</li>
					<li class="tab-link last" data-tab="tab-3" style="float:right">
						<div class="buttons" id="StatsBySysToExcel" style="display:inline">
								<a href="<c:url value='/tms/defect/StatsToExcel.do'/>"
									onclick="javascript:StatsToExcel('sys'); return false;">엑셀 다운로드</a>
						</div>
						<div class="buttons" id="StatsByUserDevToExcel" style="display:none">
							<a href="<c:url value='/tms/defect/StatsToExcel.do'/>"
								onclick="javascript:StatsToExcel('userDev'); return false;">엑셀 다운로드</a>
						</div>
					</li>
				</ul>
				
				<div id="tab-1" class="tab-content current">
					<div id="StatsBySysGb">
						<div class="default_tablestyle">
							<table border="0" width="120%" border="0" cellpadding="0"
								cellspacing="0" summary="시스템별 통계(표) 테이블">
								<caption style="visibility: hidden">시스템별 통계(표) 테이블</caption>


								<colgroup>
									<col width="12%" />
									<col width="13%" />
									<col width="10.7%" />
									<col width="10.7%" />
									<col width="10.7%" />
									<col width="10.7%" />
									<col width="10.7%" />
									<col width="10.7%" />
									<col width="10.7%" />
								</colgroup>
								<tr>
									<th align="center" rowspan="2">시스템구분</th>
									<th align="center" rowspan="2">업무구분</th>
									<th align="center" colspan="4" style="font-weight:bold">결함건수</th>
									<th align="center" rowspan="2" style="font-weight:bold">조치건수</th>
									<th align="center" rowspan="2" style="font-weight:bold">미조치건수</th>
									<th align="center" rowspan="2" class="borderLine" style="font-weight:bold">조치율(%)</th>
								</tr>
								<tr>
									<th align="center">오류</th>
									<th align="center">개선</th>
									<th align="center">문의</th>
									<th align="center">기타</th>
								</tr>

								<c:forEach var="sysGbByStats" items="${sysGbByStats}"
									varStatus="status">
									<tr>
										<c:choose>
										<c:when test="${sysGbByStats.sysNm == '합계' }">
											<td class="lineStyle2">${sysGbByStats.sysNm }</td>
											<td class="lineStyle2">${sysGbByStats.taskNm }</td>
											<td class="lineStyle2">${sysGbByStats.defectGbD1 }</td>
											<td class="lineStyle2">${sysGbByStats.defectGbD2 }</td>
											<td class="lineStyle2">${sysGbByStats.defectGbD3 }</td>
											<td class="lineStyle2">${sysGbByStats.defectGbD4 }</td>
											<td class="lineStyle2">${sysGbByStats.actionStA3 }</td>
											<td class="lineStyle2">${sysGbByStats.actionStA3Not }</td>
											<td class="lineStyle2 borderLine">${sysGbByStats.actionPer }%</td>
										</c:when>
										<c:otherwise>
											<c:choose>
											<c:when test="${sysGbByStats.taskNm == '소계'}">
												<td class="lineStyle">${sysGbByStats.sysNm }</td>
												<td class="lineStyle">${sysGbByStats.taskNm }</td>
												<td class="lineStyle">${sysGbByStats.defectGbD1 }</td>
												<td class="lineStyle">${sysGbByStats.defectGbD2 }</td>
												<td class="lineStyle">${sysGbByStats.defectGbD3 }</td>
												<td class="lineStyle">${sysGbByStats.defectGbD4 }</td>
												<td class="lineStyle">${sysGbByStats.actionStA3 }</td>
												<td class="lineStyle">${sysGbByStats.actionStA3Not }</td>
												<td class="lineStyle borderLine">${sysGbByStats.actionPer }%</td>
											</c:when>
											<c:otherwise>
												<td>${sysGbByStats.sysNm }</td>
												<td>${sysGbByStats.taskNm }</td>
												<td>${sysGbByStats.defectGbD1 }</td>
												<td>${sysGbByStats.defectGbD2 }</td>
												<td>${sysGbByStats.defectGbD3 }</td>
												<td>${sysGbByStats.defectGbD4 }</td>
												<td>${sysGbByStats.actionStA3 }</td>
												<td>${sysGbByStats.actionStA3Not }</td>
												<td class="borderLine">${sysGbByStats.actionPer }%</td>
											</c:otherwise>
											</c:choose>
										</c:otherwise>
										</c:choose>
									</tr>
								</c:forEach>
								<c:if test="${fn:length(sysGbByStats) == 0 }">
								<tr>
								<td colspan="9">
								자료가 없습니다.
								</td>
								</tr>
								</c:if>
							</table>
							<br/><br/>
						</div>
					</div>
				</div>
				
				<div id="tab-2" class="tab-content">
					<div id="StatsByUserDev">
						<div class="default_tablestyle">
							<table border="0" width="120%" border="0" cellpadding="0"
								cellspacing="0" summary="개발자별 통계(표) 테이블">
								<caption style="visibility: hidden">개발자별 통계(표) 테이블</caption>


								<colgroup>
									<col width="10%" />
									<col width="15%" />
									<col width="15%" />
									<col width="10.8%" />
									<col width="10.8%" />
									<col width="10.8%" />
									<col width="10.8%" />
									<col width="10.8%" />
									<col width="10.8%" />
									<col width="10.8%" />
								</colgroup>
								<tr>
									<th align="center" rowspan="2">개발자</th>
									<th align="center" rowspan="2">화면ID</th>
									<th align="center" rowspan="2">화면명</th>
									<th align="center" colspan="4" style="font-weight:bold">결함건수</th>
									<th align="center" rowspan="2" style="font-weight:bold">조치건수</th>
									<th align="center" rowspan="2" style="font-weight:bold">미조치건수</th>
									<th align="center" rowspan="2" style="font-weight:bold" class="borderLine">조치율(%)</th>
								</tr>
								<tr>
									<th align="center">오류</th>
									<th align="center">개선</th>
									<th align="center">문의</th>
									<th align="center">기타</th>
								</tr>

								<c:forEach var="userDevPgIdByStats" items="${userDevPgIdByStats}"
									varStatus="status">
									<tr>
									<c:choose>
									<c:when test="${ userDevPgIdByStats.userNm == '합계'}">
											<td class="lineStyle2">${userDevPgIdByStats.userNm }</td>
											<td class="lineStyle2" colspan="2">${userDevPgIdByStats.pgId }</td>
											<td class="lineStyle2">${userDevPgIdByStats.defectGbD1 }</td>
											<td class="lineStyle2">${userDevPgIdByStats.defectGbD2 }</td>
											<td class="lineStyle2">${userDevPgIdByStats.defectGbD3 }</td>
											<td class="lineStyle2">${userDevPgIdByStats.defectGbD4 }</td>
											<td class="lineStyle2">${userDevPgIdByStats.actionStA3 }</td>
											<td class="lineStyle2">${userDevPgIdByStats.actionStA3Not }</td>
											<td class="lineStyle2 borderLine">${userDevPgIdByStats.actionPer }%</td>
									</c:when>
									<c:otherwise>
										<c:choose>
										<c:when test="${userDevPgIdByStats.pgId == '소계'}">
											<td class="lineStyle">${userDevPgIdByStats.userNm }</td>
											<td class="lineStyle" colspan="2">${userDevPgIdByStats.pgId }</td>
											<td class="lineStyle">${userDevPgIdByStats.defectGbD1 }</td>
											<td class="lineStyle">${userDevPgIdByStats.defectGbD2 }</td>
											<td class="lineStyle">${userDevPgIdByStats.defectGbD3 }</td>
											<td class="lineStyle">${userDevPgIdByStats.defectGbD4 }</td>
											<td class="lineStyle">${userDevPgIdByStats.actionStA3 }</td>
											<td class="lineStyle">${userDevPgIdByStats.actionStA3Not }</td>
											<td class="lineStyle borderLine">${userDevPgIdByStats.actionPer }%</td>
										</c:when>
										<c:otherwise>
											<td>${userDevPgIdByStats.userNm }</td>
											<td>${userDevPgIdByStats.pgId }</td>
											<td>${userDevPgIdByStats.pgNm }</td>
											<td>${userDevPgIdByStats.defectGbD1 }</td>
											<td>${userDevPgIdByStats.defectGbD2 }</td>
											<td>${userDevPgIdByStats.defectGbD3 }</td>
											<td>${userDevPgIdByStats.defectGbD4 }</td>
											<td>${userDevPgIdByStats.actionStA3 }</td>
											<td>${userDevPgIdByStats.actionStA3Not }</td>
											<td class="borderLine">${userDevPgIdByStats.actionPer }%</td>
										</c:otherwise>
										</c:choose>
									</c:otherwise>
									</c:choose>
									</tr>
								</c:forEach>
								<c:if test="${fn:length(userDevPgIdByStats) == 0 }">
								<tr>
								<td colspan="10">
								자료가 없습니다.
								</td>
								</tr>
								</c:if>
							</table>
							<br/><br/>
						</div>
					</div>
				</div>
				
			</div>
			<!-- //content 끝 -->
		</div>
		<!-- //container 끝 -->
		<!-- footer 시작 -->
		<div id="footer">
			<c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" />
		</div>
		<!-- //footer 끝 -->
	</div>
	<!-- //전체 레이어 끝 -->



</body>
</html>