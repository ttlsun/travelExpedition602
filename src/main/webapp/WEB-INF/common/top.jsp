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
          	
          	<!-- 세영 : (0927)공지 이벤 위치 변경 -->
          	<li data-nav="notice"><a href="#">공지사항 </a></li>
          	<li data-nav="event"><a href="#">이벤트 </a></li>
          	
          	<li data-nav="qandA" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> Q &amp; A <b class="caret"></b></a>
            	<ul class="dropdown-menu">
            		<!-- 세영 : (0927)문의 질문 위치 변경 -->
            		<li><a href="#">문의하기</a></li>
           			<li><a href="#">자주 묻는 질문</a></li>
	         	</ul>
         	</li>
         	
          	<li data-nav="member" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown">마이페이지<b class="caret"></b></a>
            	<ul class="dropdown-menu">
            		<!-- 세영 : (0927)드랍메뉴 위치&이름 변경 -->
           			<li><a href="#">마이페이지</a></li>
	            	<li><a href="#">내 정보 관리</a></li>
	            	<li><a href="#">내 예약 목록</a></li>
	            	<li><a href="#">내 관심 목록</a></li>
	         	</ul>
         	</li>
         	
          	<!-- 세영 : (예정)로그인/회원가입 구현 완료 후, 로그인x면 로그인 & 로그인o면 로그아웃 -->
          	<li data-nav="login"><a href=""> 님 로그아웃 </a></li>
          	
        </ul>
      </div>
	</nav>
    </div>
</div>
