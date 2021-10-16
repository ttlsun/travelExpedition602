<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../common/admin/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript" >

//목록보기 버튼 클릭시
function goList(pageNumber) {
	location.href= "${contextPath}/campingList.ad?pageNumber="+pageNumber;
}

//비활성화 버튼 클릭시
function goStatus(num) {
	var msg = "";
	if(num == "00"){
		msg = "삭제";
	}else if(num == "01"){
		msg = "활성화";
	}else{
		msg = "비활성화";
	}
	
	if (!confirm(msg+' 하시겠습니까?')){
		return false;
	}
	
	$('#status').val(num);
}

//객실 상세보기 버튼
function goRoomDetail(num,pageNumber){
	location.href= "${contextPath}/roomDetail.ad?num="+num+"&pageNumber="+pageNumber;	
}

</script>

<section class="container">
<article>
<div>
	<form name="campform" action="campingDelete.ad" method="post" class="form-horizontal">
		<input type="hidden" name="num" id="num" value="${campbean.num}">
		<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
		<input type="hidden" name="status" id="status" value="">
		<input type="hidden" name="communityPageNumber" id="communityPageNumber" value="${communityPageInfo.pageNumber}">
	
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="목록보기" onclick="goList(${pageNumber})">
		<c:choose>
			<c:when test="${campbean.status eq '01' }">
				<input type="submit" class="btn btn-primary" value="비활성화" onclick="return goStatus('02')">
			</c:when>
			<c:when test="${campbean.status eq '02' }">
				<input type="submit" class="btn btn-primary" value="활성화" onclick="return goStatus('01')">
			</c:when>
			<%-- <c:otherwise>
				<input type="submit" class="btn btn-primary" value="완전삭제" onclick="return goStatus('00')">
			</c:otherwise> --%>
		</c:choose>
	</div>
	
	<header><h3 align="center" class="text-primary">${campbean.name }</h3></header>

	<table class="table table-bordered">
		<tr>
			<td rowspan="7" colspan="2" width="50%">
				<img src="${fileImg}/${campbean.imgurl}" alt="${campbean.imgurl} 이미지" title="${campbean.imgurl} 이미지" width="100%">
			</td>
			<th>캠핑장 번호</th>
			<td>${campbean.num }</td>
		</tr>
		<tr>
			<th>캠핑장 명칭</th>
			<td>${campbean.name }</td>
		</tr>
		<tr>
			<th>한줄 소개글</th>
			<td>${campbean.summary }</td>
		</tr>
		<tr>
			<th>유형</th>
			<td>
				<c:if test="${fn:contains(campbean.camptype,'01') }">일반캠핑장/</c:if>
				<c:if test="${fn:contains(campbean.camptype,'02') }">자동차캠핑장/</c:if>
				<c:if test="${fn:contains(campbean.camptype,'03') }">글램핑/</c:if>
				<c:if test="${fn:contains(campbean.camptype,'04') }">카라반/</c:if>
			</td>
		</tr>
		<tr>	
			<th>테마</th>
			<td>
				<c:if test="${campbean.themecode eq '01' }">숲/산</c:if>
				<c:if test="${campbean.themecode eq '02' }">해변/바다</c:if>
				<c:if test="${campbean.themecode eq '03' }">강/호수/계곡</c:if>
				<c:if test="${campbean.themecode eq '04' }">도심</c:if>
				<c:if test="${campbean.themecode eq '05' }">섬</c:if>
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${campbean.address1 }&nbsp;${campbean.address2 }&nbsp;${campbean.address3 }&nbsp;${campbean.address4 }</td>
		</tr>
		<tr>
			<th>연락처</th>
			<td>${campbean.contact }</td>
		</tr>
		<tr>
			<th>별점</th>
			<td>
				<fmt:parseNumber var="starranking" value="${startAvg}"/>
					<c:forEach var="i" begin="1" end="5">
						<c:choose>
							<c:when test="${i <= starranking}">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
								  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
								</svg>
							</c:when>
							<c:otherwise>
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16">
							 		<path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288L8 2.223l1.847 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.565.565 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z"/>
								</svg>
							</c:otherwise>
						</c:choose>
					</c:forEach>
			</td>
			<th>후기글수</th>
			<td>${campbean.reviewcount }&nbsp;개&nbsp;
				<input type="button" value="후기목록" onclick="">
			</td>
		</tr>
		<tr>
			<th>추천수</th>
			<td>${campbean.recommend }</td>
			<th>찜수</th>
			<td>${campbean.steamed }</td>
		</tr>
		<tr>
			<th>시설정보</th>
			<td colspan="3">${campbean.options }</td>
		</tr>
	</table>
	
	<!-- 캠핑장 상세 정보/객실 목록 탭 -->
	<div class="marginPadding10">
		<ul class="nav nav-tabs">
			<li class="active" style="width: 50%; text-align:center;"><a href="#tab1" data-toggle="tab">캠핑장 상세 정보</a></li>
			<li style="width: 50%; text-align:center;"><a href="#tab2" data-toggle="tab">객실 목록</a></li>
		</ul>
		
		<div class="tab-content marginPadding10">
			
			<!-- 상세 정보 탭 -->
			<div class="tab-pane active fade in" id="tab1" style="text-align: left;">
			    <h3>캠핑장 상세 정보</h3>
			    <div>${campbean.contents }</div>
			</div>
			
			<!-- 객실 리스트 탭 -->
			<div class="tab-pane fade" id="tab2" style="text-align: left;">
		   		<h3>객실 리스트</h3>
		    	<span class="spanFlowRootP10"></span>
				
				<!-- <form name="roomform" action="" method="post"> -->
			
					<c:forEach var="room" items="${lists }">
					
					<c:choose>
						<c:when test="${room.roomtype eq '01' }">
							<c:set var="rType" value="일반캠핑장"/>
						</c:when>
						<c:when test="${room.roomtype eq '02' }">
							<c:set var="rType" value="자동차캠핑장"/>
						</c:when>
						<c:when test="${room.roomtype eq '03' }">
							<c:set var="rType" value="글램핑"/>
						</c:when>
						<c:when test="${room.roomtype eq '04' }">
							<c:set var="rType" value="카라반"/>
						</c:when>
					</c:choose>
					
						<table class="table table-bordered">
							<tr>
								<td rowspan="4" width="25%">
									<img src="${fileImg}/${room.imgurl}" alt="" title="" width="100%">
								</td>
								<td colspan="6" style="text-align: left;">
									[${rType}]&nbsp;${room.name }
								</td>
								<td rowspan="4" width="10%" align="center" style="vertical-align: middle;">
									<input type="button" value="상세보기" class="btn btn-primary" onClick="goRoomDetail(${room.num},${pageNumber })">
								</td>
							</tr>
							<tr>
								<td colspan="6" style="text-align: left;">
									${room.summary }
								</td>
							</tr>
							<tr>
								<td width="12%">기준인원</td>
								<td width="5%">
									${room.propguests }
								</td>
								<td width="12%">최대인원</td>
								<td width="5%">
									${room.maxguests }
								</td>
								<td width="10%">가격</td>
								<td>
									<fmt:formatNumber value="${room.weekdayprice }" pattern="###,###"/>원
									&nbsp;~&nbsp;
									<fmt:formatNumber value="${room.weekendprice }" pattern="###,###"/>원
								</td>
							</tr>
							<tr>
								<td>주요시설</td>
								<td colspan="5">
									${room.options }
								</td>
							</tr>
						</table>
					</c:forEach>
				<!-- </form> -->
			</div>
			
		</div>
		<hr>
	</div>

	
	</form>
</div>
</article>
</section>



<%@ include file="../../../common/admin/bottom.jsp" %>