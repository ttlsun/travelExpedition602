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
     	
		<ul class="navbar-nav" style="width:100%">
	    	<li style="float: right; list-style: none;">
	        	<c:choose>
	          		<c:when test="${!empty userId}">
	          			<a class="navbar-brand" href="${contextPath}/logout.do"><b>${userName}님 로그아웃</b> </a>
	          		</c:when>
	          		<c:otherwise>
	          			<a class="navbar-brand" href="${contextPath}/login.do"><b> 로그인</b> </a>
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
		<div class="collapse navbar-collapse navbar-ex1-collapse ">
    	<ul class="nav navbar-nav">
    	
    		<c:if test="${userCode eq 'admin' }">
    			<li data-nav=""><a href="${contextPath}/main.ad"><b>여행자들 관리자홈</b></a></li>
    		</c:if>
    		
        	<li data-nav="introduction"><a href="${contextPath}/introduction.do"><b>여행자들 소개</b> </a></li>
        	
        	<!-- 사업자일경우 : 추후 협의하에 변경 요망-->
        	<c:if test="${userCode eq 'business'}">
        	<li data-nav="bCamping" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <b>[개인] 캠핑/관광지</b> <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="${contextPath}/bCampingList.do"><b>캠핑/글램핑</b></a></li>
	            	<li><a href="${contextPath}/bTourList.do"><b>관광지</b></a></li>
	         	</ul>
         	</li>
         	</c:if>
         	
         	<!-- 비회원 & 회원보는 리스트 -->
         	<li data-nav="camping" class="dropdown">
         		<a href="#" class="dropdown-toggle" data-toggle="dropdown">
         		<!-- 사업자와 관리자일경우, [일반회원] 으로 보이기. -->
         		<c:choose>
         			<c:when test="${userCode eq 'business' or userCode eq 'admin' }"> <b>[전체] 캠핑/관광지</b></c:when>
         			<c:otherwise><b> 캠핑/관광지</b></c:otherwise>
         		</c:choose>
           		 <b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="${contextPath}/campingList.do"><b>캠핑/글램핑</b></a></li>
	            	<li><a href="${contextPath}/tourList.do"><b>관광지</b></a></li>
	         	</ul>
         	</li>
         	
        	<li data-nav="community" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"><b> 후기</b><b class="caret"></b></a>
            	<ul class="dropdown-menu">
            		<li><a href="${contextPath}/communityList.do"><b>모든 후기</b></a></li>
           			<li><a href="${contextPath}/reviewCommunityList.do"><b>방문 후기</b></a></li>
           			<!-- 회원일경우에만 보여지게 처리 -->
           			<c:if test="${!empty userId}">
           				<li><a href="${contextPath}/myCommunityList.do"><b>MY 후기</b></a></li>
	         		</c:if>
	         	</ul>
         	</li>
         	
          	<li data-nav="notice"><a href="${contextPath}/noticeList.do"><b>공지사항</b> </a></li>
          	<li data-nav="event" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"><b> 이벤트</b> <b class="caret"></b></a>
            	<ul class="dropdown-menu">
            		<li><a href="${contextPath}/eventList.do"><b>진행중인 이벤트</b></a></li>
           			<li><a href="${contextPath}/endEventList.do"><b>종료된 이벤트</b></a></li>
	         	</ul>
         	</li>
          	
          	<li data-nav="qna" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"><b> Q &amp; A</b> <b class="caret"></b></a>
            	<ul class="dropdown-menu">
            		<!-- 세영 : (0927)문의 질문 위치 변경 -->
            		<li><a href="${contextPath}/qnaList.do"><b>문의하기</b></a></li>
           			<li><a href="${contextPath}/faqList.do"><b>자주 묻는 질문</b></a></li>
	         	</ul>
         	</li>
         	
         	<!-- 회원일경우 or 관리자가 아닐경우 보여지게 처리 -->
         	<c:if test="${userCode eq 'business' or userCode eq 'customer'}">
          	<li data-nav="myInfo" class="dropdown">
           		<a href="#" class="dropdown-toggle" data-toggle="dropdown"><b>마이페이지</b><b class="caret"></b></a>
            	<ul class="dropdown-menu">
           			<li><a href="${contextPath}/usersMyInfo.do"><b>내 정보</b></a></li>
	            	<c:if test="${userCode eq 'business'}">
	            	<li><a href="${contextPath}/payList.do"><b>입금 계좌 관리</b></a></li>
	            	</c:if>
	            	<c:if test="${userCode eq 'customer'}">
	            	<li><a href="${contextPath}/payList.do"><b>내 결제수단 목록</b></a></li>
	            	<li><a href="${contextPath}/myReservationList.do"><b>내 예약 목록</b></a></li>
	            	<li><a href="${contextPath}/myLikesList.do"><b>내 관심 목록</b></a></li>
	            	</c:if>
	         	</ul>
         	</li>
         	</c:if>
        </ul>
      	</div>
      	
	</nav>
    </div>
</div>
