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
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css" >
<title>게시판 사용등록</title>
<script type="text/javascript">


function fn_egov_update_updateDefect(){
	alert('저장되었습니다.');
	alert(document.defectVO);
	document.defectVO.action="<c:url value='/tms/defect/updateDefect.do'/>";
	document.defectVO.submit();
}

function fn_egov_delete_deleteDefect() {
	document.defectVO.action="<c:url value='/tms/defect/deleteDefect.do'/>"
	document.defectVO.submit();
}

function fn_egov_delete_defectImg() {
	document.defectVO.action = "<c:url value='/tms/defect/deleteDefectImg.do'/>"
	document.defectVO.submit();
}

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
                            <li>결함관리</li>
                            <li>&gt;</li>
                            <li>결함관리</li>
                            <li>&gt;</li>
                            <li><strong>결함관리상세</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>결함관리상세</strong></h2></div>
                </div>
                
				<form:form commandName="defectVO" name="defectVO" enctype="multipart/form-data" method="post" >
			
					<c:forEach var="defectOne" items="${defectOne}" varStatus="status">
					<div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
					<input type="hidden" name="param_trgetType" value="" />
					
                    <div class="modify_user" >
                        <table summary="결함상세 정보입니다.">
                        
					      <tr>   
					        <th width="12.5%" height="23" nowrap >결함번호
					        </th>
					        <td width="12.5%" nowrap >
					          <input name="defectIdSq" size="5" readonly="readonly" value="<c:out value="${defectOne.defectIdSq}"/>"  maxlength="40" title="결함번호"
					          style="text-align:center; border:none; width:90%;" /> 
					        </td>
					         <th width="12.5%" height="23" nowrap >업무구분
					        </th>
					        <td width="12.5%" nowrap >
					          <input type="text" size="10" readonly="readonly" value="<c:out value="${defectOne.taskGb}"/>"  maxlength="40" title="업무구분"  
					           style="text-align:center; border:none; width:80%;"/> 
					        </td>
					         <th width="12.5%" height="23" nowrap >화면ID
					        </th>
					        <td width="12.5%" nowrap >
					          <input name="pgId" type="text" size="10" readonly="readonly" value="<c:out value="${defectOne.pgId}"/>"  maxlength="40" title="화면ID" 
					          style="text-align:center; border:none; width:90%;" /> 
					        </td>
					        <th width="12.5%" height="23" nowrap >화면명
					        </th>
					        <td width="12.5%" nowrap >
					          <input size="5" readonly="readonly" value="<c:out value="${defectOne.pgNm}"/>"  maxlength="40" title="화면명"
					          style="text-align:center; border:none; width:90%;" /> 
					        </td>
					       </tr>
					       
					      <tr>   
					        <th width="12.5%" height="23" class="" nowrap >결함유형
					        </th>
					        <td width="12.5%" nowrap >
					          <select name="defectGb" id="defectGb" style="width:95%; text-align-last:center;">
									    <c:forEach var="defectGb" items="${defectGb}" varStatus="status">
									    	<option value="<c:out value="${defectGb.code}"/>"
									    	<c:if test="${defectOne.defectGb eq defectGb.codeNm}">selected="selected"</c:if>
									    	><c:out value="${defectGb.codeNm}" /></option>
									    </c:forEach>
							</select>
					        </td>
					         <th width="12.5%" height="23" class="" nowrap >테스터
					        </th>
					        <td width="12.5%" nowrap >
					        <input list="userTestList" name="userNm" value="<c:out value="${defectOne.userTestId}"/>"  autocomplete="off" style="text-align:center; width:85%;"/>
					        	<datalist id="userTestList">
									    <c:forEach var="userList" items="${userList}" varStatus="status">
									    	<option value="<c:out value="${userList.userNm}"/>"  style="text-align:center;"></option>
									    </c:forEach>
					        	</datalist>
					        <input type="hidden" name="userTestId" id="userTestId" value="<c:out value="${defectOne.userTestId}"/>"/>
					        
					        </td>
					         <th width="12.5%" height="23" nowrap >개발자
					        </th>
					        <td width="12.5%" nowrap >
					          <input type="text" size="10" readonly="readonly" value="<c:out value="${defectOne.userDevId}"/>"  maxlength="40" title="개발자" 
					          style="text-align:center; border:none; width:90%;" /> 
					        </td>
					         <th width="12.5%" height="23" nowrap >조치상태
					        </th>
					        <td width="12.5%" nowrap >
					          <select name="actionSt" id="actionSt" style="width:95%; text-align-last:center;">
									    <c:forEach var="actionSt" items="${actionSt}" varStatus="status">
									    	<option value="<c:out value="${actionSt.code}"/>"
									    	<c:if test="${defectOne.actionSt eq actionSt.codeNm}">selected="selected"</c:if>
									    	><c:out value="${actionSt.codeNm}" /></option>
									    </c:forEach>
							</select>
					        </td>
					       </tr>
					       
					      <tr>   
					        <th width="12.5%" height="23" nowrap >결함명
					        </th>
					        <td width="37.5%" nowrap colspan="3">
					          <input id="defectTitle" name="defectTitle" size="5"  value="<c:out value="${defectOne.defectTitle}"/>" autocomplete="off" maxlength="40" title="결함명"
					          style="text-align:center; width:90%;" /> 
					        </td>
					        <th width="12.5%" height="23" nowrap >등록일자
					        </th>
					        <td width="12.5%" nowrap >
					          <input name="enrollDt" size="5" readonly="readonly" value="<c:out value="${defectOne.enrollDt}"/>"  maxlength="40" title="등록일자"
					          style="text-align:center; border:none; width:90%;" /> 
					        </td>
					         <th width="12.5%" height="23" nowrap >조치일자
					        </th>
					        <td width="12.5%" nowrap >
					        <c:choose>
					        <c:when test="${defectOne.actionDt eq null }">
					          <input id="actionDt" name="actionDt" type="text" size="10" readonly="readonly" 
					          value="${defectOne.curDate}"  maxlength="40" title="조치일자" style="text-align:center; border:none; width:90%;" /> 
					        </c:when>
					        <c:otherwise>
					          <input id="actionDt" name="actionDt" type="text" size="10" readonly="readonly" 
					          value="${defectOne.actionDt}"  maxlength="40" title="조치일자" style="text-align:center; border:none; width:90%;" /> 
					        </c:otherwise>
					        </c:choose>
					        </td>
					       </tr>
					       
					       <tr>   
					        <th width="50%" height="23" nowrap colspan="4">결함내용
					        </th>
					        <th width="50%" height="23" nowrap colspan="4">조치내용
					        </th>
					       </tr>
					       
					       <tr>   
					        <td width="50%" nowrap colspan="4">
					         <textarea name="defectContent" style="height:200px; width:98%;"><c:out value="${defectOne.defectContent}"/></textarea>
					        </td>
					        <td width="50%" nowrap colspan="4">
					        <textarea name="actionContent" style="height:200px; width:98%;"><c:out value="${defectOne.actionContent}"/></textarea>
					        </td>
					       </tr>
					       
					       <tr>   
					        <th width="12.5%" height="23" nowrap >첨부파일
					        </th>
					        <td width="87.5%" nowrap colspan="7" >
					        	<c:choose>
					        		<c:when test="${!empty defectImgOne}">
										
					      			 <!--  <a href="#LINK" onclick="javaScript:download_attachment(); return false;"> -->
									<a href="<c:url value='/tms/defect/downloadDefectImg.do'/>?defectIdSq=<c:out value="${defectOne.defectIdSq}"/>">
					        	<img alt="이미지" width="200" height="200" src="<c:url value='/tms/defect/selectDefectImg.do'/>?defectIdSq=<c:out value="${defectOne.defectIdSq}"/>"/>
					        		</a>
					        <br/>
					        		<input type="text" name="fileNm" value="<c:out value="${defectImgOne.fileNm}" />"  readonly="readonly" style="border:none; width:10%; text-align:right"/>
									<input type="text" name="fileSize" value="(<c:out value="${defectImgOne.fileSize}"/>Byte)"  readonly="readonly" style="border:none; width:10%; text-align:left"/>
					        	<a href="#LINK" onclick="javascript:fn_egov_delete_defectImg(); return false;" >삭제</a>
					        		</c:when>
									<c:otherwise>
									첨부파일없음 <input type="file" name="fileImg" title="다운로드"/>
									<br/>
									<input type="hidden" name="fileNm" value="" />
									<input type="hidden" name="fileSize" value="0"/>
								</c:otherwise>					        	
					        </c:choose>
					        </td>
					       </tr>
                        </table>
                    </div>

					<!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                    
                    <a href="#LINK" onclick="javaScript:fn_egov_update_updateDefect(); return false;">저장</a>
                     <a href="#LINK" onclick="javaScript:fn_egov_delete_deleteDefect(); return false;">삭제</a>
                    <a href="<c:url value='/tms/defect/selectDefect.do'/>">목록</a>
                    </div>
                    <!-- 버튼 끝 -->  
                  </c:forEach>
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

