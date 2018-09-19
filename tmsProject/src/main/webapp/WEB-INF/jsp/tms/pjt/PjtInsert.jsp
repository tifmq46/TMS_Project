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

function checkForm() {
	if($.trim($('#PJT_ID').val())=="" || $.trim($('#PJT_NM').val())=="" || $.trim($('#PJT_TYPE').val())=="" || $.trim($('#PJT_ST').val())=="" || $.trim($('#PJT_PM').val())=="" || $.trim($('#DEV_START_DT').val())=="" || $.trim($('#DEV_END_DT').val())=="" || $.trim($('#PJT_START_DT').val())=="" || $.trim($('#PJT_END_DT').val())=="" || $.trim($('#PJT_PRICE').val())==""){
		alert("모든 값을 입력해주십시오.");
	}else if($('#DEV_START_DT').val() > $('#DEV_END_DT').val()){
		alert("계획종료일이 계획시작일보다 빠릅니다.");
	}else if($('#PJT_START_DT').val() > $('#PJT_END_DT').val()){
		alert("개발종료일이 개발시작일보다 빠릅니다.");
	}else if(isNaN($('#PJT_PRICE').val())){
		alert("금액은 숫자로 입력하십시오.");
	}else if($('#PJT_PRICE').val() < 0 ){
		alert("가격은 0이상 입력하십시오.")
	}
		
	else{
		document.TmsProjectManageVO.submit();;
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
            <div id="content" style="width:800px;">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li><strong>프로젝트생성</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>프로젝트 생성</strong></h2></div>
                </div>
                <form name="TmsProjectManageVO" method="post" action ="<c:url value='/sym/prm/insertProject.do'/>">
                    <div class="modify_user" >
                        <table summary="프로젝트 생성 화면">
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuNo">프로젝트ID</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="50%" nowrap="nowrap">
						      &nbsp;
						      <input id="PJT_ID" name="PJT_ID" size="30" maxlength="30" title="메뉴No"/>
						      <span style="padding-left:10px;"id="result"></span>
						    </td>
						  </tr>
						  <tr>
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuOrdr">프로젝트명</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <input id="PJT_NM" name="PJT_NM" size="30"  maxlength="30" title="메뉴순서" />
						    </td>
						  </tr>  
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuNm">사업유형</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <input name="PJT_TYPE" id="PJT_TYPE" size="20"  maxlength="20" title="메뉴명" />
						    </td>
						  </tr>
						  
						  <tr>
						    <th width="15%" height="23" class="required_text" scope="row"><label for="upperMenuId">프로젝트 상태</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						        <select id="PJT_ST" name='PJT_ST'>
								  <option value='' selected>-- 선택 --</option>
								  <option value='대기'>대기</option>
								  <option value='진행중'>진행중</option>
								  <option value='종료'>종료</option>
								</select>
						    </td>
						  </tr>
						  <tr>
						     <th width="15%" height="23" class="required_text" scope="row"><label for="menuNm">PM</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <input id="PJT_PM" name="PJT_PM" size="20"  maxlength="20" title="메뉴명" />
						    </td>
						  </tr>
						   <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">계획시작일</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						          &nbsp;
						          <input style="margin-right:3px;" type="date" id="DEV_START_DT" name="DEV_START_DT" size="40"  maxlength="30" title="관련이미지명"/><img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
						    </td>
						  </tr>
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">계획종료일</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						          &nbsp;
						          <input style="margin-right:3px;" type="date" id="DEV_END_DT" name="DEV_END_DT" size="40"  maxlength="30" title="관련이미지명"/><img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
						    </td>
						  </tr>
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">프로젝트 시작일</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						          &nbsp;
						          <input style="margin-right:3px;" type="date" id="PJT_START_DT" name="PJT_START_DT" size="40"  maxlength="30" title="관련이미지명"/><img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
						    </td>
						  </tr>
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">프로젝트 종료일</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						          &nbsp;
						          <input style="margin-right:3px;" type="date" id="PJT_END_DT" name="PJT_END_DT" size="40"  maxlength="30" title="관련이미지명"/><img src="<c:url value='/'/>images/calendar.gif" width="19" height="19" alt="" />
						    </td>
						  </tr>  
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">금액</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						          &nbsp;
						          <input id="PJT_PRICE" name="PJT_PRICE" size="20"  maxlength="20" title="관련이미지명" placeholder="숫자만 입력하십시오."/>
						    </td>
						  </tr>
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">프로젝트 설명</label></th>
						    <td width="35%" nowrap="nowrap">
						          &nbsp;
						          <textarea name="PJT_CONTENT" title="관련이미지명" cols="50" rows="7"/></textarea>
						    </td>
						  </tr>
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px; float:right;">
                        <!-- 목록/저장버튼  -->
                        <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr> 
                    	  <td>
                            <a href="#LINK" onclick="javascript:checkForm(); return false;"><spring:message code="button.save" /></a> 
                          </td>
                          <td width="10"></td>
                          <td>
                            <a href="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>" onclick="javascript:window.history.back(-1); return false;">취소</a> 
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