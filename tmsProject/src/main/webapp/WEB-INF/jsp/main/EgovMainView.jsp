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
<title>표준프레임워크 경량환경 내부업무템플릿</title>
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css" >
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
		var taskByMainStats = JSON.parse('${taskByMainStats}');
		var taskByMainStatsTaskNm = new Array();
		var taskByMainStatsTaskAll = new Array();
		var taskByMainStatsActionStA3 = new Array();
		for (var i = 0; i < taskByMainStats.length; i++) {
			taskByMainStatsTaskNm.push(taskByMainStats[i].taskNm);
			taskByMainStatsTaskAll.push(taskByMainStats[i].taskAll);
			taskByMainStatsActionStA3.push(taskByMainStats[i].actionStA3);
		}
		var ctx6 = document.getElementById('taskByMainStats');
		var taskByMainStatsChart = new Chart(ctx6, {
			type : 'bar',
			data : {
				labels : taskByMainStatsTaskNm,
				barThickness : '0.9',
				datasets : [ {
					label : '등록건수',
					data : taskByMainStatsTaskAll,
					backgroundColor : '#007bff',
				}, {
					label : '조치건수',
					data : taskByMainStatsActionStA3,
					backgroundColor : '#00B3E6',
				}]
			},
			options : {
				scales:{
					yAxes:[{
						ticks:{
							beginAtZero:true
						}	
					}]
				}	
			}
		});
		/** 결함 진행상태 통계 끝*/
		
		/** 개발 진척상태 통계 시작*/
		var devPlanByMainStats = JSON.parse('${devPlanByMainStats}');
		var devPlanByMainStatsTaskNm = new Array();
		var devPlanByMainStatsTaskAll = new Array();
		var devPlanByMainStatsAchieveCnt = new Array();
		for (var i = 0; i < devPlanByMainStats.length; i++) {
			devPlanByMainStatsTaskNm.push(devPlanByMainStats[i].taskNm);
			devPlanByMainStatsTaskAll.push(devPlanByMainStats[i].taskAll);
			devPlanByMainStatsAchieveCnt.push(devPlanByMainStats[i].achieveCnt);
		}
		var ctx7 = document.getElementById('devPlanByMainStats');
		var devPlanByMainStatsChart = new Chart(ctx7, {
			type : 'bar',
			data : {
				labels : devPlanByMainStatsTaskNm,
				barThickness : '0.9',
				datasets : [ {
					label : '등록건수',
					data : devPlanByMainStatsTaskAll,
					backgroundColor : '#007bff',
				}, {
					label : '완료건수',
					data : devPlanByMainStatsAchieveCnt,
					backgroundColor : '#00B3E6',
				}]
			},
			options : {
				scales:{
					yAxes:[{
						ticks:{
							beginAtZero:true
						}	
					}]
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
	    <!-- 프로그램리스트 검색 시작 -->
		 <%--  <div>
         	<ul>
            	<li>
                	<div>
                    	<input type="text" id="TmsProgrmFileNm_pg_id" size="20" disabled="disabled">
                    	<a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
	                	<img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" />검색</a>
	                	<input type="text" id="TmsProgrmFileNm_user_dev_id" size="20" disabled="disabled">
	                	<input type="text" id="TmsProgrmFileNm_pg_nm" size="20" disabled="disabled">
	                	<input type="text" id="TmsProgrmFileNm_sys_gb" size="20" disabled="disabled">
	                	<input type="text" id="TmsProgrmFileNm_task_gb" size="20" disabled="disabled">
	                	<input type="text" id="TmsProgrmFileNm_user_real_id" size="20" disabled="disabled">
                    </div>
                </li>	
            </ul>           
         </div>  --%>
        <!-- 프로그램리스트 검색 끝 --> 
        <div class="container" style="padding:0 15px; 0 15px;">
	    	<div class="page-title">
	    			<b style="font-size:14px;"><i class="icon-bar-chart"></i>&nbsp;프로젝트 상세</b>
	    	</div>
	    	
	    	<div class="crumbs">
	    		<ul id="breadcrumbs" class="breadcrumb"> 
	    			<!-- <li>영업관리</li>
	    			<li>
	    				::before
	    				"사업관리"
	    			</li> -->
	    		</ul>
	    	</div>
    	</div>
   	
    <div class="row mt30">
    <!-- 프로젝트 생성 시작 -->
	<c:if test="${tmsProjectManageVO.pjtId == null }">
		<a href="<c:url value='/sym/prm/insertProjectView.do'/>">프로젝트 생성</a>
	</c:if>
	
	<!-- 프로젝트 생성 끝 -->
     <c:if test="${tmsProjectManageVO.pjtId != null }">
    	<div class="myBsnsList" class="col-md-6" style="height: 260px; margin-bottom:30px;">
    		<div class="widget">
    			<div class="widget-header">
    				<div class="header-name" style="margin:10px;">
	    					프로젝트 정보
    				</div>
    			</div>
    			<div class="widget-content box">
    				<table class="table table-search-head table-size-th4" style="height:215px;">
    					<tbody>
    						 <tr class="last">
    							<th>프로젝트 명</th>
    							<td id="empName" name="empName" align="left" style="padding-left:60px;" valign="middle">${tmsProjectManageVO.pjtNm}</td>
    						</tr>
    						<tr class="last">
    						    <th>사업 유형</th>
    						    <td align="left" style="padding-left:60px;" valign="middle">${tmsProjectManageVO.pjtType}</td>
    						    <th>프로젝트 상태</th>
    						    <td align="left" style="padding-left:60px;" valign="middle">${tmsProjectManageVO.pjtSt}</td>
    						</tr>
    						<tr class="last">
    						    <th>PM</th>
    						    <td align="left" style="padding-left:60px;" valign="middle">${tmsProjectManageVO.pjtPm}</td>
    						    <th>가격</th>
    						    <td align="left" style="padding-left:60px;" valign="middle"><fmt:formatNumber value="${tmsProjectManageVO.pjtPrice}" pattern="#,###"/>원</td>
    						</tr>
    						<tr class="last">
    						    <th>계획시작일</th>
    						    <td align="left" style="padding-left:60px;" valign="middle"><fmt:formatDate value="${tmsProjectManageVO.devStartDt}" pattern="yyyy-MM-dd" /></td>
    						    <th>계획완료일</th>
    						    <td align="left" style="padding-left:60px;" valign="middle"><fmt:formatDate value="${tmsProjectManageVO.devEndDt}" pattern="yyyy-MM-dd" /></td>
    						</tr>
    						<tr class="last">
    						    <th>개발시작일</th>
    						    <td align="left" style="padding-left:60px;" valign="middle"><fmt:formatDate value="${tmsProjectManageVO.pjtStartDt}" pattern="yyyy-MM-dd" /></td>
    						    <th>개발완료일</th>
    						    <td align="left" style="padding-left:60px;" valign="middle"><fmt:formatDate value="${tmsProjectManageVO.pjtEndDt}" pattern="yyyy-MM-dd" /></td>
    						</tr>
    						<tr class="last">
    							<th>프로젝트 설명</th>
    							<td id="empName" name="empName" align="left" style="padding-left:60px;" valign="middle">${tmsProjectManageVO.pjtContent}</td>
    						</tr>
    					</tbody>
    				</table>
    				
    			</div>
    		</div>
    	</div>
    	</c:if>
    	<div class="recentBsnsList" class="col-md-6" style="height:260px; margin-bottom:30px !important	; ">
    		<div class="widget">
    			<div class="widget-header">
    				<div class="header-name" style="margin:10px;">
	    					프로젝트 멤버
    				</div>
    			</div>
    			<div class="widget-content default_tablestyle" style="height:212px; overflow:auto; ">
    				<table width="100%" cellspacing="0" cellpadding="0" class="table table-search-head table-size-th4">
			    					<caption>프로젝트 멤버</caption>
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
			                <th scope="col" class="f_field" nowrap="nowrap">이름</th>
			                <th scope="col" nowrap="nowrap">역할</th>
			                <th scope="col" nowrap="nowrap">대기</th>
			                <th scope="col" nowrap="nowrap">조치중</th>
			                <th scope="col" nowrap="nowrap">조치완료</th>
			                <th scope="col" nowrap="nowrap">재요청</th>
			            </tr>
			            </thead>
			            <tbody>                 
			            
			            <%-- <c:forEach var="result" items="${list_progrmmanage}" varStatus="status">
			            <!-- loop 시작 -->                                
			              <tr>
						    <td nowrap="nowrap"><c:out value="${result.SYS_GB}"/></td>
						    <td nowrap="nowrap"><c:out value="${result.TASK_GB}"/></td>
						    <td nowrap="nowrap">
						        <span class="link"><a href="#LINK" style="color:blue;"onclick="choisProgramListSearch('<c:out value="${result.PG_ID}"/>','<c:out value="${result.USER_DEV_ID}"/>','<c:out value="${result.PG_NM}"/>','<c:out value="${result.SYS_GB}"/>','<c:out value="${result.TASK_GB}"/>'); return false;">
						      <c:out value="${result.PG_ID}"/></a></span></td>
						    <td nowrap="nowrap"><c:out value="${result.PG_NM}"/></td>
						    <td nowrap="nowrap"><c:out value="${result.USER_DEV_ID}"/></td>
			              </tr>
			            </c:forEach> --%>
			             <c:forEach var="pjtMemberList" items="${pjtMemberList}" varStatus="status">
			            <!-- loop 시작 -->                                
			              <tr>
						    <td id="icl" nowrap="nowrap"  style="color:blue;"><i class="icon-user" style="font-size: 2em; color: rgb(80, 80, 80)"></i>　<c:out value="${pjtMemberList.userNm}"/></td>
						    <td nowrap="nowrap"><c:if test="${pjtMemberList.esntlId eq 'USRCNFRM_00000000000'}">관리자</c:if><c:if test="${pjtMemberList.esntlId eq 'USRCNFRM_00000000001'}">PL</c:if><c:if test="${pjtMemberList.esntlId eq 'USRCNFRM_00000000002'}">개발자</c:if></td>
						    <td nowrap="nowrap"><c:out value="${pjtMemberList.actionStA1 }"/></td>
						    <td nowrap="nowrap"><c:out value="${pjtMemberList.actionStA2 }"/></td>
						    <td nowrap="nowrap"><c:out value="${pjtMemberList.actionStA3 }"/></td>
						    <td nowrap="nowrap"><c:out value="${pjtMemberList.actionStA4 }"/></td>
			              </tr>
			            </c:forEach> 
			            </tbody> 
    				</table>
    			</div>
    		</div>    	    	
    	</div>
    	
    	<div class="myBsnsList" class="col-md-6" style="height:290px; margin-bottom:20px !important	;">
    		<div class="widget">
    			<div class="widget-header">
    				<div class="header-name" style="margin:10px;">
	    					개발진척 현황
    				</div>
    			</div>
    			<br/><br/>
    			<c:choose>
    			<c:when test="${devPlanByMainStats != null}">
    				<canvas id="devPlanByMainStats" width="100%" height="30"></canvas>
    			</c:when>
    			<c:otherwise>
    			등록된 개발계획이 없습니다.
    			</c:otherwise>
    			</c:choose>
    		</div>    	    	
    	</div>
    	
    	<div class="recentBsnsList" class="col-md-6" style="overflow:auto; white-space:nowrap; overflow-y:hidden; height:290px; width:220px; margin-bottom:20px !important	;">
    		<div class="widget">
    			<div class="widget-header">
    				<div class="header-name" style="margin:10px;">
	    					결함처리 현황
    				</div>
    			</div>
    			<br/><br/>
    			<c:choose>
    			<c:when test="${taskByMainStats != null }">
    			<canvas id="taskByMainStats" width="100%" height="30"></canvas>
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