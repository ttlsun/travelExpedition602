<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../common/css_script_js.jsp" %>   

<script type="text/javascript" >
//테마별
var selThemeArr = new Array('해변','섬','산','숲','계곡','강','호수','도심');

//메뉴바 탭 누를때 active
function navActive(activeName) {
	for (var i = 0; i < $('.navbar-nav li').length; i++) {
		//console.log(i + ":" + $('.navbar-nav li').eq(i).attr('data-nav') + ':' + activeName);
		if (activeName == $('.navbar-nav li').eq(i).attr("data-nav")) {
			$('.navbar-nav li').eq(i).addClass("active").siblings('li').removeClass("active");
			break;
		}
	}
}
</script>

<div class="container" style="padding-top: 10px;">
	<div>
	<nav class="navbar navbar-default" role="navigation" >
     
    	<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
      			<span class="navbar-toggler-icon" style="color: white"></span><small><strong>〓</strong></small>
        	</button>
        	<a class="navbar-brand" href="${contextPath}/main"><span class="glyphicon glyphicon-send"></span>&nbsp;602호여행자들</a>
      	</div>
	<div class="collapse navbar-collapse navbar-ex1-collapse ">
    	<ul class="nav navbar-nav">
        	<li data-nav="introduction"><a href=""> 여행자들 소개 </a></li>
        	
        	<li data-nav="camping" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 캠핑/글램핑 <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="#">캠핑/글램핑</a></li>
	            	<li><a href="#">관광지</a></li>
	         	</ul>
         	</li>
        	
        	<li data-nav="community"><a href="#">후기커뮤니티공간 </a></li>
          	
          	<li data-nav="event"><a href="#">이벤트 </a></li>
          	<li data-nav="notice"><a href="#">공지사항 </a></li>
          	
          	<li data-nav="qandA" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> Q &amp; A <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="#">자주 묻는 질문</a></li>
	            	<li><a href="#">문의</a></li>
	         	</ul>
         	</li>
         	
         	<li data-nav="reservation" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 내예약관리 <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="#">장바구니</a></li>
	            	<li><a href="#">내 예약 목록</a></li>
	         	</ul>
         	</li>
          	
          	<li data-nav="member" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown">내정보관리 <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="#">내정보 관리</a></li>
	            	<li><a href="#">비밀번호 변경</a></li>
	         	</ul>
         	</li>
          	
          	<li data-nav="login"><a href=""> 님 로그아웃 </a></li>

			<!-- 샘플 :추후 삭제 예정 -->
          	<li data-nav="sample"><a href="${contextPath}/sampleList"> 샘플소스보기 </a></li>
          	<!-- // 샘플 -->
          	
        </ul>
      </div>
	</nav>
    </div>
</div>
