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
	$("#metaTitle").attr("content", "my예약내역리스트 ");
	$("#metaDescription").attr("content", "my예약내역리스트");
	$("#metaKeywords").attr("content", "#my예약내역리스트 , #예약내역");
});

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> MY 예약 내역리스트 </h2></header>
	<!-- 현재날짜 -->
	<c:set var="today" value="<%=new java.util.Date()%>" />
	<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></c:set>
	
	<table class="table table-bordered" style="margin-top: 3%;">
		<caption>레코드 총 갯수 : ${totalCount} </caption>
		<thead>
			<tr class="active">
				<th colspan="2"> MY 예약 내역리스트 </th>
			</tr>
		</thead>
		
		<tbody>
			<!-- list가 없을 경우 -->
			<c:if test="${empty lists}">
			<tr>
				<td colspan="2" align="center"> 해당 MY 예약 내역 레코드가 없습니다.</td>
			</tr>
			</c:if>
			
			<c:forEach var="list" items="${lists}">
			<tr>
				<td align="center" width="6%" style="padding-top: 10%;">
					${list.rownum}
				</td>
				<td width="90%" class="" style="border-left: none; padding-top: 2%;">
					<a href="myReservationDetail.do?num=${list.num}&pageNumber=${pageInfo.pageNumber}" style="text-decoration:none;">
					<span class="textFontSizeLarge">
						<b class="text-primary" style="padding-top: 2%; font-size: 30px;">
							${list.campingname}
						</b>
						
						<span class="spanFlowRootP10" style="padding-top: 2%;"> 
						<b class="text-primary">객실 정보 : </b> ${list.roomname}
						</span>
					</span>
					<span class="spanFlowRootP10">
						<b class="text-primary">예약일 :</b> ${list.checkindate} ~ ${list.checkoutdate}
					</span>
					<span class="spanFlowRootP10">
						<b class="text-primary"> 예약 상태 : </b>
						<c:choose>
							<c:when test="${list.status eq '01'}">예약중</c:when>
							<c:when test="${list.status eq '02'}">완료</c:when>
							<c:when test="${list.status eq '03'}">보류</c:when>
							<c:when test="${list.status eq '04'}">예약취소</c:when>
						</c:choose>
					</span>
					<span class="spanFlowRootP10">
						<b class="text-primary"> 등록일 : </b> ${list.regdate}
					</span>
					<span class="spanFlowRootP10">
						<b class="text-primary"> 예약 총가격 :  </b>
						<b class="redFont"><fmt:formatNumber value="${list.totalprice}" pattern="###,###"/></b> 원
					</span>
					</a>
					<!-- 예약일 끝날짜거나 완료인 상태일경우 예약관련 후기쓰기.  -->
					<c:if test="${list.checkoutdate <= date or list.status eq '02'}">
					<span class="spanFlowRootP10">
						<input type="button" class="btn btn-primary" value="후기쓰기" onclick="location.href='${contextPath}/communityRegister.do?reservationnum=${list.num}&reviewnum=${list.campingnum}&reviewtype=01&type=1'">
					</span>
					</c:if>
				</td>
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