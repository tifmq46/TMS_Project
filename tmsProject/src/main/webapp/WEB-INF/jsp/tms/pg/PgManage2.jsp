<%--
  Class Name : EgovLoginPolicyList.jsp
  Description : EgovLoginPolicyList 화면
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01   lee.m.j            최초 생성
     2011.08.31   JJY       경량환경 버전 생성

    author   : 공통서비스 개발팀 lee.m.j
    since    : 2009.02.01
--%>
<%@ page import="egovframework.com.cmm.LoginVO"%>
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
<link href="<c:url value='/css/nav_common.css'/>" rel="stylesheet" type="text/css" >

<title>로그인정책 목록조회</title>

<script type="text/javascript">


function fn_searchList(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/tms/defect/selectDefect.do'/>";
    document.listForm.submit();
}

function searchFileNm() {
    window.open("<c:url value='/sym/prm/TmsProgramListSearch.do'/>",'','width=800,height=600');
}
<!--
function linkPage(pageNo){
	document.frm.pageIndex.value = pageNo;
	document.frm.action = "<c:url value='/tms/pg/PgManage.do'/>";
		document.frm.submit();
}

$(function(){
	$('#category1').change(function() {
		$.ajax({
			type:"POST",
			url: "<c:url value='/sym/prm/TaskGbSearch.do'/>",
			data : {searchData : this.value},
			async: false,
			dataType : 'json',
			success : function(selectTaskGbSearch){
				$("#category2").find("option").remove().end().append("<option value=''>선택하세요</option>");
				$.each(selectTaskGbSearch, function(i){
					(JSON.stringify(selectTaskGbSearch[0].task_GB)).replace(/"/g, "");
				$("#category2").append("<option value='"+JSON.stringify(selectTaskGbSearch[i].task_GB).replace(/"/g, "")+"'>"+JSON.stringify(selectTaskGbSearch[i].task_GB).replace(/"/g, "")+"</option>")
				});
			},
			error : function(request,status,error){
				alert("에러");
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	})
})

function searchExcelFileNm() {
	window.open("<c:url value='/tms/pg/ExcelFileListSearch.do'/>",'','width=800,height=600');
}

function Pg_select(){
	
	document.frm.action = "<c:url value='/tms/pg/PgManage.do'/>";
	document.frm.submit();
}

function Pg_DeleteList() {
	
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
	
    document.frm.del.value = returnValue;
	
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
	/* document.frm.PgID.value = aaa; */
	document.frm.action = "<c:url value='/tms/pg/selectPgInf.do'/>";
	document.frm.submit();     
}
function press(event) {
    if (event.keyCode==13) {
        fn_egov_select_noticeList('1');
    }
}


function fncManageChecked() {
	
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
	
    document.frm.del.value = returnValue;

    return returnBoolean;
}

//-->
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
                            <li>&gt;</li>
                            <li>프로그램 관리</li>
                            <li>&gt;</li>
                            <li><strong>프로그램 관리</strong></li>
                        </ul>
                    </div>
                </div>
     
              
             <form:form commandName="searchVO" name="frm" method="post" action="/tms/pg/PgManage.do">   
                <input type="hidden" name="pageIndex" value="<c:out value='${searchVO1.pageIndex}'/>"/>
                <!-- 검색 필드 박스 시작 -->
				<div id="search_field">
					<div id="search_field_loc"><h2><strong>프로그램 관리</strong></h2></div>
					
					<form action="form_action.jsp" method="post">
					
						<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
						<input type="hidden" name="nttId"  value="0" />
						<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
						<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
						<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO1.pageIndex}'/>"/>
						<input type="hidden" id="del" name="del" value="fncManageChecked()" />
                        <input type="submit" value="실행" onclick="fn_egov_select_noticeList('1'); return false;" id="invisible" class="invisible" />
					
					  	<fieldset><legend>조건정보 영역</legend>	  
					  	<div class="sf_start">
					  	
					  	
					  		<table border="0" style=" width:100%">
    								<tr>
        								<td class="a1">화면ID</td>
        								<td>
        									<!-- <a href="#noscript" onclick="fn_egov_select_noticeList('1'); return false;"> -->
        								    <input type="text" id="searchByPgId" name="searchByPgId" style=" width:70%" value="<c:out value='${searchVO1.searchByPgId}'/>"> 
        								    <img src="<c:url value='/images/img_search.gif' />" alt="search" /></a></td>        								  								
        								<td class="a1">시스템 구분</td>
        								<td>
											<select name="category1" id="category1" style="width:12%;text-align-last:center;">
									    		<option value="0" selected="selected" >전체</option>
									    		<c:forEach var="sysGb" items="${sysGb}" varStatus="status">
									    		<option value="<c:out value="${sysGb.SYS_GB}"/>"><c:out value="${sysGb.SYS_GB}" /></option>
									    		</c:forEach>
											</select>
        								</td>        								
        								<td class="a1">업무 구분</td>
        								<td>
        									<select name="category2" id="category2" style="width:15%;text-align-last:center;">
									    		<option value="">선택하세요</option>
											</select>	
        								</td>
        								<td class="a1">개발자</td>
        								<td>
        									<input type="text" id="searchByUserDevId" name="searchByUserDevId" style=" width:90%" value="<c:out value='${searchVO1.searchByUserDevId}'/>"> 
        								</td>
    								</tr>
								</table>
					  		<br/>
					  		
					  		<ul id="search_second_ul"  style=" width:100%">                            
                            		<li>
                            			<div class="buttons" style="float:right;">                              			
                                    		<a href="#Link" onclick="Pg_select(); return false;"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
                                    		<a href="#LINK" onclick="Pg_DeleteList(); return false;">삭제</a>
                                    		<a href="<c:url value='/tms/pg/PgInsert.do'/>" >등록</a>
                                    		<a href="#LINK" onclick="searchExcelFileNm(); return false;">엑셀등록</a>
                                    	</div>
                                	</li>
                            </ul>			
						</div>			
						</fieldset>
					</form>
				</div>
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
        					<th scope="col" class="f_field" nowrap="nowrap"><input type="checkbox" name="checkAll" class="check2" onclick="fncCheckAll()" title="전체선택"></th>
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

			<input id="TmsProgrmFileNm_sys_gb" type="hidden" /> 
			<input id="TmsProgrmFileNm_task_gb" type="hidden" /> 
			<input id="TmsProgrmFileNm_pg_nm" type="hidden" /> 
			<input id="TmsProgrmFileNm_user_dev_id" type="hidden" /> 

                <!-- 페이지 네비게이션 시작 -->
               <%--  <c:if test="${!empty loginPolicyVO.pageIndex }"> --%>
                    <div id="paging_div">
                        <ul class="paging_align">
                       <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
                        </ul>
                    </div>
                <!-- //페이지 네비게이션 끝 -->
               <%--  </c:if> --%>



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