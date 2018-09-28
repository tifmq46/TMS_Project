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
	var idReg = /^[A-za-z]/g;
	if($('#result').html() == '중복된 아이디입니다.')
	{
		alert("아이디가 중복되었습니다.")
	}else if($('#EMPLYR_ID').val().length<4){
		alert("아이디를 4글자 이상 입력하십시오.");
	}else if($('#PASSWORD').val() != $('#CONFIRM_PASSWORD').val()){
		alert("비밀번호가 맞지 않습니다.");
	}else if($.trim($('#PASSWORD').val())=="" || $.trim($('#CONFIRM_PASSWORD').val())=="" || $.trim($('#USER_NM').val())=="" || $.trim($('#ESNTL_ID').val())==""){
		alert("모든 값을 입력해주십시오.")
	}
	else{
		document.TmsLoginVO.submit();
	}
	
	
}

$(document).on('keyup','#CONFIRM_PASSWORD',function(){
		  var pw1 = $('#PASSWORD').val();
		  var pw2 = this.value;
		  if(pw1!=pw2){
			  $("#CONFIRM_PASSWORD_SPAN").css('color','red');
			  $("#CONFIRM_PASSWORD_SPAN").text("동일한 암호를 입력하세요.");
		  }
		  else{
			  $("#CONFIRM_PASSWORD_SPAN").css('color','blue');
			  $("#CONFIRM_PASSWORD_SPAN").text("암호가 확인되었습니다.");
		  }
	
});

$(document).on('keyup','#EMPLYR_ID',function(){
	if(this.value.length <4)
		{
			$("#result").css('color','red');
			$("#result").text("4글자 이상 입력하십시오.");
		}
	else
		{
			$.ajax({
				data : {EMPLYR_ID : this.value},
				url : "<c:url value='/uat/uia/checkId.do'/>",
				success : function(Id){
					if(Id == "notHave")
						{
							$("#result").css('color','blue');
							$("#result").text("사용가능한 아이디입니다.");
						}
					else
						{
							$("#result").css('color','red');
							$("#result").text("중복된 아이디입니다.");
						}
								
					
				}
			})
		}
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
            <div id="content" style="width:800px;">
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
						    <td width="50%" nowrap="nowrap">
						      &nbsp;
						      <input id="EMPLYR_ID" name="EMPLYR_ID" size="20" maxlength="20" title="메뉴No"/>
						      <span style="padding-left:10px;"id="result"></span>
						    </td>
						  </tr>
						  <tr>
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuOrdr">회원이름</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <input id="USER_NM" name="USER_NM" size="20"  maxlength="20" title="메뉴순서" />
						    </td>
						  </tr>  
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuNm">비밀번호</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <input type="password" name="PASSWORD" id="PASSWORD" size="30"  maxlength="30" title="메뉴명" />
						      <span style="padding-left:10px;" id="PASSWORD_SPAN"></span>
						    </td>
						  </tr>
						  <tr>
						     <th width="15%" height="23" class="required_text" scope="row"><label for="menuNm">비밀번호 확인</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <input type="password" id="CONFIRM_PASSWORD" name="CONFIRM_PASSWORD" size="30"  maxlength="30" title="메뉴명" />
						      <span style="padding-left:10px;"id="CONFIRM_PASSWORD_SPAN"></span>
						    </td>
						  </tr>
						  <tr>
						    <th width="15%" height="23" class="required_text" scope="row"><label for="upperMenuId">역할</label><img src="/ebt_webapp/images/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						        <select id="ESNTL_ID" name='ESNTL_ID'>
								  <option value='' selected>-- 선택 --</option>
								  <option value='USRCNFRM_00000000000'>관리자</option>
								  <option value='USRCNFRM_00000000001'>업무PL</option>
								  <option value='USRCNFRM_00000000002'>개발자</option>
								</select>
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