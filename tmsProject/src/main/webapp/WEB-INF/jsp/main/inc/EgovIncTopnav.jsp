<%--
  Class Name : EgovIncTopnav.jsp
  Description : 상단메뉴화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
<!-- topmenu start -->
<script type="text/javascript">

    function getLastLink(baseMenuNo){
    	var tNode = new Array;
        for (var i = 0; i < document.menuListForm.tmp_menuNm.length; i++) {
            tNode[i] = document.menuListForm.tmp_menuNm[i].value;
            var nValue = tNode[i].split("|");
            //선택된 메뉴(baseMenuNo)의 하위 메뉴중 첫번재 메뉴의 링크정보를 리턴한다.
            if (nValue[1]==baseMenuNo) {
                if(nValue[5]!="dir" && nValue[5]!="" && nValue[5]!="/"){
                    //링크정보가 있으면 링크정보를 리턴한다.
                    return nValue[5];
                }else{
                    //링크정보가 없으면 하위 메뉴중 첫번째 메뉴의 링크정보를 리턴한다.
                    return getLastLink(nValue[0]);
                }
            }
        }
    }
    function goMenuPage(baseMenuNo){
    	document.getElementById("baseMenuNo").value=baseMenuNo;
    	document.getElementById("link").value="forward:"+getLastLink(baseMenuNo);
        //document.menuListForm.chkURL.value=url;
        document.menuListForm.action = "<c:url value='/EgovPageLink.do'/>";
        document.menuListForm.submit();
    }
    function actionLogout()
    {
        document.selectOne.action = "<c:url value='/uat/uia/actionLogout.do'/>";
        document.selectOne.submit();
        //document.location.href = "<c:url value='/j_spring_security_logout'/>";
    }

</script>
<style>
#menu_login:hover {
	
	background-color: #C8D7FF;
}
#menu:hover {
	
	background-color: rgba( 255, 255, 255, 0.05 );
}
</style>
<fieldset><legend>조건정보 영역</legend>
<div class="nav_container" style="padding:0 20px; font-family:'Malgun Gothic';">
	<ul>
	    <a href="<c:url value='/'/>uat/uia/actionMain.do" style="float:left; border-right:1px solid rgba(0, 0, 0, 0.21); padding-top:15px; padding-bottom:16px; padding-left:18px;" >
		    <strong style="font-size:14.25px; text-shadow:0 1px 0 #000000; margin-right:90px;">KCC TMS</strong>
		    <i style="padding-top:5px; padding-bottom:5px; padding-left:5px;" class="icon-reorder"></i>
	    </a>
		<c:forEach var="result" items="${list_headmenu}" varStatus="status">
	        <li><a id="menu" href="#LINK" style="padding-top:18px; font-size:12px; float:left; padding-bottom:18px; padding-left:18px;" onclick="javascript:goMenuPage('<c:out value="${result.menuNo}"/>')"><c:out value="${result.menuNm}"/></a></li>  
	    </c:forEach>
	     <div id="menu" class="dropdown" style="float:right; border-left:1px solid rgba(0, 0, 0, 0.20); padding-top:18px; padding-bottom:18px; padding-left:18px;">
		    <li style="color:white; font-size:12px; text-shadow:0 1px 0 #000000;">
		<%
        LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
        if(loginVO == null){
        %>
       
	  	<%
        }else{
	  	%>
	  	    	<c:set var="loginName" value="<%= loginVO.getName()%>"/>
            	<font style="font-size:12px;">KCC정보통신 ㅣ <c:out value="${loginName}"/> 님</font></li>
            <div class="dropdown-content" style="float:left; font-size:12px;">
		    	<div id="menu_login" style="width:100%;height:100%;padding-top:5px; padding-bottom:5px;">
		    		<a href="<c:url value='/uat/uia/actionLogout.do'/>">로그아웃</a>
		    	</div>		    	
		    </div>
	  	<%
	  	} 
        %>
		    
	    </div>
	    
	    
	    <c:if test="${fn:length(list_headmenu) == 0 }">
	        <!-- <li>등록된 메뉴가 없습니다.</li> -->
	    </c:if>
	</ul>
</div>
 </fieldset>
<!-- //topmenu end -->	
<!-- menu list -->
    <form name="menuListForm" action="" method="post">
        <input type="hidden" id="baseMenuNo" name="baseMenuNo" value="<%=session.getAttribute("baseMenuNo")%>" />
        <input type="hidden" id="link" name="link" value="" />
        <div style="width:0px; height:0px;">
        <c:forEach var="result" items="${list_menulist}" varStatus="status" > 
            <input type="hidden" name="tmp_menuNm" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.relateImagePath}|${result.relateImageNm}|${result.chkURL}|" />
        </c:forEach>
        </div>
    </form>
