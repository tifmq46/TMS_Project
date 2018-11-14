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
<title>엑셀파일 등록</title>
<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
	
	.wrap-loading{ /*화면 전체를 어둡게 합니다.*/
    	position: fixed;
    	left:0;
    	right:0;
    	top:0;
    	bottom:0;
    	background: rgba(0,0,0,0.2); /*not in ie */
    	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */
	}
    .wrap-loading div{ /*로딩 이미지*/
        position: fixed;
        top:50%;
        left:50%;
        margin-left: -80px;
        margin-top: -60px;
    }
    .display-none{ /*감추기*/
        display:none;
    }
	
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script language="javascript1.2"  type="text/javaScript"> 

$(function(){ 	
	
	$('#listButton').click(function(){ 
		
		var file = progrmManageForm.file.value;
		var fileExt = file.substring(file.lastIndexOf('.')+1); //파일의 확장자를 구합니다.
		
		if( !file ){ 
			swal( "파일을 선택하여 주세요!");
		    return;
		}
		   
		if(!(fileExt.toUpperCase() == "XLSX")) {
		    swal("xlsx 파일만 업로드 가능합니다!");
		    return;
		}
		
		var form = $('form')[0];
		var formData = new FormData(form);
		
			      $.ajax({
			         
			         type:"POST",
			         url: "<c:url value='/tms/pg/requestupload.do'/>",
			         processData: false,
			         contentType: false,
			         data : formData,
			         success : function(str){
			        	 //alert(str.length);			        	 
			        	 $("#tb1").empty();
			        	 
			        	 if(str.length == 0) {
			        		 $("#tb1").append("<tr><td align='center' class='listtd'><font style='color:#0f438a; align:center;' size='3px'><strong>&#60;등록성공&#62;</strong></font></td></tr>")
			        	 } else {
			        		 $("#tb1").append("<tr><td align='center' class='listtd'><font style='color:#CC3C39; align:center;' size='3px'><strong>&#60;등록실패&#62;</strong></font></td></tr>")
			        		 
			        		 $.each(str, function(i){
			        			 	
			        			 if(str[0].problem === "병합") {
					        		 alert("1");
					        	 }
			        			 
					        		$("#tb1").append("<tr><td align='center' class='listtd'><strong>"+str[i].problem+"</strong></td></tr>")
							        $("#tb1").append("<tr><td align='center' class='listtd'><font style='color:#CC3C39;'><strong>- 원인 : "+str[i].reason+"</strong></font></td></tr>")
					         });
			        	 }
			        	 
			         }, 
			         beforeSend:function(){
			             $('.wrap-loading').removeClass('display-none');

			         }, 
			         complete:function(){
			             $('.wrap-loading').addClass('display-none');

			         },
			         error : function(request,status,error){
			            swal("등록할 수 없습니다.");
			         }
			      });
			   })
			})


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
	<div class="wrap-loading display-none">

    	<div><img src="<c:url value='/images/loading1.gif' />" /></div>

	</div>  
	
<form id="progrmManageForm" name="progrmManageForm" action ="<c:url value='/sym/prm/EgovProgramListSearch.do'/>" method="post" enctype="multipart/form-data">
<input type="submit" id="invisible" class="invisible"/>
<input type="submit" id="test" class="invisible"/>
    <!-- 검색 필드 박스 시작 -->
    <div id="search_field" style="width:100%">
        <div id="search_field_loc" class="h_title">엑셀파일 등록</div><br>
        	<ul id="search_first_ul">
            	<li>
                	<input type="file" id="file" name="file" />
                        
                    <div class="buttons" style="float:right;">
                    	<a id="listButton" name="listButton" href="#LINK" ><spring:message code="button.create" /></a>
                    	<input type="hidden" id="change" name="change" value="<c:out value='${result}'/>" onclick="test(); return false;">
                    </div>
                </li>       
            </ul>        
        
        
        
            <fieldset style="overflow-y : scroll; height : 235px; border-bottom: 1px solid #81B1D5; border-top: 1px solid #81B1D5;"><legend>조건정보 영역</legend>    
            <div class="sf_start">

                
                <div class="default_tablestyle">
            			<table id="tb1" width="100%" border="0" cellpadding="0" cellspacing="0" >
        					          
            			</table>  
               		</div>   
                
               	               
            </div>          
            </fieldset>
            <br>
            <ul id="search_second_ul">            		  
                    <li>
                        <div class="buttons" style="float:right;">                        
                            <a href="#LINK" onclick="window_close(); return false;"><spring:message code="button.close" /></a>
                        </div>                              
                    </li>                    
            </ul> 
            
            
    </div>
    <!-- //검색 필드 박스 끝 -->

</form>
 

</body>
</html>

