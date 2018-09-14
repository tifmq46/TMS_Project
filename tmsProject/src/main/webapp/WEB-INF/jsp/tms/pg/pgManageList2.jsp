<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : devResultList.jsp
  * @Description : 개발결과관리 화면
  * @Modification Information
  *
  *   수정일            수정자               수정내용
  *  -------    --------    ---------------------------
  *  2018.08.21 김이수                최초 생성
  *
  * author 사업지원그룹
  * since 2018.08.21
  *
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
<script type="text/javaScript" language="javascript" defer="defer">
    <!--
    /* 글 수정 화면 function */
    function fn_egov_select(id) {
    	document.listForm.selectedId.value = id;
       	document.listForm.action = "<c:url value='/updateSampleView.do'/>";
       	document.listForm.submit();
    }
    
    /* 글 등록 화면 function */
    function fn_egov_addView() {
       	document.listForm.action = "<c:url value='/addSample.do'/>";
       	document.listForm.submit();
    }
    
    /* 글 목록 화면 function */
    function fn_egov_selectList() {
    	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
       	document.listForm.submit();
    }
    
    /* pagination 페이지 링크 function */
    function fn_egov_link_page(pageNo){
    	document.listForm.pageIndex.value = pageNo;
    	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
       	document.listForm.submit();
    }
    
    //-->
</script>
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

<div>
    <form:form commandName="searchVO1" id="listForm" name="listForm" method="post" >
        <input type="hidden" name="selectedId" />
       
        <div id="content_pop">
        	
        	<!-- 타이틀 -->
        	<div id="title" style="width:120%">
        		<ul>
        			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>프로그램 관리</li>
        		</ul>
        	</div>
        	<!-- // 타이틀 -->
        	
        	

			
			
			<div id="search" class="default_tablestyle">
           

        	
        	<div id="paging">
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        		<form:hidden path="pageIndex" />
        	</div>
        	
        	
   
        	
        
    </form:form>
</div>
</body>
</html>