<%@page import="user.users.model.UsersBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="init.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />

<meta name="Title" id="metaTitle" content="">
<meta name="description" id="metaDescription" content="">
<meta name="keywords" id="metaKeywords" content=""> 

<title> 602호 여행자들</title>
</head>

<%	
	request.setCharacterEncoding("UTF-8");
	//로그인 세션 셋팅. (id,name,구분코드)
	UsersBean loginInfo = (UsersBean)session.getAttribute("loginInfo");
	String userName = loginInfo == null ? "" :  loginInfo.getName();
	String userId = loginInfo == null ? "" :  loginInfo.getId();
	String userCode = loginInfo == null ? "" :  loginInfo.getUcode();

	//사업자 회원용.(테스트시, 추후 삭제요망)
	/* String userName = loginInfo == null ? "사업자회원" :  loginInfo.getName();
	String userId = loginInfo == null ? "business01" :  loginInfo.getId();
	String userCode = loginInfo == null ? "business" :  loginInfo.getUcode();
 */

%> 

<c:set var ="userId"  value= "<%=userId%>"/>
<c:set var ="userName"  value= "<%=userName%>"/>
<c:set var ="userCode"  value= "<%=userCode%>"/>

<%-- 
해당 링크 : 썸머노트랑 같이 적용시 깨짐현상있음..
<link href="${css}/style.css" rel="stylesheet" type="text/css"> 
<link href="${css}/bootstrap.css" rel="stylesheet">
<link href="${css}/custom2.css" rel="stylesheet">
<link href="${css}/kfonts2.css" rel="stylesheet"> --%>

<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<link href="${contextPath}/resources/css/kfonts2.css" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<!-- 공통으로 쓰일 css -->
<link href="${css}/common.css" rel="stylesheet">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
<style type="text/css">
	/* 필요한게 있으면 1차적으로 여기에 테스트해보고 공통 사항으로 들어갈시 , common.css에 적용시켜주세요.(이문구는, 추후 문구 삭제 예정)*/
	.travelExpedition602{
	    max-width: 100%;
	    height: auto;
	}
	
	.nav>li>a {
	    position: relative;
	    display: block;
	    padding: 12px 17px;
	    font-size: large;
	}
	
	.navbar-default .navbar-nav>.active>a, .navbar-default .navbar-nav>.active>a:focus, .navbar-default .navbar-nav>.active>a:hover {
	    color: #3a3568;
	    background-color: ##e1e1e1;
	}
</style>

<!-- 제이쿼리 js -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<!-- 부트스트랩 js -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- 썸머노트 js -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<!-- 공통 js -->
<script type="text/javascript" src="${js}/common.js"></script>

<%-- <script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/bootstrap.min.js"></script>

 --%>
<script type="text/javascript" >
	var inputType; 	//inputType추출 변수
	
	$('.table th').addClass("textAlignCenter");
</script>



