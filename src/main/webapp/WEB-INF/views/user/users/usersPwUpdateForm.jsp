<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- usersPwUpdateForm.jsp -->
<%@ include file="../../../common/top.jsp" %>  
<script type="text/javascript" >
$(document).ready(function() {
	//메뉴 on 유지.
	navActive('login');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "비밀번호변경");
	$("#metaDescription").attr("content", "비밀번호변경");
	$("#metaKeywords").attr("content", "#여행자들602호 비밀번호변경");
});

function goBack(){
	history.go(-1);
}

function input(){
	if($('#currentPw').val() == ""){
		alert("현재 비밀번호를 입력하세요");
		$('#currentPw').focus();
		return false;
	} else if($('#pw').val() == ""){
		alert("새로운 비밀번호를 입력하세요");
		$('#pw').focus();
		return false;
	} else if($('#pwChk').val() == ""){
		alert("새로운 비밀번호를 확인해주세요");
		$('#pwChk').focus();
		return false;
	}
	
	if($('#currentPw').val() == $('#pw').val()){
		alert("현재 비밀번호와 새로운 비밀번호가 같습니다");
		$('#pw').val("");
		$('#pw').focus();
		return false;
	}
	
	if($('#pw').val() != $('#pwChk').val()){
		alert("새 비밀번호와 비밀번호 확인이 다릅니다");
		$('#pwChk').val("");
		$('#pwChk').focus();
		return false;
	}
}
</script>

<section class="container">
<article>
<div>
	<div class="container alingMargin" style="margin: auto;">
	<header><h2 align="center" class="text-primary textFontSizeLarge">회원탈퇴확인</h2></header>
	
	<form role="form" action="usersUpdateMyPw.do" method="post" class="form-horizontal">
	<fieldset>
	<legend class="textAlignLeft textFontSizeSmall"> 
		<span>비밀번호를 입력해주세요.</span>
	</legend>
		<div class="form-group">
			<label for="password" class="col-xs-2 col-lg-2 control-label text-primary">현재 비밀번호 : </label> 
			<div class="col-xs-10 col-lg-10">
				<input type="password" name="currentPw" id="currentPw" maxlength="20" class="form-control" placeholder="비밀번호를 입력해주세요.">
			</div>
		</div>
		<div class="form-group">
			<label for="password" class="col-xs-2 col-lg-2 control-label text-primary">새 비밀번호 : </label> 
			<div class="col-xs-10 col-lg-10">
				<input type="password" name="pw" id="pw" maxlength="20" class="form-control" placeholder="비밀번호를 입력해주세요.">
			</div>
		</div>
		<div class="form-group">
			<label for="password" class="col-xs-2 col-lg-2 control-label text-primary">새 비밀번호 확인 : </label> 
			<div class="col-xs-10 col-lg-10">
				<input type="password" id="pwChk" maxlength="20" class="form-control" placeholder="비밀번호를 입력해주세요.">
			</div>
		</div>
		<div class="form-group"  style="margin:auto; margin-top: 5%; text-align: center;">
			<input type="button" class="btn btn-primary" value="이전으로" onClick="goBack()">
			<input type="reset" class="btn btn-primary" value="다시작성">
			<input type="submit" class="btn btn-primary" value="수정하기" onClick="return input()">
		</div>
	</fieldset>
	</form>
	</div>
</div>
</article>
</section>

<%@ include file="../../../common/bottom.jsp" %>