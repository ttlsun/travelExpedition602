<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   
<style type="text/css">
	.mainImgWH{
	    width: 200px;
	    height: 300px;
	}
</style>
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
	
	<!-- 위에 큰 이미지 -->
	<div style="padding-top: 3%;">
		<a href="${contextPath}/main.do">
			<img class="travelExpedition602" width="1140" src="${images}/602호여행자들_큰거.jpg" title="602호여행자들 이미지" alt="602호여행자들 이미지"  />
		</a>
	</div>
	
	<div style="padding-top: 10%;">
		<!-- 캠핑 리스트 -->
		<table class="table table-bordered" style="padding-top: 5%; margin-left:2%; width: 30%; float:left;">
			<caption>캠핑장</caption>
			<thead>
				<tr class="active">
					<td colspan="3" align="center">
						캠핑장
					</td>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty campingLists}">
					<tr>
						<td colspan="3" align="center">캠핑장 목록이 없습니다.</td>
					</tr>
				</c:if>
				
				<c:forEach var="bean" items="${campingLists}">
					<tr>
						<td>
							<span style="font-size: 20px;">
								<a href="${contextPath }/campingDetail.do?num=${bean.num}&pageNumber=1">
									&nbsp;${bean.name }
								</a>
							</span>
						</td>
					</tr>
			</c:forEach> 
			</tbody>
		</table>
		<!-- //캠핑 리스트 -->
		<!-- 관광지 리스트 -->
		<table class="table table-bordered" style="padding-top: 5%; margin-left:2%; width: 30%; float:left;">
			<caption>관광지</caption>
			<thead>
				<tr class="active">
					<td colspan="3" align="center">
						관광지
					</td>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty tourLists}">
					<tr>
						<td colspan="3" align="center">관광지 목록이 없습니다.</td>
					</tr>
				</c:if>
				
				<c:forEach var="tourBean" items="${tourLists}">
					<tr>
						<td>
							<span style="font-size: 20px;">
								<a href="${contextPath }/tourDetail.do?num=${tourBean.num}&pageNumber=1">
									&nbsp;${tourBean.name }
								</a>
							</span>
						</td>
					</tr>
			</c:forEach> 
			</tbody>
		</table>
		<!-- //관광지 리스트 -->
		<!-- 후기 리스트 -->
		<table class="table table-bordered" style="padding-top: 5%; margin-left:2%; width: 30%; float:left;">
			<caption>캠핑장</caption>
			<thead>
				<tr class="active">
					<td colspan="3" align="center">
						후기
					</td>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty communityLists}">
					<tr>
						<td colspan="3" align="center">후기 목록이 없습니다.</td>
					</tr>
				</c:if>
				
				<c:forEach var="communityBean" items="${communityLists}">
					<tr>
						<td>
							<span style="font-size: 20px;">
								<a href="${contextPath }/communityDetail.do?num=${communityBean.num}&pageNumber=1&type=1">
									&nbsp;${communityBean.title }
								</a>
							</span>
						</td>
					</tr>
			</c:forEach> 
			</tbody>
		</table>
		<!-- //후기 리스트 -->
	</div>
</div>
</article>
</section>

<%@ include file="../../common/bottom.jsp" %>