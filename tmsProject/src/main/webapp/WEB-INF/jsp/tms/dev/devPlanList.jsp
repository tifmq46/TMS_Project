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
<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="egovframework.com.cmm.LoginVO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript">

function fn_result_change(asd, t) {
      
      var idVal0 = document.getElementById(asd).value;
      var idVal1 = document.getElementById(asd+1).value;
      var prjStartDate = document.getElementById("ps").value;
      var prjEndDate = document.getElementById("pe").value;

     var cngDate = t.value;
        
      if((prjStartDate >  t.value || prjEndDate <  t.value) && t.value != ""){
         alert("유효하지 않은 날짜입니다. 다시 입력하십시오.");
         document.getElementById(t.id).value = null;
         return;
      } 
      
      if(idVal1 != null && idVal1 != "")
         {
            if(idVal0 > idVal1)
               {
                  alert("계획시작일자보다 큰 값을 입력하시오.");
                  document.getElementById(asd+1).value = null;
               }
         }
      if((idVal0 == null || idVal0 == "") && t.id == asd+1)
         {
            alert("계획시작일자부터 입력하십시오.")
            document.getElementById(asd+1).value = null;
         }
      var idVal3 = document.getElementById(asd+3).id;
      $("#"+idVal3).removeClass("disabled");
      $("#"+idVal3).addClass("abled");
      
      
   }

function fn_result_regist(t){
	
   var idVal = document.getElementById(t).value;
   var idVal1 = document.getElementById(t+1).value;
   
   if(idVal == ""){
      alert("계획시작일자를 입력하십시오.");
      return;
   }else if(idVal1 == null || idVal1 == ""){
      alert("계획종료일자를 입력하십시오."); 
      return;
   }else{
      location.href ="<c:url value='/tms/dev/updateDevPlan.do'/>?pgId="+t+"&planStartDt="+idVal+"&planEndDt="+idVal1+"&page="+document.listForm.page.value;
   }
   /* 
   if(){
      alert("계획종료일자를 입력하십시오."); 
      return;
   }else{
      location.href ="<c:url value='/tms/dev/updateDevPlan.do'/>?pgId="+t+"&planStartDt="+idVal+"&planEndDt="+idVal1;
   } */   
         
}

function fn_result_reset(pgId){
   
   var startDate = document.getElementById(pgId).value;
   var endDate = document.getElementById(pgId+1).value;
   var bnt = document.getElementById(pgId+3).id;
   
   if(startDate != "" && endDate != ""){
      document.getElementById(pgId).value = "";
      document.getElementById(pgId+1).value = "";
      
      location.href ="<c:url value='/tms/dev/deleteDevPlan.do'/>?pgId="+pgId+"&page="+document.listForm.page.value;
   }
}

function fn_egov_insert_addDevPlan(){    
    document.frm.action = "<c:url value='/tms/dev/addDevPlan.do'/>";
    document.frm.submit();
}

function linkPage1(pageNo){
   
      document.listForm.pageIndex.value = pageNo;
      document.listForm.action = "<c:url value='/tms/dev/devPlans.do'/>";
      document.listForm.submit();
   }

function fn_searchList(pageNo){
	alert(pageNo);
    document.listForm.pageIndex.value = pageNo;
    document.listForm.searchBySysGb.value = document.listForm.Sys.value;
    document.listForm.searchByTaskGb.value = document.listForm.task.value;
    document.listForm.action = "<c:url value='/tms/dev/devPlans.do'/>";
    document.listForm.submit();
}

function fn_input_result(pageNo) {
   
   document.listForm.pageIndex.value = pageNo;
   document.listForm.searchBySysGb.value = document.listForm.Sys.value;
    document.listForm.searchByTaskGb.value = document.listForm.task.value;
    
   document.listForm.s1.value = ""+document.listForm.InputStartDt.value;
   document.listForm.s2.value = ""+document.listForm.InputEndDt.value;
   
   var s1 = ""+document.listForm.InputStartDt.value;
   var s2 = ""+document.listForm.InputEndDt.value;
   
   
   document.listForm.action = "<c:url value='/tms/dev/inputDevPlan.do?s1="+document.listForm.s1.value+"&s2="+s2+"'/>";
    document.listForm.submit();
}

function fn_date(date){
   var myDate = new Date(document.listForm.del.value);
   
   var ddDate = new Date(date);

   return true;
   
   alert(""+myDate);
   alert(""+ddDate);
   
   if(myDate < ddDate) {
      
      return true;
   }else {
      return false;
   }
   
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
</script>

<style>



.disabled {
       pointer-events:none;
       opacity:0.5;
}
</style>

<title>개발계획관리</title>
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
                            <li><strong>개발계획관리</strong></li>
                        </ul>
                    </div>
                </div>
 
                <!-- 검색 필드 박스 시작 -->
                <form:form commandName="searchVO" name="listForm" id="listForm" method="post" action="<c:url value='/tms/dev/devPlanList.do'/>" >   
             
                <input type="hidden" name="pageIndex" value="<c:out value='${devPlanVO.pageIndex}'/>"/>
                <input type="hidden" id="s1" name="s1" />
                <input type="hidden" id="s2" name="s2" />
            
            	<input type="hidden" id="page" name="page" value="${page}"/>
            
            <div id="search_field">
               <div id="search_field_loc"><h2><strong>개발계획관리</strong></h2></div>
                    <fieldset><legend>조건정보 영역</legend>     
                    <div class="sf_start">
                       
                          
                       <ul id="search_first_ul">
                          <li>
                            <label >시스템구분</label>
                           <select name="Sys" id="Sys" style="width:12%;text-align-last:center;">
                              <option value="" >전체</option>
                                 <c:forEach var="sysGb" items="${sysGb}" varStatus="status">
                                  <option value="<c:out value="${sysGb}"/>" <c:if test="${searchVO.searchBySysGb == sysGb}">selected="selected"</c:if> ><c:out value="${sysGb}" /></option>
                                 </c:forEach>
                           </select>
                           <input type="hidden" name="searchBySysGb" value="">
                          </li>
                          <li>
                            <label for="searchByTaskGb">업무구분</label>
                           <select name="task" id="task" style="width:15%;text-align-last:center;">
                              <option value="">선택하세요</option>
                              <c:forEach var="taskGb" items="${taskGb2}" varStatus="status">
                                     <option value="<c:out value="${taskGb}"/>" <c:if test="${searchVO.searchByTaskGb == taskGb}">selected="selected"</c:if> ><c:out value="${taskGb}" /></option>
                               </c:forEach>   
                           </select>            
                           <input type="hidden" name="searchByTaskGb" value="">
                          </li>
                          
                          <li><label for="searchByUserDevId">개발자명</label></li>
                          <% LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
                                pageContext.setAttribute("loginNm", loginVO.getName()) ;
                             if(loginVO.getName().equals("관리자")){   
                          %>
                           <li><input type="text" list="userAllList" name="searchByUserDevId" id="searchByUserDevId" size="18" style="text-align:center;" value="<c:out value='${searchVO.searchByUserDevId}'/>"/>
                                   <datalist id="userAllList">
                                   <c:forEach var="userList" items="${userList}" varStatus="status">
                              <option value="<c:out value="${userList.userNm}"/>"  style="text-align:center;"></option>
                           </c:forEach>
                           </datalist>
                                </li>
                                <%}else{%>
                                <li>
                                <input type="text" name="searchByUserDevId" id="searchByUserDevId" size="18" style="text-align:center;" value="${loginNm}" readOnly/>
                                   
                                </li>
                                <%}%>
                       </ul>
                       <ul id="search_second_ul">
                          <li><label for="searchByPgId">화면ID</label></li>
                          <li><input type="text" name="searchByPgId" id="TmsProgrmFileNm_pg_id" value="<c:out value='${searchVO.searchByPgId}'/>"/>
                          <a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
                               <img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a>
                               </li>
                          
                          
                          <li>
                          <label>계획일자</label>
                        <input type="date" id="searchByPlanStartDt" name="searchByPlanStartDt" 
                           value="<fmt:formatDate value="${searchVO.searchByPlanStartDt}" pattern="yyyy-MM-dd"/>"/>
                        <img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
                          &nbsp;~&nbsp;
                          <input type="date" id="searchByPlanEndDt" name="searchByPlanEndDt" 
                             value="<fmt:formatDate value="${searchVO.searchByPlanEndDt}" pattern="yyyy-MM-dd"/>"/>
                             <img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
                          </li>
                          
                          <li>
                           <div class="buttons" style="float:right;">
                              <a href="#LINK" onclick="javascript:fn_searchList('1')" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
                           </div>                            
                          </li>
                          
                       </ul>   
                       
                             
                  </div>         
                  </fieldset>
         
            </div>
            <!-- //검색 필드 박스 끝 -->
                
                <div id="page_info"><div id="page_info_align"></div></div>                    
                <!-- table add start -->
                <div class="default_tablestyle">
                    <label style="padding-left:53%; padding-bottom:5%; font-weight:bold; color: red; font-size:13px;">
                   기준일자 :&nbsp; ${ps} &nbsp;~&nbsp;${pe}
                   <input type="hidden" id="ps" name="ps" value="${ps}"/>
                   <input type="hidden" id="pe" name="pe" value="${pe}"/>
                   </label>
                    <table summary="번호,게시판명,사용 커뮤니티 명,사용 동호회 명,등록일시,사용여부   목록입니다" cellpadding="0" cellspacing="0">
                    <caption>게시판 템플릿 목록</caption>
                   
                    <colgroup>
                    <col width="20" >
                    <col width="10%" >
                    <col width="13%" >
                    <col width="70" >
                    <col width="60" > 
                    <col width="70" >
                    <col width="120" >
                    <col width="120" >
                    <col width="50" >
                    <col width="50" >
                    <col width="50" >
                    </colgroup>
                    <thead>
                    <tr>
                       <th align="center">번호</th>
                    <th align="center">화면ID</th>
                    <th align="center">화면명</th>
                    <th align="center">시스템구분</th>
                    <th align="center">업무구분</th>
                    <th align="center">개발자</th>
                    <th align="center">계획시작일자</th>
                    <th align="center">계획종료일자</th>
                    <th align="center">소요일수</th>
                    <th align="center"></th>
                    <th align="center"></th>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <!-- loop 시작 -->       
                      <tr>
                      
                      <td align="center" class="listtd"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
                    <td align="center" class="listtd"><c:out value="${result.PG_ID}"/></td>
                    <%-- <td align="center" class="listtd"><c:out value="${result.pgId}"/>&nbsp;</td> --%>
                    <td align="left" class="listtd"><c:out value="${result.PG_NM}"/>&nbsp;</td>
                    <td align="center" class="listtd"><c:out value="${result.SYS_GB}"/>&nbsp;</td>
                    <td align="center" class="listtd"><c:out value="${result.TASK_GB}"/>&nbsp;</td>
                    <td align="center" class="listtd"><c:out value="${result.USER_DEV_ID}"/>&nbsp;</td>
                    <%-- <td align="center" class="listtd"><c:out value="${result.planStartDt}"/>&nbsp;</td>
                    <td align="center" class="listtd"><c:out value="${result.planEndDt}"/>&nbsp;</td> --%>
                    <td><input type="date"  id="${result.PG_ID}" 
                    <c:if test="${d_test}"> class="disabled" </c:if> 
                       onchange="fn_result_change('${result.PG_ID}',this)" value="<fmt:formatDate value='${result.PLAN_START_DT}' pattern="yyyy-MM-dd"/>"
                       />
                       
                      </td>
                      <td><input type="date"  id="${result.PG_ID}1" 
                      <c:if test="${d_test}"> class="disabled" </c:if> onchange="fn_result_change('${result.PG_ID}',this)" value="<fmt:formatDate value="${result.PLAN_END_DT}" pattern="yyyy-MM-dd" />"/>
                      </td>
                    <td align="center" class="listtd"><c:out value="${result.DAY_DIFF}"/>&nbsp;</td>
                    
                       
                     <c:choose>
                       <c:when test="${d_test}">
                          <c:if test="${result.PLAN_START_DT eq null || result.PLAN_END_DT eq null}">
                           <td align="center" class="listtd"><div class="buttons" style="padding-top:5px;padding-bottom:35px;padding-left:5px;">
                              <a id="${result.PG_ID}2" class="disabled" href="#LINK" onclick="fn_result_regist('${result.PG_ID}');" style="selector-dummy:expression(this.hideFocus=false);">저장</a></div></td>
                           <td align="center" class="listtd"><div class="buttons" style="padding-top:5px;padding-bottom:35px;padding-left:3px;">
                           <a id="reset" class="disabled" href="#LINK" style="selector-dummy:expression(this.hideFocus=false);">초기화</a></div></td>
                           
                        </c:if>
                        <c:if test="${result.PLAN_START_DT ne null || result.PLAN_END_DT ne null}">
                           <td align="center" class="listtd">
                             <div class="buttons" style="padding-top:5px;padding-bottom:35px;padding-left:5px;">
                           <a id="${result.PG_ID}3" class="disabled" href="#LINK" onclick="fn_result_regist('${result.PG_ID}');" style="selector-dummy:expression(this.hideFocus=false);">저장</a></div></td>
                           <td align="center" class="listtd"><div class="buttons" style="padding-top:5px;padding-bottom:35px;padding-left:3px;">
                           <a id="reset" class="disabled" href="#LINK" style="selector-dummy:expression(this.hideFocus=false);">초기화</a></div></td>
                        </c:if>
                       </c:when>
                       <c:otherwise>
                          <c:if test="${result.PLAN_START_DT eq null || result.PLAN_END_DT eq null}">
                          <td align="center" class="listtd"><div class="buttons" style="padding-top:5px;padding-bottom:35px;padding-left:5px;">
                           <a id="${result.PG_ID}2" class="abled" href="#LINK" onclick="fn_result_regist('${result.PG_ID}');" style="selector-dummy:expression(this.hideFocus=false);">저장</a></div></td>
                           <td align="center" class="listtd"><div class="buttons" style="padding-top:5px;padding-bottom:35px;padding-left:3px;">
                           <a id="reset" href="#LINK" onclick="fn_result_reset('${result.PG_ID}');" style="selector-dummy:expression(this.hideFocus=false);">초기화</a></div></td>
                        </c:if>
                        <c:if test="${result.PLAN_START_DT ne null || result.PLAN_END_DT ne null}">
                        <td align="center" class="listtd"><div class="buttons" style="padding-top:5px;padding-bottom:35px;padding-left:5px;">
                           <a id="${result.PG_ID}3" class="disabled" href="#LINK" onclick="fn_result_regist('${result.PG_ID}');" style="selector-dummy:expression(this.hideFocus=false);">저장</a></div></td>
                           <td align="center" class="listtd"><div class="buttons" style="padding-top:5px;padding-bottom:35px;padding-left:3px;">
                           <a id="reset" href="#LINK" onclick="fn_result_reset('${result.PG_ID}');" style="selector-dummy:expression(this.hideFocus=false);">초기화</a></div></td>
                        </c:if>
                       </c:otherwise>
                     </c:choose>
                       
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
                
                 <input id="TmsProgrmFileNm_sys_gb" type="hidden" /> 
               <input id="TmsProgrmFileNm_task_gb" type="hidden" /> 
               <input id="TmsProgrmFileNm_pg_nm" type="hidden" /> 
               <input id="TmsProgrmFileNm_user_dev_id" type="hidden" /> 
               <input id="TmsProgrmFileNm_user_real_id" type="hidden" /> 
                
                <!-- 페이지 네비게이션 시작 -->
                <div id="paging_div">
                    <ul class="paging_align">
                       <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_searchList"  />
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