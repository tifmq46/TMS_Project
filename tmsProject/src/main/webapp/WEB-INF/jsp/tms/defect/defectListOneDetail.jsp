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
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css" >
<title>파일이미지보기</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="defectVOUpdate" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">

function closeFileImg(){
	window.close();
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
	<img alt="이미지" width="100%" height="100%" src="<c:url value='/tms/defect/selectDefectImg.do'/>?defectIdSq=<c:out value="${defectIdSq}"/>" onClick="javascript:closeFileImg()"/>
</body>
</html>

