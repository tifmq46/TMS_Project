<%@ page import="egovframework.com.cmm.LoginVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*, java.text.*"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >

<title>개발결과관리</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>

<script type="text/javaScript" language="javascript">

function linkPage1(pageNo){
	   document.listForm.pageIndex.value = pageNo;
	   document.listForm.action = "<c:url value='/tms/dev/devCurrent.do'/>";
	   document.listForm.submit();
	}

function fn_result_change(asd) {
	var idVal3 = document.getElementById(asd+3).id;
	$("#"+idVal3).removeClass("disabled");
	$("#"+idVal3).addClass("abled");
}



function fn_searchList(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.searchBySysGb.value = document.listForm.Sys.value;
    document.listForm.searchByTaskGb.value = document.listForm.task.value;
    document.listForm.action = "<c:url value='/tms/dev/devCurrent.do'/>";
    document.listForm.submit();
}

$(function(){
	
	$('#Sys').change(function() {
	      $.ajax({
	         
	         type:"POST",
	         url: "<c:url value='/sym/prm/TaskGbSearch.do'/>",
	         data : {searchData : this.value},
	         async: false,
	         dataType : "json",
	         success : function(selectTaskGbSearch){
	            $("#task").find("option").remove().end().append("<option value=''>선택하세요</option>");
	            $.each(selectTaskGbSearch, function(i){
	               (JSON.stringify(selectTaskGbSearch[0])).replace(/"/g, "");
	            $("#task").append("<option value='"+JSON.stringify(selectTaskGbSearch[i]).replace(/"/g, "")+"'>"+JSON.stringify(selectTaskGbSearch[i]).replace(/"/g, "")+"</option>")
	            });
	            
	         },
	         error : function(request,status,error){
	            alert("에러");
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

	         }
	      });
	   })
	})
	
	function searchFileNm() {
    window.open("<c:url value='/sym/prm/TmsProgramListSearch.do'/>",'','width=800,height=600');
}

var initBody;
function beforePrint(){
	initBody = document.body.innerHTML;
	document.body.innerHTML = printBox.innerHTML;
}
function afterPrint(){
	document.body.innerHTML = initBody;
}
function pagePrint(){
	window.onbeforeprint = beforePrint;
	window.onafterprint = afterPrint;
	window.print();
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
							<li>개발진척관리</li>
							<li>&gt;</li>
							<li><strong>개발진척현황</strong></li>
                        </ul>
                    </div>
                </div>
        
             <form:form commandName="searchVO" name="listForm" id="listForm" method="post" action="tms/dev/devPlanList.do">   
                <input type="hidden" name="pageIndex" value="<c:out value='${devPlanVO.pageIndex}'/>"/>
                <!-- 검색 필드 박스 시작 -->
				<div id="search_field">
					<div id="search_field_loc"><h2><strong>개발진척현황</strong></h2></div>
					<%-- <form action="form_action.jsp" method="post"> --%>
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
      			        		<input type="text" name="searchByPgId" style="width:80%;text-align:center;" id="TmsProgrmFileNm_pg_id" value="<c:out value='${searchVO.searchByPgId}'/>"/>
					  			<a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
                      			<img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a>
      			        		</td>
      			        		<td style="font-weight:bold;color:#666666;font-size:110%;">시스템구분
      			        		</td>
      			        		<td>
      			        		<select name="Sys" id="Sys" style="width:90%;text-align-last:center;">
									   <option value="" >전체</option>
									      <c:forEach var="sysGb" items="${sysGb}" varStatus="status">
									    	<option value="<c:out value="${sysGb}"/>" <c:if test="${searchVO.searchBySysGb == sysGb}">selected="selected"</c:if> ><c:out value="${sysGb}" /></option>
									      </c:forEach>
									</select>
									<input type="hidden" name="searchBySysGb" value="">
      			        		</td>
      			        		<td style="font-weight:bold;color:#666666;font-size:110%;">업무구분
      			        		</td>
      			        		<td>
      			        		<select name="task" id="task" style="width:90%;text-align-last:center;">
									   <option value="">선택하세요</option>
									   <c:forEach var="taskGb" items="${taskGb2}" varStatus="status">
									    		<option value="<c:out value="${taskGb}"/>" <c:if test="${searchVO.searchByTaskGb == taskGb}">selected="selected"</c:if> ><c:out value="${taskGb}" /></option>
									    </c:forEach>	
									</select>				
									<input type="hidden" name="searchByTaskGb" value="">
      			        		</td>
      			        		<td>
      			        		</td>
      			        		<td>
      			        		</td>
      			        		<td>
      			        		</td>
      			        		<td>
      			        		</td>
      			        	</tr>
      			        	<tr>
      			        		<td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">개발자
      			        		</td>
      			        		<td style="padding-top:15px;">
					  			 <input type="text" list="userAllList" name="searchByUserDevId" id="searchByUserDevId" size="18" style="width:80%;text-align:center;" value="<c:out value='${searchVO.searchByUserDevId}'/>"/>
		                          	<datalist id="userAllList">
		                          	<c:forEach var="userList" items="${userList}" varStatus="status">
										<option value="<c:out value="${userList.userNm}"/>"  style="text-align:center;"></option>
									</c:forEach>
									</datalist>
      			        		</td>
      			        		<td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">계획일자
      			        		</td>
      			        		<td colspan="3" style="padding-top:15px;">
								<input type="date" id="searchByPlanStartDt" name="searchByPlanStartDt" 
									value="<fmt:formatDate value="${searchVO.searchByPlanStartDt}" pattern="yyyy-MM-dd"/>"/>
								<img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
					  			&nbsp;~&nbsp;
					  			<input type="date" id="searchByPlanEndDt" name="searchByPlanEndDt" 
					  				value="<fmt:formatDate value="${searchVO.searchByPlanEndDt}" pattern="yyyy-MM-dd"/>"/>
					  				<img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
      			        		</td>
      			        		<td>
      			        		</td>
      			        		<td>
      			        		</td>
      			        		<td style="padding-top:15px;">
									<div class="buttons" style="float:right;">
										<a href="#LINK" onclick="javascript:fn_searchList('1')" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
										<a href="#LINK" onclick="pagePrint()" style="selector-dummy:expression(this.hideFocus=false);">인쇄</a>
									</div>	  				  			
      			        		</td>
      			        	</tr>
      			        	</table>
					  				
						</div>			
						</fieldset>
					<%-- </form> --%>
				</div>
				<!-- //검색 필드 박스 끝 -->
 			

                <div id="page_info"><div id="page_info_align"></div></div>                    
                <div class="default_tablestyle">
                
                <div style="margin:10px;">
	               	<strong>
	                	총 : ${r.cnt}&nbsp;
	                	달성률 : ${r.rateAvg}
	                </strong>
                </div>
                
                <%

				 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
				 String today = formatter.format(new java.util.Date());
				
				 pageContext.setAttribute("today", today) ;
				%>
               <div id="printBox">
              <table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
                 <caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
              
              
              <colgroup>
        			<col width="40" >
                    <col width="40" >  
                    <col width="80" >
                    <col width="100" >
                    <col width="40" >
                    <col width="50" >
                    <col width="50" >
                    <col width="50" >
                    <col width="50" >
                    <col width="30" >
                    <col width="40" >
        			</colgroup>
        			
        			<tr>
        				<th align="center">시스템구분</th>
        				<th align="center">업무구분</th>
        				<th align="center">화면ID</th>
        				<th align="center">화면명</th>
        				<th align="center">개발자</th>
        				<th align="center">계획시작일자</th>
        				<th align="center">계획종료일자</th>
			        	<th align="center">개발시작일자</th>
        				<th align="center">개발종료일자</th>
        				<th align="center">달성률(%)</th>
        				<th align="center">진행상태</th>
        			</tr>
        			
        			<c:forEach var="result" items="${resultList}" varStatus="status">
        			
            			<tr>
            				<td align="center" class="listtd" name="sys"><c:out value="${result.SYS_GB}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.TASK_GB}"/>&nbsp;</td>
            				<td align="center" class="listtd">
            					<%-- <a href="<c:url value='/tms/dev/selectDevResult.do'/>?pgId=<c:out value='${result.pgId}'/>"> --%>
                                <c:out value="${result.PG_ID}"/><!-- </a> -->
                                <input type="hidden" id="pgId" name="pgId" value='<c:out value="${result.PG_ID}"/>' >
                            </td>
            				<td align="left" class="listtd"><c:out value="${result.PG_NM}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.USER_DEV_ID}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.PLAN_START_DT}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.PLAN_END_DT}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.DEV_START_DT}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.DEV_END_DT}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.ACHIEVEMENT_RATE}"/>%&nbsp;</td>
            				
            				<c:choose>
	            				<c:when test="${result.ACHIEVEMENT_RATE eq 100 }">
	            					<c:set var="status" value="완료"></c:set>
	            				</c:when>
	            				<c:otherwise>
	            					<c:choose>
	            						<c:when test="${result.PLAN_END_DT lt today }">
	            							<c:choose>
		            							<c:when test="${result.DEV_START_DT eq null }">
		            								<c:set var="status" value="지연"></c:set>
		            							</c:when>
		            							<c:otherwise>
		            								<c:choose>
		            									<c:when test="${result.PLAN_END_DT lt result.DEV_START_DT}">
		            										<c:set var="status" value="지연"></c:set>
		            									</c:when>
		            									<c:otherwise>
		            										<c:set var="status" value="진행"></c:set>
		            									</c:otherwise>
		            								</c:choose>
		            							</c:otherwise>
	            							</c:choose>
	            						</c:when>
	            						
	            						<c:otherwise>
	            							<c:if test="${result.DEV_START_DT ne null }">
	            								<c:set var="status" value="진행"></c:set>
	            							</c:if>
	            							<c:if test="${result.DEV_START_DT eq null }">
	            								<c:set var="status" value="대기"></c:set>
	            							</c:if>
	            						</c:otherwise>
	            					</c:choose>
	            					
	            				</c:otherwise>
            				</c:choose>
            				
            				<c:choose>
            					<c:when test="${status eq '완료'}">
            						<td align="center" class="listtd" style="background-color:#819FF7;">
            						<font color="#ffffff" style="font-weight:bold">
            						<c:out value="${status}"/></td>
            					</c:when>
            					<c:when test="${status eq '지연'}">
            						<td align="center" class="listtd" style="background-color:#F78181;">
            						<font color="#ffffff" style="font-weight:bold">
            						<c:out value="${status}"/></td>
            					</c:when>
            					<c:when test="${status eq '진행'}">
            						<td align="center" class="listtd" style="background-color:#BEF781;">
            						<font style="font-weight:bold">
            						<c:out value="${status}"/></td>
            					</c:when>
            					<c:when test="${status eq '대기'}">
            						<td align="center" class="listtd" >
            						<c:out value="${status}"/></td>
            					</c:when>
            				</c:choose>
            				
            			</tr>
        			</c:forEach>
             	<c:if test="${fn:length(resultList) == 0}">
                      <tr>
                        <td nowrap colspan="5" ><spring:message code="common.nodata.msg" /></td>  
                      </tr>      
                     </c:if>
              </table>        
              </div>
           </div>
           
           		 <input id="TmsProgrmFileNm_sys_gb" type="hidden" /> 
		         <input id="TmsProgrmFileNm_task_gb" type="hidden" /> 
		         <input id="TmsProgrmFileNm_pg_nm" type="hidden" /> 
		         <input id="TmsProgrmFileNm_user_dev_id" type="hidden" /> 
		         <input id="TmsProgrmFileNm_user_real_id" type="hidden" /> 

                <!-- 페이지 네비게이션 시작 -->
                <%-- <c:if test="${!empty loginPolicyVO.pageIndex }"> --%>
                    <div id="paging_div">
                        <ul class="paging_align">
                       <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_searchList" />
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