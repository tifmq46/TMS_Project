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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css" >
<title>결함관리상세</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="defectVOUpdate" staticJavascript="false" xhtml="true" cdata="false"/>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
function searchFileImg(defectIdSq) {
    window.open("<c:url value='/tms/defect/selectListOneDetail.do'/>?defectIdSq="+defectIdSq,'','width=800,height=600');
}

function fn_egov_update_updateDefect(){
	if (!validateDefectVOUpdate(document.defectVO)){
        return;
    } else {
    document.getElementById("defectGb").disabled = "";
	document.getElementById("actionSt").disabled = "";
	document.getElementById("defectContent").disabled = "";
	document.getElementById("actionContent").disabled = "";
	if(document.getElementById("fileSize").value == 0) {
		document.getElementById("fileImg").disabled = ""
		if (document.getElementById('fileImg').files.length != 0) {
			var fileName = document.getElementById('fileImg').value;
			var strArray = fileName.split('.');
			if (strArray[1] != "jpg" && strArray[1] != "jpeg" && strArray[1] != "png"
				&& strArray[1] != "JPG" && strArray[1] != "JPEG" && strArray[1] != "PNG") {
				swal(strArray[1] + " 형식의 파일은 허용하지 않습니다.");
			} else {
				swal("저장되었습니다.");
				document.defectVO.action="<c:url value='/tms/defect/updateDefect.do'/>";
				document.defectVO.submit();
			}
		} else {
			swal("저장되었습니다.");
			document.defectVO.action="<c:url value='/tms/defect/updateDefect.do'/>";
			document.defectVO.submit();
		}
	} else {
		swal("저장되었습니다.");
		document.defectVO.action="<c:url value='/tms/defect/updateDefect.do'/>";
		document.defectVO.submit();
	}
    }
	
}

function fn_egov_delete_deleteDefect() {
	
	swal({
		text: '삭제하시겠습니까?'
		,buttons : true
	})
	.then((result) => {
		if(result) {
			document.defectVO.action="<c:url value='/tms/defect/deleteDefect.do'/>"
			document.defectVO.submit();
		}else {
			
		}
	});
	/* 
	var con= confirm("삭제하시겠습니까?");
	if( con == true ) {
		swal("정상적으로 삭제되었습니다.")
		document.defectVO.action="<c:url value='/tms/defect/deleteDefect.do'/>"
		document.defectVO.submit();
	}
	 */
}

function fn_egov_delete_defectImg() {
	var con= confirm("삭제하시겠습니까?");
	if( con == true ) {
		swal("정상적으로 삭제되었습니다.")
		document.defectVO.action = "<c:url value='/tms/defect/deleteDefectImg.do'/>"
		document.defectVO.submit();
	}
}
function changeUserTestNm() {
	var userNm = $('#userTestNm').val();
	var pre = userNm.split('(');
	var next = pre[1].split(')');
	document.getElementById("userTestNm").value = pre[0];
	document.getElementById("userTestId").value = next[0];
}

window.onload = function() {
	// 결함관리에서 상세페이지로 이동
	if($('#pageStatus').val() == "0") {
		$("#backBtn").removeAttr('onclick');
		
		if (document.getElementById("uniqId").value == "USRCNFRM_00000000000"
			|| document.getElementById("uniqId").value == "USRCNFRM_00000000001") {
		// 관리자, 업무PL 로그인할 경우
		document.getElementById("defectTitle").readOnly = false;
		document.getElementById("defectTitle").style.border = "1";
		document.getElementById("defectContent").readOnly = false;
		document.getElementById("defectContent").style.border = "1";
		document.getElementById("defectContent").disabled = "";
		document.getElementById("userTestNm").readOnly = false;
		document.getElementById("userTestNm").style.border = "1";
		document.getElementById("defectGb").disabled = "";
		document.getElementById("actionContent").readOnly = false;
		document.getElementById("actionContent").style.border = "1";
		document.getElementById("actionContent").disabled = "";
		document.getElementById("actionSt").disabled = "";
		$(deleteBtn).addClass("abled");
		$(saveBtn).addClass("abled");
		if(document.getElementById("fileSize").value == 0) {
			document.getElementById("fileImg").disabled = "";
		} else {
			$(deleteFileBtn).addClass("abled");
		}
	} else {
		// 일반 로그인
		// 테스터 로그인 - 결함 관련 내용 abled
		if (document.getElementById("loginId").value == document.getElementById("userTestId").value) {
			document.getElementById("defectTitle").readOnly = false;
			document.getElementById("defectTitle").style.border = "1";
			document.getElementById("defectContent").readOnly = false;
			document.getElementById("defectContent").style.border = "1";
			document.getElementById("defectContent").disabled = "";
			document.getElementById("userTestNm").readOnly = false;
			document.getElementById("userTestNm").style.border = "1";
			document.getElementById("defectGb").disabled = "";
			$(deleteBtn).addClass("abled");
			$(saveBtn).addClass("abled");
			if(document.getElementById("fileSize").value == 0){
				document.getElementById("fileImg").disabled = "";
			} else {
				$(deleteFileBtn).addClass("abled");
			}
		} else {
			document.getElementById("defectTitle").readOnly = true;
			document.getElementById("defectTitle").style.border = "0";
			document.getElementById("defectContent").readOnly = true;
			document.getElementById("defectContent").style.border = "0";
			document.getElementById("defectContent").disabled = "disable";
			document.getElementById("userTestNm").readOnly = true;
			document.getElementById("userTestNm").style.border = "0";
			document.getElementById("defectGb").disabled = "disable";
			$(deleteBtn).addClass("disabled");
			$(saveBtn).addClass("disabled");
			if(document.getElementById("fileSize").value == 0) {
				document.getElementById("fileImg").disabled = "disable";
			} else {
				$(deleteFileBtn).addClass("disabled");
			}
		}
		// 개발자 로그인 - 조치 관련 내용 abled
		if (document.getElementById("loginId").value == document.getElementById("userDevId").value) {
			document.getElementById("actionContent").readOnly = false;
			document.getElementById("actionContent").style.border = "1";
			document.getElementById("actionContent").disabled = "";
			document.getElementById("actionSt").disabled = "";
			$(saveBtn).addClass("abled");
		} else {
			document.getElementById("actionContent").readOnly = true;
			document.getElementById("actionContent").style.border = "0";
			document.getElementById("actionContent").disabled = "disable";
			document.getElementById("actionSt").disabled = "disable";
			$(saveBtn).addClass("disabled");
		}

	}
	// 결함처리현황에서 상세페이지로 이동
	} else {
		$("#backBtn").attr('onclick',"javascript:window.history.back(-1); return false;");
		$("#saveBtn").css("display", "none");
		$("#deleteBtn").css("display", "none");
		$("#userTestNm").attr("readOnly", "readOnly");
		$("#userTestNm").css("border", "0");
		$("#defectGb").attr("disabled", "disable");
		$("#actionSt").attr("disabled", "disable");
		$("#defectTitle").attr("readOnly", "readOnly");
		$("#defectTitle").css("border", "0");
		$("#defectContent").attr("disabled", "disable");
		$("#defectContent").css("border", "0");
		$("#actionContent").attr("disabled", "disable");
		$("#actionContent").css("border", "0");
		if($("#fileCheck").val() == "0") {
			$("#fileImg").css("display","none");
		} else {
			$("#deleteFileBtn").css("display","none");
		}
	}
}
</script>

<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
    
 .disabled {
 	   pointer-events:none;
       opacity:0.5;
}
 .abled {
 	   pointer-events:auto;
       opacity:1;
}
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
                            <li>결함관리</li>
                            <li>&gt;</li>
                            <li><strong>결함관리상세</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field" style="font-family:'Malgun Gothic';">
                    <div id="search_field_loc"><h2><strong>결함관리상세</strong></h2></div>
                </div>
                
				<form:form commandName="defectVO" name="defectVO" enctype="multipart/form-data" method="post" >
					<% LoginVO loginVO = (LoginVO) session.getAttribute("LoginVO");
							if (loginVO != null) {
						%>
						<c:set var="loginName" value="<%=loginVO.getName()%>" />
						<c:set var="loginId" value="<%=loginVO.getId()%>" />
						<c:set var="uniqId" value="<%=loginVO.getUniqId()%>" />
						<%
							}
						%>
					<c:forEach var="defectOne" items="${defectOne}" varStatus="status">
					<div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
					<input type="hidden" name="param_trgetType" value="" />
					
                    <div class="modify_user" >
                        <table summary="결함상세 정보입니다.">
                        
					      <tr>   
					        <th width="12.5%" height="23" nowrap >결함번호
					        </th>
					        <td width="12.5%" nowrap>
					          <input type="text" name="defectIdSq" size="5" readonly="readonly" value="<c:out value="${defectOne.defectIdSq}"/>"  maxlength="40" title="<c:out value="${defectOne.defectIdSq}"/>"
					           style="text-align:center; border:none; width:90%;" /> 
					          <form:errors path="defectIdSq" />
					        </td>
					         <th width="12.5%" height="23" nowrap >업무구분
					        </th>
					        <td width="12.5%" nowrap >
					          <input type="text" size="10" readonly="readonly" value="<c:out value="${defectOne.taskGb}"/>"  maxlength="40" title="<c:out value="${defectOne.taskGb}"/>"  
					           style="text-align:center; border:none; width:80%; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;"/> 
					        </td>
					         <th width="12.5%" height="23" nowrap >화면ID
					        </th>
					        <td width="12.5%" nowrap >
					          <input name="pgId" type="text" size="10" readonly="readonly" value="<c:out value="${defectOne.pgId}"/>"  maxlength="40" title="<c:out value="${defectOne.pgId}"/>" 
					          style="text-align:center; border:none; width:90%; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" /> 
					          <form:errors path="pgId" />
					        </td>
					        <th width="12.5%" height="23" nowrap >화면명
					        </th>
					        <td width="12.5%" nowrap >
					          <input size="5" readonly="readonly" value="<c:out value="${defectOne.pgNm}"/>"  maxlength="40" title="<c:out value="${defectOne.pgNm}"/>"
					          style="text-align:center; border:none; width:90%; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" /> 
					        </td>
					       </tr>
					       
					      <tr>   
					         <th width="12.5%" height="23" class="" nowrap >테스터
					        </th>
					        <td width="12.5%" nowrap >
							  <input list="userTestList" name="userNm" id="userTestNm" value="<c:out value="${defectOne.userTestNm}"/>"  autocomplete="off" style="text-align:center; width:90%;"
							  onchange="javascript:changeUserTestNm()"/>
					        	<c:if test="${loginId == defectOne.userTestId || uniqId == 'USRCNFRM_00000000000' || uniqId == 'USRCNFRM_00000000001' }">
					        	<c:if test="${pageStatus == '0' }">
					        	<datalist id="userTestList">
									    <c:forEach var="userList" items="${userList}" varStatus="status">
									    	<option value="<c:out value="${userList.userNm}"/>(<c:out value="${userList.emplyrId}"/>)"  style="text-align:center;"></option>
									    </c:forEach>
					        	</datalist>
					        	</c:if>
					        	</c:if>
					        	<form:errors path="userNm" />
					        	<input type="hidden" id="userTestId" name="userTestId" value="<c:out value="${defectOne.userTestId }"/>"/>
					        </td>
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
							  <form:errors path="defectGb" />
					        </td>
					         <th width="12.5%" height="23" nowrap >개발자
					        </th>
					        <td width="12.5%" nowrap >
					          <input type="text" id="userDevNm" size="10" readonly="readonly" value="<c:out value="${defectOne.userDevNm}"/>"  maxlength="40" title="<c:out value="${defectOne.userDevId}"/>" 
					          style="text-align:center; border:none; width:90%;" /> 
					        <input type="hidden" id="userDevId" name="userDevId" value="${defectOne.userDevId }"/>
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
							<form:errors path="actionSt" />
					        </td>
					       </tr>
					       
					      <tr>   
					        <th width="12.5%" height="23" nowrap >결함명
					        </th>
					        <td width="37.5%" nowrap colspan="3">
					          <input id="defectTitle" name="defectTitle" size="5"  value="<c:out value="${defectOne.defectTitle}"/>" autocomplete="off" maxlength="40" title="결함명"
					          style="width:90%;" /> 
					          <form:errors path="defectTitle" />
					        </td>
					        <th width="12.5%" height="23" nowrap >등록일자
					        </th>
					        <td width="12.5%" nowrap >
					          <input name="enrollDt" size="5" readonly="readonly" value="<c:out value="${defectOne.enrollDt}"/>"  maxlength="40" title="<c:out value="${defectOne.enrollDt}"/>"
					          style="text-align:center; border:none; width:90%;" /> 
					        </td>
					         <th width="12.5%" height="23" nowrap >조치일자
					        </th>
					        <td width="12.5%" nowrap >
					        <c:choose>
					        <c:when test="${defectOne.actionDt eq null }">
					          <input id="actionDt" name="actionDt" type="text" size="10" readonly="readonly" 
					          value="<c:out value="${defectOne.curDate}"/>"  maxlength="40" title="조치일자" style="text-align:center; border:none; width:90%;" /> 
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
					         <textarea name="defectContent" id="defectContent" style="height:200px; width:98%; background-color:#FFF !important;"><c:out value="${defectOne.defectContent}"/></textarea>
						        <form:errors path="defectContent" />
					        </td>
					        <td width="50%" nowrap colspan="4">
					        <textarea name="actionContent" id="actionContent" style="height:200px; width:98%; background-color:#FFF !important;"><c:out value="${defectOne.actionContent}"/></textarea>
					        </td>
					       </tr>
					       
					       <tr>   
					        <th width="12.5%" height="23" nowrap >첨부파일
					        </th>
					        <td width="87.5%" nowrap colspan="7" >
					        	<c:choose>
					        		<c:when test="${!empty defectImgOne}">
					        		<img src="<c:url value='/images/tms/fileclip.JPG' />" width="12" height="12" alt="required"/>
					        	<font color="#666666">
					        	   <a href="<c:url value='/tms/defect/selectListOneDetail.do'/>?defectIdSq=<c:out value="${defectOne.defectIdSq}"/>" target="_blank" title="미리보기" onclick="javascript:searchFileImg(${defectOne.defectIdSq}); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
									<c:out value="${defectImgOne.fileNm}" />
									</a>
									<input type="hidden" id="fileNm" name="fileNm" value="<c:out value="${defectImgOne.fileNm}" />"  readonly="readonly" style="border:none; width:; text-align:right"/>
									<fmt:formatNumber var="fileSizeKb" pattern=".0" value="${defectImgOne.fileSize/1024}" />
									(<c:out value="${fileSizeKb}"/>KB)
									<input type="hidden" id="fileSize" name="fileSize" value="<c:out value="${defectImgOne.fileSize}"/>"  readonly="readonly" style="border:none; width:; text-align:center"/>
					        	</font>
					        	&nbsp;<a href="<c:url value='/tms/defect/downloadDefectImg.do'/>?defectIdSq=<c:out value="${defectOne.defectIdSq}"/>">
					        		<font color="#0F438A">다운로드</font>
					        		</a>
					        	&nbsp;<a href="#LINK" id="deleteFileBtn" onclick="javascript:fn_egov_delete_defectImg(); return false;" ><font color="#0F438A">삭제</font></a>
					        		<input type="hidden" id="fileCheck" value="1">
					        		</c:when>
									<c:otherwise>
									첨부파일없음 <input type="file" name="fileImg" id="fileImg" title="다운로드" accept=".jpg, .jpeg, .png"/>
									<br/>
					        		<input type="hidden" id="fileCheck" value="0">
									<input type="hidden" name="fileNm" value="" />
									<input type="hidden" id="fileSize" name="fileSize" value="0"/>
								</c:otherwise>					        	
					        </c:choose>
					        </td>
					       </tr>
                        </table>
                    </div>
					<input type="hidden" id="loginNm" value="<c:out value='${loginName }'/>" />
					<input type="hidden" id="loginId" value="<c:out value='${loginId }'/>" />
					<input type="hidden" id="uniqId" value="<c:out value='${uniqId }'/>" />
					<input type="hidden" id="pageStatus" value="<c:out value='${pageStatus }'/>" />
						<!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                    
                    <a href="#LINK" id="saveBtn" onclick="javaScript:fn_egov_update_updateDefect(); return false;">저장</a>
                     <a href="#LINK" id="deleteBtn" onclick="javaScript:fn_egov_delete_deleteDefect(); return false;">삭제</a>
                    <a href="<c:url value='/tms/defect/selectDefect.do'/>" id="backBtn" >목록</a>
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

