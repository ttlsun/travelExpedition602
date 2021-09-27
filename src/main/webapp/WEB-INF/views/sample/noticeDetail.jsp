<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('notice');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "공지사항");
	$("#metaDescription").attr("content", "공지사항 상세");
	$("#metaKeywords").attr("content", "#공지사항");
});

function goList() {
	var pageNumber =  $('#pageNumber').val();
	location.href= "${contextPath}/noticeList";
}

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">공지사항 상세 화면</h2></header>
	
	<form name="myForm" action="" method="post" class="form-horizontal">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	<input type="hidden" name="num" id="num" value="">
	
	<table class="table table-bordered">
		<tr>
			<td width="20%">번호</td>
			<td></td>
			<td width="20%">조회수</td>
			<td></td>
		</tr>
		<tr>
			<td>제목</td>
			<td></td>
			<td>등록일</td>
			<td></td>
		</tr>
		<tr>
			<td colspan="4"> 내용 </td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
			</td>
		</tr>
	</table>
	</form>
</div>  
</article>
</section>
<%@ include file="../../common/bottom.jsp" %>   