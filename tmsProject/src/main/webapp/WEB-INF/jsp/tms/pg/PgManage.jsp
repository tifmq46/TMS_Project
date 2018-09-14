<%--
  Class Name : EgovNoticeList.jsp
  Description : 게시물 목록화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.19   이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.19
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images/egovframework/cop/bbs/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />" ></script>
<c:choose>
<c:when test="${preview == 'true'}">
<script type="text/javascript">
<!--
    function press(event) {
    }

    function fn_egov_addNotice() {
    }
    
    function fn_egov_select_noticeList(pageNo) {
    }
    
    function fn_egov_inqire_notice(nttId, bbsId) {      
    }
//-->
    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_bbsUseInfs('1');
        }
    }

    function fn_egov_select_bbsUseInfs(pageNo){
        document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/cop/com/selectBBSUseInfs.do'/>";
        document.frm.submit();
    }
    function fn_egov_insert_addbbsUseInf(){
        document.frm.action = "<c:url value='/tms/pg/PgInsert.do'/>";
        document.frm.submit();      
    }
    function fn_egov_select_bbsUseInf(bbsId, trgetId){
        document.frm.bbsId.value = bbsId;
        document.frm.trgetId.value = trgetId;
        document.frm.action = "<c:url value='/cop/com/selectBBSUseInf.do'/>";
        document.frm.submit();
    }
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">
<!--
	function fn_egov_select(){
		alert("d1");
		
    	document.frm.action = "<c:url value='/tms/pg/PgManage.do'/>";
    	document.frm.submit();
	}
	function fn_excel_enroll(){
		alert("d7");
	
		document.frm.action = "<c:url value='/tms/pg/ExelRegister.do'/>";
		document.frm.submit();
	}	
	
	function fncAuthorDeleteList() {
		
		var checkField = document.frm.delYn;
        var checkId = document.frm.checkId;
        var returnValue = "";

        var returnBoolean = false;
        var checkCount = 0;

        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i<checkField.length; i++) {
                    if(checkField[i].checked) {
                        checkField[i].value = checkId[i].value;
                        if(returnValue == "")
                            returnValue = checkField[i].value;
                        else 
                            returnValue = returnValue + ";" + checkField[i].value;
                        checkCount++;
                    }
                }
                if(checkCount > 0) 
                    returnBoolean = true;
                else {
                    alert("선택된 권한이 없습니다.");
                    returnBoolean = false;
                }
            } else {
                if(document.frm.delYn.checked == false) {
                    alert("선택된 권한이 없습니다.");
                    returnBoolean = false;
                }
                else {
                    returnValue = checkId.value;
                    returnBoolean = true;
                }
            }
        } else {
            alert("조회된 결과가 없습니다.");
        }
		
        alert("d2"+returnBoolean);
        document.frm.del.value = returnValue;
		
		
		
        		alert("d4");
            	document.frm.action = "<c:url value='/tms/pg/deletePg.do'/>";
            	
            	document.frm.submit();
    	
	}
	function fncCheckAll() {
    	var checkField = document.frm.delYn;
    	if(document.frm.checkAll.checked) {
        	if(checkField) {
            	if(checkField.length > 1) {
                	for(var i=0; i < checkField.length; i++) {
                    	checkField[i].checked = true;
                	}
            	} else {
                	checkField.checked = true;
            	}
        	}
    	} else {
        	if(checkField) {
            	if(checkField.length > 1) {
                	for(var j=0; j < checkField.length; j++) {
                    	checkField[j].checked = false;
                	}
            	} else {
                	checkField.checked = false;
            	}	
        	}
    	}
	}
	

	function fncSelect_Info() {
		alert("d");
		
    	/* document.frm.PgID.value = aaa; */
    	document.frm.action = "<c:url value='/tms/pg/selectPgInf.do'/>";
    	document.frm.submit();     
	}
    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_noticeList('1');
        }
    }
    function file_upload() {
		alert("upload");
		
		var fm  = document.fileForm;     
	    var fnm = fm.uploadFile;
	    var ext = fnm.value;

	    if( !(ext.substr(ext.length-3) == 'xlsx' ) )
	    {
	    	alert("xlsx 파일만 등록할 수 있습니다.");
	       	return false;
	    }
		
    	/* document.frm.PgID.value = aaa; */
    	document.fileForm.action = "<c:url value='/tms/pg/requestupload.do'/>";
    	document.fileForm.submit();     
	}
    
    
    function fncManageChecked() {
    	
    	alert("d2");

        var checkField = document.frm.delYn;
        var checkId = document.frm.checkId;
        var returnValue = "";

        var returnBoolean = false;
        var checkCount = 0;

        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i<checkField.length; i++) {
                    if(checkField[i].checked) {
                        checkField[i].value = checkId[i].value;
                        if(returnValue == "")
                            returnValue = checkField[i].value;
                        else 
                            returnValue = returnValue + ";" + checkField[i].value;
                        checkCount++;
                    }
                }
                if(checkCount > 0) 
                    returnBoolean = true;
                else {
                    alert("선택된 권한이 없습니다.");
                    returnBoolean = false;
                }
            } else {
                if(document.frm.delYn.checked == false) {
                    alert("선택된 권한이 없습니다.");
                    returnBoolean = false;
                }
                else {
                    returnValue = checkId.value;
                    returnBoolean = true;
                }
            }
        } else {
            alert("조회된 결과가 없습니다.");
        }
		
        alert("d2"+returnBoolean);
        document.frm.del.value = returnValue;

        return returnBoolean;
    }
    
//-->
</script>
</c:otherwise>
</c:choose>
<title><c:out value="${brdMstrVO.bbsNm}"/> 목록</title>

<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
<div id="wrap">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
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
                            <li>프로그램 관리</li>
                            <li>&gt;</li>
                            <li><strong>프로그램 관리</strong></li>
                        </ul>
                    </div>
                </div>
                
                
                
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>프로그램 관리</strong></h2></div>
					<form id="frm" name="frm" method="post">
						<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
						<input type="hidden" name="nttId"  value="0" />
						<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
						<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
						<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO1.pageIndex}'/>"/>
						<input type="hidden" id="del" name="del" value="javascript:fncManageChecked()" />
                        <input type="submit" value="실행" onclick="fn_egov_select_noticeList('1'); return false;" id="invisible" class="invisible" />
                        
                        <fieldset><legend>조건정보 영역</legend>    
                        
                        
                        	<div class="default_tablestyle" style=" width:100%">
                                <table border="0" style=" width:100%">
    								<tr>
        								<td class="a1">화면ID</td>
        								<td>
        									<!-- <a href="#noscript" onclick="fn_egov_select_noticeList('1'); return false;"> -->
        								    <input type="text" id="searchByPgId" name="searchByPgId" style=" width:70%" value="<c:out value='${searchVO1.searchByPgId}'/>"> 
        								    <img src="<c:url value='/images/img_search.gif' />" alt="search" /></a></td>        								  								
        								<td class="a1">시스템 구분</td>
        								<td>
        									<select id="searchBySysGb" name="searchBySysGb" >
        										<option value="<c:out value='${searchVO1.searchByTaskGb}'/>"></option>
  												<option value="<c:out value='${searchVO1.searchByTaskGb}'/>">aaa</option>
  												<option value="<c:out value='${searchVO1.searchByTaskGb}'/>">bbb</option>
  												<option value="<c:out value='${searchVO1.searchByTaskGb}'/>">ccc</option>
											</select>
        								</td>        								
        								<td class="a1">업무 구분</td>
        								<td>
        									<select id="searchByTaskGb" name="searchByTaskGb" >
        										<option value="<c:out value='${searchVO1.searchByTaskGb}'/>"></option>
  												<option value="<c:out value='${searchVO1.searchByTaskGb}'/>">aaa</option>
  												<option value="<c:out value='${searchVO1.searchByTaskGb}'/>">bbb</option>
  												<option value="<c:out value='${searchVO1.searchByTaskGb}'/>">ccc</option>
											</select>
        								</td>
        								<td class="a1">개발자</td>
        								<td>
        									<input type="text" id="searchByUserDevId" name="searchByUserDevId" style=" width:90%" value="<c:out value='${searchVO1.searchByUserDevId}'/>"> 
        								</td>
    								</tr>
								</table>
							</div>
							  
                            <div class="default_tablestyle"  style=" width:100%"> 
                            	<ul id="search_second_ul"  style=" width:100%">                            
                            		<li>
                            			<div class="buttons" style="float:right;">                              			
                                    		<a href="#Link" onclick="fn_egov_select(); return false;"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
                                    		<a href="#LINK" onclick="javascript:fncAuthorDeleteList(); return false;">삭제</a>
                                    		<a href="<c:url value='/tms/pg/PgInsert.do'/>" >등록</a>
                                    		<a href="#LINK" onclick="javascript:fn_excel_enroll(); return false;">엑셀등록</a>
                                    	</div>
                                	</li>
                            	</ul>
                            
                            </div>
                        
                        
                        
                           
                        </fieldset>
                    
                	<!-- //검색 필드 박스 끝 -->
                
                
                	<div id="page_info"><div id="page_info_align"></div></div>    
                	<div class="default_tablestyle">
        			<table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
        				<caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
        				<colgroup>
        					<col width="25"/>
        					<col width="25"/> 
        					<col width="25"/>
        					<col width="30"/>
        					<col width="50"/>
        					<col width="20"/>
        					<col width="50"/>
        					<col width="30"/>
        				</colgroup>
        				<tr>
        					<th scope="col" class="f_field" nowrap="nowrap"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()" title="전체선택"></th>
        					<th align="center">NO</th>
        					<th align="center">화면ID</th>
        					<th align="center">화면명</th>
        					<th align="center">시스템구분</th>
        					<th align="center">업무구분</th>
        					<th align="center">개발자</th>
        					<th align="center">사용여부</th>
        				</tr>
        			
        				<c:forEach var="result" items="${resultList}" varStatus="status">
            				<tr>
            					<td align="center" class="listtd" nowrap="nowrap"><input type="checkbox" name="delYn" class="check2" title="선택"><input type="hidden" name="checkId" value="<c:out value="${result.PG_ID}"/>" /></td>
            					<td align="center" class="listtd"><c:out value="${(paginationInfo.totalRecordCount+1 - ((searchVO1.pageIndex-1) * searchVO1.pageSize + status.count))}"/></td>
            					<td align="center" class="listtd">         							
            						<a href="<c:url value='/tms/pg/selectPgInf.do'/>?PG_ID=<c:out value='${result.PG_ID}'/>">
                                		<c:out value="${result.PG_ID}"/>
                            		</a></td>
            					<td align="center" class="listtd"><c:out value="${result.PG_NM}"/></td>
            					<td align="center" class="listtd"><c:out value="${result.SYS_GB}"/>&nbsp;</td>
            					<td align="center" class="listtd"><c:out value="${result.TASK_GB}"/>&nbsp;</td>
            					<td align="center" class="listtd"><c:out value="${result.USER_DEV_ID}"/>&nbsp;</td>
            					<td align="center" class="listtd"><c:out value="${result.USE_YN}"/>&nbsp;</td>
            				</tr>
        				</c:forEach>
        			</table>  		
        		
        			</div>
        		
                	</form>    
                	 
					<form id="fileForm" name="fileForm" method="post" enctype="multipart/form-data">
        				<input type="file" name="file" />
        				<a href="#LINK" onclick="javascript:file_upload(); return false;">전송</a>
    				</form>

  	
                </div>
                

                <!-- 페이지 네비게이션 시작 -->
                <div id="paging_div">
                    <ul class="paging_align">
                        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_noticeList" />  
                    </ul>
                </div>                          
                <!-- //페이지 네비게이션 끝 -->  

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