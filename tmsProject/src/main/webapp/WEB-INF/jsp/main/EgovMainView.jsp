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
	
</script>

<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>	
<!-- 전체 레이어 시작 -->

<div id="wrap">
    <div id="topnavi" style="margin : 0;"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>
	<!-- //header 끝 -->	
	<!-- container 시작 -->
	<div id="main_container">
	    <!-- 프로그램리스트 검색 시작 -->
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
    	<div id="myBsnsList" class="col-md-6" style="height: 241px;">
    		<div class="widget">
    			<div class="widget-header">
    				<div class="header-name" style="margin:10px;">
	    					프로젝트 정보
	    				</i>
    				</div>
    			</div>
    			<div class="widget-content box">
    				<table class="table table-search-head table-size-th4">
    					<tbody>
    						 <tr class="last">
    							<th>프로젝트 명</th>
    							<td id="empName" name="empName" align="left" style="padding-left:60px;" valign="middle">${tmsProjectManageVO.PJT_NM}</td>
    						</tr>
    						<tr class="last">
    						    <th>사업 유형</th>
    						    <td align="left" style="padding-left:60px;" valign="middle">${tmsProjectManageVO.PJT_TYPE}</td>
    						    <th>프로젝트 상태</th>
    						    <td align="left" style="padding-left:60px;" valign="middle">${tmsProjectManageVO.PJT_ST}</td>
    						</tr>
    						<tr class="last">
    						    <th>PM</th>
    						    <td align="left" style="padding-left:60px;" valign="middle">${tmsProjectManageVO.PJT_PM}</td>
    						    <th>가격</th>
    						    <td align="left" style="padding-left:60px;" valign="middle"><fmt:formatNumber value="${tmsProjectManageVO.PJT_PRICE}" pattern="#,###"/>원</td>
    						</tr>
    						<tr class="last">
    						    <th>계획시작일</th>
    						    <td align="left" style="padding-left:60px;" valign="middle"><fmt:formatDate value="${tmsProjectManageVO.DEV_START_DT}" pattern="yyyy-MM-dd" /></td>
    						    <th>계획완료일</th>
    						    <td align="left" style="padding-left:60px;" valign="middle"><fmt:formatDate value="${tmsProjectManageVO.DEV_END_DT}" pattern="yyyy-MM-dd" /></td>
    						</tr>
    						<tr class="last">
    						    <th>개발시작일</th>
    						    <td align="left" style="padding-left:60px;" valign="middle"><fmt:formatDate value="${tmsProjectManageVO.PJT_START_DT}" pattern="yyyy-MM-dd" /></td>
    						    <th>개발완료일</th>
    						    <td align="left" style="padding-left:60px;" valign="middle"><fmt:formatDate value="${tmsProjectManageVO.PJT_END_DT}" pattern="yyyy-MM-dd" /></td>
    						</tr>
    						<tr class="last">
    							<th>프로젝트 설명</th>
    							<td id="empName" name="empName" align="left" style="padding-left:60px;" valign="middle">${tmsProjectManageVO.PJT_CONTENT}</td>
    						</tr>
    					</tbody>
    				</table>
    				
    			</div>
    		</div>
    	</div>
    	<div id="recentBsnsList" class="col-md-6" style="height:241px;">
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
			            <col width="25%" >
			            <col width="25%" >
			            <col width="10%" >
			            <col width="10%" >
			            <col width="10%" >
			            <col width="10%" >
			            <col width="10%" > 
			            </colgroup>
			            <thead>
			            <tr>
			                <th scope="col" class="f_field" nowrap="nowrap">이름</th>
			                <th scope="col" nowrap="nowrap">역할</th>
			                <th scope="col" nowrap="nowrap">대기</th>
			                <th scope="col" nowrap="nowrap">조치중</th>
			                <th scope="col" nowrap="nowrap">조치완료</th>
			                <th scope="col" nowrap="nowrap">재요청</th>
			                <th scope="col" nowrap="nowrap">최종완료</th>
			            </tr>
			            </thead>
			            <tbody>                 
			            
			             <c:forEach var="userList" items="${userList}" varStatus="status">
			            <!-- loop 시작 -->                                
			              <tr>
						    <td nowrap="nowrap"><i class="fas fa-user"></i><c:out value="${userList.USER_NM}"/></td>
						    <td nowrap="nowrap"><c:if test="${userList.ESNTL_ID eq 'USRCNFRM_00000000000'}">관리자</c:if><c:if test="${userList.ESNTL_ID eq 'USRCNFRM_00000000001'}">PL</c:if><c:if test="${userList.ESNTL_ID eq 'USRCNFRM_00000000002'}">개발자</c:if></td>
						    <td nowrap="nowrap"><c:out value="0"/></td>
						    <td nowrap="nowrap"><c:out value="0"/></td>
						    <td nowrap="nowrap"><c:out value="0"/></td>
						    <td nowrap="nowrap"><c:out value="0"/></td>
						    <td nowrap="nowrap"><c:out value="0"/></td>
			              </tr>
			            </c:forEach> 
			            </tbody> 
    				</table>
    			</div>
    		</div>    	    	
    	</div>
    	
    </div>	                
	</div>
	<!-- //게시판 끝 -->
	<!-- 프로젝트 생성 시작 -->
	<a href="<c:url value='/sym/prm/insertProjectView.do'/>">이거 건들지 말것</a>
	<!-- 프로젝트 생성 끝 -->
	<!-- 공통코드 셀렉트박스 시작 -->
        <div id="search_field">
					<div id="search_field_loc"><h2><strong>공통코드관리</strong></h2></div>
					<form action="form_action.jsp" method="post">
					  	<fieldset><legend>조건정보 영역</legend>	  
					  	<div class="sf_start">
					  		<ul id="search_first_ul">
					  			<li>
								    <label for="searchByTaskGb">시스템구분&nbsp;</label>
									<select name="category1" id="category1" style="width:12%;text-align-last:center;">
									    <option value="0" selected="selected" >전체</option>
									    <c:forEach var="sysGb" items="${sysGb}" varStatus="status">
									    	<option value="<c:out value="${sysGb.SYS_GB}"/>"><c:out value="${sysGb.SYS_GB}" /></option>
									    </c:forEach>
									</select>						
					  			</li> 			
					  			 <li>
								    <label for="searchByDefectGb">업무구분</label>
									<select name="category2" id="category2" style="width:15%;text-align-last:center;">
									    <option value="">선택하세요</option>
									</select>						
					  			</li>
					  		</ul>
						</div>			
						</fieldset>
					</form>
				</div>
				<!-- //검색 필드 박스 끝 -->
        
        <!-- 공통코드 셀렉트박스 끝 -->
	<!-- footer 시작 -->
	<div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
	<!-- //footer 끝 -->
</div>
<!-- //전체 레이어 끝 -->
</body>
</html>