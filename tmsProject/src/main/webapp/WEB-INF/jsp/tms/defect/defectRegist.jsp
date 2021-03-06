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
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css" >
<title>결함 등록</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="defectVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/showModalDialog.js'/>" ></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.js"></script>
<script src="https://unpkg.com/sweetswal/dist/sweetswal.min.js"></script>
<script type="text/javascript" language="javascript" defer="defer">

	function fn_egov_insert_addDefectImpl() {
		if (!validateDefectVO(document.defectVO)) {
			return;
		} else {
			var fileLength = document.getElementById('fileImg').files.length;
			if (fileLength == 0) {
				swal({
		   			text: '등록하시겠습니까?'
		   			,buttons : true
		   		})
		   		.then((result) => {
		   			if(result) {
		   				document.defectVO.action = "<c:url value='/tms/defect/insertDefectImpl.do'/>";
						document.defectVO.submit();		
		   			}
		   			   			
		   		});
			} else {
				var fileName = document.getElementById('fileImg').value;
				var strArray = fileName.split('.');
				if (strArray[1] != "jpg" && strArray[1] != "jpeg" && strArray[1] != "png"
						&& strArray[1] != "JPG" && strArray[1] != "JPEG" && strArray[1] != "PNG") {
					swal(strArray[1] + " 형식의 파일은 허용하지 않습니다.");
				} else {
					swal({
			   			text: '등록하시겠습니까?'
			   			,buttons : true
			   		})
			   		.then((result) => {
			   			if(result) {
			   				document.defectVO.action = "<c:url value='/tms/defect/insertDefectImpl.do'/>";
							document.defectVO.submit();	  
			   			}
			   		});
				}
			}
		}
	}

	function searchFileNm() {
		window.open("<c:url value='/sym/prm/TmsProgramListSearch.do'/>", '',
				'width=800,height=600');
	}

	function pgIdSearch(){
		swal("화면ID를 검색하십시오.");
	}

	<!--
	function fn_egov_select_viewDefect() {
		document.defectVO.action = "<c:url value='/tms/defect/selectDefect.do'/>";
		document.defectVO.submit();
	}
	-->
	
	$(document).ready(function(){
		$("#TmsProgrmFileNm_pg_full").focus();	
		$("#TmsProgrmFileNm_pg_full").on('keyup', function(){
			searchFileNm();
		});
	});
	
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
            <div id="content" style="font-family:'Malgun Gothic';">
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
                <div id="search_field" style="font-family:'Malgun Gothic';">
                    <div id="search_field_loc"><h2><strong>결함등록</strong></h2></div>
                </div>

				<form:form commandName="defectVO" name="defectVO" enctype="multipart/form-data" method="post" >
					<div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
					<input type="hidden" name="param_trgetType" value="" />

                    <div class="modify_user" >
                        <table summary="결함등록 정보입니다.">
					      <tr>   
					        <th width="15%" height="23" class="required_text" nowrap >결함번호
					        <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					        <td width="12%" nowrap >
					          <input id="defectIdSq" name="defectIdSq" size="5" value="${defectIdSq}"  maxlength="40" title="결함번호"
					          style="text-align:center; border:none; width:90%;" /> 
					          <form:errors path="defectIdSq" />
					        </td>
					         <th width="15%" height="23" class="required_text" nowrap >화면ID
					         <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					        <td width="28%" nowrap >
					           <input type="text" id="TmsProgrmFileNm_pg_full"
					           style="text-align:center; width:90%;" onclick="javascript:searchFileNm(); return false;"/>
					          <input type="hidden" id="TmsProgrmFileNm_pg_id" name="pgId" size="" value=""  title="화면ID"  
					           style="text-align:center;" readonly="readonly" onclick="javascript:searchFileNm(); return false;"/> 
					           <form:errors path="pgId" />
					          <a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
	                			<img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a>
					        </td>
					         <th width="15%" height="23" class="required_text" nowrap >개발자
					         <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					        <td width="15%" nowrap >
					          <input id="TmsProgrmFileNm_user_dev_id" type="text" size="10" value=""  maxlength="40" title="개발자" 
					          style="text-align:center; width:90%;" readonly="readonly" onclick="javascript:pgIdSearch(); return false;"/> 
					          &nbsp;
					        </td>
					       </tr>

					      <tr>   
					        <th width="15%" height="23" class="required_text" nowrap >시스템구분
					        <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					        <td width="12%" nowrap >
					          <input id="TmsProgrmFileNm_sys_gb" type="text" size="5" value=""  maxlength="40" title="업무구분" 
					          style="text-align:center; width:85%;" readonly="readonly" onclick="javascript:pgIdSearch(); return false;"/> 
					          &nbsp;
					        </td>
					        <th width="15%" height="23" class="required_text" nowrap >업무구분
					        <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					        <td width="28%" nowrap >
					          <input id="TmsProgrmFileNm_task_gb" type="text" size="5" value=""  maxlength="40" title="업무구분" 
					          style="text-align:center; width:90%;" readonly="readonly" onclick="javascript:pgIdSearch(); return false;"/> 
					          &nbsp;
					        </td>
					        
					         <th width="15%" height="23" class="required_text" nowrap >테스터
					         <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
								<%
									LoginVO loginVO = (LoginVO) session.getAttribute("LoginVO");
										if (loginVO == null) {
								%>

								<%
									} else {
								%>

								<c:set var="loginName" value="<%=loginVO.getName()%>" />
								<c:set var="loginId" value="<%=loginVO.getId()%>" />
									<%
								}
								%>
								<td width="15%" nowrap >
					        	<input name="userNm" value='${loginName}'  autocomplete="off" readOnly="readOnly" style="text-align:center; width:90%" />
					        	<form:errors path="userNm" />
								<input type="hidden" name="userTestId" value="${loginId }"/>
					       		 </td>
					       </tr>

					       <tr >
					       <th width="15%" height="23" class="required_text" nowrap >결함명
					       <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					        <td width="55%" nowrap colspan="3">
					          <input id="defectTitle" name="defectTitle" type="text" value=""  autocomplete="off" maxlength="40" title="결함제목" 
					          style="width:95%;"/> 
					          <form:errors path="defectTitle" />
					          &nbsp;
					        </td>
					       <th width="15%" height="23" class="required_text" nowrap >결함유형
					       <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					        <td width="15%" nowrap>
									<select name="defectGb" id="defectGb" style="width:95%; text-align-last:center;">
									    <option value="" selected="selected">선택</option>
									    <c:forEach var="defectGb" items="${defectGb}" varStatus="status">
									    	<option value="<c:out value="${defectGb.code}"/>"><c:out value="${defectGb.codeNm}" /></option>
									    </c:forEach>
									</select>
									<form:errors path="defectGb" />
					        </td>
					       </tr>

					       <tr>
					        <th width="100%" height="23" class="required_text" colspan="6" nowrap >결함내용
					        <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
					        </th>
					       </tr>

					       <tr>
					       <td width="100%" nowrap colspan="6">
					          <textarea id="defectContent" name="defectContent" style="height:200px; width:98%; margin-top:5px;"></textarea>
					         <form:errors path="defectContent" />
					          &nbsp;
					        </td>
					       </tr>

					       <tr>
					       <th width="15%" height="23" class="required_text" nowrap >첨부파일
					        </th>
					        <td width="85%" colspan="5" nowrap >
								<input type="file" name="fileImg" id="fileImg" title="첨부파일" accept=".jpg, .jpeg, .png"/>
					        </td>
					       </tr>
                        </table>
                    </div>
                     <input type="hidden" id="TmsProgrmFileNm_pg_nm" name="pgNm" size="" value=""  title="화면명"  
					           style="text-align:center;" readonly="readonly" onclick="javascript:searchFileNm(); return false;"/> 
					         
					<input id="TmsProgrmFileNm_user_real_id" type="hidden" />
					<input id="TmsProgrmFileNm_task_gb_code" type="hidden" />
					<input type="hidden" id="testscenarioId" name="testscenarioId" value="<c:out value="${testscenarioId}"/>"/>
					<input type="hidden" id="aaa" name="aaa" value="" />

              <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
						<a href="#LINK" onclick="javaScript:fn_egov_insert_addDefectImpl(); return false;"><spring:message code="button.save" /></a>
						<a href="<c:url value='/tms/defect/selectDefect.do'/>" ><spring:message code="button.list" /></a>
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