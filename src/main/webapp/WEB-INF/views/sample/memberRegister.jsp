<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<script type="text/javascript" >

$(document).ready(function(){
	//메뉴 on 유지.
	navActive('member');
});

function inputSave() {
	if (!confirm('등록 하시겠습니까?')){
		return false;
	}
	
	return true;
	
}

</script>



<section>
<article>
<div class="marginPadding10">
	<header><h2 align="center" class="text-primary"> 회원가입 </h2></header>
	
	<form name="myForm" action="" method="post" class="form-horizontal">
	<table class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
		<tr>
			<td width="20%"><label for="id"><span class="redFont"> * </span>아이디 </label> </td>
			<td>
				<input type="text" class="form-control" id="id" name="id" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="password"><span class="redFont"> * </span> 비번 </label> </td>
			<td>
				<input type="text" class="form-control" id="password" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="rePassword"><span class="redFont"> * </span> 비번 재확인 </label> </td>
			<td>
				<input type="text" class="form-control" id="rePassword" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="name"><span class="redFont"> * </span> 이름</label> </td>
			<td>
				<input type="text" class="form-control" id="name" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="email"><span class="redFont"> * </span> 이메일 </label> </td>
			<td>
				<input type="text" class="form-control" id="email" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="phone"><span class="redFont"> * </span> 핸드폰번호 </label> </td>
			<td>
				<input type="text" class="form-control" id="phone" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" class="btn btn-primary" value="등록" onclick="return inputSave()">
				<input type="reset" class="btn btn-default" value="다시작성">
				<input type="button" class="btn btn-primary" value="목록보기">
			</td>
		</tr>
	</table>
	</form>
</div>  
</article>
</section>


<%@ include file="../../common/bottom.jsp" %>
   