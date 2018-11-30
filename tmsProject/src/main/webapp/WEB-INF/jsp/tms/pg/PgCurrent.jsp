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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />" ></script>

<c:choose>
<c:when test="${preview == 'true'}">
<script type="text/javascript">
<!--
    function press(event) {
		if (event.keyCode==13) {
        	fn_egov_select_bbsUseInfs('1');
    	}
    }

    function fn_egov_addNotice() {
    }
    
    function fn_egov_select_noticeList(pageNo) {
    	document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/tms/pg/PgManage.do'/>";
        document.frm.submit();
    }
    
    function fn_egov_inqire_notice(nttId, bbsId) {    
    	
    }
//-->
    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_bbsUseInfs('1');
        }
    }

    function fn_egov_select_bbsUseInfs(pageNo){
        document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/cop/com/selectBBSUseInfs.do'/>";
        document.frm.submit();
    }
    function fn_egov_insert_addbbsUseInf(){
        document.frm.action = "<c:url value='/tms/pg/ExelWrite.do'/>";
        document.frm.submit();      
    }
    function fn_egov_select_bbsUseInf(bbsId, trgetId){
    	
        document.frm.bbsId.value = bbsId;
        document.frm.trgetId.value = trgetId;
        document.frm.action = "<c:url value='/cop/com/selectBBSUseInf.do'/>";
        document.frm.submit();
    }
</script>
</c:when>
<c:otherwise>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript">

	$(function(){
	   $('#bbb').change(function() {
	      $.ajax({
	         
	         type:"POST",
	         url: "<c:url value='/sym/prm/TaskGbSearch.do'/>",
	         data : {searchData : this.value},
	         async: false,
	         dataType : "json",
	         success : function(selectTaskGbSearch){
	        	 $("#searchBySysGb").val($("#bbb").val());
	            $("#task").find("option").remove().end().append("<option value=''>선택하세요</option>");
	            $.each(selectTaskGbSearch, function(i){
	            	$("#task").append("<option value='"+selectTaskGbSearch[i]+"'>"
	            			+selectTaskGbSearch[i]+"</option>");
	            });
	            
	         },
	         error : function(request,status,error){
	            alert("에러");
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

	         }
	      });
	   })
	})

	
	function setting() {
		document.frm.searchBySysGb.value = document.frm.bbb.value;
		document.frm.searchByTaskGb.value = document.frm.task.value;
		
	}
	
	function Pg_select(pageNo){
		document.frm.cnt.value = "a";
		document.frm.searchBySysGb.value = document.frm.bbb.value;
		document.frm.searchByTaskGb.value = document.frm.task.value;
		document.frm.pageIndex.value = pageNo;
		var url = "<c:url value='/tms/pg/PgCurrent.do" + "?cnt=" + document.frm.cnt.value + "'/>";
    	document.frm.action = url;
    	document.frm.submit();
	}
	
	function fncSelect_Info() {
    	document.frm.action = "<c:url value='/tms/pg/selectPgInf.do'/>";
    	document.frm.submit();     
	}
    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_noticeList('1');
        }
    }
    function fn_egov_insert_addbbsUseInf(){
        document.frm.action = "<c:url value='/tms/pg/ExelWrite.do'/>";
        document.frm.submit();      
    }
    function searchFileNm() {
        window.open("<c:url value='/sym/prm/TmsProgramListSearch.do'/>",'','width=800,height=600');
    }
    
</script>
</c:otherwise>
</c:choose>

<title>프로그램현황</title>
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
</head>
<body>

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
							<li>프로그램관리</li>
							<li>&gt;</li>
							<li><strong>프로그램현황</strong></li>
                        </ul>
                    </div>
                </div>
                
                <form name="frm" id="frm" action ="<c:url value='/tms/pg/PgManage.do'/>" method="post">
				
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field" style="font-family:'Malgun Gothic';">
                    <div id="search_field_loc"><h2><strong>프로그램 현황</strong></h2></div>
					
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
					  			<input type="text" name="searchByPgId" id="TmsProgrmFileNm_pg_id" style="width:80%;text-align:center;" value="${searchVO.searchByPgId}"/>
					  				<a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
	                				<img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a>
      			        		</td>
      			        		<td style="font-weight:bold;color:#666666;font-size:110%;">시스템구분
      			        		</td>
      			        		<td>
      			        		<select name="bbb" id="bbb" style="width:90%;text-align-last:center;">
									   <option value="" >전체</option>
									      <c:forEach var="sysGb" items="${sysGb}" varStatus="status">
									    	<option value="${sysGb}" <c:if test="${searchVO.searchBySysGb == sysGb}">selected="selected"</c:if> ><c:out value="${sysGb}" /></option>
									    </c:forEach>
									</select>
									
									<input type="hidden" name="searchBySysGb" id="searchBySysGb" value=""/>
      			        		</td>
      			        		<td style="font-weight:bold;color:#666666;font-size:110%;">업무구분
      			        		</td>
      			        		<td>
      			        		<select name="task" id="task" style="width:90%;text-align-last:center;">
									   <option value="">선택하세요</option>
					      					<c:forEach var="taskGb" items="${taskGb2}" varStatus="status">
									    		<option value="${taskGb}" <c:if test="${searchVO.searchByTaskGb == taskGb}">selected="selected"</c:if> ><c:out value="${taskGb}" /></option>
									    	</c:forEach>								   
									</select>				
									<input type="hidden" name="searchByTaskGb" id="searchByTaskGb" value=""/>
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
      			        		<input type="text" list="userAllList" autocomplete="off" name="searchByUserDevId" id="searchByUserDevId" size="15" style="width:80%;text-align:center;" value="${searchVO.searchByUserDevId}"/>
      			        		<datalist id="userAllList">
									    <c:forEach var="userList" items="${userList}" varStatus="status">
									    	<option value="${userList.userNm}"  style="text-align:center;"></option>
									    </c:forEach>
					        	</datalist>
      			        		</td>
      			        		<td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">사용여부
      			        		</td>
      			        		<td style="padding-top:15px;">
      			        		<select name="searchUseYn" id="searchUseYn" style="width:90%;text-align-last:center;">
									   <option value="">전체</option>
					      					<c:forEach var="useYn" items="${useYnList}" varStatus="status">
					      						<c:if test="${useYn == 'Y'}">
									    			<option value="${useYn}" <c:if test="${searchVO.searchUseYn == useYn}">selected="selected"</c:if> >사용</option>
									    		</c:if> 
									    		<c:if test="${useYn == 'N'}">
									    			<option value="${useYn}" <c:if test="${searchVO.searchUseYn == useYn}">selected="selected"</c:if> >미사용</option>
									    		</c:if> 
									    	</c:forEach>								   
									</select>			
      			        		</td>
      			        		<td colspan="5" style="padding-top:15px;">
      			        		 	<div class="buttons" style="float:right;">                                       
                                       	<a href="#Link" onclick="setting();Pg_select('1'); return false;"><img src="<c:url value='/images/img_search.gif' />" alt="search" />
                                       		<spring:message code="button.inquire" /></a>
                              			<a href="<c:url value='/tms/pg/ExelWrite.do'/>" onclick="setting();fn_egov_insert_addbbsUseInf(); return false;">
                              				<spring:message code="button.excel_down" /></a>
                                 	</div>
      			        		</td>
      			        	</tr>
      			        	</table>
                            		
							</div>
							
                        </fieldset>
                 	</div>
                 	<input type="submit" id="invisible" class="invisible"/>
                 	<input type="submit" value="실행" onclick="fn_egov_select_noticeList('1'); return false;" id="invisible" class="invisible" />
                	<!-- //검색 필드 박스 끝 -->

				 <div id="page_info"><div id="page_info_align"></div></div>    
                 <div class="default_tablestyle">
                	
        			<table width="120%" border="0" cellpadding="0" cellspacing="0" >
        				<caption style="visibility:hidden">NO, 화면ID, 화면명, 시스템구분, 업무구분, 개발자, 사용여부</caption>
        				<colgroup>
        					<col width="7"/> 
        					<col width="20"/>
        					<col width="45"/>
        					<col width="17"/>
        					<col width="17"/>
        					<col width="17"/>
        					<col width="8"/>
        				</colgroup>
        				<tr>
        					<th align="center">NO</th>
        					<th align="center">화면ID</th>
        					<th align="center">화면명</th>
        					<th align="center">시스템구분</th>
        					<th align="center">업무구분</th>
        					<th align="center">개발자</th>
        					<th align="center">사용여부</th>
        				</tr>
        			
        				<c:forEach var="result" items="${resultList}" varStatus="status">
            				<tr>
            					<td align="center" class="listtd"><font style="font-weight:bold"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></font></td>
            					<td align="center" class="listtd"><c:out value="${result.pgId}"/></td>
            					<td align="left" class="listtd" style="padding-left:3px;">
            						<a href="<c:url value='/tms/pg/selectPgCheck.do'/>?pgId=<c:out value='${result.pgId}'/>">
            							<font color="#0F438A" style="font-weight:bold"><c:out value="${result.pgNm}"/></font>
            						</a></td>
            					<td align="center" class="listtd"><c:out value="${result.sysGb}"/>&nbsp;</td>
            					<td align="center" class="listtd"><c:out value="${result.taskGb}"/>&nbsp;</td>
            					<td align="center" class="listtd"><c:out value="${result.userDevId}"/>&nbsp;</td>
            					<c:if test="${result.useYn == 'Y'}">
            						<td align="center" class="listtd" ><font style="font-weight:bold"><c:out value="${result.useYn}"/></font></td>
            					</c:if>
            					<c:if test="${result.useYn == 'N'}">
            						<td align="center" class="listtd" ><font style="font-weight:bold"><c:out value="${result.useYn}"/></font></td>
            					</c:if>
            				</tr>
        				</c:forEach>
        				<c:if test="${fn:length(resultList) == 0}">
                     		<tr>
                       			<td nowrap colspan="7" ><spring:message code="common.nodata.msg" /></td>  
                     		</tr>      
              			</c:if>        				
        			</table>  		
        			  
        		</div>
        			
        		<input name="pageIndex" type="hidden" value="${searchVO.pageIndex}"/>
				<input id="TmsProgrmFileNm_sys_gb" type="hidden" /> 
				<input id="TmsProgrmFileNm_task_gb" type="hidden" /> 
				<input id="TmsProgrmFileNm_pg_nm" type="hidden" /> 
				<input id="TmsProgrmFileNm_user_dev_id" type="hidden" />
				<input id="TmsProgrmFileNm_user_real_id" type="hidden" />
				<input id="TmsProgrmFileNm_pg_full" type="hidden" />
				<input id="TmsProgrmFileNm_task_gb_code" type="hidden" />
				<input id="cnt" type="hidden" />
	</form>
    <!-- 페이지 네비게이션 시작 -->
    <div id="paging_div">
        <ul class="paging_align">
            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="Pg_select"/>
        </ul>
    </div>                          
    <!-- //페이지 네비게이션 끝 -->  
    
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