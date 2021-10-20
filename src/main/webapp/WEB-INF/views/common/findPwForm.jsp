<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- views/common/findIdForm.jsp -->
<%@ include file="../../common/top.jsp" %>  

<script type="text/javascript" >
$(document).ready(function() {
	//메뉴 on 유지.
	navActive('login');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "비밀번호 찾기");
	$("#metaDescription").attr("content", "비밀번호 찾기");
	$("#metaKeywords").attr("content", "#여행자들602호 비밀번호 찾기");
});

function goBack(){
	history.go(-1);
}

function findIdBtn(){
	location.href="usersFindId.do";
}
</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
      <input type="button" style="float: left" class="btn btn-default" value="돌아가기" onClick="goBack()">
    </div>
	<div class="container alingMargin" style="margin: auto;">
		<header><h2 align="center" class="text-primary textFontSizeLarge">비밀번호 찾기</h2></header>
	
	<form:form commandName="users" action="usersFindPw.do" method="post" class="form-horizontal">
	<fieldset>
	<legend class="textAlignLeft textFontSizeSmall"> 
		<span>찾으실 아이디와 등록한 이메일을 입력하세요</span>
	</legend>
		<div class="form-group">
			<label for="id" class="col-xs-2 col-lg-2 control-label text-primary">ID : </label> 
			<div class="col-xs-10 col-lg-10">
				<input type="text" name="id" id="id" maxlength="20" class="form-control" placeholder="아이디를 입력하세요">
				<form:errors cssClass="errMessage" path="id"/>
			</div>
		</div>
		<div class="form-group">
			<label for="email" class="col-xs-2 col-lg-2 control-label text-primary">이메일 : </label> 
			<div class="col-xs-10 col-lg-10">
				<input type="text" name="email" id="email" maxlength="20" class="form-control" placeholder="이메일을 입력하세요">
				<form:errors cssClass="errMessage" path="email"/>
			</div>
		</div>
		<div class="form-group"  style="margin:auto; margin-top: 5%; text-align: center;">
			<input type="button" class="btn btn-primary" value="아이디 찾기" onClick="findIdBtn()">
			<input type="submit" class="btn btn-primary" value="비밀번호 찾기"> 
		</div>
	</fieldset>
	</form:form>
	</div>
</div>
</article>
</section>

<%@ include file="../../common/bottom.jsp" %>