<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/sym/mpm/icon/";
  String imagePath_button = "/images/egovframework/sym/mpm/button/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link href="<c:url value='/'/>css/popup.css" rel="stylesheet" type="text/css" >
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >
<title>개발진척현황 인쇄페이지</title>
<style type="text/css">
   h1 {font-size:12px;}
   caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
   

</style>
<script language="javascript1.2"  type="text/javaScript"> 
var initBody;
function beforePrint(){
	initBody = document.body.innerHTML;
	document.body.innerHTML = printBox.innerHTML;
}
function afterPrint(){
	document.body.innerHTML = initBody;
}
function pagePrint(){
	//window.open("<c:url value='/tms/dev/devCurListPrint.do'/>",'','width=1000,height=600');
	window.onbeforeprint = beforePrint;
	window.onafterprint = afterPrint;
	window.print();
}
</script>
</head>
<body> 
     <div id="search_field" style="width:100%">
       <div id="search_field_loc" class="h_title">인쇄 페이지
       <div class="buttons" style="float:right;">
                <a href="#LINK" onclick="pagePrint()">인쇄 </a>
           </div>
       
       </div>

           
    </div>
    <div id="page_info"><div id="page_info_align"></div></div>                    
    <!-- table add start -->
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
        				<th align="center">달성률(%)</th>
        				<th align="center">진행상태</th>
        			</tr>
        			
        			<c:forEach var="result" items="${resultList}" varStatus="status">
        			
            			<tr>
            			 	<td align="center" class="listtd"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
            				<td align="center" class="listtd" name="sys"><c:out value="${result.SYS_GB}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.TASK_GB}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.PG_ID}"/></td>
            				<td align="left" class="listtd"><c:out value="${result.PG_NM}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.USER_DEV_NM}"/>&nbsp;</td>
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
            						<td align="center" class="listtd" style="background-color:#007bff;">
            						<font color="#ffffff" style="font-weight:bold">
            						<c:out value="${status}"/></td>
            					</c:when>
            					<c:when test="${status eq '지연'}">
            						<td align="center" class="listtd" style="background-color:#CC3C39;;">
            						<font color="#ffffff" style="font-weight:bold">
            						<c:out value="${status}"/></td>
            					</c:when>
            					<c:when test="${status eq '진행'}">
            						<td align="center" class="listtd" style="background-color:#3ADF00;">
            						<font color="#ffffff" style="font-weight:bold">
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
                        <td nowrap colspan="11" ><spring:message code="common.nodata.msg" /></td>  
                      </tr>      
                     </c:if>
              </table>        
              </div>
              </div>
    
</body>
</html>
