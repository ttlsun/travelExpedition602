<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/top.jsp" %> 

<script type="text/javascript" >
$(document).ready(function() {
	navActive('introduction');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "여행자들602호 소개");
	$("#metaDescription").attr("content", "여행자들602호 개발자들 소개");
	$("#metaKeywords").attr("content", "#여행자들602호, #개발자들");
	
});
</script>

<section class="container">
<article>
<div>
	<header>
		<div style="padding-bottom: 1%;">
			<img class="travelExpedition602" width="1140" src="${images}/introduction.jpg" title="introduction 이미지" alt="introduction 이미지"  />
		</div>
	</header>
	
	<div class="marginPadding10">
		<ul class="nav nav-tabs">
		      <li><a href="#home" data-toggle="tab">팀원 소개</a></li>
		      <li class="active"><a href="#tab1" data-toggle="tab">602호여행자들 소개</a></li>
		      <li><a href="#tab2" data-toggle="tab">개발일정</a></li>
		      <li><a href="#tab3" data-toggle="tab">오시는 길</a></li>
		</ul>
		<div class="tab-content marginPadding10">
		    <div class="tab-pane fade" id="home" style="text-align: left;">
			    <h3>팀원</h3>
			    <div style="padding-top: 3%;">
					<img class="travelExpedition602" width="600" src="${images}/member.jpg" title="602호여행자들 팀원 이미지" alt="602호여행자들 팀원 이미지"  />
				</div>
			</div>
		    <div class="tab-pane active fade in" id="tab1" style="text-align: left;">
		    	<h3>602호여행자들 소개</h3>
		    	<span class="spanFlowRootP10"></span>
				<p>캠핑/글램핑 비교 예약 웹 서비스이며, 기존 캠핑/글램핑을 제공하는 다양한 업체들의 위치, 가격, 옵션, 이용시간 등을 한눈에 비교할 수 있도록 보여주려고 한다.</p>
				<p>또한, 캠핑/글램핑을 진행하는 장소에 따라 주변에서 접근이 용이한 관광지를 지도 형태로 보여주며,</p>
				<p>원하는 여행의 테마를 선택 했을 경우 사용자 맞춤 코스를 제공할 예정이다.</p>
				<p>후기 피드를 남길 수 있는 SNS 형태의 게시판도 운영.</p>
				
			</div>
		    <div class="tab-pane fade" id="tab2" style="text-align: left;">
		    	<h3>개발일정</h3>
		     	<p>	
			     	<span>현재~ ing</span> 
			     	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			     	<span> 2021.09.24 개발단계.</span>
		     	</p>
		     	<p>	
			     	<span>2021.10.20 이후</span> 
			     	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			     	<span> 2021.10.20 이후 개발 완료. 서비스 중..</span>
		     	</p>
				
			</div>
		    <div class="tab-pane fade" id="tab3" style="text-align: left;">
		      	<h3> 오시는 길</h3>
				<span>중앙정보처리학원 </span>
				<p>서울 마포구 신촌로 176</p>
				<a href="http://naver.me/FPsLILOP" target="_blank" class="text-decoration-none" title="구글 중앙정보처리학원 지도 페이지로 이동">
				지도보기
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-geo-alt-fill" viewBox="0 0 16 16">
			  		<path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10zm0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6z"/>
					</svg>
              	</a>
			</div>
		</div>
	</div>
</div>
</article>
</section>
<%@ include file="../../../common/bottom.jsp" %>
