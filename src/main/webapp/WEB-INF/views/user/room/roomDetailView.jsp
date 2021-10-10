<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../common/top.jsp" %>   
<!-- 
<script src="https://unpkg.com/vue-airbnb-style-datepicker@latest/dist/vue-airbnb-style-datepicker.min.js"></script>
	   <script>
	    var datepickerOptions = {}
	    Vue.use(window.AirbnbStyleDatepicker, datepickerOptions)
	
	    var app = new Vue({
	      el: '#app',
	      data: {
	        dateFormat: 'YYYY년 MM월 D일',
	        inputDateOne: '',
	        inputDateTwo: '',
	        buttonDateOne: '',
	        buttonDateTwo: '',
	        inlineDateOne: '',
	        sundayDateOne: '',
	        sundayFirst: false,
	        alignRight: false,
	        trigger: false,
	      },
	      methods: {
	        formatDates: function(dateOne, dateTwo) {
	          var formattedDates = ''
	          if (dateOne) {
	            formattedDates =  dateFns.format(dateOne, this.dateFormat)
	          }
	          if (dateTwo) {
	            formattedDates += ' - ' + dateFns.format(dateTwo, this.dateFormat)
	          }
	          return formattedDates
	        },
	        onClosed: function() {
	          var datesStr = this.formatDates(this.inputDateOne, this.inputDateTwo)
	          console.log('Dates Selected: ' + datesStr)
	          this.trigger = false
	          $('#dateOne').val(this.buttonDateOne);
	          $('#dateTwo').val(this.buttonDateTwo);
	          if(this.buttonDateOne=="" || this.buttonDateTwo ==""){
	            	alert("날짜를 선택해 주세요.");
	          }else{
	          alert("선택하신 날짜는 "+this.buttonDateOne+"~"+this.buttonDateTwo+"입니다.");
	          }
	        },
	        toggleAlign: function() {
	          this.alignRight = !this.alignRight
	        },
	        triggerDatepicker: function() {
	          this.trigger = !this.trigger
	        },
	        onMonthChange: function(dates) {
	          console.log('months changed', dates)
	        },
	        login: function(dateOne, dateTwo){
	      	  console.log(this.dateOne, this.dateTwo)
	        },
	      },
	    })
	    
	    function printTime() {
	
	        var clock = document.getElementById("clock");// 출력할 장소 선택
	        var now = new Date();// 현재시간
	        var nowTime = "'" + now.getFullYear() + "-" + (now.getMonth()+1) + "-" + now.getDate() + "'";
	        clock.innerHTML = nowTime;// 현재시간을 출력
	}
		window.onload = function() {// 페이지가 로딩되면 실행
		printTime();
		}
	  </script>

<script type="text/javascript">
 -->
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
	<div align="center">
		<h2 align="center" class="text-primary">${roombean.name }</h2>
		<h4 align="center" class="text-info">${cname }</h4>
		<!-- 사용자용 -->
		<div class="marginPadding10">
			<input type="button" class="btn btn-primary" value="예약하기(사용자)" onclick="goReservation(${roombean.num},${pageNumber})">
			<input type="button" class="btn btn-primary" value="문의하기(사용자)" onclick="goQna(${roombean.num})">
		</div>
		<!-- 사업자용 -->
		<div class="marginPadding10">
			<input type="button" class="btn btn-primary" value="객실정보수정(사업자)" onclick="goUpdate(${roombean.num},${pageNumber})">
			<input type="button" class="btn btn-primary" value="객실목록에서제거(사업자)" onclick="goDelete(${roombean.num},${pageNumber})">
		</div>
		
	</div>
	
	<div class="container">
        <div id="carousel-example-generic" class="carousel slide">
        
            <!-- Indicators(이미지 하단의 동그란것->class="carousel-indicators") -->
			<ol class="carousel-indicators">
				<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
				
				<c:forEach var="i" begin="1" end="${fn:length(imgList)}" step="1"> 
					<li data-target="#carousel-example-generic" data-slide-to="${i}"></li>
				</c:forEach>
			</ol>
			
			<!-- Carousel items -->
			<div class="carousel-inner">
				<div class="item active">
					<img src="${images}/uploaded_file/${roombean.imgurl}" style="height:500px; display: block; margin: 0px auto;" alt="1 slide" >
				</div>
				
				<c:forEach var="i" begin="0" end="${fn:length(imgList)-1}" step="1"> 
					<div class="item">
						<img src="${images}/uploaded_file/${imgList[i].imgname}" style="height:500px; display: block; margin: 0px auto;" alt="${i+2 } slide">               
					</div>
				</c:forEach>
			</div>
			<!-- 
			Controls
			<a class="left carousel-control" href="#carousel-example-generic" style="background-image:none;" data-slide="prev">
				<span class="icon-prev"></span>
			</a>
			<a class="right carousel-control" href="#carousel-example-generic" style="background-image:none;" data-slide="next">
				<span class="icon-next"></span>
			</a>
		</div>
  	</div>
  	
  	<div class="marginPadding10" align="center">
  		<hr>
  		<article><h4 class="text-info text-center">예약하기</h4></article>
  		
  		<div>
  			<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
				<div class="panel panel-default">
					<div class="panel-heading" role="tab" id="headingOne">
						<h4 class="panel-title">
							<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne"> 일정체크 & 객실 인원선택 </a>
						</h4>
					</div>
					<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
						<div class="panel-body">
						<div class="row">
						<div class="col-md-3">
						
							달력시작 --><!-- 달력시작 --><!-- 달력시작 --><!-- 달력시작 --><!-- 달력시작 --><!-- 달력시작 --><!-- 달력시작
			<div id="app" class="app" :class="{'align-right': alignRight}">
			 <div  class="datepicker-container with-button">
		        <div class="datepicker-trigger">
		          <button id="datepicker-button-trigger" >
		            {{ formatDates(buttonDateOne, buttonDateTwo) || '날짜를 선택해 주세요' }}
		          </button>
		          <airbnb-style-datepicker
		            :trigger-element-id="'datepicker-button-trigger'"
		            :mode="'range'"
		            :date-one="buttonDateOne"
		            :date-two="buttonDateTwo"
		            :min-date="'2020-04-18'"
		            :fullscreen-mobile="true"
		            :months-to-show="2"
		            :offset-y="10"
		            :trigger="trigger"
		            v-on:date-one-selected="function(val) { buttonDateOne = val }"
		            v-on:date-two-selected="function(val) { buttonDateTwo = val }"
		            v-on:closed="onClosed"
		            v-on:previous-month="onMonthChange"
		            v-on:next-month="onMonthChange"
		          ></airbnb-style-datepicker>
		        </div>
		      </div>
		    </div>
  		</div>
  		</div>
	
					
						<div class="col-md-3">
					
					<select class="form-control" name="adult" >
					  <option value="1">성인 1</option>
					  <option value="2">성인 2</option>
					  <option value="3">성인 3</option>
					</select>
					</div>
					
					<div class="col-md-3">
		
					<select class="form-control" name="child" >
					  <option value="1">어린이 1</option>
					  <option value="2">어린이 2</option>
					  <option value="3">어린이 3</option>
					</select>
					</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>아코디언 끝
	<div style="float:right">
				<input class="btn btn-dark" type="submit" value="예약하기" >
				</div>
  	</div> -->
  	
  	<div class="marginPadding10" align="center">
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
</article>
</section>



<%@ include file="../../../common/bottom.jsp" %>