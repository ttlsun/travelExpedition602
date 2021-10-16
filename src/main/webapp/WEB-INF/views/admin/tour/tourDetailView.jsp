<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../common/admin/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript" >

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/tourList.ad?pageNumber="+${pageNumber};
}

function goStatus(num) {
	
	var msg = "";
	if(num == "00"){
		msg = "삭제";
	}else if(num == "01"){
		msg = "비활성화";
	}else{
		msg = "활성화";
	}
	
	if (!confirm(msg+' 하시겠습니까?')){
		return false;
	}
	
	$('#status').val(num);
	$('#myForm').attr("action","tourDetail.ad").submit();
	
}

</script>

<section class="container">
<article>
<div>
	<!-- 버튼 -->
	<div class="marginPadding10" align="center">
		<c:choose>
			<c:when test="${community.status eq '01' }">
				<input type="submit" class="btn btn-primary" value="비활성화" onclick="return goStatus('02')">
			</c:when>
			<c:when test="${community.status eq '02' }">
				<input type="submit" class="btn btn-primary" value="활성화" onclick="return goStatus('01')">
			</c:when>
			<c:otherwise>
				<input type="submit" class="btn btn-primary" value="완전삭제" onclick="return goStatus('00')">
			</c:otherwise>
		</c:choose>
		
		<input type="button" style="float: left" class="btn btn-default" value="목록보기" onclick="goList()">
	</div>
	<!-- // 버튼 -->
	
	<header><h3 align="center" class="text-primary">${tourbean.name }</h3></header>
	
	<form name="tourform" action="tourDetail.do" method="post" class="form-horizontal">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	<input type="hidden" name="num" id="num" value="${tourbean.num }">
	<input type="hidden" name="communityPageNumber" id="communityPageNumber" value="${communityPageInfo.pageNumber}">
	
	<table class="table table-bordered">
		<tr>
			<td rowspan="7" colspan="2" width="50%">
				<img src="${fileImg}/${tourbean.imgurl}" alt="${tourbean.imgurl} 이미지" title="${tourbean.imgurl} 이미지" width="100%">
			</td>
			<th>관광지 번호</th>
			<td>${tourbean.num }</td>
		</tr>
		<tr>
			<th>관광지 명칭</th>
			<td>${tourbean.name }</td>
		</tr>
		<tr>
			<th>한줄 소개글</th>
			<td>${tourbean.summary }</td>
		</tr>
		<tr>
			<th>테마</th>
			<td>
				<c:if test="${fn:contains(tourbean.themecode,'01') }">베스트</c:if>
				<c:if test="${fn:contains(tourbean.themecode,'02') }">제주여행</c:if>
				<c:if test="${fn:contains(tourbean.themecode,'03') }">내륙여행</c:if>
				<c:if test="${fn:contains(tourbean.themecode,'04') }">섬여행</c:if>
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${tourbean.address1 }&nbsp;${tourbean.address2 }&nbsp;${tourbean.address3 }&nbsp;${tourbean.address4 }</td>
		</tr>
		<tr>
			<th>연락처</th>
			<td>${tourbean.contact }</td>
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
			<td>${tourbean.reviewcount }&nbsp;개&nbsp;
				<input type="button" value="후기목록" onclick="">
			</td>
		</tr>
		<tr>
			<th>추천수</th>
			<td>${tourbean.recommend }</td>
			<th>찜수</th>
			<td>${tourbean.steamed }</td>
		</tr>
		<tr>
			<th>시설정보</th>
			<td colspan="3">${tourbean.options }</td>
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
			    <h3>관광지 상세 정보</h3>
			    <div>${tourbean.contents }</div>
			</div>
			
			<!-- 주변관광지 리스트 탭 -->
			<div class="tab-pane fade" id="tab2" style="text-align: left;">
		   		<h3>주변관광지</h3>
		    	<div class="marginPadding10">
						<table class="table table-bordered" style="margin-top: 3%;">
					<caption>레코드 총 갯수 : ${totalCount}</caption>
					<thead>
						<tr class="active">
							<th width="6%">번호</th>
							<th>관광지명</th>
							<th>주소</th>
							<th>한줄요약</th>
							<th width="14%">등록일</th>
						</tr>
					</thead>
				
					<tbody>
						<!-- list가 없을 경우 -->
						<c:if test="${empty lists}">
						<tr>
							<td colspan="5" align="center"> 해당 주변 관광지 레코드가 없습니다.</td>
						</tr>
						</c:if>
						
						<c:forEach var="list" items="${lists}">
						<tr>
							<td>${list.rownum}</td>
							<td>
								<a href="tourDetail.do?num=${list.num}&pageNumber=${pageInfo.pageNumber}">${list.name}</a>
							</td>
							<td>${list.postcode} &nbsp; ${tourbean.address1 }&nbsp;${tourbean.address2 }&nbsp;${tourbean.address3 }&nbsp;${tourbean.address4 } </td>
							<td>${list.summary}</td>
							<td>
								<fmt:parseDate var="dateFmt" value="${list.regdate}" pattern="yyyy-MM-dd"/>
								<fmt:formatDate var="registerDate" value="${dateFmt}" pattern="yyyy-MM-dd"/>
								${registerDate}
							</td> 
						</tr>
						</c:forEach>
					</tbody>
				
					</table>
			
		</div>
		<hr>
	</div>

	
	</form>
</div>
</article>
</section>


<%@ include file="../../../common/admin/bottom.jsp" %>