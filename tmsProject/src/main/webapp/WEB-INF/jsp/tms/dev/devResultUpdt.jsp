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
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<%-- <validator:javascript formName="devPlanVo" staticJavascript="false" xhtml="true" cdata="false"/> --%>
<script type="text/javascript">

function fn_result_regist() {
    
    form = document.devPlanVO;
    form.action = "<c:url value='/tms/dev/updateDevResult.do'/>";
    form.submit();
}



function fn_result_update() {
    var varFrom = document.getElementById("devPlanVO");
    varFrom.action = "<c:url value='/tms/dev/updateDevResult.do'/>";

    if(confirm("수정 하시겠습니까?")){
        //if(!validateAuthorManage(varFrom)){           
            //return;
        //}else{
            varFrom.submit();
        //} 
    }
}


function fn_result_delete() {
    var varFrom = document.getElementById("devPlanVO");
    varFrom.action = "<c:url value='/tms/dev/deleteDevResult.do'/>";
    if(confirm("삭제 하시겠습니까?")){
        varFrom.submit();
    }
}
	
</script>
<title>계발계획 등록</title>

<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


</head>
<body >
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
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>개발계획 수정</strong></h2></div>
                </div>
                <form:form commandName="devPlanVO" name="devPlanVO" method="post" >
                    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
                    <%-- <input name="pgId" type="hidden" value='<c:out value="${DevPlanDefaultVO.pgId}"/>' /> --%>

                    <div class="modify_user" >
                        <table >
                          <tr> 
                             <%-- <th width="20%" height="23" class="required_text" nowrap >
                                <label >시스템구분</label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            
                            <td>
                            <select name="searchBySysGb" id="searchBySysGb" onchange="fn_egov_selectSysType(this)">
									    <option value="0" selected="selected">전체</option>
									    <c:forEach var="resultS" items="${resultS}" varStatus="status">
                                    		<option value='<c:out value="${resultS.code}"/>'><c:out value="${resultS.codeNm}"/></option>
                                		</c:forEach>    
									</select>	
                            </td>
                            <th width="20%" height="23" class="required_text" nowrap >
                                <label>업무구분</label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td width="30%">
                            	<select name="searchByTaskGb" id="searchByTaskGb" >
									<option value="0" selected="selected">전체</option>
									   <c:forEach var="resultT" items="${resultT}" varStatus="status">
                                    		<option value='<c:out value="${resultT.code}"/>'><c:out value="${resultT.codeNm}"/></option>
                                		</c:forEach>
								</select>
									&nbsp;&nbsp;&nbsp;<span id="sometext"></span>
                            </td> --%>
                          </tr>
                          
                           <tr> 
                            <th width="20%" height="23" class="required_text" >
                                <label for="pgId">화면명</label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                             <td width="30%" nowrap colspan="3">
                             
                              <input name="pgId" type="text" size="60" value='<c:out value="${DevPlanDefaultVO.pgId}"/>' 
                              	maxlength="60"  id="pgId"  title="시스템구분">
                              
                              <br/><form:errors path="pgId" /> 
                            
                             <%-- <form:input path="pdId" /> --%>
                              <%-- <form:hidden path="pdId"  />
                             &nbsp;<a href="#LINK" style="selector-dummy: expression(this.hideFocus=false);">
                             <img src="<c:url value='/images/img_search.gif' />"
                                        width="15" height="15" align="middle" alt="새창" /></a>
                             <br/><form:errors path="pdId" /> --%>
                             
                             
                            </td> 
                          </tr>
                         
                          <tr> 
                            <th width="20%" class="required_text" nowrap >
                                <label> 계획시작일자</label>
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td>
                            
                            <input type="date" name="planStartDt" id="planStartDt" value="<fmt:formatDate value="${DevPlanDefaultVO.planStartDt}" pattern="yyyy-MM-dd" />"/>
                            <img src="images/calendar.gif"  width="19" height="19" alt="" />
                            </td>
                            <th width="20%" height="23" class="required_text" nowrap >
                                <label> 계획종료일자</label>
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td>
                            <input type="date" name="planEndDt" id="planEndDt" value="<fmt:formatDate value="${DevPlanDefaultVO.planEndDt}" pattern="yyyy-MM-dd" />"/>
                            <img src="images/calendar.gif" width="19" height="19" alt="" />
                            </td>
                            
                          </tr>  
                          
                          <tr> 
                            <th width="20%" class="required_text" nowrap >
                                <label> 개발시작일자</label>
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td>
                            
                            <input type="date" name="devStartDt" id="devStartDt" value="<fmt:formatDate value="${DevPlanDefaultVO.devStartDt}" pattern="yyyy-MM-dd" />"/>
                            <img src="images/calendar.gif"  width="19" height="19" alt="" />
                            </td>
                            <th width="20%" height="23" class="required_text" nowrap >
                                <label> 개발종료일자</label>
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td>
                            <input type="date" name="devEndDt" id="devEndDt" value="<fmt:formatDate value="${DevPlanDefaultVO.devEndDt}" pattern="yyyy-MM-dd" />"/>
                            <img src="images/calendar.gif" width="19" height="19" alt="" />
                            </td>
                            
                          </tr>  
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                     <table border="0" cellspacing="0" cellpadding="0" align="center">
                     <tr> 
	                    <c:choose>
	                    	<c:when test="${empty DevPlanDefaultVO.devStartDt }">
	                    	 <td>
                              <a href="#LINK" onclick="fn_result_regist();" style="selector-dummy:expression(this.hideFocus=false);">저장</a> 
                          	</td>
	                    	<td>
                              <a href="<c:url value='/tms/dev/devResultList.do'/>"  >목록</a>
                          	</td> 
	                    	</c:when>
	                    	
	                    	<c:otherwise>
	                    	<td>
                              <a href="#LINK" onclick="fn_result_update();" style="selector-dummy:expression(this.hideFocus=false);">수정</a> 
                          	</td>
                          	<td>
                              <a href="#LINK" onclick="fn_result_delete();" style="selector-dummy:expression(this.hideFocus=false);">삭제</a> 
                            </td>
	                    	<td>
                              <a href="<c:url value='/tms/dev/devResultList.do'/>"  >목록</a>
                          	</td>
	                    	</c:otherwise>
	                    </c:choose>
                    
                    </tr>
                    </table>
                    </div>
                                         
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

