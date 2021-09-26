<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   
<script type="text/javascript" >
$(document).ready(function() {
	//메뉴 on 유지.
	navActive('sample');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "상세");
	$("#metaDescription").attr("content", "상세화면");
	$("#metaKeywords").attr("content", "#상세");
	
});

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/sampleList";
}
</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">상세 화면</h2></header>
	
	<form name="myForm" action="" method="post" class="form-horizontal">
	<table class="table table-bordered">
		<tr>
			<td width="20%">번호</td>
			<td></td>
		</tr>
		<tr>
			<td>제목</td>
			<td></td>
		</tr>
		<tr>
			<td>상세</td>
			<td></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" class="btn btn-primary" value="수정">
				<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
			</td>
		</tr>
	</table>
	</form>
</div>  
</article>
</section>
<%@ include file="../../common/bottom.jsp" %>   