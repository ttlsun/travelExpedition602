<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage ="true" %>

<%@ include file="../common/css_script_js.jsp" %>   

<script type="text/javascript">

function loginBtn() {
	alert("로그인페이지로 이동합니다"); //추후 login 넣으면 변경예정
	location.href = "login.do";
}
</script>

<section>
<article>
	<div class="marginPadding10">
	<header><h2 align="center" class="text-primary"> error </h2></header>
	<div class="divform">
		
		<form method="post">
			<table class="table table-bordered rounded">
				<tr>
					<td class="divform">
						경로를 잘못 접근하셨습니다.<br>
						입력하신 주소가 정확한지 다시 한번 확인하시고,<br>
						동일한 문제가 지속적으로 발생되는 경우는<br>
						관리자에게 문의해주세요.<br>
						
						<br><br>
						ⓒ 여행자들 602호 관리자 올림.
					</td>
				</tr>
				<tr>
					<td>
						<input type="button" class="btn btn-primary" value="로그인" onclick="loginBtn()">
					</td>
				</tr>
			</table>
		</form>
		</div>
	</div>
</article>
</section>
