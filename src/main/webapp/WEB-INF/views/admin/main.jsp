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
	
	<!-- 회원수, 캠핑수, 관광지수, 후기수, -->
	<div style="padding-top:3%; padding-bottom: 10%">
		<table class="table table-bordered" style="padding-top: 5%; margin-left:17%; width: 15%; float:left;">
			<thead>
				<tr class="active">
					<th colspan="3" style="text-align: center;">회원 수</th>
				</tr>
			</thead>
			<tbody>
			<tr>
				<td colspan="3" align="center"> ${usersCount+=' 명'}</td>
			</tr>
			</tbody>
		</table>
		<table class="table table-bordered" style="padding-top: 5%; margin-left:2%; width: 15%; float:left;">
			<thead>
				<tr class="active">
					<th colspan="3" style="text-align: center;">캠핑 수</th>
				</tr>
			</thead>
			<tbody>
			<tr>
				<td colspan="3" align="center">${campingCount+=' 곳'}</td>
			</tr>
			</tbody>
		</table>
		<table class="table table-bordered" style="padding-top: 5%; margin-left:2%; width: 15%; float:left;">
			<thead>
				<tr class="active">
					<th colspan="3" style="text-align: center;">관광지 수</th>
				</tr>
			</thead>
			<tbody>
			<tr>
				<td colspan="3" align="center">${tourCount+=' 곳'}</td>
			</tr>
			</tbody>
		</table>
		<table class="table table-bordered" style="padding-top: 5%; margin-left:2%; width: 15%; float:left;">
			<thead>
				<tr class="active">
					<th colspan="3" style="text-align: center;">후기 수</th>
				</tr>
			</thead>
			<tbody>
			<tr>
				<td colspan="3" align="center">${communityCount+=' 개'}</td>
			</tr>
			</tbody>
		</table>
	</div>
	
	<!-- 위에 큰 이미지 -->
	<div style="padding-top: 3%;">
		<a href="${contextPath}/main.do">
			<img class="travelExpedition602" width="1140" src="${images}/602travelerMain.jpg" title="602호여행자들 이미지" alt="602호여행자들 이미지"  />
		</a>
	</div>
	
	<div style="padding-top: 10%;">
		<!-- 캠핑 리스트 -->
		<table class="table table-bordered" style="padding-top: 5%; margin-left:2%; width: 30%; float:left;">
			<caption> 인기 캠핑장 리스트 </caption>
			<thead>
				<tr class="active">
					<th colspan="3" style="text-align: left; padding-left: 15px;">캠핑 
						<span style="float:right;"><a href="${contextPath }/campingList.ad?orderBy=steamed desc">더보기+</a></span>
					</th>
				</tr>
			</thead>
			<tbody>
			
			<!-- list가 없을 경우 -->
			<c:if test="${empty campingLists}">
			<tr>
				<td colspan="3" align="center"> 해당 캠핑 레코드가 없습니다.</td>
			</tr>
			</c:if>
			
			<c:forEach var="beanRow" items="${campingLists}" varStatus="vsRow" step="1">
			<tr>
				<c:forEach var="beanCell" items="${campingLists}" varStatus="vsCell" begin="${vsRow.index}" end="${vsRow.count*1-1}">
				<td align="center" class="col-xs-12 col-sm-6 col-md-3" width="30%">
					<table>
						<tr>
							<td>
								<img src="${fileImg}/${beanCell.imgurl}" style="height: 60px;" alt="${beanCell.imgurl} 이미지" title="${beanCell.imgurl} 이미지">
							</td>
							<td style="padding-left: 15px;">
								<h4><a href="${contextPath }/campingDetail.ad?num=${beanCell.num}&pageNumber=1">${beanCell.name}</a> </h4>
				           		 <p>${beanCell.summary}</p>
							</td>
						</tr>
					</table>
				</td>
				</c:forEach>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<!-- //캠핑 리스트 -->
		<!-- 관광지 리스트 -->
		<table class="table table-bordered" style="padding-top: 5%; margin-left:2%; width: 30%; float:left;">
			<caption> 인기 관광지 리스트 </caption>
			<thead>
				<tr class="active">
					<th colspan="3" style="text-align: left;"> 관광지 
						<span style="float:right;"><a href="${contextPath }/tourList.ad?orderBy=steamed desc">더보기+</a></span>
					</th>
				</tr>
			</thead>
			<tbody>
			
			<!-- list가 없을 경우 -->
			<c:if test="${empty tourLists}">
			<tr>
				<td colspan="3" align="center"> 해당 관광지 레코드가 없습니다.</td>
			</tr>
			</c:if>
			
			<c:forEach var="beanRow" items="${tourLists}" varStatus="vsRow" step="1">
			<tr>
				<c:forEach var="tourBeanCell" items="${tourLists}" varStatus="vsCell" begin="${vsRow.index}" end="${vsRow.count*1-1}">
				<td align="center" class="col-xs-12 col-sm-6 col-md-3" width="30%">
					<table>
						<tr>
							<td>
								<img src="${fileImg}/${tourBeanCell.imgurl}" style="height: 60px;" alt="${tourBeanCell.imgurl} 이미지" title="${tourBeanCell.imgurl} 이미지">
							</td>
							<td style="padding-left: 15px;">
								<h4><a href="${contextPath }/tourDetail.ad?num=${tourBeanCell.num}&pageNumber=1">${tourBeanCell.name}</a> </h4>
				           		 <p>${tourBeanCell.summary}</p>
							</td>
						</tr>
					</table>
				</td>
				</c:forEach>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<!-- //관광지 리스트 -->
		<!-- 후기 리스트 -->
		<table class="table table-bordered" style="padding-top: 5%; margin-left:2%; width: 30%; float:left;">
			<caption> 후기 리스트 </caption>
			<thead>
				<tr class="active">
					<th colspan="3" style="text-align: center;"> 후기 
						<span style="float:right;"><a href="${contextPath }/communityList.ad">더보기+</a></span>
					</th>
				</tr>
			</thead>
			<tbody>
			
			<!-- list가 없을 경우 -->
			<c:if test="${empty communityLists}">
			<tr>
				<td colspan="3" align="center"> 해당 후기 레코드가 없습니다.</td>
			</tr>
			</c:if>
			
			<c:forEach var="beanRow" items="${communityLists}" varStatus="vsRow" step="1">
			<tr>
				<c:forEach var="communityBeanCell" items="${communityLists}" varStatus="vsCell" begin="${vsRow.index}" end="${vsRow.count*1-1}">
				<td align="center" class="col-xs-12 col-sm-6 col-md-3" width="30%">
					<table>
						<tr>
							<td>
								<img src="${fileImg}/${communityBeanCell.imgurl}" style="height: 60px;" alt="${communityBeanCell.imgurl} 이미지" title="${communityBeanCell.imgurl} 이미지">
							</td>
							<td style="padding-left: 15px;">
								<h4><a href="${contextPath }/communityDetail.ad?num=${communityBeanCell.num}&pageNumber=1&type=1">${communityBeanCell.title}</a> </h4>
				           		 <p>${communityBeanCell.summary}</p>
							</td>
						</tr>
					</table>
				</td>
				</c:forEach>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<!-- //후기 리스트 -->
	</div>
</div>   
</article>
</section>

<%@ include file="../../common/admin/bottom.jsp" %>