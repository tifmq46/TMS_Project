<%--
  Class Name : EgovBoardUseInfRegist.jsp
  Description : 게시판  사용정보  등록화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.02   이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.04.02
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
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >
<title>게시판 사용등록</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<script type="text/javascript" src="<c:url value='/js/showModalDialog.js'/>" ></script>
<script type="text/javascript">
	
	
    function fn_egov_insert_addDefectImpl(){
    	document.defectVO.action = "<c:url value='/tms/defect/insertDefectImpl.do'/>";
        document.defectVO.submit();
    }
 
    function searchFileNm() {
	    window.open("<c:url value='/sym/prm/TmsProgramListSearch.do'/>",'','width=800,height=600');
	}
    
    
    <!-- 
    function fn_egov_select_viewDefect(){
        document.defectVO.action = "<c:url value='/tms/defect/selectDefect.do'/>";
        document.defectVO.submit();
    }  
    -->
</script>

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
    <div id="header_mainsize"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
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
                            <li>결함관리</li>
                            <li>&gt;</li>
                            <li><strong>결함등록</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>결함등록</strong></h2></div>
                </div>
				<form:form commandName="defectVO" name="defectVO" enctype="multipart/form-data" method="post" >
					<div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
					<input type="hidden" name="param_trgetType" value="" />

                    <div class="modify_user" >
                        <table summary="결함등록 정보입니다.">
					      <tr>   
					        <th width="16.6%" height="23" class="required_text" nowrap >결함번호
					        <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					        <td width="16.6%" nowrap >
					          <input id="defectIdSq" name="defectIdSq" size="5" value="${defectIdSq}"  maxlength="40" title="결함번호"
					          style="text-align:center; width:90%;" /> 
					        </td>
					         <th width="16.6%" height="23" class="required_text" nowrap >화면ID
					         <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					        <td width="16.6%" nowrap >
					          <input id="TmsProgrmFileNm_pg_id" name="pgId" type="text" size="10" value=""  maxlength="40" title="화면ID"  
					           style="text-align:center; width:80%;" readonly="readonly"/> 
					          <a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
	                	<img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a>
					        </td>
					         <th width="16.6%" height="23" class="required_text" nowrap >화면명
					         <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					        <td width="16.6%" nowrap >
					          <input id="TmsProgrmFileNm_pg_nm" type="text" size="10" value=""  maxlength="40" title="화면명" 
					          style="text-align:center; width:90%;" readonly="readonly"/> 
					        </td>
					       </tr>
					       
					      <tr>   
					        <th width="16.6%" height="23" class="required_text" nowrap >업무구분
					        <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					        <td width="16.6%" nowrap >
					          <input id="TmsProgrmFileNm_task_gb" type="text" size="5" value=""  maxlength="40" title="업무구분" 
					          style="text-align:center; width:90%;" readonly="readonly"/> 
					          &nbsp;
					        </td>
					         <th width="16.6%" height="23" class="required_text" nowrap >개발자
					         <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					        <td width="16.6%" nowrap >
					          <input id="TmsProgrmFileNm_user_dev_id" type="text" size="10" value=""  maxlength="40" title="개발자" 
					          style="text-align:center; width:90%;" readonly="readonly"/> 
					          &nbsp;
					        </td>
					         <th width="16.6%" height="23" class="required_text" nowrap >테스터
					         <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					        <td width="16.6%" nowrap >
					          <select name="userTestId" id="userTestId" style="width:90%; text-align-last:center;">
									    <option value="0" selected="selected">선택</option>
									    <c:forEach var="userList" items="${userList}" varStatus="status">
									    	<option value="<c:out value="${userList.userId}"/>"><c:out value="${userList.userNm}" /></option>
									    </c:forEach>
								</select>
					        </td>
					       </tr>
					       
					       <tr >
					       <th width="16.6%" height="23" class="required_text" nowrap >결함제목
					        </th>
					        <td width="49.8%" nowrap colspan="3">
					          <input id="defectTitle" name="defectTitle" type="text" value=""  maxlength="40" title="결함제목" 
					          style="width:98%;"/> 
					          &nbsp;
					        </td>
					       <th width="16.6%" height="23" class="required_text" nowrap >결함유형
					        </th>
					        <td width="16.6%" nowrap>
									<select name="defectGb" id="defectGb" style="width:90%; text-align-last:center;">
									    <option value="0" selected="selected">선택</option>
									    <c:forEach var="defectGb" items="${defectGb}" varStatus="status">
									    	<option value="<c:out value="${defectGb.code}"/>"><c:out value="${defectGb.codeNm}" /></option>
									    </c:forEach>
									</select>
					        </td>
					        
					       </tr>
					       
					       <tr>
					        <th width="100%" height="23" class="required_text" colspan="6" nowrap >결함내용
					        </th>
					       </tr>
					       
					       <tr>
					       <td width="100%" nowrap colspan="6">
					          <textarea id="defectContent" name="defectContent" style="height:200px; width:98%;"></textarea>
					          &nbsp;
					        </td>
					       </tr>
					       
					       <tr>
					       <th width="16.6%" height="23" class="required_text" nowrap >다운로드
					        </th>
					        <td width="83.4%" colspan="5" nowrap >
								<input type="file" name="fileImg" title="다운로드"/>
					        </td>
					       </tr>
					      
                        </table>
                    </div>
					<input id="TmsProgrmFileNm_sys_gb" type="hidden" /> 

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
						<a href="#LINK" onclick="javaScript:fn_egov_insert_addDefectImpl(); return false;">저장</a>
						<a href="<c:url value='/tms/defect/selectDefect.do'/>" >목록</a>
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

