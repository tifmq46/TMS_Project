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
<title>화면 삭제</title>
<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}

</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script language="javascript1.2"  type="text/javaScript"> 


$(function(){ 
	var deleteList = document.progrmManageForm.returnValue.value;
	
	$('#listButton').click(function(){ 
			      $.ajax({
			         
			         type:"POST",
			         url: "<c:url value='/tms/pg/deleteListAction.do?returnValue="+deleteList+"'/>",
			         success : function(){
			        	 opener.location.reload();			        	 
			        	 window.close();
			            
			         },
			         error : function(request,status,error){
			            swal("삭제할 수 없습니다.");
			            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

			         }
			      });
			   })
			})



function window_close() {
	   
	opener.location.reload();
	self.close();
}




</script>
<title>프로그램 삭제</title>

<style type="text/css">

    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


</head>
<body>
<form id="progrmManageForm" name="progrmManageForm" action ="<c:url value='/sym/prm/EgovProgramListSearch.do'/>" method="post" >
	
	<input type="hidden" id="returnValue" name="returnValue" value="<c:out value="${returnValue}"/>" />

    <div id="search_field" style="width:100%">
        <div id="search_field_loc" class="h_title">화면 삭제</div>
			<fieldset style="overflow-y : scroll; height : 150px; border-bottom: 1px solid #81B1D5; border-top: 1px solid #81B1D5;"><legend>조건정보 영역</legend> 
        				<div class="searchT">
        				<c:forEach var="result" items="${Pg_Relation_List}" varStatus="status">
        				
        					<label style="color:#0f438a;" for="searchByPgId"><strong>화면ID : ${result.PG_ID}</strong></label>
        				
        					<table id="searchT" width="100%" border="0" cellpadding="0" cellspacing="0" style="border-bottom: 1px solid #dddddd; border-top: 1px solid #dddddd;
    color:#0f438a;">
            					<tr>
            						<td align="left" class="listtd">
            						<c:if test="${result.dev > 0}">
            							<strong><c:out value="[계획] "/></strong>
            						</c:if>
            						<c:if test="${result.test > 0}">
            							<strong><c:out value="[테스트] "/></strong>
            						</c:if>
            						<c:if test="${result.defect > 0}">
            							<strong><c:out value="[결함] "/></strong>
            						</c:if>
            						<strong><c:out value="관련 데이터가 존재해 삭제가 불가능합니다! "/></strong>
            						</td>
            					</tr>
            				</table>
            			
        				</c:forEach>
						</div>

            <br>
            </fieldset>
            
            <br>


			<c:if test="${fn:length(Pg_Relation_List) == 0}">
            	<ul id="search_second_ul">            		  
                    <li>
                        <div style="float:right;">      
                        	<font style="color:#0f438a;" size="3px"><strong>삭제하시겠습니까? </strong></font>                  
                        </div>                              
                    </li>                    
            	</ul> 
            </c:if>  
            
            <ul id="search_second_ul">            		  
                    <li>
                        <div style="align:right; ">      
                        	                  
                        </div>                              
                    </li>   
                    <li>
                        <div class="buttons" style="float:right;"> 
                        	<c:if test="${fn:length(Pg_Relation_List) == 0}">
                        		<a id="listButton" name="listButton" href="#LINK" >삭제 </a> 
                        		<a href="#LINK" onclick="javascript:window_close(); return false;">취소 </a>
                        	</c:if>  
                        	<c:if test="${fn:length(Pg_Relation_List) > 0}">
                        		<a href="#LINK" onclick="javascript:window_close(); return false;">닫기 </a>
                        	</c:if>                                             
                        </div>                              
                    </li>                     
            </ul> 
            
			
    </div>
</form>
</body>
</html>

