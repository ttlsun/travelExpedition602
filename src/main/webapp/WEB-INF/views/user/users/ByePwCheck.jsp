<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- ByePwCheck.jsp -->
<%@ include file="../../../common/top.jsp" %>  
<script type="text/javascript" >
$(document).ready(function() {
	//메뉴 on 유지.
	navActive('users');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "회원탈퇴확인");
	$("#metaDescription").attr("content", "회원탈퇴확인");
	$("#metaKeywords").attr("content", "#여행자들602호 회원탈퇴확인");
});

function goBack(){
	history.go(-1);
}
</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
      <input type="button" style="float: left" class="btn btn-default" value="돌아가기" onClick="goBack()">
    </div>
	<div class="container alingMargin" style="margin: auto;">
	<header><h2 align="center" class="text-primary textFontSizeLarge">회원탈퇴확인</h2></header>
	
	<form:form commandName="users" role="form" action="usersBye.do" method="post" class="form-horizontal">
	
	<fieldset>
	<legend class="textAlignLeft textFontSizeSmall"> 
		<span>비밀번호를 입력해주세요.</span>
	</legend>
		<div class="form-group">
			<label for="id" class="col-xs-2 col-lg-2 control-label text-primary">ID : </label> 
			<div class="col-xs-10 col-lg-10">${loginInfo.id}</div>
		</div>
		<div class="form-group">
			<label for="pw" class="col-xs-2 col-lg-2 control-label text-primary">비밀번호 : </label> 
			<div class="col-xs-10 col-lg-10">
				<input type="password" name="pw" id="pw" maxlength="20" class="form-control" placeholder="비밀번호를 입력해주세요.">
				<form:errors css="errMessage" path="pw"/>
			</div>
		</div>
		<div class="form-group"  style="margin:auto; margin-top: 5%; text-align: center;">
			<input type="submit" class="btn btn-primary" value="회원탈퇴">
		</div>
	</fieldset>
	</form:form>
	</div>
</div>
</article>
</section>

<%@ include file="../../../common/bottom.jsp" %>