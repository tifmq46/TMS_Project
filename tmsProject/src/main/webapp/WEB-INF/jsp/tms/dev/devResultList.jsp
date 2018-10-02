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
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >

<title>개발결과관리</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>

<script type="text/javaScript" language="javascript">

function linkPage1(pageNo){
	   document.listForm.pageIndex.value = pageNo;
	   document.listForm.action = "<c:url value='/tms/dev/devResultList.do'/>";
	   document.listForm.submit();
	}

function fn_result_change(asd) {
	var idVal0 = document.getElementById(asd).value;
	var idVal1 = document.getElementById(asd+1).value;
	if(idVal1 != null && idVal1 != "")
		{
			if(idVal0 > idVal1)
				{
					alert("개발시작일자보다 큰 값을 입력하시오.");
					document.getElementById(asd+1).value = null;
				}
		}
	if(idVal0 == null || idVal0 == "")
		{
			alert("개발시작일자부터 입력하십시오.")
			document.getElementById(asd+1).value = null;
		}
	var idVal3 = document.getElementById(asd+3).id;
	$("#"+idVal3).removeClass("disabled");
	$("#"+idVal3).addClass("abled");
}


function fn_result_regist(t){
	
	var f = document.listForm;

	var idVal = document.getElementById(t).value;
	var idVal1 = document.getElementById(t+1).value;
	var idVal2 = document.getElementById(t+2).value;


	
	location.href ="<c:url value='/tms/dev/updateDevResult.do'/>?pgId="+t+"&devStartDt="+idVal+"&devEndDt="+idVal1;
			
}

function fn_searchList(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.searchByTaskGb.value = document.listForm.task.value;
    document.listForm.action = "<c:url value='/tms/dev/devResultList.do'/>";
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
<style>
.disabled {
       pointer-events:none;
       opacity:0.5;
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
                    <div id="cur_loc_align">
                        <ul>
							<li>HOME</li>
							<li>&gt;</li>
							<li>개발진척관리</li>
							<li>&gt;</li>
							<li><strong>개발결과관리</strong></li>
                        </ul>
                    </div>
                </div>
        
             <form:form commandName="searchVO" name="listForm" id="listForm" method="post" action="tms/dev/devPlanList.do">   
                <input type="hidden" name="pageIndex" value="<c:out value='${devPlanVO.pageIndex}'/>"/>
                <!-- 검색 필드 박스 시작 -->
				<div id="search_field">
					<div id="search_field_loc"><h2><strong>개발결과관리</strong></h2></div>
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
        				<th align="center"></th>
        			</tr>
        			
        			<c:forEach var="result" items="${resultList}" varStatus="status">
        			
            			<tr>
            				<td align="center" class="listtd" name="sys"><c:out value="${result.sysGb}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.taskGb}"/>&nbsp;</td>
            				<td align="center" class="listtd">
            					<%-- <a href="<c:url value='/tms/dev/selectDevResult.do'/>?pgId=<c:out value='${result.pgId}'/>"> --%>
                                <c:out value="${result.pgId}"/><!-- </a> -->
                                <input type="hidden" id="pgId" name="pgId" value='<c:out value="${result.pgId}"/>' >
                            </td>
            				<td align="left" class="listtd"><c:out value="${result.pgNm}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.userDevId}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.planStartDt}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.planEndDt}"/>&nbsp;</td>
            				
            				<td><input type="date"  id="${result.pgId}" onchange="fn_result_change('${result.pgId}')" value="<fmt:formatDate value="${result.devStartDt}" pattern="yyyy-MM-dd" />"/>
                            <img src="images/calendar.gif"  width="19" height="19" alt="" /></td>
                            <td><input type="date"  id="${result.pgId}1" onchange="fn_result_change('${result.pgId}')" value="<fmt:formatDate value="${result.devEndDt}" pattern="yyyy-MM-dd" />"/>
                            <img src="images/calendar.gif" width="19" height="19" alt="" /></td>
            				
            				<%-- <td align="center" class="listtd"><c:out value="${result.devStartDt}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.devEndDt}"/>&nbsp;</td> --%>
            				
            				<td align="center" class="listtd">
            				
            				<div class="buttons" style="padding-top:5px;padding-bottom:35px;padding-left:20px;">
            				<%-- <a href="<c:url value='/tms/dev/updateDevResult.do'/>?pgId=<c:out value='${result.pgId}'/>" >저장</a> --%>
            				<c:if test="${result.devStartDt eq null || result.devEndDt eq null}">
            				<a id="${result.pgId}2" class="abled" href="#LINK" onclick="fn_result_regist('${result.pgId}');" style="selector-dummy:expression(this.hideFocus=false);">저장</a>
            				</c:if>
            				<c:if test="${result.devStartDt ne null || result.devEndDt ne null}">
            				<a id="${result.pgId}3" class="disabled" href="#LINK" onclick="fn_result_regist('${result.pgId}');" style="selector-dummy:expression(this.hideFocus=false);">저장</a>
            				</c:if>
            				<%-- <a href="<c:url value='/tms/dev/selectDevResult.do'/>?pgId=<c:out value='${result.pgId}'/>" >저장</a> --%> 
            				<!-- 값이 바뀌는 이벤트가 발생했을 때 저장 버튼 활성화
            					저장 누르면 버튼 enable
            				  -->
            				
            				</div>
            				<!-- <input type="button" value="등록" class="buttons"
            				onclick=""
            				/> -->
            				</td>
            				<%-- <td align="center" class="listtd"><c:out value="${result.devStartDt}"/>&nbsp;</td>
	            					<td align="center" class="listtd"><c:out value="${result.devEndDt}"/>&nbsp;</td> --%>
            				
            				<!--  계획일자가 등록되어 있는 경우에만 개발일자를 등록할 수 있음 -->
            				<%-- <c:choose>
	            				<c:when test="${!empty result.planStartDt}">
	            					
		            				<td align="center" class="listtd"><input type="date" id="${result.pgId}DevStartDt" style="width:120px; height:15px;" value="<c:out value="${result.devStartDt}"/>"/>&nbsp;</td>
		            				<td align="center" class="listtd"><input type="date" id="${result.pgId}DevEndDt" style="width:120px; height:15px;" value="<c:out value="${result.devEndDt}"/>"/>&nbsp;</td> 
	           					</c:when>
	            				
	            				<c:otherwise>
	            					<td align="center" class="listtd"></td>
	            					<td align="center" class="listtd"></td>
	            				</c:otherwise>
            				</c:choose> --%>
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