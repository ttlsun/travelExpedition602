<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/top.jsp" %>   
<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('myInfo');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "my찜내역리스트 ");
	$("#metaDescription").attr("content", "my찜내역리스트");
	$("#metaKeywords").attr("content", "#my찜내역리스트 , #찜");
});

function goBack(){
	history.go(-1);
}

</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left;" class="btn btn-default" value="돌아가기" onClick="goBack()">
	</div>

	<header><h2 align="center" class="text-primary"> MY 찜 내역리스트 </h2></header>
	
	<table class="table table-bordered" style="margin-top: 3%;">
		<caption>레코드 총 갯수 : ${totalCount} </caption>
		<thead>
			<tr class="active">
				<th width="6%">번호</th>
				<th>[찜구분]찜명칭</th>
				<th>찜 한줄요약</th>
				<th>찜 태마</th>
				<th width="14%">찜등록일</th>
			</tr>
		</thead>
		
		<tbody>
			<!-- list가 없을 경우 -->
			<c:if test="${empty lists}">
			<tr>
				<td colspan="5" align="center"> 해당 MY 찜 내역 레코드가 없습니다.</td>
			</tr>
			</c:if>
			
			<c:forEach var="list" items="${lists}">
				<tr>
					<td>${list.rownum}</td>
					<td>
						[<c:choose>
							<c:when test="${list.acode eq '1'}">캠핑/글램핑</c:when>
							<c:when test="${list.acode eq '2'}">관광지</c:when>
							<c:when test="${list.acode eq '3'}">커뮤니티</c:when>
						</c:choose>]
						${list.name}
					</td>
					<td>${list.summary}</td>
					<td>
						<c:choose>
							<c:when test="${list.acode eq '1'}">
								<c:choose>
									<c:when test="${list.themecode eq '01'}">숲/산</c:when>
									<c:when test="${list.themecode eq '02'}">해변/바다</c:when>
									<c:when test="${list.themecode eq '03'}">강/호수/계곡</c:when>
									<c:when test="${list.themecode eq '04'}">도심</c:when>
									<c:when test="${list.themecode eq '05'}">섬</c:when>
								</c:choose>
							</c:when>
							<c:when test="${list.acode eq '2'}">
								<c:choose>
									<c:when test="${list.themecode eq '01'}">베스트</c:when>
									<c:when test="${list.themecode eq '02'}">제주여행</c:when>
									<c:when test="${list.themecode eq '03'}">내륙여행</c:when>
									<c:when test="${list.themecode eq '04'}">섬여행</c:when>
								</c:choose>
							</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
					</td>
					<td>${list.regdate}</td>
				</tr>
			</c:forEach>
		</tbody>
		
	</table>
	
	<!-- 페이징 -->
	<div class="paginationCenter" align="center">
		${pageInfo.pagingHtml}
	</div>
	
</div>   
</article>
</section>
<%@ include file="../../../common/bottom.jsp" %>