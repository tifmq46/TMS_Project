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
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css" >
<title>결함처리현황</title>
<style type="text/css">

td.listtd {
		white-space:nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
}

</style>
<script type="text/javascript">
   
	function fn_searchList(pageNo){
		//alert(pageNo);
    	document.listForm.pageIndex.value = pageNo;
    	document.listForm.action = "<c:url value='/tms/defect/selectDefectCurrent.do'/>";
    	document.listForm.submit();
	}

   
    function fn_egov_select_viewDefect(){
        document.frm.action = "<c:url value='/tms/defect/selectDefectCurrent.do'/>";
        document.frm.submit();      
    }

    function searchFileNm() {
        window.open("<c:url value='/sym/prm/TmsProgramListSearch.do'/>",'','width=800,height=600');
    }


</script>
</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

<!-- 전체 레이어 시작 -->


<div id="wrap">
    <!-- header 시작 -->
    <div id="topnavi" style="margin:0;"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>
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
							<li><strong>결함처리현황</strong></li>
                        </ul>
                    </div>
                </div>
     
              
             <form:form commandName="searchVO" name="listForm" method="post" action="tms/defect/selectDefectCurrent.do">   
                <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
                <!-- 검색 필드 박스 시작 -->
            <div id="search_field" style="font-family:'Malgun Gothic';">
               <div id="search_field_loc"><h2><strong>결함처리현황</strong></h2></div>
               
                    <fieldset><legend>조건정보 영역</legend>     
                    <div class="sf_start">
                    	<table style="width:100%;padding-bottom:10px;padding-left:10px;padding-top:10px;">
                    		<colgroup>
                  			  <col width="7%"/> 
                  			  <col width="14.4%"/> 
                  			  <col width="7%"/> 
                  			  <col width="14.4%"/> 
                  			  <col width="7%"/> 
                  			  <col width="14.4%"/> 
                  			  <col width="7%"/> 
                  			  <col width="14.4%"/> 
                  			  <col width="14.4%"/> 
      			        	</colgroup>
      			        <tr>
      			        	<td style="font-weight:bold;color:#666666;font-size:110%;">화면ID
      			        	</td>
      			        	<td>
                      	    <input id="TmsProgrmFileNm_pg_id" name="searchByPgId" type="text" size="10" autocomplete="off" style="width:80%;text-align:center;" title="화면ID" value="<c:out value='${searchVO.searchByPgId}'/>"/>
                     	    <a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
                   		   <img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a>
      			        	</td>
      			        	<td style="font-weight:bold;color:#666666;font-size:110%;">업무구분
      			        	</td>
      			        	<td>
                           <input list="taskGbList" name="searchByTaskGb" id="searchByTaskGb" style="width:80%;text-align-last:center;" value="<c:out value='${searchVO.searchByTaskGb}'/>"/>
                               <datalist id="taskGbList">
									    <c:forEach var="taskGb" items="${taskGb}" varStatus="status">
									    	<option value="<c:out value="${taskGb.codeNm}"/>"  style="text-align:center;"></option>
									    </c:forEach>
					        	</datalist>
      			        	</td>
      			        	<td style="font-weight:bold;color:#666666;font-size:110%;">결함유형
      			        	</td>
      			        	<td>
      			        	<select name="searchByDefectGb" id="searchByDefectGb" style="width:90%;text-align-last:center;">
                               <option value="" selected="selected">전체</option>
                               <c:forEach var="defectGb" items="${defectGb}" varStatus="status">
                               	  <option value="<c:out value="${defectGb.codeNm}"/>" <c:if test="${searchVO.searchByDefectGb == defectGb.codeNm}">selected="selected"</c:if> ><c:out value="${defectGb.codeNm}" /></option>                                  
                               </c:forEach>
                           </select>  
      			        	</td>
      			        	<td style="font-weight:bold;color:#666666;font-size:110%;">조치상태
      			        	</td>
      			        	<td>
      			        	<select name="searchByActionSt" id="searchByActionSt" style="width:90%;text-align-last:center;">
                               <option value="" selected="selected">전체</option>
                               <c:forEach var="actionSt" items="${actionSt}" varStatus="status">
                               	  <option value="<c:out value="${actionSt.codeNm}"/>" <c:if test="${searchVO.searchByActionSt == actionSt.codeNm}">selected="selected"</c:if> ><c:out value="${actionSt.codeNm}" /></option>
                                  
                               </c:forEach>
                           </select>
      			        	</td>
      			        	<td>
      			        	</td>
      			        </tr>
      			        <tr>
                        	<td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">테스터
      			        	</td>
      			        	<td style="padding-top:15px;">
                        	<input type="text" list="userAllList" autocomplete="off" name="searchByUserTestId" id="searchByUserTestId" size="10" style="width:80%;text-align:center;" value="<c:out value='${searchVO.searchByUserTestId}'/>"/>
      			        	</td>
      			        	<td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">개발자
      			        	</td>
      			        	<td style="padding-top:15px;">
                          	<input type="text" list="userAllList" autocomplete="off" name="searchByUserDevId" id="searchByUserDevId" size="15" style="width:80%;text-align:center;" value="<c:out value='${searchVO.searchByUserDevId}'/>"/>
      			        	</td>
      			        	  <datalist id="userAllList">
									    <c:forEach var="userList" items="${userList}" varStatus="status">
									    	<option value="<c:out value="${userList.userNm}"/>"  style="text-align:center;"></option>
									    </c:forEach>
					        	</datalist>
      			        	<td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">등록일자
      			        	</td>
      			        	<td colspan="3" style="padding-top:15px;">
                        <input type="date" name="searchByStartDt" id="searchByStartDt" style="text-align:center; width:38%" value="<c:out value='${ST_date}'/>"/>&nbsp;<img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
                          &nbsp;~&nbsp;<input type="date" name="searchByEndDt" id="searchByEndDt" style="text-align:center; width:38%" value="<c:out value='${EN_date}'/>"/>&nbsp;<img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
      			        	</td>
      			        	<td style="padding-top:15px;">
                           <div class="buttons" style="float:right;">
                            <a href="#LINK" onclick="javascript:fn_searchList('1')" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
                           </div>                            
      			        	</td>
      			        </tr>
                    	</table>
                  </div>         
                  </fieldset>
          	  </div>
          	  <!-- //검색 필드 박스 끝 -->
                
                 <table width="100%" cellspacing="0" summary="총 건수, 완료건수, 미완료, 진행률 표시하는 테이블">
                 <caption style="visibility:hidden">총 건수, 완료건수, 미완료, 진행률 표시하는 테이블</caption>
                 
                 <tr>
                 	<td align="right" width="6%" style="font-size:1.2em; font-weight:bolder">조치율 : </td>
                 	<c:if test="${actionTotCnt ne '0' }">
                 		<fmt:parseNumber var="actionProgression" integerOnly="true" value="${actionStCnt.actionStA3 / actionTotCnt * 100}"/>
                 	</c:if>
                 	<td width="50%" style="font-size:15px; font-weight:bolder">
                 	<c:choose>
                 		<c:when test="${actionTotCnt ne '0' }">
                 			<div class="progress" style="height: 1.5rem;"><div class="progress-bar" style="width:${actionProgression}%" > <strong><c:out value=" ${actionProgression}"></c:out>%</strong></div></div>
                 		</c:when>
                 		<c:otherwise>
                 			<div class="progress" style="height: 1.5rem;"><div class="progress-bar" style="width:0%"> <strong><c:out value="0"></c:out>%</strong></div></div>
                 		</c:otherwise>
                 	</c:choose>
                 	</td>
                 	<td align="left" width="40%" style="font-size:1.2em; font-weight:bold"> (&nbsp;전체 : <c:out value="${actionTotCnt}"/>건&nbsp;
                 	대기 : <c:out value="${actionStCnt.actionStA1}"/>건&nbsp;
                 	조치중 : <c:out value="${actionStCnt.actionStA2}"/>건&nbsp;
                 	조치완료 : <font color="#007BFF"><c:out value="${actionStCnt.actionStA3}"/></font>건&nbsp;
                 	재요청 : <c:out value="${actionStCnt.actionStA4}"/>건 )
                 	</td>
                 </tr>        
             	</table>
             	
                <!-- <div id="page_info"><div id="page_info_align"></div></div> -->
                                    
                <div class="default_tablestyle">
              <table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
                 <caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
              
              
              <colgroup>
                    <col width="5%"/> 
                    <col width="5%"/>
                    <col width="10%"/>
                    <col width="15%"/>
                    <col width="8%"/>
                    <col width="29%"/>
                    <col width="5%"/>
                    <col width="5%"/>
                    <col width="10%"/>
                    <col width="8%"/>
           </colgroup>
        			<tr>
        			
        				<th align="center">번호</th>
        				<th align="center">결함번호</th>
        				<th align="center">화면ID</th>
        				<th align="center">화면명</th>
        				<th align="center">업무구분</th>
        				<th align="center">결함명</th>
        				<th align="center">결함유형</th>
        				<th align="center">테스터</th>
			        	<th align="center">등록일자</th>
        				<th align="center">조치상태</th>
        				
        	
        			</tr>
        			
        			<c:forEach var="result" items="${defectList}" varStatus="status">
        			
            			<tr>
            				<td align="center" class="listtd" style="font-weight:bold"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
            				<td align="center" class="listtd"><c:out value="${result.defectIdSq}"/></td>
            				<td align="center" class="listtd" title="<c:out value="${result.pgId}"/>" style="text-align:left;"><c:out value="${result.pgId}"/></td>
            				<td align="center" class="listtd" title="<c:out value="${result.pgNm}"/>" style="text-align:left;"><c:out value="${result.pgNm}"/></td>
            				<td align="center" class="listtd" title="<c:out value="${result.taskGb}"/>"><c:out value="${result.taskGb}"/></td>
            				<td align="center" class="listtd" style="text-align:left;">
            				<a href="<c:url value='/tms/defect/selectDefectInfo.do'/>?pgId=<c:out value='${result.pgId}'/>&amp;defectIdSq=<c:out value='${result.defectIdSq}'/>&amp;status=1"
                       			 title="<c:out value="${result.defectTitle}"/>">
                       			 <font color="0F438A" style="font-weight:bold"><c:out value="${result.defectTitle}"/></font>
                        	</a>
            				</td>
            				<td align="center" class="listtd" title="<c:out value="${result.defectGb}"/>"><c:out value="${result.defectGb}"/></td>
            				<td align="center" class="listtd" title="<c:out value="${result.userTestId}"/>"><c:out value="${result.userTestNm}"/></td>
            				<td align="center" class="listtd"><c:out value="${result.enrollDt}"/></td>
            			<c:choose>
            			<c:when test="${result.actionSt == '조치중' }">
                        <td align="center" class="listtd" title="<c:out value="${result.actionSt}"/>">
                        <font style="font-weight:bold"><c:out value="${result.actionSt}"/></font></td>
                        </c:when>
                        <c:when test="${result.actionSt == '재요청'}">
                        <td align="center" class="listtd" title="<c:out value="${result.actionSt}"/>" style="background-color:#CC3C39;">
                         <font color="#ffffff" style="font-weight:bold"><c:out value="${result.actionSt}"/></font></td>
                        </c:when>
                        <c:when test="${result.actionSt == '조치완료' }">
                        <td align="center" class="listtd" title="<c:out value="${result.actionSt}"/>" style="background-color:#007bff;">
                        <font color="#ffffff" style="font-weight:bold"><c:out value="${result.actionSt}"/></font></td>
                        </c:when>
                        <c:otherwise>
                        <td align="center" class="listtd" title="<c:out value="${result.actionSt}"/>"><c:out value="${result.actionSt}"/>&nbsp;</td>
                        </c:otherwise>
                        </c:choose>
            			
            			</tr>
        			</c:forEach>
               <c:if test="${fn:length(defectList) == 0}">
                     <tr>
                       <td nowrap colspan="10" ><spring:message code="common.nodata.msg" /></td>  
                     </tr>      
              </c:if>
              </table>        
              
           </div>
         <input id="TmsProgrmFileNm_sys_gb" type="hidden" /> 
         <input id="TmsProgrmFileNm_task_gb" type="hidden" /> 
         <input id="TmsProgrmFileNm_pg_nm" type="hidden" /> 
         <input id="TmsProgrmFileNm_user_dev_id" type="hidden" /> 
         <input id="TmsProgrmFileNm_user_real_id" type="hidden" /> 
         <input id="TmsProgrmFileNm_task_gb_code" type="hidden" />
         <input id="TmsProgrmFileNm_pg_full" type="hidden" />


       </form:form>
                <!-- 페이지 네비게이션 시작 -->
               <%--  <c:if test="${!empty loginPolicyVO.pageIndex }"> --%>
                    <div id="paging_div">
                        <ul class="paging_align">
                       <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_searchList" />
                        </ul>
                    </div>
                <!-- //페이지 네비게이션 끝 -->
               <%--  </c:if> --%>
       

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