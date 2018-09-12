<%--
  Class Name : EgovTemplateList.jsp
  Description : 템플릿 목록화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.18   이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.18
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<script type="text/javascript">

function fn_egov_selectSysType(obj){
	
	var op = document.createElement('option');
	op.text='Append'+1;
	op.value='append'+1;
	var task = document.getElementById('searchByTaskGb');
	
	if(obj.value == 'S1'){
		alert("d");
	}/* 
    if (obj.value == 'TMPT01') {
        document.getElementById('sometext').innerHTML = "게시판 템플릿은 CSS만 가능합니다.";
    } else if (obj.value == '') {
        document.getElementById('sometext').innerHTML = "";
    } else {
        document.getElementById('sometext').innerHTML = "템플릿은 JSP만 가능합니다.";
    }        */
}

function fn_egov_insert_addDevPlan(){    
    document.frm.action = "<c:url value='/tms/dev/addDevPlan.do'/>";
    document.frm.submit();
}

function fn_searchList(pageNo){

    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/tms/dev/devPlans.do'/>";
    document.listForm.submit();
}
</script>

<title>템플릿 목록</title>
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
<!-- 전체 레이어 시작 -->
<div id="wrap">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <div id="topnavi"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>      
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
                            <li>개발진척관리</li>
                            <li>&gt;</li>
                            <li><strong>개발계획관리</strong></li>
                        </ul>
                    </div>
                </div>
 
 			
                
                <!-- 검색 필드 박스 시작 -->
                <form:form commandName="searchVO" name="listForm" id="listForm" method="post" action="<c:url value='tms/dev/devPlanList.do'/>" >   
				 
                <input type="hidden" name="pageIndex" value="<c:out value='${devPlanVO.pageIndex}'/>"/>
				
				<div id="search_field">
					<div id="search_field_loc"><h2><strong>개발계획관리</strong></h2></div>
					
					  	<fieldset><legend>조건정보 영역</legend>	  
					  	<div class="sf_start">
					  		<ul id="search_first_ul">
					  		
					  			<li>
								    <label for="searchBySysGb">시스템구분</label>
									<select name="searchBySysGb" id="searchBySysGb" onchange="fn_egov_selectSysType(this)">
									    <option value="0" selected="selected">전체</option>
									    <c:forEach var="resultS" items="${resultS}" varStatus="status">
                                    		<option value='<c:out value="${resultS.code}"/>'><c:out value="${resultS.codeNm}"/></option>
                                		</c:forEach>    
									</select>						
					  			</li>
					  			<li>
								    <label for="searchByTaskGb">업무구분</label>
									<select name="searchByTaskGb" id="searchByTaskGb" >
									    <option value="0" selected="selected">전체</option>
									    <c:forEach var="resultT" items="${resultT}" varStatus="status">
                                    		<option value='<c:out value="${resultT.code}"/>'><c:out value="${resultT.codeNm}"/></option>
                                		</c:forEach>
									</select>						
					  			</li>
					  			
					  			<li><label for="searchByUserDevId">개발자명</label></li>
					  			<li><input type="text" name="searchByUserDevId" id="searchByUserDevId" /></li>
					  			
					  		</ul>
					  		<ul id="search_second_ul">
					  			<li><label for="searchByPgId">화면ID</label></li>
					  			<li><input type="text" name="searchByPgId" id="searchByPgId" value='${devPlanVO.searchByPgId}'/></li>
					  			<li>
									<div class="buttons" style="float:right;">
										<a href="#LINK" onclick="javascript:fn_searchList('1')" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
									    <a href="<c:url value='/tms/dev/addDevPlan.do'/>" onclick="javascript:fn_egov_insert_addDevPlan(); return false;" >등록</a>
									</div>	  				  			
					  			</li>
					  			
					  			<li>
					  			<label>계획일자</label>
								<input type="date" name="planStartDt" /><img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
					  			~ <input type="date" name="planEndDt" /><img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
					  			</li>
					  			
					  		</ul>	
					  		
					  				
						</div>			
						</fieldset>
			
				</div>
				<!-- //검색 필드 박스 끝 -->
                
                <div id="page_info"><div id="page_info_align"></div></div>                    
                <!-- table add start -->
                <div class="default_tablestyle">
                    <table summary="번호,게시판명,사용 커뮤니티 명,사용 동호회 명,등록일시,사용여부   목록입니다" cellpadding="0" cellspacing="0">
                    <caption>게시판 템플릿 목록</caption>
                    <colgroup>
                    <col width="10%" >
                    <col width="10%" >  
                    <col width="10%" >
                    <col width="15%" >
                    <col width="10%" >
                    <col width="20%" >
                    <col width="20%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <th align="center">시스템구분</th>
        				<th align="center">업무구분</th>
        				<th align="center">화면ID</th>
        				<th align="center">화면명</th>
        				<th align="center">개발자</th>
        				<th align="center">계획시작일자</th>
        				<th align="center">계획종료일자</th>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <!-- loop 시작 -->                                
                      <tr>
                        <td align="center" class="listtd"><c:out value="${result.sysGb}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.taskGb}"/>&nbsp;</td>
            				<td align="center" class="listtd">
            					<a href="<c:url value='/tms/dev/selectDevPlan.do'/>?pgId=<c:out value='${result.pgId}'/>">
                                <c:out value="${result.pgId}"/></a>
                             </td>
            				<%-- <td align="center" class="listtd"><c:out value="${result.pgId}"/>&nbsp;</td> --%>
            				<td align="left" class="listtd"><c:out value="${result.pgNm}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.userDevId}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.planStartDt}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.planEndDt}"/>&nbsp;</td>
                      </tr>
                     </c:forEach>     
                     <c:if test="${fn:length(resultList) == 0}">
                      <tr>
                        <td nowrap colspan="5" ><spring:message code="common.nodata.msg" /></td>  
                      </tr>      
                     </c:if>
                    </tbody>
                    </table>
                </div>
                <!-- 페이지 네비게이션 시작 -->
                <div id="paging_div">
                    <ul class="paging_align">
                       <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_tmplatInfo"  />
                    </ul>
                </div>                          
                <!-- //페이지 네비게이션 끝 -->
                
               
                
                </form:form> 
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