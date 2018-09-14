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
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.cmm.LoginVO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>로그인정책 목록조회</title>

<script type="text/javaScript" language="javascript" defer="defer">

function fn_egov_insert_addbbsUseInf(){
	alert("C://TMS_통계자료 경로에 '프로그램현황.xlsx'이 다운되었습니다.");
    document.frm.action = "<c:url value='/tms/pg/ExelWrite.do'/>";
    document.frm.submit();      
}

function fn_file(){
	alert("dd");
    document.uploadfile.action = "<c:url value='/tms/pg/fileupload.do'/>";
    document.uploadfile.submit();
}
function test() { 
	//document.uploadfile_nm.file.select(); 
	//alert(document.selection.createRange().text); 
	document.getElementById('filetext').value=document.selection.createRange().text.toString();


	document.getElementById('uploadfile').value=document.selection.createRange().text.toString();
	alert(document.selection.createRange().text.toString());
}
function getRealPath(obj){
	  obj.select();

	 

	  document.selection.createRange().text.toString();

	  //document.selection.createRangeCollection()[0].text.toString();
	  document.upimage.real_path.value = document.selection.createRangeCollection()[0].text.toString();

}
function load() {
    if(!(File && FileReader && FileList && Blob)) {
        alert("Not Supported File API");
    }
 
    document.getElementById("inputFile").onchange = function () {
        var file = this.files[0];
        var name = file.name;
        var size = file.size;
        var reader = new FileReader();
 
        reader.onload = function () {
            var aBuf = this.result; // ArrayBuffer
            var dView = new DataView(aBuf);
 
            var validFlag = dView.getUint8(0);
            var year = dView.getUint8(1);
            var month = dView.getUint8(2);
            var day = dView.getUint8(3);
            var numRecords = dView.getInt32(4, true);
            var numHeaders = dView.getInt16(8, true);
 
 
        };
 
        var blob = file.slice(0, 1000);
        alert(reader.readAsArrayBuffer(blob));
        
    };
}

</script>

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
                            <li>프로그램관리</li>
                            <li>&gt;</li>
                            <li><strong>프로그램현황</strong></li>
                        </ul>
                    </div>
                </div>
                
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>프로그램 현황</strong></h2></div>
                        <fieldset><legend>조건정보 영역</legend>    
                        <div class="sf_start">
                            
                            <ul id="search_second_ul">
                                
                                <li>
                                    <div class="buttons" style="float:right;">
                                        <a href="<c:url value='/tms/pg/ExelWrite.do'/>" onclick="fn_egov_insert_addbbsUseInf(); return false;">엑셀</a>
                                        <!-- a href="#LINK" onclick="fnInitAll(); return false;">초기화</a-->
                                    </div>                              
                                </li>
                                
                            </ul>           
                        </div>          
                        </fieldset>
                </div>
                <!-- //검색 필드 박스 끝 -->
                
                
                
                <div id="page_info"><div id="page_info_align"></div></div>    
                <div class="default_tablestyle">
        		<table width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
        			<caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
        			<colgroup>
        				<col width="25"/> 
        				<col width="25"/>
        				<col width="30"/>
        				<col width="50"/>
        				<col width="20"/>
        				<col width="50"/>
        				<col width="30"/>
        			</colgroup>
        			<tr>
        				<th align="center">프로그램ID</th>
        				<th align="center">프로그램명</th>
        				<th align="center">개발자</th>
        				<th align="center">개발완료일자</th>
        				<th align="center">개발여부</th>
        				<th align="center">PL확인</th>
        				<th align="center">단위테스트</th>
        			</tr>
        			
        			<c:forEach var="result" items="${resultList}" varStatus="status">
            			<tr>
            				<td align="center" class="listtd"><c:out value="${result.PG_ID}"/></td>
            				<td align="center" class="listtd"><c:out value="${result.PG_NM}"/></td>
            				<td align="center" class="listtd"><c:out value="${result.USER_DEV_ID}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.DEV_END_DT}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.DEV_END_YN}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.SECOND_TEST_RESULT_YN}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.THIRD_TEST_RESULT_YN}"/>&nbsp;</td>
            			</tr>
        			</c:forEach>
        		</table>  		
        		
        		</div>
        		
                

                <!-- 페이지 네비게이션 시작 -->
                <c:if test="${!empty loginPolicyVO.pageIndex }">
                    <div id="paging_div">
                        <ul class="paging_align">
					        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
                        </ul>
                    </div>
                <!-- //페이지 네비게이션 끝 -->
                </c:if>

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