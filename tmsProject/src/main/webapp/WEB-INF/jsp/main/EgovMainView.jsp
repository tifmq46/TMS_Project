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
<script language="javascript1.2" type="text/javaScript">
	function searchFileNm() {
	    window.open("<c:url value='/sym/prm/TmsProgramListSearch.do'/>",'','width=800,height=600');
	}
</script>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>	
<!-- 전체 레이어 시작 -->

<div id="wrap">
    <div id="topnavi" style="margin : 0;"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>
	<!-- //header 끝 -->	
	<!-- container 시작 -->
	<div id="main_container">
	     <%-- <!-- 프로그램리스트 검색 시작 -->
		  <div>
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
                    </div>
                </li>	
            </ul>           
         </div> 
        <!-- 프로그램리스트 검색 끝 -->  --%>
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
    	<div id="myBsnsList" class="col-md-6">
    		<div class="widget">
    			<div class="widget-header">
    				<div class="header-name" style="margin:10px;">
	    				<i class="icon-reorder">
	    					프로젝트 정보
	    				</i>
    				</div>
    			</div>
    			<div class="widget-content box">
    				<table class="table table-search-head table-size-th4">
    					<tbody>
    						<tr class="last">
    							<th>프로젝트 명</th>
    							<td id="empName" name="empName" align="center" valign="middle">TMS</td>
    						</tr>
    						<tr class="last">
    						    <th>프로젝트 분류</th>
    						    <td align="center" valign="middle">사업개선</td>
    						    <th>프로젝트 상태</th>
    						    <td align="center" valign="middle">진행</td>
    						</tr>
    						<tr class="last">
    						    <th>부서</th>
    						    <td align="center" valign="middle">개발부서</td>
    						    <th>PM</th>
    						    <td align="center" valign="middle">장현우</td>
    						</tr>
    						<tr class="last">
    						    <th>계획시작일</th>
    						    <td align="center" valign="middle">2018-06-04</td>
    						    <th>계획완료일</th>
    						    <td align="center" valign="middle">2018-09-21</td>
    						</tr>
    						<tr class="last">
    						    <th>시작일</th>
    						    <td align="center" valign="middle">2018-06-04</td>
    						    <th>완료일</th>
    						    <td align="center" valign="middle">진행중</td>
    						</tr>
    						<tr class="last">
    						    <th>중요도</th>
    						    <td align="center" valign="middle">100</td>
    						    <th>금액</th>
    						    <td align="center" valign="middle">$10,000,000</td>
    						</tr>
    						<tr class="last">
    							<th>프로젝트 설명</th>
    							<td id="empName" name="empName" align="center" valign="middle">Test Management System</td>
    						</tr>
    						
    					</tbody>
    				</table>
    				
    			</div>
    		</div>    	
    	</div>
    </div>	                
	</div>
	<!-- //게시판 끝 -->
	<!-- footer 시작 -->
	<div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
	<!-- //footer 끝 -->
</div>
<!-- //전체 레이어 끝 -->
</body>
</html>