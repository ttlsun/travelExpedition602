<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- webapp/WEB-INF/views/common/loginForm.jsp -->
<%@ include file="../../common/top.jsp"%>
<style type="text/css">
	#inputDiv{
		width: 75%;
		height: 100px;
		float: left;
	}
	
	#submitDiv{
		width: 25%;
		height: 100px;
		float: left;
	}
	
	#buttonDiv{
		width: 100%;
		height: 30px;
		clear: both;
	}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		//메뉴 on 유지.
		navActive('login');

		//메타태그 설정.
		$("#metaTitle").attr("content", "로그인");
		$("#metaDescription").attr("content", "로그인");
		$("#metaKeywords").attr("content", "#여행자들602호 로그인");
	});
	
	function goBack(){
		history.go(-1);
	}

	//회원가입 클릭시
	function goRegister() {
		location.href = "usersReigster.do";
	}

	//아이디찾기 버튼 클릭시
	function findIdBtn(){
		location.href = "usersFindId.do";
	}
	
	//비번찾기 버튼 클릭시
	function findPwBtn(){
		location.href = "usersFindPw.do";
	}
</script>

<section class="container">
	<article>
		<div>
			<div class="marginPadding10" align="right">
      			<input type="button" style="float: left" class="btn btn-default" value="돌아가기" onClick="goBack()">
      		</div>
			<div class="container alingMargin" style="margin: auto;">
				<header>
					<h2 align="center" class="text-primary textFontSizeLarge">로그인</h2>
				</header>

				<form:form commandName="users" role="form" action="login.do" method="post" class="form-horizontal">
					<fieldset>
						<legend class="textAlignLeft textFontSizeSmall">
							<span>아이디와 비밀번호를 입력하세요</span>
						</legend>
						<div id="inputDiv">
							<div class="form-group">
								<label for="id" class="col-xs-2 col-lg-2 control-label text-primary">ID : </label>
								<div class="col-xs-10 col-lg-10">
									<input type="text" name="id" id="id" maxlength="20"	class="form-control" placeholder="아이디를 입력하세요">
									<form:errors css="errMessage" path="id"/>
								</div>
							</div>
							<div class="form-group">
								<label for="pw" class="col-xs-2 col-lg-2 control-label text-primary">비밀번호 : </label>
								<div class="col-xs-10 col-lg-10">
									<input type="password" name="pw" id="pw" maxlength="20" class="form-control" placeholder="비밀번호를 입력하세요">
									<form:errors css="errMessage" path="pw"/>
								</div>
							</div>
						</div>
						<div id="submitDiv" class="form-group"	style="text-align: center;">
							<input type="submit" class="btn btn-primary" style="width:60%; height:80%" value="로그인">
						</div>
						<div id="buttonDiv" class="form-group"	style="margin: auto; margin-top: 5%; text-align: center;">
							<input type="button" class="btn btn-default" value="회원가입" onclick="goRegister()">
							&nbsp;
							<input type="button" class="btn btn-default" value="아이디찾기" onclick="findIdBtn()">
							&nbsp;
							<input type="button" class="btn btn-default" value="비번찾기" onclick="findPwBtn()">
						</div>
					</fieldset>
				</form:form>
			</div>
		</div>
	</article>
</section>

<%@ include file="../../common/bottom.jsp"%>