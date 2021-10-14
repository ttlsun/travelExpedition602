<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../common/top.jsp" %>   

<script type="text/javascript">

$(document).ready(function() {
	
	$.datepicker.setDefaults({ 
		showOn: "button",
	    buttonImage: "${images}/calendar.ico",
	    buttonImageOnly: true,
	    buttonText: "Select date",
		dateFormat : "yy-mm-dd",
		showMonthAfterYear: true ,
		yearSuffix: '년',
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		
	});
	
	//달력 얻어오기. (달력 여러개 적용시 class에 주기)
	$( "#startDate" ).datepicker({
	    minDate: 0,
	    maxDate: "+3M",
		onClose: function( selectedDate ) { //시작일(startDate) datepicker가 닫힐때 //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
			$("#endDate").datepicker( "option", "minDate", selectedDate ); }
		
	});
	
	$( "#endDate" ).datepicker({ });
});


//예약하기(사용자) 버튼 클릭시
function goReservation(num,pageNumber) {
	location.href= "${contextPath}/reservation.do?num="+num+"&pageNumber="+pageNumber;
}

//문의하기(사용자) 버튼 클릭시
function goQna(num) {
	location.href= "${contextPath}/캠핑문의게시판";
}

//객실정보수정(사업자) 버튼 클릭시
function goUpdate(num,pageNumber) {
	location.href= "${contextPath}/roomUpdate.do?num="+num+"&pageNumber="+pageNumber;
}

//객실목록에서제거(사업자) 버튼 클릭시
function goDelete(num,pageNumber) {
	location.href= "${contextPath}/roomDelete.do?num="+num+"&pageNumber="+pageNumber;
}

</script>

<section class="container">
<article>
<div>
	<header><h5 align="left" class="text-primary">객실 상세 화면</h5></header>
	<div align="left">
		<input type="button" class="btn btn-default" value="돌아가기" onclick="history.back()">
	</div>
	<div>
		<div align="center">
			<h2 align="center" class="text-primary">${roombean.name }</h2>
			<h4 align="center" class="text-info">${cname }</h4>
			<!-- 사용자용 -->
			<div class="marginPadding10">
				<input type="button" class="btn btn-primary" value="문의하기(사용자)" onclick="goQna(${roombean.num})">
			</div>
			<!-- 사업자용 -->
			<div class="marginPadding10">
				<input type="button" class="btn btn-primary" value="객실정보수정(사업자)" onclick="goUpdate(${roombean.num},${pageNumber})">
				<input type="button" class="btn btn-primary" value="객실목록에서제거(사업자)" onclick="goDelete(${roombean.num},${pageNumber})">
			</div>
		</div>
		
		<!-- 객실 여럿 이미지  -->
		<div class="container"> 
			<div id="carousel-example-generic" class="carousel slide">
	      	<!-- Indicators(이미지 하단의 동그란것->class="carousel-indicators") -->
	          <ol class="carousel-indicators">
	            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
	            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
	            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
	          </ol>
	           <!-- Carousel items -->
	           <div class="carousel-inner">
	              <c:forEach items="${imgList}" var="list" varStatus="status">
	              	<div class="item <c:if test="${status.first}"> active </c:if> ">
	              	<img src="${fileImg}/${list.imgname}" style="height:400px; display: block; margin: 0px auto;" alt="${list.imgname} 이미지" title="${list.imgname} 이미지" >
	               </div>
	              </c:forEach>
	           </div>
	          <!-- Controls -->
	            <a class="left carousel-control" href="#carousel-example-generic" style="background-image:none;" data-slide="prev">
	              <span class="icon-prev"></span>
	            </a>
	            <a class="right carousel-control" href="#carousel-example-generic" style="background-image:none;" data-slide="next">
	              <span class="icon-next"></span>
	            </a>
	        </div>
	  	</div>
		<!-- // 객실 여럿 이미지  -->
	 
	  	<div class="marginPadding10" align="center">
	  		<hr>
	  		<article><h4 class="text-info text-center">객실 예약</h4></article>
	  		
	  		<form name="myForm" action="${contextPath }/reservation.do" method="get" class="form-horizontal">
	  			<input type="hidden" name="num" value="${roombean.num }">
	  			<input type="hidden" name="pageNumber" value="${pageNumber }">
	  			<input type="hidden" name="cname" value="${cname }">
	  			
				<table border="1" class="table table-bordered">
					<tr class="text-center">
						<td width="12%"><label for="startDate">입실일 선택</label></td>
						<td width="23%">
							<input type="text" class="form-date-control60" id="startDate" name="checkindate" value="" placeholder="입실일 선택">
						</td>
						<td width="12%"><label for="endDate">퇴실일 선택</label> </td>
						<td width="23%">
							<input type="text" class="form-date-control60" id="endDate" name="checkoutdate" value="" placeholder="퇴실일 선택">
						</td>
						<td width="12%"><label for="guests">이용인원</label></td>
						<td width="18%">
							<select class="form-control" id="guests" name="guests">
								<option value="">선택</option>
								<c:forEach var="i" begin="1" end="${roombean.maxguests }" varStatus="n">
									<c:if test="${i != roombean.propguests && i != n.end}">	
										<option value="${i}">${i}</option>
									</c:if>
									<c:if test="${i eq roombean.propguests }">
										<option value="${i}">${i }&nbsp;[기준인원]</option> 
									</c:if>
									<c:if test="${i eq n.end }">
										<option value="${i}">${i }&nbsp;[최대인원]</option> 
									</c:if>
									
								</c:forEach>
							</select>
						</td>
						
					</tr>
					
					<tr>
						<td colspan="4" class="textLeft">
							<span style="font-size: 14px; color: gray;">
								* 체크인 가능 날짜만 표시됩니다.&nbsp;&nbsp;|&nbsp;
								* 미성년자 및 아동도 1인 기준으로 체크해주세요.<br>
								* 객실 기준인원 초과 예약 시, 입실 시 캠핑장 기준에 따른 추가요금이 발생될 수 있습니다.
							</span>
						</td>
						<td colspan="2" class="text-center">
							<input type="submit" class="btn btn-primary" value="예약하기(사용자)" onclick="goReservation(${roombean.num},${pageNumber})">
						</td>
					</tr>
				</table>
			</form>
	  		
	  	</div> 
	  	
	  	<div align="center">
	  		<hr>
	  		<article><h4 class="text-info text-center">객실 소개</h4></article>
	  		<div class="marginPadding10">
	  			${roombean.summary }
	  		</div>
	  		<div class="marginPadding10">
	  			${roombean.contents }
	  		</div>
	  	</div>
	  	
	  	<div class="marginPadding10" align="center">
	  		<hr>
	  		<article><h4 class="text-info text-center">이용 정보</h4></article>
	  		<br>
	  		<table class="table table-bordered text-center" style="width: 100%">
	  			<tr>
	  				<td width="25%">기준인원</td>
	  				<td width="25%">${roombean.propguests }</td>
	  				<td width="25%">최대인원</td>
	  				<td width="25%">${roombean.maxguests }</td>
	  			</tr>
	  			<tr>
	  				<td>주중가격</td>
	  				<td>${roombean.weekdayprice }</td>
	  				<td>주말가격</td>
	  				<td>${roombean.weekendprice }</td>
	  			</tr>
	  			<tr>
	  				<td>내부 시설</td>
	  				<td colspan="3">${roombean.options }</td>
	  			</tr>
	  			<tr>
	  				<td>내부 비품</td>
	  				<td colspan="3">${roombean.amenity }</td>
	  			</tr>
	  		</table>
	  	</div>
	  </div>
</div>
</article>
</section>

<script>
	$('.carousel').carousel();
</script>

<%@ include file="../../../common/bottom.jsp" %>