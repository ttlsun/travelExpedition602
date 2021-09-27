<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>  
<script type="text/javascript" >
$(document).ready(function() {
	//메뉴 on 유지.
	navActive('member');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "비밀번호변경");
	$("#metaDescription").attr("content", "비밀번호변경");
	$("#metaKeywords").attr("content", "#여행자들602호 비밀번호변경");
});

</script>

<section class="container">
<article>
<div>
	<div class="container alingMargin" style="margin: auto;">
		<div align="center">
			<h2><label class="text-primary textFontSizeLarge"> 비밀번호변경 </label></h2>
		</div>
	
	<form role="form" action="" method="post" class="form-horizontal">
	
	<fieldset>
	<legend class="textAlignLeft textFontSizeSmall"> 
		<span>안전한 비밀번호로 내 정보를 보호하세요.</span>
	</legend>
		<div class="form-group">
			<label for="biasPassword" class="col-xs-2 col-lg-2 control-label text-primary"> 현재 비밀번호 : </label> 
			<div class="col-xs-10 col-lg-10">
				<input type="password" name="" id="biasPassword" class="form-control" placeholder="현재 비밀번호" value="">
			</div>
		</div>
		<div class="form-group">
			<label for="password" class="col-xs-2 col-lg-2 control-label text-primary"> 새 비밀번호 : </label> 
			<div class="col-xs-10 col-lg-10">
				<input type="password" name="" id="password" class="form-control" placeholder="새 비밀번호" value="">
			</div>
		</div>
		<div class="form-group">
			<label for="rePassword" class="col-xs-2 col-lg-2 control-label text-primary"> 새 비밀번호 확인: </label> 
			<div class="col-xs-10 col-lg-10">
				<input type="password" name="" id="rePassword" class="form-control" placeholder="새 비밀번호 확인" value="">
			</div>
		</div>
		<div class="form-group"  style="margin:auto; margin-top: 5%; text-align: center;">
			<input type="submit" class="btn btn-primary" value="비밀번호 변경">
		</div>
	</fieldset>
	</form>
	</div>
</div>
</article>
</section>

<%@ include file="../../common/bottom.jsp" %>