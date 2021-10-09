<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../common/css_script_js.jsp" %>   

<script type="text/javascript">
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
        	<li data-nav="introduction"><a href="${contextPath}/introduction.do"> 여행자들 소개 </a></li>
        	
        	<!-- 사업자일경우 : 추후 협의하에 변경 요망-->
        	<c:if test="${userCode eq 'business' }">
        	<li data-nav="camping" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 캠핑/글램핑 <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="${contextPath}/campingList.do">캠핑/글램핑</a></li>
	            	<li><a href="${contextPath}/tourList.do">관광지</a></li>
	         	</ul>
         	</li>
         	</c:if>
         	
         	<!-- 사용자일경우 : 추후 협의하에 변경 요망-->
         	<c:if test="${userCode eq 'customer' }">
         	<li data-nav="camping" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 캠핑/글램핑 <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="${contextPath}/campingList.do">캠핑/글램핑</a></li>
	            	<li><a href="${contextPath}/tourList.do">관광지</a></li>
	         	</ul>
         	</li>
         	</c:if>
        	
        	
        	<li data-nav="community" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 후기커뮤니티공간<b class="caret"></b></a>
            	<ul class="dropdown-menu">
            		<li><a href="${contextPath}/communityList.do">모든 후기</a></li>
           			<li><a href="${contextPath}/reviewCommunityList.do">방문 후기</a></li>
           			<!-- 회원일경우에만 보여지게 처리 -->
           			<c:if test="${!empty userId}">
           				<li><a href="${contextPath}/reservationCommunityList.do">MY 후기</a></li>
	         		</c:if>
	         	</ul>
         	</li>
         	
          	<li data-nav="notice"><a href="${contextPath}/noticeList.do">공지사항 </a></li>
          	<li data-nav="event" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 이벤트 <b class="caret"></b></a>
            	<ul class="dropdown-menu">
            		<li><a href="${contextPath}/eventList.do">진행중인 이벤트</a></li>
           			<li><a href="${contextPath}/endEventList.do">종료된 이벤트</a></li>
	         	</ul>
         	</li>
          	
          	<li data-nav="qna" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> Q &amp; A <b class="caret"></b></a>
            	<ul class="dropdown-menu">
            		<!-- 세영 : (0927)문의 질문 위치 변경 -->
            		<li><a href="${contextPath}/qnaList.do">문의하기</a></li>
           			<li><a href="${contextPath}/faqList.do">자주 묻는 질문</a></li>
	         	</ul>
         	</li>
         	
         	<!-- 회원일경우에만 보여지게 처리 -->
         	<c:if test="${!empty userId}">
          	<li data-nav="myInfo" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown">마이페이지<b class="caret"></b></a>
            	<ul class="dropdown-menu">
            		<!-- 세영 : (0927)드랍메뉴 위치&이름 변경 -->
           			<li><a href="#">내 정보</a></li>
	            	<li><a href="${contextPath}/myReservationList.do">내 예약 목록</a></li>
	            	<li><a href="${contextPath}/myLikesList.do">내 관심 목록</a></li>
	         	</ul>
         	</li>
         	</c:if>
         	
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
