<%--
  Class Name : EgovTemplateRegist.jsp
  Description : 템플릿 속성 등록화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.18   이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.18
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="templateInf" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript">
    
    
    function fn_egov_select_tmplatInfo(){
        document.pgVO.action = "<c:url value='/cop/com/selectTemplateInfs.do'/>";
        document.pgVO.submit();  
    }
    
    function fn_egov_regist_tmplatInfo(){
        document.programVO.action = "<c:url value='/tms/pg/Pgupdate.do'/>";
        document.programVO.submit();
    
    }
    
	$(function(){
		   $('#SYS_GB').change(function() {
		      $.ajax({
		         type:"POST",
		         url: "<c:url value='/sym/prm/TaskGbSearch.do'/>",
		         data : {searchData : this.value},
		         async: false,
		         dataType : "json",
		         success : function(selectTaskGbSearch){
		        	 $("#searchBySysGb").val($("#SYS_GB").val());
		            $("#TASK_GB").find("option").remove().end().append("<option value=''>선택하세요</option>");
		            $.each(selectTaskGbSearch, function(i){
		               (JSON.stringify(selectTaskGbSearch[0].task_GB)).replace(/"/g, "");
		            $("#TASK_GB").append("<option value='"+JSON.stringify(selectTaskGbSearch[i].task_GB).replace(/"/g, "")+"'>"+JSON.stringify(selectTaskGbSearch[i].task_GB).replace(/"/g, "")+"</option>")
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
<title>프로그램상세</title>

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
                            <li>프로그램 관리</li>
                            <li>&gt;</li>
                            <li><strong>프로그램 상세</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>프로그램 상세</strong></h2></div>
                </div>
                <form:form commandName="programVO" id="programVO" name="programVO" method="post" >

                    <div class="modify_user" >
                        <table >
                          <tr> 
                            <th width="20%" height="23" class="required_text" nowrap >
                                <label for="tmplatNm">
                                    	화면ID
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td width="80%" nowrap="nowrap">
                              <input id="PG_ID" name="PG_ID" type="text" size="60"  maxlength="60" style="width:100%" id="PG_ID"  title="화면ID" value="<c:out value='${programVO.PG_ID}'/>" >
                              <br/> 
                            </td>
                          </tr>
                          <tr> 
                            <th width="20%" height="23" class="required_text" nowrap >
                                <label for="tmplatNm">
                                    	화면명
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td width="80%" nowrap="nowrap">
                              <input id="PG_NM" name="PG_NM" type="text" size="60"  maxlength="60" style="width:100%" title="화면ID" value="<c:out value='${programVO.PG_NM}'/>" >
                              <br/>
                            </td>
                          </tr>
                          <tr> 
                            <th height="23" class="required_text" >
                                <label for="tmplatSeCode">  
                                    	시스템구분
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td>
                            <select id="SYS_GB" name="SYS_GB" class="select" title="시스템구분">
									   <option selected value="" >선택하세요</option>
									      <c:forEach var="sysGb" items="${sysGb}" varStatus="status">
									    	<option value="<c:out value="${sysGb.SYS_GB}"/>" <c:if test="${programVO.SYS_GB == sysGb.SYS_GB}">selected="selected"</c:if> ><c:out value="${sysGb.SYS_GB}" /></option>
									      </c:forEach>
                                <%-- <c:forEach var="result" items="${resultList}" varStatus="status">
                                    <option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
                                </c:forEach>  --%>   
                            </select>&nbsp;&nbsp;&nbsp;<span id="sometext"></span>
                               <br/>
                            </td>
                          </tr> 
                          <tr> 
                            <th height="23" class="required_text" >
                                <label for="tmplatSeCode">  
                                    	업무구분
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td>
                            <select id="TASK_GB" name="TASK_GB" class="select" id="TASK_GB" title="업무구분">
									   <option value="">선택하세요</option>
					      					<c:forEach var="taskGb" items="${taskGb2}" varStatus="status">
									    		<option value="<c:out value="${taskGb.TASK_GB}"/>" <c:if test="${programVO.TASK_GB == taskGb.TASK_GB}">selected="selected"</c:if> ><c:out value="${taskGb.TASK_GB}" /></option>
									    	</c:forEach>	
                            </select>&nbsp;&nbsp;&nbsp;<span id="sometext"></span>
                               <br/>
                            </td>
                          </tr> 
                          <tr> 
                            <th width="20%" height="23" class="required_text" nowrap >
                                <label for="tmplatCours">   
                                    	개발자
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td width="80%" nowrap="nowrap">
                            <select id="USER_DEV_ID" name="USER_DEV_ID" class="select" title="개발자">
									   <option value="" >선택하세요</option>
									      <c:forEach var="DEV_ID" items="${dev_List}" varStatus="status">
									    	<option value="<c:out value="${DEV_ID.USER_NM}"/>" <c:if test="${programVO.USER_DEV_ID == DEV_ID.USER_NM}">selected="selected"</c:if>><c:out value="${DEV_ID.USER_NM}" /></option>
									      </c:forEach>
                                <%-- <c:forEach var="result" items="${resultList}" varStatus="status">
                                    <option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
                                </c:forEach>  --%>   
                            </select>&nbsp;&nbsp;&nbsp;<span id="sometext"></span>
                              <br/>
                            </td>
                          </tr>
                          <tr> 
                            <th width="20%" height="23" class="required_text" nowrap >
                                <label> 
                                    	사용여부
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td width="80%" nowrap="nowrap">
                                Y : <input type="radio" id="USE_YN" name="USE_YN" id="USE_YN" class="radio2" value="Y" <c:if test="${programVO.USE_YN == 'Y'}"> checked="checked"</c:if> >&nbsp;
                                N : <input type="radio" id="USE_YN" name="USE_YN" id="USE_YN" class="radio2" value="N" <c:if test="${programVO.USE_YN == 'N'}"> checked="checked"</c:if> >
                                <br/>
                            </td>
                          </tr>  
                        </table>
                    </div>


                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                      <!-- 목록/저장버튼  -->
                      <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr> 
                          <td>
                              <a onclick="javaScript:fn_egov_regist_tmplatInfo(); return false;">저장</a> 
                          </td>
                          <td>
                              <a href="<c:url value='/tms/pg/PgManage.do'/>" >목록</a>
                          </td>                       
                        </tr>
                      </table>
                    </div>
                    <!-- 버튼 끝 -->                           
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

