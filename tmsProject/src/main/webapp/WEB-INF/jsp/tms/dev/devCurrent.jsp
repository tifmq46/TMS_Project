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

function pagePrint(){
	document.listForm.searchBySysGb.value = document.listForm.Sys.value;
    document.listForm.searchByTaskGb.value = document.listForm.task.value;
	/*  var myForm = document.listForm;
	 var url = "<c:url value='/tms/dev/devCurListPrint.do'/>";

	 window.open(url ,'printForm',"width=1000, height=600");
	 myForm.action =url; 
	 myForm.method="post";
	 myForm.target="printForm";
	 myForm.submit(); */
	 var a = $("#listForm").serializeArray();
	 var b = JSON.stringify(a);
	window.open("<c:url value='/tms/dev/devCurListPrint.do'/>?vo="+b,'','width=1000,height=600');
	//document.listForm.action = "<c:url value='/tms/dev/devCurListPrint.do'/>";
	//document.listForm.submit(); 
}

function StatsToExcel() {
	document.listForm.searchBySysGb.value = document.listForm.Sys.value;
    document.listForm.searchByTaskGb.value = document.listForm.task.value;
	document.listForm.action = "<c:url value='/tms/dev/devCurrentExcel.do'/>";
    document.listForm.submit(); 
}
</script>
<style>

input[type=date]{
	text-align: center;
}

</style>

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
                    <div id="cur_loc_align" style="font-family:'Malgun Gothic';">
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
                <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
                <!-- 검색 필드 박스 시작 -->
				<div id="search_field" style="font-family:'Malgun Gothic';">
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
                  			  <col width="17%"/> 
                  			  <col width="7%"/> 
                  			  <col width="14.4%"/> 
                  			  <col width="14.4%"/>
      			        	</colgroup>
      			        	<tr>
      			        		<td style="font-weight:bold;color:#666666;font-size:110%;">화면ID
      			        		</td>
      			        		<td>
      			        		<input type="text" name="searchByPgId" style="width:80%;text-align:center;" id="TmsProgrmFileNm_pg_id" autocomplete="off" value="<c:out value='${searchVO.searchByPgId}'/>"/>
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
      			        		<select name="task" id="task" style="width:77%;text-align-last:center;">
									   <option value="">선택하세요</option>
									   <c:forEach var="taskGb" items="${taskGb2}" varStatus="status">
									    		<option value="<c:out value="${taskGb}"/>" <c:if test="${searchVO.searchByTaskGb == taskGb}">selected="selected"</c:if> ><c:out value="${taskGb}" /></option>
									    </c:forEach>	
									</select>				
									<input type="hidden" name="searchByTaskGb" value="">
      			        		</td>
      			        		<td></td><td></td><td></td><td></td>
      			        	</tr>
      			        	<tr>
      			        		<td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">개발자
      			        		</td>
      			        		<td style="padding-top:15px;">
					  			 <input type="text" list="userAllList" autocomplete="off" name="searchByUserDevId" id="searchByUserDevId" size="18" style="width:80%;text-align:center;" value="<c:out value='${searchVO.searchByUserDevId}'/>"/>
		                          	<datalist id="userAllList">
		                          	<c:forEach var="userList" items="${userList}" varStatus="status">
										<option value="<c:out value="${userList.userNm}"/>"  style="text-align:center;"></option>
									</c:forEach>
									</datalist>
      			        		</td>
      			        		<td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">개발일자
      			        		</td>
      			        		<td colspan="3" style="padding-top:15px;">
								<input type="date" id="searchByDevStartDt" name="searchByDevStartDt" 
									value="<fmt:formatDate value="${searchVO.searchByDevStartDt}" pattern="yyyy-MM-dd"/>"/>
								<img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
					  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><font size="3px">~</font></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  			<input type="date" id="searchByDevEndDt" name="searchByDevEndDt" 
					  				value="<fmt:formatDate value="${searchVO.searchByDevEndDt}" pattern="yyyy-MM-dd"/>"/>
					  				<img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
      			        		</td>
      			        		<td colspan="3" style="padding-top:15px;">
									<div class="buttons" style="float:right;">
										<a href="#LINK" onclick="javascript:fn_searchList('1')" ><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
										<a href="#LINK" onclick="pagePrint();">인쇄</a>
										<a href="#" onclick="StatsToExcel(); return false;">엑셀 다운로드</a>
									</div>	  				  			
      			        		</td>
      			        	</tr>
      			        	</table>
					  				
						</div>			
						</fieldset>
					</form:form>
				</div>
				<!-- //검색 필드 박스 끝 -->
                <table width="100%" cellspacing="5" summary="총 건수, 달성률 표시하는 테이블">
                 <caption style="visibility:hidden">총 건수, 달성률 표시하는 테이블</caption>
                 
                 <tr>
                 <td align="right" width="100" style="font-size:1.2em; font-weight:bolder">완료율 : </td>
                 	<td style="font-size:15px; font-weight:bolder">
                 	<c:choose>
                 		<c:when test="${r.rateAvg ne null }">
                 			<div class="progress" style="height: 1.5rem; width:400px;"><div class="progress-bar" style="width:${r.rateAvg}%" > <strong><c:out value=" ${r.rateAvg}"></c:out>%</strong></div></div>
                 		</c:when>
                 		<c:otherwise>
                 			<div class="progress" style="height: 1.5rem; width:400px;"><div class="progress-bar" style="width:0%"> <strong><c:out value="0"></c:out>%</strong></div></div>
                 		</c:otherwise>
                 	</c:choose>
                 	</td>
                 	<td align="center" width="110" style="font-size:1.2em; font-weight:bolder">[ 대상본수: <c:out value="${r.cnt}"/>개</td>
                  	<td align="center" width="110" style="font-size:1.2em; font-weight:bolder">대기건수 : <c:out value="${r.s1}"/>개</td>
                  	<td align="center" width="110" style="font-size:1.2em; font-weight:bolder">진행건수 : <c:out value="${r.s2}"/>개</td>
                  	<td align="center" width="110" style="font-size:1.2em; font-weight:bolder">지연건수 : <c:out value="${r.s3}"/>개</td>
                  	<td align="center" width="110" style="font-size:1.2em; font-weight:bolder">완료건수 : <c:out value="${r.s4}"/>개]</td>
                  	
                  	
                 </tr>        
             	</table>
                
               <div id="printBox"> 
                <div class="default_tablestyle">
                <%
				 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
				 String today = formatter.format(new java.util.Date());
				
				 pageContext.setAttribute("today", today) ;
				%>
               
              <table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
                 <caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
              
              
              <colgroup>
              		<col width="15" >
        			<col width="30" >
                    <col width="40" >  
                    <col width="50" >
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
        				<th align="center">번호</th>
        				<th align="center">시스템구분</th>
        				<th align="center">업무구분</th>
        				<th align="center">화면ID</th>
        				<th align="center">화면명</th>
        				<th align="center">개발자</th>
        				<th align="center">계획시작일자</th>
        				<th align="center">계획종료일자</th>
			        	<th align="center">개발시작일자</th>
        				<th align="center">개발종료일자</th>
        				<th align="center">완료율(%)</th>
        				<th align="center">진행상태</th>
        			</tr>
        			
        			<c:forEach var="result" items="${resultList}" varStatus="status">
        			
            			<tr>
            			 	<td align="center" class="listtd"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
            				<td align="center" class="listtd" name="sys"><c:out value="${result.sysGb}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.taskGb}"/>&nbsp;</td>
            				<td align="left" class="listtd" title="<c:out value="${result.pgId}"/>"><c:out value="${result.pgId}"/></td>
            				<td align="left" class="listtd" style="padding-left:5px;" title="<c:out value="${result.pgNm}"/>"><c:out value="${result.pgNm}"/>&nbsp;</td>
            				<td align="center" class="listtd" title="<c:out value="${result.userDevId}"/>"><c:out value="${result.userDevNm}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.planStartDt}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.planEndDt}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.devStartDt}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.devEndDt}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.achievementRate}"/>%&nbsp;</td>
            				<c:choose>
            					<c:when test="${result.st eq '완료'}">
            					<td align="center" class="listtd" style="background-color:#007bff;"><font color="#ffffff" style="font-weight:bold"><c:out value="${result.st}"/></font></td>
            					</c:when>
            					<c:when test="${result.st eq '지연'}">
            					<td align="center" class="listtd" style="background-color:#CC3C39;"><font color="#ffffff" style="font-weight:bold"><c:out value="${result.st}"/></font></td>
            					</c:when>
            					<c:when test="${result.st eq '진행'}">
            					<td align="center" class="listtd" style="background-color:#3ADF00;"><font color="#ffffff" style="font-weight:bold"><c:out value="${result.st}"/></font></td>
            					</c:when>
            					<c:when test="${result.st eq '대기'}">
            					<td align="center" class="listtd"><c:out value="${result.st}"/></td>
            					</c:when>
            				</c:choose>
            			</tr>
        			</c:forEach>
             	<c:if test="${fn:length(resultList) == 0}">
                      <tr>
                        <td nowrap colspan="11" ><spring:message code="common.nodata.msg" /></td>  
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
		         <input id="TmsProgrmFileNm_task_gb_code" type="hidden" />
         		 <input id="TmsProgrmFileNm_pg_full" type="hidden" /> 

                <!-- 페이지 네비게이션 시작 -->
                <%-- <c:if test="${!empty loginPolicyVO.pageIndex }"> --%>
                    <div id="paging_div">
                        <ul class="paging_align">
                       <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_searchList" />
                        </ul>
                    </div>
                <!-- //페이지 네비게이션 끝 -->
                <%-- </c:if> --%>



 		

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