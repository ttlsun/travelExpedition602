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
	navActive('myInfo');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 회원 예약내역 리스트 관리");
	$("#metaDescription").attr("content", "관리자 회원 예약내역 리스트 관리");
	$("#metaKeywords").attr("content", "#회원 예약내역리스트 , #예약내역");
});

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 회원 예약 내역리스트 </h2></header>

	<div class="form-horizontal rounded">
		<form action="userReservationList.ad">
			<div>
				<dl>
					<dt><label for="searchStatus">진행사항 상태</label></dt>
					<dd>
						<select id="searchStatus" name="status" class="form-control">
							<option value="">선택</option>
							<option value="01">입금대기</option>
							<option value="02">결제완료</option>
							<option value="03">예약취소신청</option>
							<option value="04">환불완료</option>
						</select>
					</dd>
				</dl>
				<dl>
					<dt><label for="searchWhatColumn">검색</label></dt>
					<dd>
						<select name="whatColumn" id="searchWhatColumn" class="form-control">
							<option value="">전체 검색</option>
							<option value="id">예약 회원 아이디</option>
						</select>
						
						<div align="left" style="padding-top: 5px;">
							<input type="text" class="form-control" name="keyword" placeholder="검색">
						</div>
						<div align="right" style="padding-top: 5px;">
							<input type="submit" class="btn btn-default" value="검색">
						</div>
					</dd>
				</dl>
			</div>
		</form>
	</div>

	<table class="table table-bordered" style="margin-top: 3%;">
		<caption>레코드 총 갯수 : ${totalCount} </caption>
		<thead>
			<tr class="active">
				<th colspan="2"> 회원 예약 내역리스트 </th>
			</tr>
		</thead>
		
		<tbody>
			<!-- list가 없을 경우 -->
			<c:if test="${empty lists}">
			<tr>
				<td colspan="2" align="center"> 해당 회원 예약 내역 레코드가 없습니다.</td>
			</tr>
			</c:if>
			
			<c:forEach var="list" items="${lists}">
			<tr>
				<td align="center" width="6%" style="padding-top: 10%;">
					${list.rownum}
				</td>
				<td width="90%" class="" style="border-left: none; padding-top: 2%;">
					<a href="userReservationDetail.ad?num=${list.num}&pageNumber=${pageInfo.pageNumber}" style="text-decoration:none;">
					<span class="textFontSizeLarge">
						<b class="text-primary" style="padding-top: 2%; font-size: 30px;">
							${list.campingname}
						</b>
						
						<span class="spanFlowRootP10" style="padding-top: 2%;"> 
						<b class="text-primary">객실 정보 : </b> ${list.roomname}
						</span>
						
						<span class="spanFlowRootP10" style="padding-top: 2%;"> 
						<b class="text-primary">예약 회원 정보 : </b> ${list.id}
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
<%@ include file="../../../common/admin/bottom.jsp" %>