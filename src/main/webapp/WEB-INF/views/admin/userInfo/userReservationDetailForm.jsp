<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/admin/top.jsp" %>   

<script type="text/javascript" >
$(document).ready(function() {
	//메뉴 on 유지.
	navActive('myInfo');
	
	$("#metaTitle").attr("content", "관리자 예약회원관리 상세");
	$("#metaDescription").attr("content", "관리자 예약회원관리상세");
	
});

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/userReservationList.ad?pageNumber="+${pageNumber};
}

function goUpdate() {
	if (!confirm('진행사항 변경 하시겠습니까?')){
		return false;
	}
	
	$('#myForm').attr("method","post").attr("action","userReservationDetail.ad").submit();
}

</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="목록보기" onclick="goList()">
	
		<c:if test="${myReservation.status ne '02'}">
			<input type="button" class="btn btn-primary" value="수정하기" onclick="return goUpdate()">
		</c:if>
	</div>

	<header><h2 align="center" class="text-primary">회원 ${myReservation.campingname} 예약 상세</h2></header>
	
	<form name="myForm" id="myForm" action="" method="post" class="form-horizontal">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	<input type="hidden" name="num" id="num" value="${myReservation.num}">
	
	<table class="table table-bordered">
		<caption>예약자 정보</caption>
		<tr>
			<td class="active">예약 번호</td>
			<td>${myReservation.num}</td>
			<td class="active">예약자 ID</td>
			<td>${myReservation.id}</td>
			<td class="active">예약자 이름</td>
			<td>${myReservation.name}</td>
			<td class="active">예약자 등록일자</td>
			<td>${myReservation.regdate}</td>
		</tr>
		<tr>
			<td class="active">체크인~체크아웃 날짜</td>
			<td>${myReservation.checkindate} ~ ${myReservation.checkoutdate}</td>
			<td class="active">이용인원</td>
			<td>${myReservation.guests}</td>
			<td class="active"><label for="status">예약 진행사항</label></td>
			<td>
				<!-- 예약완료상태이면, 진행사항 변경 못하게 함. 완료가 아닐경우 상태 변경가능. -->
				<c:choose>
					<c:when test="${myReservation.status ne '02'}">
						<select name="status" id="status" class="form-control">
							<option value="01" <c:if test="${myReservation.status eq '01'}">selected="selected" </c:if>>입금대기</option>
							<option value="02" <c:if test="${myReservation.status eq '02'}">selected="selected" </c:if>>결제완료</option>
							<option value="03" <c:if test="${myReservation.status eq '03'}">selected="selected" </c:if>>예약취소신청</option>
							<option value="04" <c:if test="${myReservation.status eq '04'}">selected="selected" </c:if>>환불완료</option>
						</select>
					</c:when>
					<c:when test="${myReservation.status eq '02'}">결제완료</c:when>
				</c:choose>
			</td>
			<td class="active">예약 총금액</td>
			<td>
				<b class="redFont"><fmt:formatNumber value="${myReservation.totalprice}" pattern="###,###"/></b> 원
			</td>
		</tr>
		<c:if test="${!empty myReservation.paycode}">
		<tr>
			<td class="active">결제수단</td>
			<!-- 얼랜 위에서..td 명칭 바꾸고 해야되는데 ..귀찮아서 걍 .. 무식하게 처리.. -->
			<c:choose>
				<c:when test="${myReservation.paycode eq '계좌이체'}">
					<td>${myReservation.paycode}</td>
					<td class="active">은행명</td>
					<td>${myReservation.paydetail1}</td>
					<td class="active">계좌번호</td>
					<td colspan="3">${myReservation.paydetail2}</td>
				</c:when>
				<c:when test="${myReservation.paycode eq '무통장입금'}">
					<td>${myReservation.paycode}</td>
					<td class="active">은행명</td>
					<td>${myReservation.paydetail1}</td>
					<td class="active">계좌번호</td>
					<td colspan="3">${myReservation.paydetail2}</td>
				</c:when>
				<c:when test="${myReservation.paycode eq '카드결제'}">
					<td>${myReservation.paycode}</td>
					<td class="active">카드명</td>
					<td>${myReservation.paydetail1}</td>
					<td class="active">카드번호</td>
					<td>${myReservation.paydetail2}</td>
					<td class="active">cvc</td>
					<td>${myReservation.cvc}</td>
				</c:when>
				<c:when test="${myReservation.paycode eq '휴대폰결제'}">
					<td>${myReservation.paycode}</td>
					<td class="active">통신사명</td>
					<td>${myReservation.paydetail1}</td>
					<td class="active">핸드폰번호</td>
					<td colspan="3">${myReservation.paydetail2}</td>
				</c:when>
				<c:otherwise>
					<td colspan="8" class="active">현장 결제</td>
				</c:otherwise>
			</c:choose>
		</tr>
		</c:if>
	</table>
	
	<table class="table table-bordered">
		<caption>캠핑장 정보</caption>
		<tr>
			<td colspan="6" align="center" style="border-bottom: none;">
				<img src="${fileImg}/${myReservation.campingimgurl}" alt="${myReservation.campingimgurl} 이미지" title="${myReservation.campingimgurl} 이미지" width="30%">
			</td>
		</tr>
		<tr>
			<td class="active">캠핑장 이름</td>
			<td>${myReservation.campingname}</td>
			<td class="active">캠핑장 타입</td>
			<td>
				<c:if test="${fn:contains(myReservation.camptype,'01') }">일반캠핑장/&nbsp;</c:if>
				<c:if test="${fn:contains(myReservation.camptype,'02') }">자동차캠핑장/&nbsp;</c:if>
				<c:if test="${fn:contains(myReservation.camptype,'03') }">글램핑/&nbsp;</c:if>
				<c:if test="${fn:contains(myReservation.camptype,'04') }">카라반/&nbsp;</c:if>
			</td>
			<td class="active">캠핑장 태마</td>
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
			<td class="active">캠핑장 연락처</td>
			<td>
				<a href="tel:${myReservation.contact }" class="text-decoration-none">
                	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone-outbound" viewBox="0 0 16 16">
				  <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.568 17.568 0 0 0 4.168 6.608 17.569 17.569 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.678.678 0 0 0-.58-.122l-2.19.547a1.745 1.745 0 0 1-1.657-.459L5.482 8.062a1.745 1.745 0 0 1-.46-1.657l.548-2.19a.678.678 0 0 0-.122-.58L3.654 1.328zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511zM11 .5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-1 0V1.707l-4.146 4.147a.5.5 0 0 1-.708-.708L14.293 1H11.5a.5.5 0 0 1-.5-.5z"/>
				</svg>
              	</a>
              	&nbsp;
				${myReservation.contact}
			</td>
			<td style="border-left: none; border-right: none;" class="active">캠핑장 주소</td>
			<td colspan="3" style="border-left: none; border-right: none;">${myReservation.postcode} ${myReservation.addr}</td>
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
			<td class="active">ROOM 명칭</td>
			<td>${myReservation.roomname}</td>
			<td class="active">ROOM 타입</td>
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
			<td class="active">ROOM 적정인원 (최대인원)</td>
			<td>${myReservation.propguests} 명 ( <span class="redFont">${myReservation.maxguests}</span> 명) </td>
			<td class="active">ROOM 주중가격 / 주말가격</td>
			<td>
				<b class="redFont"><fmt:formatNumber value="${myReservation.weekdayprice}" pattern="###,###"/></b> 원 /
				<b class="redFont"><fmt:formatNumber value="${myReservation.weekendprice}" pattern="###,###"/></b> 원
			</td>
		</tr>
		<tr>
			<td class="active">ROOM 시설정보</td>
			<td>${myReservation.options}</td>
			<td class="active">ROOM 비품</td>
			<td>${myReservation.amenity}</td>
		</tr>
	</table>

	<!-- 버튼 -->
	<div class="marginPadding10" align="center">
		<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
		<input type="button" class="btn btn-default" value="돌아가기" onclick="goList()">
		<c:if test="${myReservation.status ne '02'}">
			<input type="button" class="btn btn-primary" value="수정하기" onclick="return goUpdate()">
		</c:if>
	</div>
	<!-- // 버튼 -->
	
	</form>
</div>  
</article>
</section>

<%@ include file="../../../common/admin/bottom.jsp" %> 