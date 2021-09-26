<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<script type="text/javascript" >
$(document).ready(function() {
	navActive('member');
});

function byeBtn() {
	if(confirm("정말 회원탈퇴 하시겠습니까?")){
		$('#myFrom').submit();
	}
}

</script>


<section>
<article>
<div class="marginPadding10">
	<header><h2 align="center" class="text-primary"> 회원정보 </h2></header>
	
	<form action="" method="post" id="myFrom" class="form-horizontal" role="form">
	
		<div class="form-group">
		<table class="table table-bordered">
			<tr>
				<td width="20%"><label>아이디</label></td>
				<td></td>
			</tr>
			<tr>
				<td><label>비밀번호</label></td>
				<td>*****</td>
			</tr>
			<tr>
				<td><label>이름</label></td>
				<td></td>
			</tr>
			<tr>
				<td><label>이메일</label></td>
				<td></td>
			</tr>
			<tr>
				<td><label>핸드폰번호</label></td>
				<td></td>
			</tr>
			<tr>
				<td><label>적립포인트</label></td>
				<td></td>
			</tr>
		</table>
		</div>
		<div class="marginPadding10" align="center">
			<input type="button" class="btn btn-primary" value="정보변경하기" >
			<input type="button" class="btn btn-primary" value="비밀번호변경" >
			<input type="submit" class="btn btn-primary" value="회원탈퇴" onclick="byeBtn()">
			<input type="button" class="btn btn-primary" value="목록" >
		</div>
	</form>
	</div>

</article>
</section>

<%@ include file="../../common/bottom.jsp" %>    
