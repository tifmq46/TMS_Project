<%@ page import="egovframework.com.cmm.LoginVO"%>
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
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >

<title>개발진척통계</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>o
<script type="text/javaScript" language="javascript">

</script>

</head>

<body>
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
							<li>&#62;</li>
							<li>개발진척관리</li>
							<li>&gt;</li>
							<li><strong>개발진척통계</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
               
				
				<div id="search_field">
					<div id="search_field_loc"><h2><strong>개발진척통계(통계표)</strong></h2></div>
					
					  	<fieldset><legend>조건정보 영역</legend>	  
					  	<div class="sf_start">
					  	<ul id="search_first_ul">
						  	<li><label >계획시작일</label></li>
						  	<li>
						  	<input type="text" value="<fmt:formatDate value="${tt.DEV_START_DT}" pattern="yyyy-MM-dd" />">
						  	</li>
						  
						  	<li><label >계획종료일</label></li>
						  	<li><input type="text" value="<fmt:formatDate value="${tt.DEV_END_DT}" pattern="yyyy-MM-dd" />"></li>
					  	</ul>
						</div>			
						</fieldset>		
				</div>
				<!-- //검색 필드 박스 끝 -->
                
                <div id="page_info"><div id="page_info_align"></div></div>                    
                <!-- table add start -->
                <div class="default_tablestyle">
                    <table summary="진척통계 테이블입니다" cellpadding="0" cellspacing="0">
                    <caption>진척통계 테이블</caption>
           
          			<thead>
                    <tr>
                    	<th align="center">개발자</th>
                        <th align="center">10/1</th>
        				<th align="center">10/2</th>
        				<th align="center">10/3</th>
        				<th align="center">10/4</th>
        				<th align="center">10/5</th>
        				<th align="center">10/8</th>
        				<th align="center">10/9</th>
        				<th align="center">10/10</th>
        				<th align="center">10/11</th>
        				<th align="center">10/12</th>
        				<th align="center">10/15</th>
        				<th align="center">10/16</th>
        				<th align="center">10/17</th>
        				<th align="center">10/18</th>
        				<th align="center">10/19</th>
        				<th align="center"></th>
                    </tr>
                    </thead>
           			
           			<c:forEach var="stats" items="${a}" varStatus="status">
           			
                    <tr>
                    <td><c:out value="${stats.DevNm}" /></td>
                    	<td><c:out value="${stats.a20181001}" /></td>
                    	<td><c:out value="${stats.a20181002}" /></td>
                    	<td><c:out value="${stats.a20181003}" /></td>
                    	<td><c:out value="${stats.a20181004}" /></td>
                    	<td><c:out value="${stats.a20181005}" /></td>
                    	<td><c:out value="${stats.a20181008}" /></td>
                    	<td><c:out value="${stats.a20181009}" /></td>
                    	<td><c:out value="${stats.a20181010}" /></td>
                    	<td><c:out value="${stats.a20181011}" /></td>
                    	<td><c:out value="${stats.a20181012}" /></td>
                    	<td><c:out value="${stats.a20181015}" /></td>
                    	<td><c:out value="${stats.a20181016}" /></td>
                    	<td><c:out value="${stats.a20181017}" /></td>
                    	<td><c:out value="${stats.a20181018}" /></td>
                    	<td><c:out value="${stats.a20181019}" /></td>
                    	
                    	</tr>
                    </c:forEach>
            
                    
                    </table>
                </div>
                
               
                
                 
				<%-- <table width="120%" border="0" cellpadding="0" cellspacing="0" >
                 <caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
              
              <tr>
            <c:forEach var="resultP" items="${resultP}" varStatus="status">
        			
        				<th align="center" class="listtd"><c:out value="${resultP.formatFriday}"/></th>
        				
        			
            			<tr>
            				<td align="center" class="listtd"><c:out value="${resultP.formatFriday}"/>&nbsp;</td>
            				
            			</tr>
        			</c:forEach>
        			</tr>
              
              </table>         --%>
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