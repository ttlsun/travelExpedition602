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

<div class="container">
	<!-- 승민님이 만들어주신 저희 대표이미지..! -->
	<div style="padding-top: 3%;">
		<!-- 관형님이 링크 걸어달라고 하셔서 걸었습니다. 관형님 아이디어~! -->
		<a href="${contextPath}/main.do">
			<img class="travelExpedition602" width="1140" src="${images}/602traveler.jpg" title="602호여행자들 이미지" alt="602호여행자들 이미지"  />
		</a>
	</div>
	<div>
		<nav class="navbar navbar-default" role="navigation" >
     	
     	<ul class="navbar-default" style="width:100%">
	    	<li style="float: right; list-style: none;">
	        	<c:choose>
	          		<c:when test="${!empty userId}">
	          			<b><a class="navbar-brand" style="float: right;" href="${contextPath}/logout.do"><b> ${userName}님 로그아웃</b> </a></b>
	          		</c:when>
	          		<c:otherwise>
	          			<b><a class="navbar-brand" style="float: right;" href="${contextPath}/login.do"><b> 로그인</b> </a></b>
	          		</c:otherwise>
	          	</c:choose>
	        </li>
	    </ul>
     	
     	<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
      			<span class="navbar-toggler-icon" style="color: white"></span><small><strong><b>〓</b></strong></small>
        	</button>
        	
        	<a class="navbar-brand" href="${contextPath}/main.do">
        	<span class="glyphicon glyphicon-send"></span>&nbsp;<b>602호여행자들</b></a>
      	</div>
		<div class="collapse navbar-collapse navbar-ex1-collapse">
    	<ul class="nav navbar-nav">
        	<li data-nav="main"><a href="${contextPath}/main.ad"><b>여행자들 관리자홈</b> </a></li>
        	
        	<li data-nav="keyword" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"><b> 태그&amp;이미지</b> <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="${contextPath}/keywordList.ad"><b>키워드태그관리</b></a></li>
	            	<li><a href="${contextPath}/postimgList.ad"><b>이미지 관리</b></a></li>
	         	</ul>
         	</li>
        	
        	<li data-nav="camping" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"><b> 캠핑/관광지</b> <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="${contextPath}/campingList.ad"><b>캠핑/글램핑 관리</b></a></li>
	            	<li><a href="${contextPath}/tourList.ad"><b>관광지 관리</b></a></li>
	         	</ul>
         	</li>
         	
         	<li data-nav="community" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"><b> 후기커뮤니티</b> <b class="caret"></b></a>
            	<ul class="dropdown-menu">
            		<li><a href="${contextPath}/communityList.ad"><b>후기커뮤니티</b> </a></li>
           			<li><a href="${contextPath}/communityRatingList.ad"><b>후기관련 통계</b> </a></li>
	         	</ul>
         	</li>
         	
          	<li data-nav="notice"><a href="${contextPath}/noticeList.ad"> <b>공지사항</b> </a></li>
          	<li data-nav="event" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"><b> 이벤트</b> <b class="caret"></b></a>
            	<ul class="dropdown-menu">
            		<li><a href="${contextPath}/eventList.ad"><b>진행중인 이벤트</b> </a></li>
           			<li><a href="${contextPath}/endEventList.ad"><b>종료된 이벤트</b> </a></li>
	         	</ul>
         	</li>
         	
          	<li data-nav="qna" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <b>Q&amp;A</b> <b class="caret"></b></a>
            	<ul class="dropdown-menu">
	            	<li><a href="${contextPath}/qnaList.ad"><b>문의</b> </a></li>
	         	</ul>
         	</li>
          	
          	<li data-nav="member" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"><b>회원관리</b> <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="${contextPath}/usersList.ad"><b>회원리스트</b> </a></li>
	            	<li><a href="${contextPath}/userReservationList.ad"><b>회원예약리스트</b> </a></li>
	         	</ul>
         	</li>
        </ul>
      	</div>
      	
		</nav>
    </div>
</div>
