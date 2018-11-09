<%--
  Class Name : EgovLoginUsr.jsp
  Description : 로그인화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    박지욱             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀  박지욱
    since    : 2009.03.10
--%>
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
<title>프로젝트 수정</title>
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >
<link href="<c:url value='/'/>css/login.css" rel="stylesheet" type="text/css" >
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="tmsProjectManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">

function checkForm() {
		if(!validateTmsProjectManageVO(document.tmsProjectManageVO)){
			return;
		} else {
			var message = "";
			if($('#pjtStartDt').val() == "" || $('#pjtEndDt').val() == "") {
				if(message == "") {
					message += "사업기간은(는) 필수 입력값입니다.";
				} else {
					message += "\n사업기간은(는) 필수 입력값입니다.";
				}
			}
			if($('#devStartDt').val() == "" || $('#devEndDt').val() == "") {
				if(message == "") {
					message += "개발기간은(는) 필수 입력값입니다.";
				} else {
					message += "\n개발기간은(는) 필수 입력값입니다.";
				}
			}
			
			if($('#pjtStartDt').val() > $('#pjtEndDt').val()){
				if(message == "") {
					message += "사업종료일이 사업시작일보다 빠릅니다.";
				} else {
					message += "\n사업종료일이 사업시작일보다 빠릅니다.";
				}
			}
			if($('#devStartDt').val() > $('#devEndDt').val()){
				if(message == "") {
					message += "개발종료일이 개발시작일보다 빠릅니다.";
				} else {
					message += "\n개발종료일이 개발시작일보다 빠릅니다.";
				}
			} 
			if($('#devStartDt').val() > $('#devEndDt').val()){
				if(message == "") {
					message += "개발종료일이 개발시작일보다 빠릅니다.";
				} else {
					message += "\n개발종료일이 개발시작일보다 빠릅니다.";
				}
			}
			if($('#planStartDt').val() > $('#planEndDt').val()){
				if(message == "") {
					message += "계획종료일이 계획시작일보다 빠릅니다.";
				} else {
					message += "\n계획종료일이 계획시작일보다 빠릅니다.";
				}
			}
			if($('#inputStartDt').val() > $('#inputEndDt').val()){
				if(message == "") {
					message += "계획입력종료일이 계획입력시작일보다 빠릅니다.";
				} else {
					message += "\n계획입력종료일이 계획입력시작일보다 빠릅니다.";
				}
			}
			
			if(message == "") {
				
	        	swal("저장되었습니다.")
				.then((value) => {
					document.tmsProjectManageVO.action ="<c:url value='/sym/prm/updateProjectImpl.do'/>";
					document.tmsProjectManageVO.submit();
				});
			} else {
				swal(message);				
			}
		}
}
</script>
</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
<div id="wrap">
    <!-- header 시작 -->
    <div id="topnavi" style="margin:0;"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>       
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
                            <li><strong>프로젝트수정</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field" style="font-family:'Malgun Gothic';">
                    <div id="search_field_loc"><h2><strong>프로젝트 수정</strong></h2></div>
                </div>
                <form:form name="tmsProjectManageVO" commandName="tmsProjectManageVO" method="post">
                    <div class="modify_user" >
                        <table summary="프로젝트 생성 화면">
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuNo">프로젝트ID</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="50%" nowrap="nowrap">
						      &nbsp;
						      <input id="pjtId" name="pjtId" readOnly="readOnly" maxlength="30" value="<c:out value='${tmsProjectManageVO.pjtId }'/>" style="width:25%;" title="프로젝트ID" />
						      <form:errors path="pjtId" />
						    </td>
						  </tr>
						  <tr>
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuOrdr">프로젝트명</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="50%" nowrap="nowrap">
						      &nbsp;
						      <input id="pjtNm" name="pjtNm" maxlength="30" value="<c:out value='${tmsProjectManageVO.pjtNm }'/>"style="width:25%;" title="프로젝트명" />
						      <form:errors path="pjtNm" />
						    </td>
						  </tr>  
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuNm">사업유형</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="50%" nowrap="nowrap">
						      &nbsp;
						      <input name="pjtType" id="pjtType" maxlength="20" value="<c:out value='${tmsProjectManageVO.pjtType }'/>"style="width:25%;" title="사업유형" />
						      <form:errors path="pjtType" />
						    </td>
						  </tr>
						  
						  <tr>
						    <th width="15%" height="23" class="required_text" scope="row"><label for="upperMenuId">사업상태</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="50%" nowrap="nowrap">
						      &nbsp;
						        <select id="pjtSt" name="pjtSt" style="width:25%; text-align-last:center;">
						        <c:choose>
						        <c:when test="${tmsProjectManageVO.pjtSt eq '계획' }">
						         <option value='계획' selected>계획</option>
								  <option value='진행'>진행</option>
								  <option value='완료'>완료</option>
						        </c:when>
						        <c:when test="${tmsProjectManageVO.pjtSt eq '진행' }">
						         <option value='계획'>계획</option>
								  <option value='진행' selected>진행</option>
								  <option value='완료'>완료</option>
						        </c:when>
						        <c:otherwise>
						         <option value='계획'>계획</option>
								  <option value='진행'>진행</option>
								  <option value='완료' selected>완료</option>
						        </c:otherwise>
						        </c:choose>
								 
								</select>
						      <form:errors path="pjtSt" />
						    </td>
						  </tr>
						  <tr>
						     <th width="15%" height="23" class="required_text" scope="row"><label for="menuNm">PM</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="50%" nowrap="nowrap">
						      &nbsp;
						      <input id="pjtPm" name="pjtPm" value="<c:out value='${tmsProjectManageVO.pjtPm }'/>"style="width:25%;" maxlength="20" title="PM" />
						      <form:errors path="pjtPm" />
						    </td>
						  </tr>
						  <tr>
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">사업비</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="50%" nowrap="nowrap">
						          &nbsp;
						          <input value="<c:out value='${tmsProjectManageVO.pjtPrice }'/>"id="pjtPrice" name="pjtPrice" value="" style="width:25%;"  maxlength="20" title="금액" placeholder="숫자만 입력하십시오."/>
						    		<form:errors path="pjtPrice" />
						    </td>
						  </tr>
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">사업기간</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="50%" nowrap="nowrap">
						          &nbsp;
						          <input value="<fmt:formatDate value='${tmsProjectManageVO.pjtStartDt}' pattern="yyyy-MM-dd"/>"style="margin-right:3px;" type="date" id="pjtStartDt" name="pjtStartDt" style="width:25%;"  maxlength="30" title="관련이미지명"/>
						          <img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" /> ~ <input value="<fmt:formatDate value='${tmsProjectManageVO.pjtEndDt}' pattern="yyyy-MM-dd"/>"style="margin-right:3px;" type="date" id="pjtEndDt" name="pjtEndDt" title="관련이미지명" style="width:25%;"/>
						          <img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
						    </td>
						  </tr>
						   <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">개발기간</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="50%" nowrap="nowrap">
						          &nbsp;
						          <input value="<fmt:formatDate value='${tmsProjectManageVO.devStartDt}' pattern="yyyy-MM-dd"/>"style="margin-right:3px;" type="date" id="devStartDt" name="devStartDt" style="width:25%;" maxlength="40" title="관련이미지명"/>
						          <img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" /> ~ <input value="<fmt:formatDate value='${tmsProjectManageVO.devEndDt}' pattern="yyyy-MM-dd"/>"style="margin-right:3px;" type="date" id="devEndDt" name="devEndDt" style="width:25%;"  maxlength="30" title="관련이미지명"/>
						          <img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
						    </td>
						  </tr>
						 <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">계획기간</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="50%" nowrap="nowrap">
						          &nbsp;
						          <input value="<fmt:formatDate value='${tmsProjectManageVO.planStartDt}' pattern="yyyy-MM-dd"/>"style="margin-right:3px;" type="date" id="planStartDt" name="planStartDt" style="width:25%;"  maxlength="30" title="관련이미지명"/>
						          <img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" /> ~ <input value="<fmt:formatDate value='${tmsProjectManageVO.planEndDt}' pattern="yyyy-MM-dd"/>"style="margin-right:3px;" type="date" id="planEndDt" name="planEndDt" title="관련이미지명" style="width:25%;"/>
						          <img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
						    </td>
						  </tr>
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">계획입력기간</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="50%" nowrap="nowrap">
						          &nbsp;
						          <input value="<fmt:formatDate value='${tmsProjectManageVO.inputStartDt}' pattern="yyyy-MM-dd"/>" style="margin-right:3px;" type="date" id="inputStartDt" name="inputStartDt" style="width:25%;" maxlength="40" title="관련이미지명"/>
						          <img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" /> ~ <input value="<fmt:formatDate value='${tmsProjectManageVO.inputEndDt}' pattern="yyyy-MM-dd"/>" style="margin-right:3px;" type="date" id="inputEndDt" name="inputEndDt" style="width:25%;"  maxlength="30" title="관련이미지명"/>
						          <img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
						    </td>
						  </tr>
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">프로젝트 설명</label></th>
						    <td width="35%" nowrap="nowrap">
						          &nbsp;
						          <textarea id="pjtContent" name="pjtContent" title="프로젝트 설명" style=" height:100px; width:50%;"/><c:out value='${tmsProjectManageVO.pjtContent }'/></textarea>
						    </td>
						  </tr>
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                        <!-- 목록/저장버튼  -->
                            <a href="#LINK" onclick="javascript:checkForm(); return false;"><spring:message code="button.save" /></a> 
                            <a href="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>" onclick="javascript:window.history.back(-1); return false;">취소</a> 
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