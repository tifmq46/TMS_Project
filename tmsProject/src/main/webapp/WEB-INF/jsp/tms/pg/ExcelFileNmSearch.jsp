<%--
  Class Name : EgovTemplateRegist.jsp
  Description : 템플릿 속성 등록화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.18   이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.18
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/sym/mpm/icon/";
  String imagePath_button = "/images/egovframework/sym/mpm/button/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link href="<c:url value='/'/>css/popup.css" rel="stylesheet" type="text/css" >
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >
<title>엑셀파일명 검색</title>
<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script language="javascript1.2"  type="text/javaScript"> 


function window_close() {
	   
	opener.location.reload();
	self.close();
}


</script>
<title>엑셀파일 등록</title>

<style type="text/css">

    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


</head>
<body>
<form id="progrmManageForm" name="progrmManageForm" action ="<c:url value='/sym/prm/EgovProgramListSearch.do'/>" method="post" enctype="multipart/form-data">
<input type="submit" id="invisible" class="invisible"/>
<input type="submit" id="test" class="invisible"/>
    <!-- 검색 필드 박스 시작 -->
    <div id="search_field" style="width:100%">
        <div id="search_field_loc" class="h_title">엑셀파일 등록</div>
            <fieldset style="border-bottom: 1px solid #81B1D5; border-top: 1px solid #81B1D5;"><legend>조건정보 영역</legend>    
            <div class="sf_start">
                <ul id="search_first_ul">
                    <li>
                        <input type="file" name="file" />
                        <div class="buttons" style="float:right;">                     	
                        	<a href="#LINK" onclick="file_upload(); return false;">등록 </a>
                        	<font id="fon" >${result}</font> 
                        	<input type="hidden" id="change" name="change" value="<c:out value='${result}'/>" onclick="test(); return false;">
                        </div>
                    </li>       
                </ul>
                
                
                
            	<div class="default_tablestyle">
            		<table width="100%" border="0" cellpadding="0" cellspacing="0" >
        				<c:forEach var="error_hash" items="${error_hashs}" varStatus="status">
            				<tr>
            					<td align="center" class="listtd"><strong><c:out value="${error_hash.problem}"/>&nbsp;</strong></td>
            				</tr>
            				<tr>
            					<td align="center" class="listtd"><c:out value="=>원인 : ${error_hash.reason}"/>&nbsp;</td>
            				</tr>
        				</c:forEach>           
            		</table>  
               	</div>     
               	
               	               
            </div>          
            </fieldset>
            <br>
            <ul id="search_second_ul">            		  
                    <li>
                        <div class="buttons" style="float:right;">                        
                            <a href="#LINK" onclick="javascript:window_close(); return false;">닫기 </a>
                        </div>                              
                    </li>                    
            </ul> 
            
            
    </div>
    <!-- //검색 필드 박스 끝 -->

</form>

</body>
</html>

