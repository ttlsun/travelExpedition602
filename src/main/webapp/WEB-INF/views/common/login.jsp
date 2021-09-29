<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>  
<script type="text/javascript" >
$(document).ready(function() {
	//메뉴 on 유지.
	navActive('login');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "로그인");
	$("#metaDescription").attr("content", "로그인");
	$("#metaKeywords").attr("content", "#여행자들602호 로그인");
	
});

//회원가입 클릭시
function goRegister() {
	location.href= "${contextPath}/sampleMemberRegister";
}

</script>

<section class="container">
<article>
<div>
	<div class="container alingMargin" style="margin: auto;">
	<header><h2 align="center" class="text-primary textFontSizeLarge">로그인</h2></header>
	
	<form role="form" action="" method="post" class="form-horizontal">
	
	<fieldset>
	<legend class="textAlignLeft textFontSizeSmall"> 
		<span>아이디와 비밀번호를 입력해주세요.</span>
	</legend>
		<div class="form-group">
			<label for="id" class="col-xs-2 col-lg-2 control-label text-primary">ID : </label> 
			<div class="col-xs-10 col-lg-10">
				<input type="text" name="id" id="id" maxlength="40" class="form-control" placeholder="아이디를 입력해주세요." value="${id}">
			</div>
		</div>
		<div class="form-group">
			<label for="password" class="col-xs-2 col-lg-2 control-label text-primary">비밀번호 : </label> 
			<div class="col-xs-10 col-lg-10">
				<input type="password" name="password" id="password" maxlength="8" class="form-control" placeholder="비밀번호를 입력해주세요." value="${pw}">
			</div>
		</div>
		<div class="form-group"  style="margin:auto; margin-top: 5%; text-align: center;">
			<input type="submit" class="btn btn-primary" value="로그인">
			<input type="button" class="btn btn-primary" value="아이디찾기" onclick="findIdBtn()"> 
			<input type="button" class="btn btn-primary" value="비번찾기" onclick="findPwdBtn()">
			<input type="button" class="btn btn-primary" value="회원가입" onclick="goRegister()">
		</div>
	</fieldset>
	</form>
	</div>
</div>
</article>
</section>

<%@ include file="../../common/bottom.jsp" %>