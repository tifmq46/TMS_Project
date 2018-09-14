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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<title>로그인</title>
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >
<link href="<c:url value='/'/>css/login.css" rel="stylesheet" type="text/css" >
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">

$(document).on('keyup','#EMPLYR_ID',function(){
	$.ajax({
		data : {id : this.value},
		url : "/uat/uia/checkId.do",
		success : function(data){
			document.getElementById('checkId').innerHTML="ID가능"
		}
	})
});
			
</script>
</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
<div id="wrap">
    <!-- header 시작 -->
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
                            <li>내부시스템관리</li>
                            <li>&gt;</li>
                            <li>메뉴관리</li>
                            <li>&gt;</li>
                            <li><strong>메뉴목록관리</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>회원가입</strong></h2></div>
                </div>
                <form name="TmsLoginVO" method="post" action ="<c:url value='/uat/uia/addUsr.do'/>">
                    <div class="modify_user" >
                        <table summary="회원가입 화면">
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuNo">회원ID</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <input id="EMPLYR_ID" name="EMPLYR_ID" size="20" maxlength="20" title="메뉴No"/>
						    </td>
						  </tr>
						  <tr>
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuOrdr">회원이름</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <input name="USER_NM" size="20"  maxlength="20" title="메뉴순서" />
						    </td>
						  </tr>  
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuNm">비밀번호</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <input name="PASSWORD" size="30"  maxlength="30" title="메뉴명" />
						    </td>
						  </tr>
						  <tr>
						     <th width="15%" height="23" class="required_text" scope="row"><label for="menuNm">비밀번호 확인</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <input name="CONFIRM_PASSWORD" size="30"  maxlength="30" title="메뉴명" />
						    </td>
						  </tr>
						  <tr>
						    <th width="15%" height="23" class="required_text" scope="row"><label for="upperMenuId">역할</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <input name="ESNTL_ID" size="10"  maxlength="10" title="상위메뉴No"/>
						    </td>
						  </tr>
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">이메일　</label></th>
						    <td width="35%" nowrap="nowrap">
						          &nbsp;
						          <input name="EMAIL_ADRES" size="40"  maxlength="30" title="관련이미지명"/>
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
                            <a href="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>" onclick="javascript:selectList(); return false;">취소</a> 
                          </td>
                          <td width="10"></td>
                          <td>
                            <a href="#LINK" onclick="javascript:insertMenuManage(document.getElementById('menuManageVO')); return false;"><spring:message code="button.save" /></a> 
                          </td>
                        </tr>
                        </table>
                    </div>
                    <!-- 버튼 끝 -->                           
                </form>

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