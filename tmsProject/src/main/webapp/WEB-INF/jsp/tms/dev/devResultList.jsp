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
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javaScript" language="javascript">

Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
 
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
     
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};
 
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);
};

 function fn_result_change(pgId, obj){
	 var date = obj.value;
	 var cDate = (new Date().format("yyyy-MM-dd"));
	 
	 var idVal0 = document.getElementById(pgId).value;
	 var idVal1 = document.getElementById(pgId+1).value;
	 
	 
	 var bnt = document.getElementById(pgId+3).id;
	 $("#"+bnt).removeClass("disabled");
	 $("#"+bnt).addClass("abled");
	
	 var rateId = document.getElementById(pgId+4).id;
	 var rateVal = document.getElementById(pgId+4).value;
	 $("#"+rateId).removeClass("disabled");
	 $("#"+rateId).addClass("abled");
	 
	 var flag = true;
	 
	 if(date > cDate){
		 swal("오늘 이후 날짜는 입력할 수 없습니다. 다시 입력하십시오.");
		 obj.value = null;
		 if(obj.id != pgId && idVal0 != ""){
			 document.getElementById(pgId+4).value = "50";
		 }else{
			 document.getElementById(pgId+4).value = "0";
			 $("#"+rateId).removeClass("abled");
			 $("#"+rateId).addClass("disabled");
		 }
		 
	 }
	 if(obj.value == ""){
		if(obj.id == pgId){
			document.getElementById(pgId).value = null;
			document.getElementById(pgId+1).value = null;
			document.getElementById(pgId+4).value = "0";
			$("#"+rateId).removeClass("abled");
			 $("#"+rateId).addClass("disabled");
		}else{
			document.getElementById(pgId+4).value = "50";
		}
	 }
	 
	 if(idVal1 == "" && idVal0 != "" && idVal0 <= cDate){
		 if(rateVal != '50' && rateVal != '0'){
			 return;
		 }else{
		 	document.getElementById(pgId+4).value = "50";
		 }
	 }
	 
	 
	 if(idVal0 <= idVal1 && idVal1 <= cDate && idVal0 != "" && idVal1 != ""){
	  		document.getElementById(pgId+4).value = "100";
			 $("#"+rateId).removeClass("abled");
			 $("#"+rateId).addClass("disabled");
	  }
	 
	 if(idVal1 != null && idVal1 != "")
     {
        if(idVal0 > idVal1)
           {
        	if(obj.id==pgId && date <= cDate){
        		swal("개발종료일자보다 큰 값을 입력하시오.");
                document.getElementById(pgId+1).value = null;
                document.getElementById(pgId+4).value = "50";
        	}else if(obj.id != pgId && date <= cDate){
        		swal("개발시작일자보다 큰 값을 입력하시오.");
        		if(rateVal != '50'){
        			document.getElementById(pgId+1).value = null;
        			return;
        		}
        		document.getElementById(pgId+1).value = null;
        		document.getElementById(pgId+4).value = "50";
        	}
              
          }
        if(idVal0 == ""){
	        document.getElementById(pgId+1).value = null;
	        document.getElementById(pgId+4).value = "0";
	        $("#"+rateId).removeClass("abled");
			 $("#"+rateId).addClass("disabled");
        }
     }
	 
 }
 
function fn_rate_change(pgId, event, obj, maxByte) {
	var idVal0 = document.getElementById(pgId).value;
	var idVal1 = document.getElementById(pgId+1).value;
	
	if(idVal0 == null || idVal0 == ""){
		swal("개발시작일자 먼저 입력하십시오."); 
		document.getElementById(pgId+4).value = "0";
		$("#"+rateId).removeClass("abled");
		 $("#"+rateId).addClass("disabled");
		return;
	}
	else{
		
			var idVal3 = document.getElementById(pgId+3).id;
			$("#"+idVal3).removeClass("disabled");
			$("#"+idVal3).addClass("abled");
			var rate = obj.value;//document.getElementById(pgId+4).value;
			
			 if(rate.length >= 3 && rate >= 100){
					swal("100이상 입력할 수 없습니다.");
					document.getElementById(pgId+4).value = null;
			    }
			
			var strValue = obj.value;
	        var strLen = strValue.length;
	        var totalByte = 0;
	        var len = 0;
	        var oneChar = "";
	        var str2 = "";
	 
	        for (var i = 0; i < strLen; i++) {
	            oneChar = strValue.charAt(i);
	            if (escape(oneChar).length > 4) {
	                totalByte += 2;
	            } else {
	                totalByte++;
	            }
	 
	            // 입력한 문자 길이보다 넘치면 잘라내기 위해 저장
	            if (totalByte <= maxByte) {
	                len = i + 1;
	            }
	        }
	        
	        if (totalByte > maxByte) {
	            swal(maxByte + "자를 초과 입력 할 수 없습니다.");
	            str2 = strValue.substr(0, len);

	            obj.value = null;
	            //obj.value = str2;
	            fn_rate_change(obj, 4000);
	            return false;
	        }
			
	       
			
			document.listForm.flag.value = "change";
			event = event || window.event;
		    var keyID = (event.which) ? event.which : event.keyCode;
		    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		        return;
		    else{
		    	event.target.value = event.target.value.replace(/[^0-9]/g, "");
		    	return false;
		    }
	}

}

function removeChar(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        event.target.value = event.target.value.replace(/[^0-9]/g, "");
}

function linkPage1(pageNo){

	   document.listForm.pageIndex.value = pageNo;
	   document.listForm.action = "<c:url value='/tms/dev/devResultList.do'/>";
	   document.listForm.submit();
	}


function fn_result_regist(t){
	
	var f = document.listForm;

	var idVal = document.getElementById(t).value;
	var idVal1 = document.getElementById(t+1).value;
	var rate = document.getElementById(t+4).value;
	
	var page = document.listForm.page.value;
	var sys = document.listForm.Sys.value;
	var task = document.listForm.task.value;
	var flag = document.listForm.flag.value;
	
	var dev = document.listForm.searchByUserDevId.value;
	var start = document.listForm.searchByDevStartDt.value;
	var end = document.listForm.searchByDevEndDt.value;
	var id = document.listForm.TmsProgrmFileNm_pg_id.value;

	if(rate == null || rate == ""){
		swal("완료율을 입력해주십시오.");
	}else{
		location.href ="<c:url value='/tms/dev/updateDevResult.do'/>?pgId="+t+"&devStartDt="+idVal+"&devEndDt="+idVal1+"&achievementRate="+rate+"&flag="+flag
				+"&pageIndex="+page+"&searchByPgId="+id+"&searchBySysGb="+sys+"&searchByTaskGb="+task
				+"&searchByUserDevId="+dev+"&searchByDevStartDt="+start+"&searchByDevEndDt="+end;
	}	
}

function fn_searchList(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.searchBySysGb.value = document.listForm.Sys.value;
    document.listForm.searchByTaskGb.value = document.listForm.task.value;
    document.listForm.action = "<c:url value='/tms/dev/devResultList.do'/>";
    document.listForm.submit();
}

function clickEvent(i){
	$('#'+i.id).removeAttr("readonly");
	$('#'+i.id).css("border","1");
	$('#'+i.id).css("text-align","left");
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
	            swal("에러");
	            swal("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

	         }
	      });
	   })
	})
	
	function searchFileNm() {
    window.open("<c:url value='/sym/prm/TmsProgramListSearch.do'/>",'','width=800,height=600');
}
</script>
<style>

input[type=date]{
	text-align: center;
}

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
                    <div id="cur_loc_align" style="font-family:'Malgun Gothic';">
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
                <input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
                <input type="hidden" name="flag" value="auto"/>
                <input type="hidden" name="page" id="page" value="${page}"/>
                <!-- 검색 필드 박스 시작 -->
				<div id="search_field" style="font-family:'Malgun Gothic';">
					<div id="search_field_loc"><h2><strong>개발결과관리</strong></h2></div>
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
      			        		<input type="text" name="searchByPgId" style="width:80%;text-align:center;" id="TmsProgrmFileNm_pg_id" autocomplete="off" value="${searchVO.searchByPgId}"/>
					  			<a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
                      			<img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a>
      			        		</td>
      			        		<td style="font-weight:bold;color:#666666;font-size:110%;">시스템구분
      			        		</td>
      			        		<td>
      			        		<select name="Sys" id="Sys" style="width:90%;text-align-last:center;">
									   <option value="" >전체</option>
									      <c:forEach var="sysGb" items="${sysGb}" varStatus="status">
									    	<option value="${sysGb}" <c:if test="${searchVO.searchBySysGb == sysGb}">selected="selected"</c:if> ><c:out value="${sysGb}" /></option>
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
									    		<option value="${taskGb}" <c:if test="${searchVO.searchByTaskGb == taskGb}">selected="selected"</c:if> ><c:out value="${taskGb}" /></option>
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
      			        		<% LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
					  					pageContext.setAttribute("loginNm", loginVO.getName()) ;
					  				if(loginVO.getName().equals("관리자")){	
					  			%>
					  			 <input type="text" list="userAllList" autocomplete="off" name="searchByUserDevId" id="searchByUserDevId" size="18" style="width:80%;text-align:center;" value="${searchVO.searchByUserDevId}"/>
		                          	<datalist id="userAllList">
		                          	<c:forEach var="userList" items="${userList}" varStatus="status">
										<option value="${userList.userNm}"  style="text-align:center;"></option>
									</c:forEach>
									</datalist>
		                          <%}else{%>
		                          <input type="text" name="searchByUserDevId" id="searchByUserDevId" size="18" style="width:80%;text-align:center;" value="${loginNm}" readOnly/>
		                          	
		                          <%}%>
      			        		</td>
      			        		<td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">개발일자
      			        		</td>
      			        		<td colspan="3" style="padding-top:15px;">
								<input type="date" id="searchByDevStartDt" name="searchByDevStartDt" 
									value="<fmt:formatDate value="${searchVO.searchByDevStartDt}" pattern="yyyy-MM-dd"/>"/>
								<img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
					  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><font size="3px">~</font></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  			<input type="date" id="searchByDevEndDt" name="searchByDevEndDt" 
					  				value="<fmt:formatDate value="${searchVO.searchByDevEndDt}" pattern="yyyy-MM-dd"/>"/>
					  				<img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
      			        		</td>
      			        		<td>
      			        		</td>
      			        		<td>
      			        		</td>
      			        		<td style="padding-top:15px;">
									<div class="buttons" style="float:right;">
										<a href="#LINK" onclick="javascript:fn_searchList('1')" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/img_search.gif' />" alt="search" /><spring:message code="button.inquire" /></a>
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
              <table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
                 <caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
              
              
              <colgroup>
              		<col width="40" > 
                    <col width="70" >
                    <col width="135" >
        			<col width="50" >
                    <col width="60" > 
                    <col width="40" >
                    <col width="60" >
                    <col width="60" >
                    <col width="95" >
                    <col width="95" >
                    <col width="40" >
                    <col width="50" >
        			</colgroup>
        			<tr>
        				<th align="center">번호</th>
        				<th align="center">화면ID</th>
        				<th align="center">화면명</th>
        				<th align="center">시스템구분</th>
        				<th align="center">업무구분</th>
        				<th align="center">개발자</th>
        				<th align="center">계획시작일자</th>
        				<th align="center">계획종료일자</th>
			        	<th align="center">개발시작일자</th>
        				<th align="center">개발종료일자</th>
        				<th align="center">완료율(%)</th>
        				<th align="center"></th>
        			</tr>
        			
        			<c:forEach var="result" items="${resultList}" varStatus="status">
        			
            			<tr>
            				<td align="center" class="listtd"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
            				<td align="left" class="listtd" title="<c:out value="${result.PG_ID}"/>" style="text-overflow:ellipsis;">
                                <c:out value="${result.PG_ID}"/>
                                <input type="hidden" id="pgId" name="pgId" value='<c:out value="${result.PG_ID}"/>' >
                            </td>
            				<td align="left" class="listtd" style="padding-left:5px;text-overflow:ellipsis;" title="<c:out value="${result.PG_NM}"/>"><c:out value="${result.PG_NM}"/>&nbsp;</td>
            				<td align="center" class="listtd" name="sys"><c:out value="${result.SYS_GB}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.TASK_GB}"/>&nbsp;</td>
            				<td align="center" class="listtd" title="<c:out value="${result.USER_DEV_ID}"/>"><c:out value="${result.USER_DEV_NM}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.PLAN_START_DT}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.PLAN_END_DT}"/>&nbsp;</td>
            				
            				 <c:choose>
		            		  	<c:when test="${result.DEV_START_DT ne null}">
	            					<td><input type="date"  id="${result.PG_ID}" readOnly style="border:0; text-align:right; width:120px;" onclick="clickEvent(this)" onchange="fn_result_change('${result.PG_ID}',this)" value="<fmt:formatDate value="${result.DEV_START_DT}" pattern="yyyy-MM-dd" />"/></td>
	                            </c:when>
	                            <c:otherwise>
	                            	<td><input type="date"  id="${result.PG_ID}" onchange="fn_result_change('${result.PG_ID}',this)" value="<fmt:formatDate value="${result.DEV_START_DT}" pattern="yyyy-MM-dd" />" style="width:120px;"/></td>
	                            </c:otherwise>
                            </c:choose>
                            
                             <c:choose>
		            		  	<c:when test="${result.DEV_END_DT ne null}">
                            		<td><input type="date"  id="${result.PG_ID}1" readOnly style="border:0; text-align:right; width:120px;" onclick="clickEvent(this)" onchange="fn_result_change('${result.PG_ID}',this)" value="<fmt:formatDate value="${result.DEV_END_DT}" pattern="yyyy-MM-dd" />"/></td>
            					</c:when>
            					<c:otherwise>
	                            	<td><input type="date"  id="${result.PG_ID}1" onchange="fn_result_change('${result.PG_ID}',this)" value="<fmt:formatDate value="${result.DEV_END_DT}" pattern="yyyy-MM-dd" />" style="width:120px;"/></td>
	                            </c:otherwise>
            				</c:choose>
            				
            				<c:choose>
	            				<c:when test="${result.ACHIEVEMENT_RATE eq 100 || result.ACHIEVEMENT_RATE eq 0}" >
	            					<td><input name="${result.PG_ID}4" id="${result.PG_ID}4" style="text-align:right; width:30px;" value="${result.ACHIEVEMENT_RATE}" onkeyup="fn_rate_change('${result.PG_ID}', event, this ,3);"  class="disabled" /></td>
	            				</c:when>
	            				<c:otherwise>
	            					<td><input name="${result.PG_ID}4" id="${result.PG_ID}4" style="text-align:right; width:30px;" value="${result.ACHIEVEMENT_RATE}" onkeyup="fn_rate_change('${result.PG_ID}', event, this ,3);" /></td>
	            				</c:otherwise>
            				</c:choose>
          
            				
            				<td align="center" class="listtd">
            				<div class="buttons" style="padding-top:5px;padding-bottom:35px;padding-left:20px;">
            				<c:choose>
	            				<c:when test="${result.DEV_START_DT eq null && result.DEV_END_DT eq null}">
	            				<a id="${result.PG_ID}3" class="abled" href="#LINK" onclick="fn_result_regist('${result.PG_ID}');" style="selector-dummy:expression(this.hideFocus=false);">저장</a>
	            				</c:when>
	            				<c:when test="${result.DEV_START_DT ne null || result.DEV_END_DT ne null}">
	            				<a id="${result.PG_ID}3" class="disabled" href="#LINK" onclick="fn_result_regist('${result.PG_ID}');" style="selector-dummy:expression(this.hideFocus=false);">저장</a>
	            				</c:when>
            				</c:choose>
            				
            				<%-- <a href="<c:url value='/tms/dev/selectDevResult.do'/>?pgId=<c:out value='${result.pgId}'/>" >저장</a> --%>
            				</div>
            				</td>
            				
            				
            			</tr>
        			</c:forEach>
             		<c:if test="${fn:length(resultList) == 0}">
                      <tr>
                        <td nowrap colspan="12" ><spring:message code="common.nodata.msg" /></td>  
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