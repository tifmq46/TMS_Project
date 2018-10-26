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
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="programVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
    
    function pg_update(){
    	
    	if (!validateProgramVO(document.programVO)) {
			return;
		}
    	
		swal({
   			text: '저장하시겠습니까?'
   			,buttons : true
   		})
   		.then((result) => {
   			if(result) {
   				document.programVO.action = "<c:url value='/tms/pg/Pgupdate.do'/>";
   		        document.programVO.submit(); 
   			}else {
   					
   			}
   		});
    	
    
    }
    
    function selectChange() {

    	if(document.programVO.sysGb.value == '') {
    		$("select#taskGb option").remove();
        	$("select#taskGb").append("<option value=''>선택하세요</option>");
    	}
    	
    }
    
	$(function(){
		   $('#sysGb').change(function() {
		      $.ajax({
		         type:"POST",
		         url: "<c:url value='/sym/prm/TaskGbSearch.do'/>",
		         data : {searchData : this.value},
		         async: false,
		         dataType : "json",
		         success : function(selectTaskGbSearch){
		        	 $("#searchBySysGb").val($("#sysGb").val());
		            $("#taskGb").find("option").remove().end().append("<option value=''>선택하세요</option>");
		            $.each(selectTaskGbSearch, function(i){
		               (JSON.stringify(selectTaskGbSearch[0])).replace(/"/g, "");
		            $("#taskGb").append("<option value='"+JSON.stringify(selectTaskGbSearch[i]).replace(/"/g, "")+"'>"+JSON.stringify(selectTaskGbSearch[i]).replace(/"/g, "")+"</option>")
		            });
		            
		         },
		         error : function(request,status,error){
		            alert("에러");
		            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

		         }
		      });
		   })
		})


</script>
<title>프로그램상세</title>

<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
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
            <div id="content">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>프로그램 관리</li>
                            <li>&gt;</li>
                            <li><strong>프로그램 상세</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>프로그램 상세</strong></h2></div>
                </div>
                <form:form commandName="programVO" id="programVO" name="programVO" method="post" >

                    <div class="modify_user" >
                        <table >
                          <tr> 
                            <th width="20%" height="23" class="required_text" nowrap >
                                <label for="tmplatNm">
                                    	화면ID
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td width="80%" nowrap="nowrap">
                              <input id="pgId" name="pgId" type="text" size="60"  maxlength="20" style="width:50%" title="화면ID" value="<c:out value='${programVO.pgId}'/>" readonly>
                              <form:errors path="pgId" style="color: red"/>
                              <br/> 
                            </td>
                          </tr>
                          <tr> 
                            <th width="20%" height="23" class="required_text" nowrap >
                                <label for="tmplatNm">
                                    	화면명
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td width="80%" nowrap="nowrap">
                              <input id="pgNm" name="pgNm" type="text" size="60"  maxlength="100" style="width:50%" title="화면ID" value="<c:out value='${programVO.pgNm}'/>" >&nbsp;<span id="sometext"></span>
                              <form:errors path="pgNm" style="color: red"/>
                              <br/>
                            </td>
                          </tr>
                          <tr> 
                          <tr> 
                            <th height="23" class="required_text" >
                                <label for="tmplatSeCode">  
                                    	시스템구분
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td>
                            <select id="sysGb" name="sysGb" class="select" title="시스템구분" onchange="selectChange();" readonly>
									   <option selected value="" >선택하세요</option>
									      <c:forEach var="sysGb" items="${sysGb}" varStatus="status">
									    	<option value="<c:out value="${sysGb}"/>" <c:if test="${programVO.sysGb == sysGb}">selected="selected"</c:if> ><c:out value="${sysGb}" /></option>
									      </c:forEach>
                                <%-- <c:forEach var="result" items="${resultList}" varStatus="status">
                                    <option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
                                </c:forEach>  --%>   
                            </select>&nbsp;<span id="sometext"></span>
                            <form:errors path="sysGb" style="color: red"/>
                               <br/>
                            </td>
                          </tr> 
                          <tr> 
                            <th height="23" class="required_text" >
                                <label for="tmplatSeCode">  
                                    	업무구분
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td>
                            <select id="taskGb" name="taskGb" class="select" title="업무구분">
									   <option value="">선택하세요</option>
					      					<c:forEach var="taskGb" items="${taskGb2}" varStatus="status">
									    		<option value="<c:out value="${taskGb}"/>" <c:if test="${programVO.taskGb == taskGb}">selected="selected"</c:if> ><c:out value="${taskGb}" /></option>
									    	</c:forEach>	
                            </select>&nbsp;<span id="sometext"></span>
                            <form:errors path="taskGb" style="color: red"/>
                               <br/>
                            </td>
                          </tr> 
                            <th width="20%" height="23" class="required_text" nowrap >
                                <label for="tmplatCours">   
                                    	개발자
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td width="80%" nowrap="nowrap">
                            <select id="userDevId" name="userDevId" class="select" title="개발자">
									   <option value="" >선택하세요</option>
									      <c:forEach var="DEV_ID" items="${dev_List}" varStatus="status">
									    	<option value="<c:out value="${DEV_ID.USER_NM}"/>" <c:if test="${programVO.userDevId == DEV_ID.USER_NM}">selected="selected"</c:if>><c:out value="${DEV_ID.USER_NM}" /></option>
									      </c:forEach>
                                <%-- <c:forEach var="result" items="${resultList}" varStatus="status">
                                    <option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
                                </c:forEach>  --%>   
                            </select>&nbsp;<span id="sometext"></span>
                            <form:errors path="userDevId" style="color: red"/>
                              <br/>
                            </td>
                          </tr>
                          <tr> 
                            <th width="20%" height="23" class="required_text" nowrap >
                                <label> 
                                    	사용여부
                                </label>    
                                <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required"/>
                            </th>
                            <td width="80%" nowrap="nowrap">
                                Y : <input type="radio" id="useYn" name="useYn" class="radio2" value="Y" <c:if test="${programVO.useYn == 'Y'}"> checked="checked"</c:if> >&nbsp;
                                N : <input type="radio" id="useYn" name="useYn" class="radio2" value="N" <c:if test="${programVO.useYn == 'N'}"> checked="checked"</c:if> >
                                <br/>
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
                              <a onclick="pg_update(); return false;">저장</a> 
                          </td>
                          <td>
                              <a href="<c:url value='/tms/pg/PgManage.do'/>" >목록</a>
                          </td>                       
                        </tr>
                      </table>
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

