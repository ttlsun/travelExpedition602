<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- admin용 top -->
<%@ include file="../../common/css_script_js.jsp" %>   

<script type="text/javascript" >

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
        	<li data-nav="main"><a href=""> 여행자들 관리자홈 </a></li>
        	
        	<li data-nav="keyword" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 태그 &amp; 이미지 관리 <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="${contextPath}/keywordList.ad">키워드태그관리</a></li>
	            	<li><a href="${contextPath}/postimgList.ad">이미지 관리</a></li>
	         	</ul>
         	</li>
        	
        	<li data-nav="camping" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 캠핑/글램핑 관리 <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="${contextPath}/campingList.ad">캠핑/글램핑 관리</a></li>
	            	<li><a href="${contextPath}/tourList.ad">관광지 관리</a></li>
	         	</ul>
         	</li>
         	
         	<li data-nav="community" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 후기커뮤니티공간<b class="caret"></b></a>
            	<ul class="dropdown-menu">
            		<li><a href="${contextPath}/communityList.ad">후기커뮤니티관리</a></li>
           			<li><a href="${contextPath}/communityRatingList.ad">후기관련 통계</a></li>
	         	</ul>
         	</li>
         	
          	<li data-nav="notice"><a href="${contextPath}/noticeList.ad">공지사항관리 </a></li>
          	<li data-nav="event" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 이벤트 <b class="caret"></b></a>
            	<ul class="dropdown-menu">
            		<li><a href="${contextPath}/eventList.ad">진행중인 이벤트</a></li>
           			<li><a href="${contextPath}/endEventList.ad">종료된 이벤트</a></li>
	         	</ul>
         	</li>
         	
          	<li data-nav="qna" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> Q &amp; A 관리 <b class="caret"></b></a>
            	<ul class="dropdown-menu">
	            	<li><a href="${contextPath}/qnaList.ad">문의</a></li>
	         	</ul>
         	</li>
          	
          	<li data-nav="member" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 회원관리 <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="#">회원리스트</a></li>
	            	<li><a href="#">회원예약리스트</a></li>
	         	</ul>
         	</li>
         	
          	<!-- 세영 : (예정)로그인/회원가입 구현 완료 후, 로그인x면 로그인 & 로그인o면 로그아웃 -->
          	<li data-nav="login">
	          	<c:choose>
	          		<c:when test="${!empty userId}">
	          			<a href="${contextPath}/logout.do"> ${userName}님 로그아웃 </a>
	          		</c:when>
	          		<c:otherwise>
	          			<a href="${contextPath}/login.do"> 로그인 </a>
	          		</c:otherwise>
	          	</c:choose>
          	</li>

        </ul>
      </div>
	</nav>
    </div>
</div>
