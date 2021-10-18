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

function goBack(){
	history.go(-1);
}


//후기 썻는지 체크 후 후기 미등록시 등록하러 가기.
function goCommunityRegister(num,campingnum) {
	var userId = "${userId}";
	$.ajax({
		url: "getCommunityWritCount.do",
		type: "POST",
		data: {
			reservationnum : num,
			reviewnum : campingnum,
			regid : userId
		},
		dataType: "json",
		success: function(data) {
			//alert(data.cnt);
			if(data.cnt > 0){
				alert("이미 후기쓴 분은 쓸수 없습니다.");
				return;
			}
			
			location.href='${contextPath}/communityRegister.do?reservationnum=${list.num}&reviewnum=${list.campingnum}&reviewtype=01&type=1'
			
		},
		error: function(msg, error) {
			console.log("처리오류");
		}
	});
	
}

</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left;" class="btn btn-default" value="돌아가기" onClick="goBack()">
	</div>

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
							<c:when test="${list.status eq '01'}">입금대기</c:when>
							<c:when test="${list.status eq '02'}">결제완료</c:when>
							<c:when test="${list.status eq '03'}">예약취소신청</c:when>
							<c:when test="${list.status eq '04'}">환불완료</c:when>
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
						<input type="button" class="btn btn-primary" value="후기쓰기" onclick="return goCommunityRegister(${list.num},${list.campingnum})">
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