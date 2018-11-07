<%--
  Class Name : EgovMainView.jsp 
  Description : 메인화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page import="egovframework.com.cmm.LoginVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<title>KCC TMS</title>
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css" >
<style>
	tr.row:hover { background-color: lightyellow; } 
</style>
</head>
<body>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/Chart.min.js' />" ></script>
<script type="text/javaScript">
	function searchFileNm() {
	    window.open("<c:url value='/sym/prm/TmsProgramListSearch.do'/>",'','width=800,height=600');
	}
	$(function(){
		$('#category1').change(function() {
			$.ajax({
				type:"POST",
				url: "<c:url value='/sym/prm/TaskGbSearch.do'/>",
				data : {searchData : this.value},
				async: false,
				dataType : 'json',
				success : function(selectTaskGbSearch){
					$("#category2").find("option").remove().end().append("<option value=''>선택하세요</option>");
					$.each(selectTaskGbSearch, function(i){
						(JSON.stringify(selectTaskGbSearch[0].task_GB)).replace(/"/g, "");
					$("#category2").append("<option value='"+JSON.stringify(selectTaskGbSearch[i].task_GB).replace(/"/g, "")+"'>"+JSON.stringify(selectTaskGbSearch[i].task_GB).replace(/"/g, "")+"</option>")
					});
				},
				error : function(request,status,error){
					alert("에러");
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

				}
			});
		})
	})
	
window.onload = function() {
		
		/** 결함 진행상태 통계 시작*/
		var sysByMainStats = JSON.parse('${sysByMainStats}');
		var sysByMainStatsSysNm = new Array();
		var sysByMainStatsSysCnt = new Array();
		var sysByMainStatsActionStA3Cnt = new Array();
		for (var i = 0; i < sysByMainStats.length; i++) {
			sysByMainStatsSysNm.push(sysByMainStats[i].sysNm);
			sysByMainStatsSysCnt.push(sysByMainStats[i].sysCnt);
			sysByMainStatsActionStA3Cnt.push(sysByMainStats[i].actionStA3Cnt);
		}
		var ctx6 = document.getElementById('sysByMainStats');
		var sysByMainStatsChart = new Chart(ctx6, {
			type : 'bar',
			data : {
				labels : sysByMainStatsSysNm,
				barThickness : '0.9',
				datasets : [ {
					label : '결함건수',
					data : sysByMainStatsSysCnt,
					backgroundColor : '#007bff',
				}, {
					label : '조치건수',
					data : sysByMainStatsActionStA3Cnt,
					backgroundColor : '#00B3E6',
				}]
			},
			options : {
				legend:{
					position:'bottom'
				},
				scales:{
					yAxes:[{
						ticks:{
							suggestedMax:sysByMainStatsSysCnt[0]+1,
							beginAtZero:true
						}	
					}],
					xAxes: [{
			            barPercentage: 0.9
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
		/** 결함 진행상태 통계 끝*/
		
		/** 개발 진척상태 통계 시작*/
		var devPlanByMainStats = JSON.parse('${devPlanByMainStats}');
		var devPlanByMainStatsSysNm = new Array();
		var devPlanByMainStatsTp = new Array();
		var devPlanByMainStatsTd = new Array();
		var maxValue =0;
		
		for (var i = 0; i < devPlanByMainStats.length; i++) {
			
			//값들 중 최대값 구하기(수정중)
			if(maxValue < devPlanByMainStats[i].tp){
				maxValue = devPlanByMainStats[i].tp;

				alert(maxValue);
				alert(devPlanByMainStats[i].td);
				if(maxValue < devPlanByMainStats[i].td){
					maxValue = devPlanByMainStats[i].td;
				}
			}
			if(devPlanByMainStats[i].sysGb == 'total'){
				devPlanByMainStatsSysNm.unshift(devPlanByMainStats[i].sysNm);
				devPlanByMainStatsTp.unshift(devPlanByMainStats[i].tp);
				devPlanByMainStatsTd.unshift(devPlanByMainStats[i].td);
			}else{
				devPlanByMainStatsSysNm.push(devPlanByMainStats[i].sysNm);
				devPlanByMainStatsTp.push(devPlanByMainStats[i].tp);
				devPlanByMainStatsTd.push(devPlanByMainStats[i].td);
			}
		}
		var ctx7 = document.getElementById('devPlanByMainStats');
		var devPlanByMainStatsChart = new Chart(ctx7, {
			type : 'bar',
			data : {
				labels : devPlanByMainStatsSysNm,
				barThickness : '0.9',
				datasets : [ {
					label : '계획건수',
					data : devPlanByMainStatsTp,
					backgroundColor : '#007bff',
				},{
					label : '실적건수',
					data : devPlanByMainStatsTd,
					backgroundColor :  '#00B3E6',
				}]
			},
			options : {
				legend:{
					position:'bottom'
				},
				scales:{
					yAxes:[{
						ticks:{
							suggestedMax:maxValue+1,
							beginAtZero:true
						}	
					}],
					xAxes: [{
			            barPercentage: 0.9
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
		/** 개발 진척상태 통계 끝*/
}	

</script>

<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>	
<!-- 전체 레이어 시작 -->

<div id="wrap">
    <div id="topnavi" style="margin : 0;"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>
	<!-- //header 끝 -->	
	<!-- container 시작 -->
	<div id="main_container">
								<%
									LoginVO loginVO = (LoginVO) session.getAttribute("LoginVO");
										if (loginVO != null) {
								%>
										<c:set var="loginUniqId" value="<%=loginVO.getUniqId()%>" />
								<% 
										}
								%>
        <div class="container" style="padding:0 15px; 0 15px; font-family:'Malgun Gothic';">
	    	<div class="page-title">
	    			<b style="font-size:14px;"><i class="icon-bar-chart"></i>&nbsp;프로젝트 상세</b>
	    	</div>
	    	
	    	<div class="crumbs">
	    		<ul id="breadcrumbs" class="breadcrumb"> 
	    		</ul>
	    	</div>
    	</div>
   	
    <div class="row mt30" style="font-family:'Malgun Gothic';">
    <!-- 프로젝트 생성 시작 -->
	<c:if test="${tmsProjectManageVO.pjtId == null }">
	<div class="myBsnsList" class="col-md-6" style="height: 260px; margin-bottom:30px; font-family:'Malgun Gothic';">
    		<div class="widget">
    			<div class="widget-header">
    				<div class="header-name" style="margin:10px;">
	    					프로젝트 정보
    				</div>
    			</div>
    			<div class="widget-content box">
    				<div class="default_tablestyle">
    				<table class="table table-search-head table-size-th4" style="height:215px; font-family:'Malgun Gothic';">
					<tr>
					<td>
						<c:choose>
						<c:when test="${loginUniqId == 'USRCNFRM_00000000000'}">
						<font size="3px" style="font-weight:bold;">
							<a href="<c:url value='/sym/prm/insertProject.do'/>">프로젝트 생성</a>
						</font>
						</c:when>
						<c:otherwise>
						<font size="3px" style="font-weight:bold;">관리자에게 문의하십시오.
						</font>
						</c:otherwise>
						</c:choose>
					</td>
					</tr>
					</table>
					</div>
    			</div>
    		</div>
    	</div>
	</c:if>
	
	<!-- 프로젝트 생성 끝 -->
     <c:if test="${tmsProjectManageVO.pjtId != null }">
    	<div class="myBsnsList" class="col-md-6" style="height: 260px; margin-bottom:30px; font-family:'Malgun Gothic';">
    		<div class="widget">
    			<div class="widget-header">
    			<c:if test="${loginUniqId == 'USRCNFRM_00000000000'}">
    				<table style="width:100%;margin-bottom:8px;">
    					<colgroup>
                  		<col width="20%"/> 
                  		<col width="20%"/> 
                  		<col width="20%"/> 
                  		<col width="20%"/> 
                  		<col width="20%"/>
      			        </colgroup>
    					<tr>
    						<td style="font-weight:bold;color:#666666;font-size:100%;">프로젝트 정보</td>
    						<td></td>
    						<td></td>
    						<td></td>
    						<td>
    						<c:if test="${loginUniqId == 'USRCNFRM_00000000000'}">
    							<div class="buttons" style="float:right; font-size:10px;">
    								<a href="<c:url value='/sym/prm/updateProject.do'/>">수정</a>
    							</div>
    						</c:if>
    						</td>
    					</tr>
    				</table>
    			</c:if>
    			<c:if test="${loginUniqId != 'USRCNFRM_00000000000'}">
    				<table style="width:100%;margin-bottom:7px;margin-top:10px;">
    					<colgroup>
                  		<col width="20%"/> 
                  		<col width="20%"/> 
                  		<col width="20%"/> 
                  		<col width="20%"/> 
                  		<col width="20%"/>
      			        </colgroup>
    					<tr>
    						<td style="font-weight:bold;color:#666666;font-size:100%;">프로젝트 정보</td>
    						<td></td>
    						<td></td>
    						<td></td>
    						<td></td>
    					</tr>
    				</table>    					
    			</c:if>
    			</div>
    			<div class="widget-content box">
    				<table class="table table-search-head table-size-th4" style="height:215px; font-family:'Malgun Gothic';">
    					<tbody>
    						 <tr class="last">
    							<th style="font-weight:bold;color:#0F438A;font-size:110%;">프로젝트명</th>
    							<td colspan="4" id="empName" name="empName" align="left" style="font-size:110%; padding-left:60px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" valign="middle">${tmsProjectManageVO.pjtNm}</td>
    						</tr>
    						<tr class="last">
    						    <th style="font-weight:bold;color:#0F438A;font-size:110%;">사업유형</th>
    						    <td align="left" style="font-size:110%; padding-left:60px;" valign="middle">${tmsProjectManageVO.pjtType}</td>
    						    <th style="font-weight:bold;color:#0F438A;font-size:110%;">사업상태</th>
    						    <td align="left" style="font-size:110%; padding-left:60px;" valign="middle">${tmsProjectManageVO.pjtSt}</td>
    						</tr>
    						<tr class="last">
    						    <th style="font-weight:bold;color:#0F438A;font-size:110%;">PM</th>
    						    <td align="left" style="font-size:110%; padding-left:60px;" valign="middle">${tmsProjectManageVO.pjtPm}</td>
    						    <th style="font-weight:bold;color:#0F438A;font-size:110%;">사업비</th>
    						    <td align="left" style="font-size:110%; padding-left:60px;" valign="middle"><fmt:formatNumber value="${tmsProjectManageVO.pjtPrice}" pattern="#,###"/>원</td>
    						</tr>
    						<tr class="last">
    						    <th style="font-weight:bold;color:#0F438A;font-size:110%;">사업시작일</th>
    						    <td align="left" style="font-size:110%; padding-left:60px;" valign="middle"><fmt:formatDate value="${tmsProjectManageVO.pjtStartDt}" pattern="yyyy-MM-dd" /></td>
    						    <th style="font-weight:bold;color:#0F438A;font-size:110%;">사업종료일</th>
    						    <td align="left" style="font-size:110%; padding-left:60px;" valign="middle"><fmt:formatDate value="${tmsProjectManageVO.pjtEndDt}" pattern="yyyy-MM-dd" /></td>
    						</tr>
    						<tr class="last">
    						    <th style="font-weight:bold;color:#0F438A;font-size:110%;">개발시작일</th>
    						    <td align="left" style="font-size:110%; padding-left:60px;" valign="middle"><fmt:formatDate value="${tmsProjectManageVO.devStartDt}" pattern="yyyy-MM-dd" /></td>
    						    <th style="font-weight:bold;color:#0F438A;font-size:110%;">개발종료일</th>
    						    <td align="left" style="font-size:110%; padding-left:60px;" valign="middle"><fmt:formatDate value="${tmsProjectManageVO.devEndDt}" pattern="yyyy-MM-dd" /></td>
    						</tr>
    						<tr class="last">
    							<th style="font-weight:bold;color:#0F438A;font-size:110%;">프로젝트 설명</th>
    							<td colspan="4" id="empName" name="empName" align="left" title="<c:out value='${tmsProjectManageVO.pjtContent}'/>" style="font-size:110%; padding-left:60px;
    							 white-space:nowrap; overflow:hidden;	text-overflow:ellipsis;" valign="middle">${tmsProjectManageVO.pjtContent}</td>
    						</tr>
    					
    					</tbody>
    				</table>
    				
    			</div>
    		</div>
    	</div>
    	</c:if>
    	<div class="recentBsnsList" class="col-md-6" style="height:260px; margin-bottom:30px !important	; font-family:'Malgun Gothic';">
    		<div class="widget">
    			<div class="widget-header">
    				<div class="header-name" style="margin:10px;">
	    					개발자별 개발현황
    				</div>
    			</div>
    			<div class="widget-content default_tablestyle" style="height:212px; overflow:auto; ">
    				<table width="100%" cellspacing="0" cellpadding="0" class="table table-search-head table-size-th4">
			    					<caption>개발자별 개발현황</caption>
			            <colgroup>
			            <col width="20%" >
			            <col width="20%" >
			            <col width="12%" >
			            <col width="12%" >
			            <col width="12%" >
			            <col width="12%" >
			            </colgroup>
			            <thead>
			            <tr>
			                <th scope="col" class="f_field" nowrap="nowrap" style="font-weight:bold;color:#0F438A;font-size:110%;">이름</th>
			                <th scope="col" nowrap="nowrap" style="font-weight:bold;color:#0F438A;font-size:110%;">총 본수</th>
			                <th scope="col" nowrap="nowrap" style="font-weight:bold;color:#0F438A;font-size:110%;">대기</th>
			                <th scope="col" nowrap="nowrap" style="font-weight:bold;color:#0F438A;font-size:110%;">진행</th>
			                <th scope="col" nowrap="nowrap" style="font-weight:bold;color:#0F438A;font-size:110%;">지연</th>
			                <th scope="col" nowrap="nowrap" style="font-weight:bold;color:#0F438A;font-size:110%;">완료</th>
			            </tr>
			            </thead>
			            <tbody>          
			                   
			             <c:forEach var="stats" items="${userDevByDevStats}" varStatus="status">
			            <!-- loop 시작 -->                                
			              <tr>
						    <td id="icl" nowrap="nowrap"  style="font-weight:bold;color:#0F438A;font-size:110%;" title="${stats.userId }"><i class="icon-user" style="font-size: 2em; color: rgb(80, 80, 80)" ></i>　<c:out value="${stats.userNm}"/></td>
						    <td nowrap="nowrap" style="font-size:110%;"><c:out value="${stats.totCnt }"/></td>
						    <td nowrap="nowrap" style="font-size:110%;"><c:out value="${stats.s1 }"/></td>
						    <td nowrap="nowrap" style="font-size:110%;"><c:out value="${stats.s2 }"/></td>
						    <td nowrap="nowrap" style="font-size:110%;"><c:out value="${stats.s3 }"/></td>
						    <td nowrap="nowrap" style="font-size:110%;"><c:out value="${stats.s4 }"/></td>
			              </tr>
			            </c:forEach> 
			            <c:if test="${fn:length(userDevByDevStats) == 0 }">
			            <tr>
							<td colspan="6">
							자료가 없습니다.
							</td>
						</tr>			            
			            </c:if>
			            </tbody> 
    				</table>
    			</div>
    		</div>    	    	
    	</div>
    	
    	<div class="myBsnsList" class="col-md-6" style="height:290px; margin-bottom:20px !important	; font-family:'Malgun Gothic';">
    		<div class="widget">
    			<div class="widget-header">
    				<div class="header-name" style="margin:10px;">
	    					개발진척 현황
    				</div>
    			</div>
    			<br/><br/>
    			<c:choose>
    			<c:when test="${devPlanByMainStats != null}">
    				<canvas id="devPlanByMainStats" width="100%" height="28"></canvas>
    			</c:when>
    			<c:otherwise>
    			등록된 개발계획이 없습니다.
    			</c:otherwise>
    			</c:choose>
    		</div>    	    	
    	</div>
    	
    	<div class="recentBsnsList" class="col-md-6" style="overflow:auto; white-space:nowrap; overflow-y:hidden; height:290px; width:220px; margin-bottom:20px !important	; font-family:'Malgun Gothic';">
    		<div class="widget">
    			<div class="widget-header">
    				<div class="header-name" style="margin:10px;">
	    					결함처리 현황
    				</div>
    			</div>
    			<br/><br/>
    			<c:choose>
    			<c:when test="${sysByMainStats != null }">
    			<canvas id="sysByMainStats" width="100%" height="28"></canvas>
    			</c:when>
    			<c:otherwise>
    			 등록된 결함이 없습니다.
    			</c:otherwise>
    			</c:choose>
    		</div>    	    	
    	</div>
    	
    
    </div>	                
	</div>
	
	<!-- footer 시작 -->
	<div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
	<!-- //footer 끝 -->
</div>
<!-- //전체 레이어 끝 -->
</body>
</html>