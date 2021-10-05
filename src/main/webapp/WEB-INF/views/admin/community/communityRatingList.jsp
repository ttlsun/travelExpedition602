<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/admin/top.jsp" %>   
<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('community');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 후기 등급 테이블");
	$("#metaDescription").attr("content", "관리자 후기 등급 테이블 리스트");

});

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 후기 등급 통계 리스트 </h2></header>
	
	<table class="table table-bordered" style="margin-top: 3%;">
		<caption></caption>
		<thead>
			<tr class="active">
				<th>후기구분별</th>
				<th>좋아요 합계</th>
				<th>찜 합계</th>
				<th>별점 합계</th>
				<th>별평균</th>
			</tr>
		</thead>
		
		<tbody>
			<!-- list가 없을 경우 -->
			<c:if test="${empty lists}">
			<tr>
				<td colspan="3" align="center"> 해당 후기 레코드가 없습니다.</td>
			</tr>
			</c:if>
			
			<c:forEach var="list" items="${lists}">
			<tr>
				<td>
					<c:choose>
						<c:when test="${list.reviewtype eq '01'}">캠핑/글램핑 후기</c:when>
						<c:when test="${list.reviewtype eq '02'}">관광지 후기</c:when>
						<c:otherwise>커뮤니티 후기</c:otherwise>
					</c:choose>
				</td> 
				<td>${list.good}</td> 
				<td>${list.jjem}</td> 
				<td>${list.starsum}</td> 
				<td>${list.staravg} 점</td> 
			</tr>
			</c:forEach>
		</tbody>
		
	</table>
	
</div>   
</article>
</section>
<%@ include file="../../../common/admin/bottom.jsp" %>