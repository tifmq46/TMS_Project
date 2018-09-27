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
<script type="text/javascript">
    
    
    function fn_egov_select_tmplatInfo(){
        document.pgVO.action = "<c:url value='/cop/com/selectTemplateInfs.do'/>";
        document.pgVO.submit();  
    }
    
    function fn_egov_regist_tmplatInfo(){
        document.programVO.action = "<c:url value='/tms/pg/Pgupdate.do'/>";
        document.programVO.submit();
    
	}


    function fn_egov_previewTmplat() {
        var frm = document.templateInf;
        
        var url = frm.tmplatCours.value;

        var target = "";

        if (frm.tmplatSeCode.value == 'TMPT01') {
            target = "<c:url value='/cop/bbs/previewBoardList.do'/>";
            width = "1024";
        } else {
            alert('<spring:message code="cop.tmplatCours" /> 지정 후 선택해 주세요.');
        }

        if (target != "") {
            window.open(target + "?searchWrd="+url, "preview", "width=" + width + "px, height=500px;");
        }
    }
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
                              <input id="PG_ID" name="PG_ID" type="text" size="60"  maxlength="60" style="width:100%" id="PG_ID"  title="화면ID"
                               value="<c:out value='${programVO.PG_ID}'/>" >
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
                              <input id="PG_NM" name="PG_NM" type="text" size="60"  maxlength="60" style="width:100%" title="화면ID"
                               value="<c:out value='${programVO.PG_NM}'/>" >
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
                            <select id="SYS_GB" name="SYS_GB" class="select" id="SYS_GB" title="시스템구분" >
                                   <option selected value=''>--선택하세요--</option>
                                   <option <c:if test="${programVO.SYS_GB == '철도1'}"> selected</c:if> value="철도1"><c:out value="철도1"/></option>
                                   <option <c:if test="${programVO.SYS_GB == '철도2'}"> selected</c:if> value="철도2"><c:out value="철도2"/></option>
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
                            <select id="TASK_GB" name="TASK_GB" class="select" onchange="fn_egov_selectTmplatType(this)" id="TASK_GB" title="업무구분">
                                   <option selected value=''>--선택하세요--</option>
                                   <option <c:if test="${programVO.TASK_GB == '철도1'}"> selected</c:if> value="철도1"><c:out value="철도1"/></option>
                                   <option <c:if test="${programVO.TASK_GB == '철도2'}"> selected</c:if> value="철도2"><c:out value="철도2"/></option>
                                <%-- <c:forEach var="result" items="${resultList}" varStatus="status">
                                    <option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
                                </c:forEach>   --%>  
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
                              <input id="USER_DEV_ID" name="USER_DEV_ID" type="text" size="60"  maxlength="60" style="width:100%" title="개발자"
                                value="<c:out value='${programVO.USER_DEV_ID}'/>" >
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
                            <td width="80%" nowrap="nowrap" >
                                Y : <input type="radio" id="USE_YN" name="USE_YN" id="USE_YN" class="radio2" value="Y" <c:if test="${programVO.USE_YN == 'Y'}"> checked="checked"</c:if> >&nbsp;
                                N : <input type="radio" id="USE_YN" name="USE_YN" id="USE_YN" class="radio2" value="N" <c:if test="${programVO.USE_YN == 'N'}"> checked="checked"</c:if> >                            
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

