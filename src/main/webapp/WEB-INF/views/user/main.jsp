<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   
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
	<header><h2 align="center" class="text-primary"> 602호여행자들 메인 </h2></header>
	
		<div>
			이젠 관형님이 여기에 이것저것 이쁘게 뿌려주실 공간입니다..
			<br>
			상위 여행자들 클릭시, 회원 메인으로 이동 시켜놨는데.. 딴데 걸어두시는게 맞다.. 의견있으신분 알려주셔요.(조언도 주셔요..)
			<br>
			관리자페이지 홈은 어떤 내용이 좋을까요??? 머리가 안돌아가요.. 알려주셔요..
			<br>
			<span> (샘플페이지 가고 싶다면, <a href="home">샘플보러가기</a>) </span>
			<br>
			<span> 관리자 : 메인(<a href="main.ad">관리자 - 메인</a>) </span>
			<br>
			<span> 회원 : 메인(<a href="main.do">회원 - 메인</a>) </span>
		</div>
	
</div>   
</article>
</section>

<%@ include file="../../common/bottom.jsp" %>