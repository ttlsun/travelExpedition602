<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/top.jsp" %>   



<script type="text/javascript" >
$(document).ready(function() {
	//메뉴 on 유지.
	navActive('myInfo');
	
	$("#metaTitle").attr("content", "my예약내역리스트 상세");
	$("#metaDescription").attr("content", "my예약내역리스트 상세");
	$("#metaKeywords").attr("content", "#my예약내역리스트 상세");
	
});

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/myReservationList.do?pageNumber="+${pageNumber};
}

function goBack(){
	history.go(-1);
}

</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="돌아가기" onclick="goBack()">
		<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
	</div>

	<header><h2 align="center" class="text-primary">${myReservation.campingname} 예약 상세</h2></header>
	
	<form name="myForm" id="myForm" action="" method="post" class="form-horizontal">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	
	<table class="table table-bordered">
		<caption>예약자 정보 (예약 변경시, 관리자에게 문의하세요.)</caption>
		<tr>
			<td>예약 번호</td>
			<td>${myReservation.num}</td>
			<td>예약자 ID</td>
			<td>${myReservation.id}</td>
			<td>예약자 이름</td>
			<td>${myReservation.name}</td>
			<td>예약자 등록일자</td>
			<td>${myReservation.regdate}</td>
		</tr>
		<tr>
			<td>체크인 날짜 ~ 체크아웃날짜</td>
			<td>${myReservation.checkindate} ~ ${myReservation.checkoutdate}</td>
			<td>이용인원</td>
			<td>${myReservation.guests}</td>
			<td>예약 진행사항</td>
			<td>
				<b class="redFont">
				<c:choose>
					<c:when test="${myReservation.status eq '01'}">입금대기</c:when>
					<c:when test="${myReservation.status eq '02'}">결제완료</c:when>
					<c:when test="${myReservation.status eq '03'}">예약취소신청</c:when>
					<c:when test="${myReservation.status eq '04'}">환불완료</c:when>
				</c:choose>
				</b>
			</td>
			<td>예약 총금액</td>
			<td>
				<b class="redFont"><fmt:formatNumber value="${myReservation.totalprice}" pattern="###,###"/></b> 원
			</td>
		</tr>
		<tr>
			<td>결제수단</td>
			<c:choose>
				<c:when test="${myReservation.paycode eq '계좌이체'}">
					<td>${myReservation.paycode}</td>
					<td>은행명</td>
					<td>${myReservation.paydetail1}</td>
					<td>계좌번호</td>
					<td colspan="3">${myReservation.paydetail2}</td>
				</c:when>
				<c:when test="${myReservation.paycode eq '무통장입금'}">
					<td>${myReservation.paycode}</td>
					<td>은행명</td>
					<td>${myReservation.paydetail1}</td>
					<td>계좌번호</td>
					<td colspan="3">${myReservation.paydetail2}</td>
				</c:when>
				<c:when test="${myReservation.paycode eq '카드결제'}">
					<td>${myReservation.paycode}</td>
					<td>카드명</td>
					<td>${myReservation.paydetail1}</td>
					<td>카드번호</td>
					<td>${myReservation.paydetail2}</td>
					<td>cvc</td>
					<td>${myReservation.cvc}</td>
				</c:when>
				<c:when test="${myReservation.paycode eq '휴대폰결제'}">
					<td>${myReservation.paycode}</td>
					<td>통신사명</td>
					<td>${myReservation.paydetail1}</td>
					<td>핸드폰번호</td>
					<td colspan="3">${myReservation.paydetail2}</td>
				</c:when>
				<c:otherwise>
					<td colspan="8">${myReservation.paycode}</td>
				</c:otherwise>
			</c:choose>
		</tr>
	</table>
	
	<table class="table table-bordered">
		<caption>캠핑장 정보</caption>
		<tr>
			<td colspan="6" align="center" style="border-bottom: none;">
				<img src="${fileImg}/${myReservation.campingimgurl}" alt="${myReservation.campingimgurl} 이미지" title="${myReservation.campingimgurl} 이미지" width="30%">
			</td>
		</tr>
		<tr>
			<td>캠핑장 이름</td>
			<td>
				${myReservation.campingname}
				<a href="${contextPath}/campingDetail.do?num=${myReservation.campingnum}&pageNumber=1" class="text-decoration-none">
                 	상세 보러가기
	               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-card-list" viewBox="0 0 16 16">
					<path d="M14.5 3a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h13zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z"/>
	 					<path d="M5 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 5 8zm0-2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm0 5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm-1-5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zM4 8a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm0 2.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z"/>
					</svg>
            	</a>
			</td>
			<td>캠핑장 타입</td>
			<td>
				<c:choose>
					<c:when test="${myReservation.camptype eq '01'}">일반캠핑장</c:when>
					<c:when test="${myReservation.camptype eq '02'}">자동차캠핑장</c:when>
					<c:when test="${myReservation.camptype eq '03'}">글램핑</c:when>
					<c:when test="${myReservation.camptype eq '04'}">카라반</c:when>
				</c:choose>
			</td>
			<td>캠핑장 태마</td>
			<td>
				<c:choose>
					<c:when test="${myReservation.themecode eq '01'}">&nbsp;숲/산&nbsp;</c:when>
					<c:when test="${myReservation.themecode eq '02'}">&nbsp;해변/바다&nbsp;</c:when>
					<c:when test="${myReservation.themecode eq '03'}">&nbsp;강/호수/계곡&nbsp;</c:when>
					<c:when test="${myReservation.themecode eq '04'}">&nbsp;도심&nbsp;</c:when>
					<c:when test="${myReservation.themecode eq '05'}">&nbsp;섬&nbsp;</c:when>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td>캠핑장 연락처</td>
			<td>
				<a href="tel:${myReservation.contact }" class="text-decoration-none">
                	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone-outbound" viewBox="0 0 16 16">
				  <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.568 17.568 0 0 0 4.168 6.608 17.569 17.569 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.678.678 0 0 0-.58-.122l-2.19.547a1.745 1.745 0 0 1-1.657-.459L5.482 8.062a1.745 1.745 0 0 1-.46-1.657l.548-2.19a.678.678 0 0 0-.122-.58L3.654 1.328zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511zM11 .5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-1 0V1.707l-4.146 4.147a.5.5 0 0 1-.708-.708L14.293 1H11.5a.5.5 0 0 1-.5-.5z"/>
				</svg>
              	</a>
              	&nbsp;
				${myReservation.contact}
			</td>
			<td style="border-left: none; border-right: none;">캠핑장 주소</td>
			<td style="border-left: none; border-right: none;">${myReservation.postcode} </td>
			<td colspan="2" style="border-left: none;">${myReservation.addr}</td>
		</tr>
	</table>
	
	<table class="table table-bordered">
		<caption>객실(ROOM) 정보</caption>
		<tr>
			<td colspan="4" align="center" style="border-bottom: none;">
				<img src="${fileImg}/${myReservation.roomimg}" alt="${myReservation.roomimg} 이미지" title="${myReservation.roomimg} 이미지" width="30%">
			</td>
		</tr>
		<tr>
			<td>ROOM 명칭</td>
			<td>${myReservation.roomname}
				<a href="${contextPath}/roomDetail.do?num=${myReservation.roomnum}&pageNumber=1" class="text-decoration-none">
                 	상세 보러가기
	               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-card-list" viewBox="0 0 16 16">
					<path d="M14.5 3a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h13zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z"/>
	 					<path d="M5 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 5 8zm0-2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm0 5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm-1-5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zM4 8a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm0 2.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z"/>
					</svg>
            	</a>
			</td>
			<td>ROOM 타입</td>
			<td>
				<c:choose>
						<c:when test="${myReservation.roomtype eq '01'}">일반캠핑장</c:when>
						<c:when test="${myReservation.roomtype eq '02'}">자동차캠핑장</c:when>
						<c:when test="${myReservation.roomtype eq '03'}">글램핑</c:when>
						<c:when test="${myReservation.roomtype eq '04'}">카라반</c:when>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td>ROOM 적정인원 (최대인원)</td>
			<td>${myReservation.propguests} 명 ( <span class="redFont">${myReservation.maxguests}</span> 명) </td>
			<td>ROOM 주중가격 / 주말가격</td>
			<td>
				<b class="redFont"><fmt:formatNumber value="${myReservation.weekdayprice}" pattern="###,###"/></b> 원 /
				<b class="redFont"><fmt:formatNumber value="${myReservation.weekendprice}" pattern="###,###"/></b> 원
			</td>
		</tr>
		<tr>
			<td>ROOM 시설정보</td>
			<td>${myReservation.options}</td>
			<td>ROOM 비품</td>
			<td>${myReservation.amenity}</td>
		</tr>
	</table>

	<!-- 버튼 -->
	<div class="marginPadding10" align="center">
		<input type="button" class="btn btn-default" value="목록보기" onclick="goList()">
	</div>
	<!-- // 버튼 -->
	
	</form>
</div>  
</article>
</section>
<script>
	$('.carousel').carousel();
</script>
<%@ include file="../../../common/bottom.jsp" %>   