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
    document.listForm.searchByTaskGb.value = document.listForm.task.value;
    document.listForm.action = "<c:url value='/tms/dev/devCurrent.do'/>";
    document.listForm.submit();
}

$(function(){
	
	   $('#searchBySysGb').change(function() {
	      $.ajax({
	         
	         type:"POST",
	         url: "<c:url value='/sym/prm/TaskGbSearch.do'/>",
	         data : {searchData : this.value},
	         async: false,
	         dataType : "json",
	         success : function(selectTaskGbSearch){
	            $("#task").find("option").remove().end().append("<option value=''>선택하세요</option>");
	            $.each(selectTaskGbSearch, function(i){
	               (JSON.stringify(selectTaskGbSearch[0].task_GB)).replace(/"/g, "");
	            $("#task").append("<option value='"+JSON.stringify(selectTaskGbSearch[i].task_GB).replace(/"/g, "")+"'>"+JSON.stringify(selectTaskGbSearch[i].task_GB).replace(/"/g, "")+"</option>")
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
					  		<ul id="search_first_ul">
					  			<li>
								    <label >시스템구분</label>
									<select name="searchBySysGb" id="searchBySysGb" style="width:12%;text-align-last:center;">
									   <option value="" >전체</option>
									      <c:forEach var="sysGb" items="${sysGb}" varStatus="status">
									    	<option value="<c:out value="${sysGb.SYS_GB}"/>" <c:if test="${searchVO.searchBySysGb == sysGb.SYS_GB}">selected="selected"</c:if> ><c:out value="${sysGb.SYS_GB}" /></option>
									      </c:forEach>
									</select>
									
					  			</li>
					  			<li>
								    <label for="searchByTaskGb">업무구분</label>
									<select name="task" id="task" style="width:15%;text-align-last:center;">
									   <option value="">선택하세요</option>
									   <c:forEach var="taskGb" items="${taskGb2}" varStatus="status">
									    		<option value="<c:out value="${taskGb.TASK_GB}"/>" <c:if test="${searchVO.searchByTaskGb == taskGb.TASK_GB}">selected="selected"</c:if> ><c:out value="${taskGb.TASK_GB}" /></option>
									   </c:forEach>
									</select>				
									<input type="hidden" name="searchByTaskGb" value="">
					  			</li>
					  			
					  			<li><label for="searchByUserDevId">개발자명</label></li>
					  			<li><input type="text" name="searchByUserDevId" id="searchByUserDevId" /></li>
					  			
					  		</ul>
					  		<ul id="search_second_ul">
					  			<li><label for="searchByPgId">화면ID</label></li>
					  			<li><input type="text" name="searchByPgId" id="searchByPgId" /></li>
					  			<li>
									<div class="buttons" style="float:right;">
										<a href="#LINK" onclick="javascript:fn_searchList('1')" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
									</div>	  				  			
					  			</li>
					  			
					  			<li>
					  			<label>개발일자</label>
								<input type="date" name="devStartDt" /><img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
					  			~ <input type="date" name="devEndDt" /><img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
					  			</li>
					  			
					  		</ul>			
						</div>			
						</fieldset>
					<%-- </form> --%>
				</div>
				<!-- //검색 필드 박스 끝 -->
               	
                <c:forEach var="r" items="${r}" varStatus="status">
                	${r}
                </c:forEach>
                

                <div id="page_info"><div id="page_info_align"></div></div>                    
                <div class="default_tablestyle">
              <table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
                 <caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
              
              
              <colgroup>
        			<col width="70" >
                    <col width="60" >  
                    <col width="10%" >
                    <col width="10%" >
                    <col width="40" >
                    <col width="90" >
                    <col width="90" >
                    <col width="10%" >
                    <col width="10%" >
                     <col width="5%" >
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
            		
            				
            				
            			</tr>
        			</c:forEach>
            
              </table>        
              
           </div>

                <!-- 페이지 네비게이션 시작 -->
                <%-- <c:if test="${!empty loginPolicyVO.pageIndex }"> --%>
                    <div id="paging_div">
                        <ul class="paging_align">
                       <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage1" />
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