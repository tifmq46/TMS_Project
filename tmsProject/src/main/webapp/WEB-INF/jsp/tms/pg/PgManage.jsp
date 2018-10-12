<%--
  Class Name : EgovTemplateList.jsp
  Description : 템플릿 목록화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.18   이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.18
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/nav_common.css" rel="stylesheet" type="text/css" >
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />" ></script>

<c:choose>
<c:when test="${preview == 'true'}">
<script type="text/javascript">
<!--
    function press(event) {
		if (event.keyCode==13) {
        	fn_egov_select_bbsUseInfs('1');
    	}
    }

    function fn_egov_addNotice() {
    }
    
    function fn_egov_select_noticeList(pageNo) {
    	document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/tms/pg/PgManage.do'/>";
        document.frm.submit();
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
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript">

	$(function(){
	   $('#bbb').change(function() {
	      $.ajax({
	         
	         type:"POST",
	         url: "<c:url value='/sym/prm/TaskGbSearch.do'/>",
	         data : {searchData : this.value},
	         async: false,
	         dataType : "json",
	         success : function(selectTaskGbSearch){
	        	 $("#searchBySysGb").val($("#bbb").val());
	            $("#task").find("option").remove().end().append("<option value=''>선택하세요</option>");
	            $.each(selectTaskGbSearch, function(i){
	               (JSON.stringify(selectTaskGbSearch[0].task_GB)).replace(/"/g, "");
	            $("#task").append("<option value='"+JSON.stringify(selectTaskGbSearch[i].task_GB).replace(/"/g, "")+"'>"+JSON.stringify(selectTaskGbSearch[i].task_GB).replace(/"/g, "")+"</option>")
	            });
	            
	         },
	         error : function(request,status,error){
	            alert("에러");
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

	         }
	      });
	   })
	})

	
	function setting() {
		document.frm.searchBySysGb.value = document.frm.bbb.value;
		document.frm.searchByTaskGb.value = document.frm.task.value;
		
	}
	
	
	function searchExcelFileNm() {
    	window.open("<c:url value='/tms/pg/ExcelFileListSearch.do'/>",'','width=500, height=400, left=350, top=200');
	}
	
	function Pg_Relation_Search() {
		
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
                    alert("삭제할 화면ID를 선택해주십시오.");
                    returnBoolean = false;
                    return;
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
        //document.frm.action = "<c:url value='/tms/pg/deletePg2.do'/>";
        //document.frm.submit();
        
        
    	window.open("<c:url value='/tms/pg/deletePg2.do?result="+returnValue+"'/>",'','width=500, height=300, left=350, top=200');
	}

	function Pg_select(pageNo){
		
		document.frm.searchBySysGb.value = document.frm.bbb.value;
		document.frm.searchByTaskGb.value = document.frm.task.value;
		
		//alert(pageNo);
		document.frm.pageIndex.value = pageNo;
		//document.frm.searchByTaskGb.value = document.frm.task.value;
		//document.frm.fon.value = pageNo;
    	document.frm.action = "<c:url value='/tms/pg/PgManage.do'/>";
    	document.frm.submit();
	}
	
	function Pg_DeleteList(pageNo) {
		//alert(pageNo);
		
		document.frm.pageIndex.value = pageNo;
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
    function searchFileNm() {
        window.open("<c:url value='/sym/prm/TmsProgramListSearch.do'/>",'','width=800,height=600');
    }

</script>
</c:otherwise>
</c:choose>

<title>프로그램관리</title>
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
</head>
<body>

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
							<li>프로그램관리</li>
							<li>&gt;</li>
							<li><strong>프로그램관리</strong></li>
                        </ul>
                    </div>
                </div>
                
                
                <form name="frm" id="frm" action ="<c:url value='/tms/pg/PgManage.do'/>" method="post">
				<input type="submit" id="invisible" class="invisible"/>
				<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				
							<input id="TmsProgrmFileNm_sys_gb" type="hidden" /> 
			<input id="TmsProgrmFileNm_task_gb" type="hidden" /> 
			<input id="TmsProgrmFileNm_pg_nm" type="hidden" /> 
			<input id="TmsProgrmFileNm_user_dev_id" type="hidden" />
				
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>프로그램 관리</strong></h2></div>
					
						<input type="hidden" id="del" name="del" value="fncManageChecked()" />
						<input type="hidden" id="fon" name="fon" />
                        <input type="submit" value="실행" onclick="fn_egov_select_noticeList('1'); return false;" id="invisible" class="invisible" />
                        
                        <fieldset><legend>조건정보 영역</legend>    
                        
                        
                        	<div class="default_tablestyle" style=" width:100%">

					  		<ul id="search_first_ul">					  		
					  			<li><label for="searchByPgId">화면ID</label></li>
					  			<li><input type="text" name="searchByPgId" id="TmsProgrmFileNm_pg_id" value="<c:out value='${searchVO.searchByPgId}'/>"/>
					  				<a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
	                				<img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a></li>
					  					
					  			<li><label for="searchByUserDevId">개발자명</label></li>
					  			<li><input type="text" name="searchByUserDevId" id="searchByUserDevId" value="<c:out value='${searchVO.searchByUserDevId}'/>"/></li>
					  		
                        	
                        	</ul>
                        	
                        	<ul id="search_first_ul">	
					  			<li>
								    <label >시스템구분</label>
									<select name="bbb" id="bbb" style="width:12%;text-align-last:center;">
									   <option value="" >전체</option>
									      <c:forEach var="sysGb" items="${sysGb}" varStatus="status">
									    	<option value="<c:out value="${sysGb.SYS_GB}"/>" <c:if test="${searchVO.searchBySysGb == sysGb.SYS_GB}">selected="selected"</c:if> ><c:out value="${sysGb.SYS_GB}" /></option>
									      </c:forEach>
									</select>
									
									<input type="hidden" name="searchBySysGb" id="searchBySysGb" value=""/>					
					  			</li>
					  			
					  			
					  			<li>
								    <label for="searchByTaskGb">업무구분</label>
									<select name="task" id="task" style="width:15%;text-align-last:center;">
									   <option value="">선택하세요</option>
					      					<c:forEach var="taskGb" items="${taskGb2}" varStatus="status">
									    		<option value="<c:out value="${taskGb.TASK_GB}"/>" <c:if test="${searchVO.searchByTaskGb == taskGb.TASK_GB}">selected="selected"</c:if> ><c:out value="${taskGb.TASK_GB}" /></option>
									    	</c:forEach>								   
									</select>				
									<input type="hidden" name="searchByTaskGb" id="searchByTaskGb" value=""/>
					  			</li>                     	


                       
							</ul> 	
							</div>
							  
                            <div class="default_tablestyle"  style=" width:100%"> 
                            	<ul id="search_second_ul"  style=" width:100%">                            
                            		<li>
                            			<div class="buttons" style="float:right;">                              			
                                    		<a href="#Link" onclick="setting();Pg_select('1'); return false;"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
                                    		<a href="#Link" onclick="Pg_Relation_Search(); return false;">삭제</a>
                                    		<a href="<c:url value='/tms/pg/PgInsert.do'/>" >등록</a>
                                    		<a href="#LINK" onclick="searchExcelFileNm(); return false;">엑셀등록</a>
                                    	</div>
                                	</li>
                            	</ul>
                            
                            </div>
                        
                        
                        
                           
                        </fieldset>
                 	</div>
                	<!-- //검색 필드 박스 끝 -->


                	<div id="page_info"><div id="page_info_align"></div></div>    
                	<div class="default_tablestyle">
        			<table width="120%" border="0" cellpadding="0" cellspacing="0" >
        				<caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
        				<colgroup>
        					<col width="10"/>
        					<col width="5"/> 
        					<col width="25"/>
        					<col width="40"/>
        					<col width="30"/>
        					<col width="20"/>
        					<col width="20"/>
        					<col width="20"/>
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
            					<td align="center" class="listtd"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
            					<td align="center" class="listtd"><c:out value="${result.PG_ID}"/></td>
            					<td align="left" class="listtd">
            						<a href="<c:url value='/tms/pg/selectPgInf.do'/>?PG_ID=<c:out value='${result.PG_ID}'/>">
            							<strong><c:out value="${result.PG_NM}"/></strong>
            						</a></td>
            					<td align="center" class="listtd"><c:out value="${result.SYS_GB}"/>&nbsp;</td>
            					<td align="center" class="listtd"><c:out value="${result.TASK_GB}"/>&nbsp;</td>
            					<td align="center" class="listtd"><c:out value="${result.USER_DEV_ID}"/>&nbsp;</td>
            					<td align="center" class="listtd"><c:out value="${result.USE_YN}"/></td>
            				</tr>
        				</c:forEach>
        			</table>  		
        			  
        			</div>
	</form>
    <!-- 페이지 네비게이션 시작 -->
    <div id="paging_div">
        <ul class="paging_align">
            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="Pg_select"/>
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