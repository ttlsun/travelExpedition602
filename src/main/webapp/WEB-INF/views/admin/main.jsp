<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/admin/top.jsp" %>  
<script type="text/javascript">
$(document).ready(function() {
	navActive('main');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 홈");
	$("#metaDescription").attr("content", "관리자 홈");
	
});

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 관리자 홈 </h2></header>
	
	<div>
		안녕하세요 . 관리자님. 반갑습니다.
	</div>
	
</div>   
</article>
</section>

<%@ include file="../../common/admin/bottom.jsp" %>