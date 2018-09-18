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
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css" >

<script type="text/javascript">
   
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
            <div id="content">
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
     
              
             <form:form commandName="searchVO" name="listForm" method="post" action="tms/defect/defectList.do">   
                
              <!-- 검색 필드 박스 시작 -->
				<div id="search_field">
					<div id="search_field_loc"><h2><strong>결함관리</strong></h2></div>
					
					<form action="form_action.jsp" method="post">
					  	<fieldset><legend>조건정보 영역</legend>	  
					  	<div class="sf_start">
					  		<ul id="search_first_ul">
					  			<li><label for="searchByPgId">화면ID</label></li>
					  			<li>
					  			<input id="TmsProgrmFileNm_pg_id" name="searchByPgId" type="text" size="10" value="" style="text-align:center;" maxlength="40" title="화면ID"/> 
					          <a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
	                	<img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a>
					  			</li>
					  			<li>
								    <label for="searchByTaskGb">업무구분&nbsp;</label>
									<select name="searchByTaskGb" id="searchByTaskGb" style="width:12%;text-align-last:center;">
									    <option value="" selected="selected" >전체</option>
									    <c:forEach var="taskGb" items="${taskGb}" varStatus="status">
									    	<option value="<c:out value="${taskGb.codeNm}"/>"><c:out value="${taskGb.codeNm}" /></option>
									    </c:forEach>
									</select>						
					  			</li> 			
					  			<li>
								    <label for="searchByDefectGb">결함유형구분</label>
									<select name="searchByDefectGb" id="searchByDefectGb" style="width:10%;text-align-last:center;">
									    <option value="" selected="selected">전체</option>
									    <c:forEach var="defectGb" items="${defectGb}" varStatus="status">
									    	<option value="<c:out value="${defectGb.codeNm}"/>"><c:out value="${defectGb.codeNm}" /></option>
									    </c:forEach>
									</select>						
					  			</li>
					  			
					  			<li>
								    <label for="searchByActionSt">조치상태구분</label>
									<select name="searchByActionSt" id="searchByActionSt" style="width:10%;text-align-last:center;">
									    <option value="" selected="selected">전체</option>
									    <c:forEach var="actionSt" items="${actionSt}" varStatus="status">
									    	<option value="<c:out value="${actionSt.codeNm}"/>"><c:out value="${actionSt.codeNm}" /></option>
									    </c:forEach>
									</select>						
					  			</li>
					  			
					  		</ul>
					  		
					  		<ul id="search_second_ul">
								<li><label for="searchByUserTestId">테스터명</label>&nbsp;&nbsp;</li>
								<li><input type="text" name="searchByUserTestId" id="searchByUserTestId" size="10" style="text-align:center;"/></li>
					  			<li><label for="searchByUserDevId">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;개발자명</label>&nbsp;</li>
					  			<li><input type="text" name="searchByUserDevId" id="searchByUserDevId" size="13" style="text-align:center;"/>&nbsp;</li>
					  			<li>
					  			<label>&nbsp;&nbsp;등록일자</label>
								<input type="date" name="searchByStartDt" size="15" style="text-align:center;"/><img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
					  			~<input type="date" name="searchByEndDt" size="15" style="text-align:center;"/><img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
					  			</li>
					  		</ul>
					  		<br/>
					  		<ul id="search_third_ul">
					  			<li>
									<div class="buttons" style="float:right;">
									 <a href="#LINK" onclick="javascript:fn_searchList('1')" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
									    <a href="<c:url value='/tms/defect/insertDefect.do'/>">등록</a>
									</div>	  				  			
					  			</li>
					  			
					  		</ul>			
						</div>			
						</fieldset>
					</form>
				</div>
				<!-- //검색 필드 박스 끝 -->
                
                
                <table width="80% border="0" cellpadding="0" cellspacing="10" summary="총 건수, 완료건수, 미완료, 진행률 표시하는 테이블">
                 <caption style="visibility:hidden">총 건수, 완료건수, 미완료, 진행률 표시하는 테이블</caption>
                 
                 <tr>
                 	<td align="center">총 : <c:out value="${actionTotCnt}"/> </td>
                 	<td align="center"></td>
                 	<td align="center">완료 : <c:out value="${actionComplete}"/></td>
                 	<td align="center"></td>
                 	<td align="center">미완료 : <c:out value="${actionTotCnt - actionComplete}"/></td>
                 	<td align="center"></td>
                 	<fmt:parseNumber var="actionProgression" integerOnly="true" value="${actionComplete / actionTotCnt * 100}"/>
                 	<%-- ${actionProgression}% --%>
                 	<td align="center">진행률 : <div class="progress"><div class="progress-bar" style="width:${actionProgression}%"> <strong><c:out value=" ${actionProgression}"></c:out>%</strong></div></div>
                 	</td>
                 	<td align="center"></td>
                 	
                 </tr>        
             	</table>

                <div id="page_info"><div id="page_info_align"></div></div>                    
                <div class="default_tablestyle">
              <table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
                 <caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
              
              
              <colgroup>
        				<col width="5%"/> 
        				<col width="10%"/>
        				<col width="10%"/>
        				<col width="10%"/>
        				<col width="15%"/>
        				<col width="10%"/>
        				<col width="10%"/>
        				<col width="10%"/>
        				<col width="10%"/>
        				<col width="10%"/>
        	</colgroup>
        			<tr>
        			
        				<th align="center">No</th>
        				<th align="center">업무구분</th>
        				<th align="center">화면ID</th>
        				<th align="center">화면명</th>
        				<th align="center">제목</th>
        				<th align="center">결함유형</th>
        				<th align="center">테스터</th>
			        	<th align="center">등록일자</th>
        				<th align="center">조치율</th>
        				<th align="center">조치상태</th>
        				
        	
        			</tr>
        			
        			<c:forEach var="result" items="${defectList}" varStatus="status">
        			
            			<tr>
            				<td align="center" class="listtd"><c:out value="${result.defectIdSq}"/></td>
            				<td align="center" class="listtd"><c:out value="${result.taskGb}"/></td>
            				<td align="center" class="listtd"><c:out value="${result.pgId}"/></td>
            				<td align="center" class="listtd"><c:out value="${result.pgNm}"/></td>
            				<td align="center" class="listtd"><c:out value="${result.defectTitle}"/></td>
            				<td align="center" class="listtd"><c:out value="${result.defectGb}"/></td>
            				<td align="center" class="listtd"><c:out value="${result.userTestId}"/></td>
            				<td align="center" class="listtd"><c:out value="${result.enrollDt}"/></td>
            				<!-- 조치상태에 따른 조치율 -->
            				<c:choose>
	            				<c:when test="${result.actionSt eq '대기'}">
	            					<td align="center" class="listtd">0%</td>
	           					</c:when>
	            				<c:when test="${result.actionSt eq '조치중'}">
	            					<td align="center" class="listtd">25%</td>
	           					</c:when>
	           					<c:when test="${result.actionSt eq '조치완료'}">
	            					<td align="center" class="listtd">50%</td>
	           					</c:when>
	           					<c:when test="${result.actionSt eq '재요청'}">
	            					<td align="center" class="listtd">75%</td>
	           					</c:when>
	           					<c:otherwise>
	            					<td align="center" class="listtd">100%</td>
	            				</c:otherwise>
            				</c:choose>
            				
            				<td align="center" class="listtd"><c:out value="${result.actionSt}"/>&nbsp;</td>
            			
            			</tr>
        			</c:forEach>
              
              </table>        
              
           </div>
<input id="TmsProgrmFileNm_sys_gb" type="hidden" /> 
			<input id="TmsProgrmFileNm_task_gb" type="hidden" /> 
			<input id="TmsProgrmFileNm_pg_nm" type="hidden" /> 
			<input id="TmsProgrmFileNm_user_dev_id" type="hidden" /> 
                <!-- 페이지 네비게이션 시작 -->
                <%-- <c:if test="${!empty loginPolicyVO.pageIndex }"> --%>
                    <div id="paging_div">
                        <ul class="paging_align">
                       <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
                        </ul>
                    </div>
                <!-- //페이지 네비게이션 끝 -->
                <%-- </c:if> --%>



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