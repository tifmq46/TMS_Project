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
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
	               (JSON.stringify(selectTaskGbSearch[0])).replace(/"/g, "");
	            	$("#task").append("<option value='"+JSON.stringify(selectTaskGbSearch[i]).replace(/"/g, "")+"'>"+JSON.stringify(selectTaskGbSearch[i]).replace(/"/g, "")+"</option>")
	            });
	            
	         },
	         error : function(request,status,error){
	            swal("에러");
	            //swal("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	         }
	      });
	   })
	})
	
$(function(){
	   $('#delete').click(function() {
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
	                    swal("삭제할 화면ID를 선택해주십시오.");
	                    returnBoolean = false;
	                    return;
	                }
	            } else {
	                if(document.frm.delYn.checked == false) {
	                    swal("선택된 권한이 없습니다.");
	                    returnBoolean = false;
	                }
	                else {
	                    returnValue = checkId.value;
	                    returnBoolean = true;
	                }
	            }
	        } else {
	        	swal("삭제할 화면ID를 선택해주십시오.");
	            returnBoolean = false;
	            return;
	        }		   
		   
			$.ajax({
			         
			         type:"POST",
			         url: "<c:url value='/tms/pg/deletePgList2.do?returnValue="+returnValue+"'/>",
			         success : function(str){
			        	 if(str.length == 0) {
			        		 $.ajax({
						         
						         type:"POST",
						         url: "<c:url value='/tms/pg/deleteListAction.do?returnValue="+returnValue+"'/>",
						         success : function(){
						        	//location.reload();
						        	//swal("정상적으로 삭제되었습니다.");
						        	swal("정상적으로 삭제되었습니다.")
									.then((value) => {
										location.reload();
									});
						         },
						         error : function(request,status,error){
						            swal("삭제할 수 없습니다.");
						         }
						      });
			        	 }else {
			        		 window.open("<c:url value='/tms/pg/deletePgList.do?result="+returnValue+"'/>",'','width=500, height=300, left=350, top=200');
			        	 }
			         },
			         error : function(request,status,error){
			            swal("삭제할 수 없습니다.");

			         }
			      });
			   })
			})	
$(function(){
	   $('#full_delete').click(function() {
			swal({
	   			text: '프로그램 일괄삭제를 하시겠습니까?'
	   			,buttons : true
	   		})
	   		.then((result) => {
	   			if(result) {
   					$.ajax({			         
   			         	type:"POST",
   			         	url: "<c:url value='/tms/pg/full_deleteListAction.do'/>",
   			         	success : function(){
   			         		
   			         		swal("정상적으로 일괄삭제되었습니다.")
							.then((value) => {
								location.reload();
							});
   			        		//location.reload();
   			        	 	//swal("프로그램 일괄삭제가 정상적으로 처리되었습니다.");
   			         	},
   			         	error : function(request,status,error){
   			            	swal("삭제할 수 없습니다.");
   			         	}
   			  		});
	   			}else {
	   					
	   			}
	   		});
		   
	   })
	})	
	
	
	
	
	function setting() {
		document.frm.searchBySysGb.value = document.frm.bbb.value;
		document.frm.searchByTaskGb.value = document.frm.task.value;
		
	}
	
	function searchExcelFileNm() {
    	window.open("<c:url value='/tms/pg/ExcelFileListSearch.do'/>",'','location=no, width=500, height=400, left=350, top=200');
	}
	

	function Pg_select(pageNo){
		document.frm.cnt.value = "a";
		document.frm.searchBySysGb.value = document.frm.bbb.value;
		document.frm.searchByTaskGb.value = document.frm.task.value;
		//alert(pageNo);
		document.frm.pageIndex.value = pageNo;
		//document.frm.searchByTaskGb.value = document.frm.task.value;
		//document.frm.fon.value = pageNo;
		var url = "<c:url value='/tms/pg/PgManage.do" + "?cnt=" + document.frm.cnt.value + "'/>";
    	document.frm.action = url;
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
                    swal("선택된 권한이 없습니다.");
                    returnBoolean = false;
                }
            } else {
                if(document.frm.delYn.checked == false) {
                    swal("선택된 권한이 없습니다.");
                    returnBoolean = false;
                }
                else {
                    returnValue = checkId.value;
                    returnBoolean = true;
                }
            }
        } else {
            swal("조회된 결과가 없습니다.");
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
                    swal("선택된 권한이 없습니다.");
                    returnBoolean = false;
                }
            } else {
                if(document.frm.delYn.checked == false) {
                    swal("선택된 권한이 없습니다.");
                    returnBoolean = false;
                }
                else {
                    returnValue = checkId.value;
                    returnBoolean = true;
                }
            }
        } else {
            swal("조회된 결과가 없습니다.");
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
<c:if test="${!empty message and fn:length(message) > 0}">
	<script type="text/javascript"> swal("${message}");</script>
</c:if>

<div id="wrap" style="font-family:'Malgun Gothic';">
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
                    <div id="cur_loc_align" style="font-family:'Malgun Gothic';">
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
				
				
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc" >
                    <h2><strong>프로그램 관리</strong></h2></div>
					
                         <fieldset><legend>조건정보 영역</legend>     
                  			  <div class="sf_start">
							<table style="width:100%;padding-bottom:10px;padding-left:10px;padding-top:10px;">
                    		<colgroup>
                  			  <col width="7%"/> 
                  			  <col width="14.4%"/> 
                  			  <col width="7%"/> 
                  			  <col width="14.4%"/> 
                  			  <col width="7%"/> 
                  			  <col width="14.4%"/> 
                  			  <col width="7%"/> 
                  			  <col width="14.4%"/> 
                  			  <col width="14.4%"/> 
      			        	</colgroup>
      			        	<tr> 
      			        		<td style="font-weight:bold;color:#666666;font-size:110%;">화면ID
      			        		</td>
      			        		<td>
					  			<input type="text" name="searchByPgId" id="TmsProgrmFileNm_pg_id" style="width:80%;text-align:center;" value="<c:out value='${searchVO.searchByPgId}'/>"/>
					  				<a href="<c:url value='/sym/prm/TmsProgramListSearch.do'/>" target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
	                				<img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" /></a>
      			        		</td>
      			        		<td style="font-weight:bold;color:#666666;font-size:110%;">시스템구분
      			        		</td>
      			        		<td>
      			        		<select name="bbb" id="bbb" style="width:90%;text-align-last:center;">
									   <option value="" >전체</option>
									      <c:forEach var="sysGb" items="${sysGb}" varStatus="status">
									    	<option value="<c:out value="${sysGb}"/>" <c:if test="${searchVO.searchBySysGb == sysGb}">selected="selected"</c:if> ><c:out value="${sysGb}" /></option>
									    </c:forEach>
									</select>
									
									<input type="hidden" name="searchBySysGb" id="searchBySysGb" value=""/>
      			        		</td>
      			        		<td style="font-weight:bold;color:#666666;font-size:110%;">업무구분
      			        		</td>
      			        		<td>
      			        		<select name="task" id="task" style="width:90%;text-align-last:center;">
									   <option value="">선택하세요</option>
					      					<c:forEach var="taskGb" items="${taskGb2}" varStatus="status">
									    		<option value="<c:out value="${taskGb}"/>" <c:if test="${searchVO.searchByTaskGb == taskGb}">selected="selected"</c:if> ><c:out value="${taskGb}" /></option>
									    	</c:forEach>								   
									</select>				
									<input type="hidden" name="searchByTaskGb" id="searchByTaskGb" value=""/>
      			        		</td>
      			        		<td colspan="3">
      			        			<div class="buttons" style="float:right;">
                                    	<a id="full_delete" href="#Link" >프로그램 일괄삭제</a>
                                    </div>
      			        		</td>
      			        	</tr>
      			        	<tr>
      			        		<td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">개발자
      			        		</td>
      			        		<td style="padding-top:15px;">
      			        		<input type="text" list="userAllList" autocomplete="off" name="searchByUserDevId" id="searchByUserDevId" size="15" style="width:80%;text-align:center;" value="<c:out value='${searchVO.searchByUserDevId}'/>"/>
      			        		<datalist id="userAllList">
									    <c:forEach var="userList" items="${userList}" varStatus="status">
									    	<option value="<c:out value="${userList.userNm}"/>"  style="text-align:center;"></option>
									    </c:forEach>
					        	</datalist>
      			        		</td>
      			        		<td style="padding-top:15px;font-weight:bold;color:#666666;font-size:110%;">사용여부
      			        		</td>
      			        		<td style="padding-top:15px;">
      			        			<select name="searchUseYn" id="searchUseYn" style="width:90%;text-align-last:center;">
									   <option value="">전체</option>
					      					<c:forEach var="useYn" items="${useYnList}" varStatus="status">
					      						<c:if test="${useYn == 'Y'}">
									    			<option value="<c:out value="${useYn}"/>" <c:if test="${searchVO.searchUseYn == useYn}">selected="selected"</c:if> >사용</option>
									    		</c:if> 
									    		<c:if test="${useYn == 'N'}">
									    			<option value="<c:out value="${useYn}"/>" <c:if test="${searchVO.searchUseYn == useYn}">selected="selected"</c:if> >미사용</option>
									    		</c:if> 
									    	</c:forEach>								   
									</select>			
      			        		</td>
      			        		<td colspan="5" style="padding-top:15px;">
      			        			<div class="buttons" style="float:right;">                              			
                                    	<a href="#Link" onclick="setting();Pg_select('1'); return false;"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
                                    	<a id="delete" href="#Link" >삭제</a>
                                    	<a href="<c:url value='/tms/pg/PgInsert.do'/>" >등록</a>
                                    	<a href="#LINK" onclick="searchExcelFileNm(); return false;">엑셀등록</a>
                                    </div>
      			        		</td>
      			        	</tr>
      			        	</table>
                            		
							</div>
							
                        </fieldset>
                 	</div>
                 	<input type="submit" id="invisible" class="invisible"/>
				<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				
				<input id="TmsProgrmFileNm_sys_gb" type="hidden" /> 
				<input id="TmsProgrmFileNm_task_gb" type="hidden" /> 
				<input id="TmsProgrmFileNm_pg_nm" type="hidden" /> 
				<input id="TmsProgrmFileNm_user_dev_id" type="hidden" />
				<input id="TmsProgrmFileNm_user_real_id" type="hidden" />
				<input id="TmsProgrmFileNm_pg_full" type="hidden" />
				<input id="TmsProgrmFileNm_task_gb_code" type="hidden" />
				<input id="cnt" type="hidden" />
				
				<input type="hidden" id="del" name="del" value="fncManageChecked()" />
				<input type="hidden" id="fon" name="fon" />
                <input type="submit" value="실행" onclick="fn_egov_select_noticeList('1'); return false;" id="invisible" class="invisible" />
				
                	<!-- //검색 필드 박스 끝 -->


                	<div id="page_info"><div id="page_info_align"></div></div>    
                	<div class="default_tablestyle">
        			<table width="120%" border="0" cellpadding="0" cellspacing="0" >
        				<caption style="visibility:hidden">NO, 화면ID, 화면명, 시스템구분, 업무구분, 개발자, 사용여부</caption>
        				<colgroup>
        					<col width="10"/>
        					<col width="5"/> 
        					<col width="20"/>
        					<col width="50"/>
        					<col width="20"/>
        					<col width="20"/>
        					<col width="20"/>
        					<col width="10"/>
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
            					<td align="center" class="listtd" nowrap="nowrap">
            						<input type="checkbox" name="delYn" class="check2" title="선택">
            						<input type="hidden" name="checkId" value="<c:out value="${result.pgId}"/>" /></td>
            					<td align="center" class="listtd"><font style="font-weight:bold"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></font></td>
            					<td align="center" class="listtd"><c:out value="${result.pgId}"/></td>
            					<td align="left" class="listtd">
            						<a href="<c:url value='/tms/pg/selectPgInf.do'/>?pgId=<c:out value='${result.pgId}'/>&searchByPgId=<c:out value='${pgid}'/>&pageIndex=<c:out value='${page}'/>&searchBySysGb=<c:out value='${sys}'/>&searchByTaskGb=<c:out value='${task}'/>&searchByUserDevId=<c:out value='${dev}'/>&searchUseYn=<c:out value='${yn}'/>">
            							<font color="#0F438A" style="font-weight:bold"><c:out value="${result.pgNm}"/></font>
            						</a></td>
            					<td align="center" class="listtd"><c:out value="${result.sysGb}"/>&nbsp;</td>
            					<td align="center" class="listtd"><c:out value="${result.taskGb}"/>&nbsp;</td>
            					<td align="center" class="listtd"><c:out value="${result.userDevId}"/>&nbsp;</td>
            					<c:if test="${result.useYn == 'Y'}">
            						<td align="center" class="listtd""><font style="font-weight:bold"><c:out value="${result.useYn}"/></font></td>
            					</c:if>
            					<c:if test="${result.useYn == 'N'}">
            						<td align="center" class="listtd""><font style="font-weight:bold"><c:out value="${result.useYn}"/></font></td>
            					</c:if>
            				</tr>
        				</c:forEach>
        				
        				<c:if test="${fn:length(resultList) == 0}">
                     		<tr>
                       			<td nowrap colspan="8" ><spring:message code="common.nodata.msg" /></td>  
                     		</tr>      
              			</c:if>
              
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