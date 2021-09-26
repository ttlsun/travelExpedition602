<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<!-- 지도관련 js -->
<script src="${js}/mapview-1.0.0.js"></script>
<!-- //지도관련 js -->

<script type="text/javascript" >
var map;
var overlay;
var marker;

$(document).ready(function() {
	//메뉴 on 유지.
	navActive('tourism');
	
	//지도를 생성합니다
	map = mapViewInit('map');
	
	//주소 값 내려서 받기.
	var fullAddr = "경기 가평군 북면 노씨터길 12"; //테스트 주소.
	addSerach(fullAddr, 37.9501622932289, 127.536039129141);
});

function addSerach(fullAddr, lat, lng) {
	
	var coords = new kakao.maps.LatLng(lat, lng);
	
	// 결과값으로 받은 위치를 마커로 표시합니다
    marker = mapViewSetMarker(map, coords, marker);
	
    overlay = mapViewSetCustomOverlay(map, marker, name, fullAddr, overlay);

    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    map.setCenter(coords);
}

//커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/sampleTourismList";
}


</script>

<section>
<article>
<div class="marginPadding10">
	<header><h2 align="center" class="text-primary">관광지 상세 화면</h2></header>
	
	<!-- 상세페이지 form -->
	<form name="myForm" action="" method="post" class="form-horizontal">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	<input type="hidden" name="num" id="num" value="">
	
	<table class="table table-bordered">
		<tr>
			<td colspan="4" align="center" style="border-bottom: none;">
				<img src="${images}/1.jpg" alt="" title="" width="30%">
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center" style="border: none; padding-bottom: 20px;">
				<span class="text-primary" style="font-size: 25px;">
				타이틀
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center" style="border: none; padding-bottom: 20px;">
				<span class="text-primary" style="font-size: 15px;">
				한줄요약
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="border: none;"> (관광지 구분) / 테마별: 계곡 </td>
			<td colspan="2" align="right" style="border: none; padding-top: 2%" width="20%">
				<div class="fs-4 mb-3">
             		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
 						<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
 						<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
				</svg>
					조회수 1
           		</div>
			</td>
		</tr>
		<tr>
			<td colspan="1" style="border: none;">
				<c:forEach var="i" begin="1" end="5">
					<c:choose>
						<c:when test="${i <= 3}"> <!-- 3으로 적힌 곳을 별등급 받은 숫자 컬럼값으로 셋팅하세요. -->
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
			<td colspan="3" style="border: none; text-align:end;" width="30%">
				<button type="button" class="btn outline-secondary" >
					추천
			    	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up" viewBox="0 0 16 16">
			  		<path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"/>
					</svg>
					1 
			    </button>
			    <!-- <button type="button" class="btn outline-secondary" >
	           		비추천
	           		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-down" viewBox="0 0 16 16">
					<path d="M8.864 15.674c-.956.24-1.843-.484-1.908-1.42-.072-1.05-.23-2.015-.428-2.59-.125-.36-.479-1.012-1.04-1.638-.557-.624-1.282-1.179-2.131-1.41C2.685 8.432 2 7.85 2 7V3c0-.845.682-1.464 1.448-1.546 1.07-.113 1.564-.415 2.068-.723l.048-.029c.272-.166.578-.349.97-.484C6.931.08 7.395 0 8 0h3.5c.937 0 1.599.478 1.934 1.064.164.287.254.607.254.913 0 .152-.023.312-.077.464.201.262.38.577.488.9.11.33.172.762.004 1.15.069.13.12.268.159.403.077.27.113.567.113.856 0 .289-.036.586-.113.856-.035.12-.08.244-.138.363.394.571.418 1.2.234 1.733-.206.592-.682 1.1-1.2 1.272-.847.283-1.803.276-2.516.211a9.877 9.877 0 0 1-.443-.05 9.364 9.364 0 0 1-.062 4.51c-.138.508-.55.848-1.012.964l-.261.065zM11.5 1H8c-.51 0-.863.068-1.14.163-.281.097-.506.229-.776.393l-.04.025c-.555.338-1.198.73-2.49.868-.333.035-.554.29-.554.55V7c0 .255.226.543.62.65 1.095.3 1.977.997 2.614 1.709.635.71 1.064 1.475 1.238 1.977.243.7.407 1.768.482 2.85.025.362.36.595.667.518l.262-.065c.16-.04.258-.144.288-.255a8.34 8.34 0 0 0-.145-4.726.5.5 0 0 1 .595-.643h.003l.014.004.058.013a8.912 8.912 0 0 0 1.036.157c.663.06 1.457.054 2.11-.163.175-.059.45-.301.57-.651.107-.308.087-.67-.266-1.021L12.793 7l.353-.354c.043-.042.105-.14.154-.315.048-.167.075-.37.075-.581 0-.211-.027-.414-.075-.581-.05-.174-.111-.273-.154-.315l-.353-.354.353-.354c.047-.047.109-.176.005-.488a2.224 2.224 0 0 0-.505-.804l-.353-.354.353-.354c.006-.005.041-.05.041-.17a.866.866 0 0 0-.121-.415C12.4 1.272 12.063 1 11.5 1z"/>
					</svg>
					1
				</button> -->
				<button type="button" class="btn outline-secondary" >
	           		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
					  <path d="m8 6.236-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z"/>
					</svg>
					찜
				</button>
			</td>
		</tr>
		<tr>
			<td width="10%">번호</td>
			<td>1</td>
			<td width="10%">등록 ID</td>
			<td> id </td>
		</tr>
		<tr>
			<td>할인가</td>
			<td>10%</td>
			<td>가격</td>
			<td>  원 </td>
		</tr>
		<tr>
			<td>적립 포인트</td>
			<td>100 <span class="redFont">Point</span></td>
			<td>관광지 연락처</td>
			<td>
				<!-- tel: 에도 연락처 같이 넣어주기. -->
				<a href="tel:010-4000-4000" class="text-decoration-none">
                	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone-outbound" viewBox="0 0 16 16">
				  <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.568 17.568 0 0 0 4.168 6.608 17.569 17.569 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.678.678 0 0 0-.58-.122l-2.19.547a1.745 1.745 0 0 1-1.657-.459L5.482 8.062a1.745 1.745 0 0 1-.46-1.657l.548-2.19a.678.678 0 0 0-.122-.58L3.654 1.328zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511zM11 .5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-1 0V1.707l-4.146 4.147a.5.5 0 0 1-.708-.708L14.293 1H11.5a.5.5 0 0 1-.5-.5z"/>
				</svg>
              	</a>
              	&nbsp; 010-4000-4000
			</td>
		</tr>
		<tr>
			<td>주소</td>
			<td colspan="3" style="border: none;">
				<!-- value : 테스트 데이터 -->
				<c:set var="fullAddr" value="경기 가평군 북면 노씨터길 12"/>
				${fullAddr} 
				<div id="map" style="width:100%;height:350px; "></div>
			</td>
		</tr>
		<tr>
			<td colspan="4" style="border-bottom: none;"> 설명 </td>
		</tr>
		<tr>
			<td align="center" colspan="4" style="border-top: none;">
			설명칸
			</td>
		</tr>
		<tr>
			<td> 키워드 </td>
			<td colspan="3"> <span class="text-primary"> #후기, #좋아요, #추천 </span> </td>
		</tr>
	</table>
	</form>
	<!-- //상세페이지 form -->
	
	<!-- 댓글 관련 form-->
	<form name="myForm2" action="" method="post" class="form-horizontal">
	<div class="marginPadding10">
		<fieldset>
		<legend class="textAlignLeft">관광지 문의 댓글</legend>
			<div class="form-group">
				<label for="content" class="col-xs-2 col-lg-2 control-label text-primary">댓글</label> 
				<div class="col-xs-6 col-lg-6">
					<span>
						<input type="text" class="form-control" name="content" id="content" value="">
					</span>
				</div>
				<div align="left">
					<button type="button" class="btn btn-outline-secondary">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-reply" viewBox="0 0 16 16">
					<path d="M6.598 5.013a.144.144 0 0 1 .202.134V6.3a.5.5 0 0 0 .5.5c.667 0 2.013.005 3.3.822.984.624 1.99 1.76 2.595 3.876-1.02-.983-2.185-1.516-3.205-1.799a8.74 8.74 0 0 0-1.921-.306 7.404 7.404 0 0 0-.798.008h-.013l-.005.001h-.001L7.3 9.9l-.05-.498a.5.5 0 0 0-.45.498v1.153c0 .108-.11.176-.202.134L2.614 8.254a.503.503 0 0 0-.042-.028.147.147 0 0 1 0-.252.499.499 0 0 0 .042-.028l3.984-2.933zM7.8 10.386c.068 0 .143.003.223.006.434.02 1.034.086 1.7.271 1.326.368 2.896 1.202 3.94 3.08a.5.5 0 0 0 .933-.305c-.464-3.71-1.886-5.662-3.46-6.66-1.245-.79-2.527-.942-3.336-.971v-.66a1.144 1.144 0 0 0-1.767-.96l-3.994 2.94a1.147 1.147 0 0 0 0 1.946l3.994 2.94a1.144 1.144 0 0 0 1.767-.96v-.667z"/>
					</svg>
					<span class="visually-hidden">댓글</span>
					</button>
				</div>
			</div>
		</fieldset>
	</div>
	<!-- 댓글 리스트 -->
	<div class="marginPadding10">
		<div class="form-group">
			<table class="table table-bordered">
			<caption>관광지 문의 댓글 목록</caption>
				<tr>
					<td colspan="3"> 등록된 댓글이 없습니다.</td>
				</tr>
				<tr>
					<td class="tableWidth200" style="border: none;" align="center">
						<label for="rippleNo"> 작성자 이름 </label> 
					</td>
					<td style="border: none;">
						<input type="hidden" name="" value="">
						댓글 내용
					</td>
					<td style="border: none;">
						<input type="button" class="btn btn-primary" value="X">
					</td>
				</tr>
			</table>
		</div>
		
		<!-- 댓글 페이징 -->
		<div class="paginationCenter" align="center">
			${pageInfo.pagingHtml} <!-- 댓글 관련 페이징으로 변경해야함 -->
		</div>
		<!-- // 댓글 페이징 -->
	</div>
	<!-- // 댓글 리스트 -->
	</form>
	<!-- // 댓글 관련 form -->
	
	<!-- 후기 관련 form-->
	<form name="myForm2" action="" method="post" class="form-horizontal">
	<!-- 관광지 후기 리스트 -->
	<div class="marginPadding10">
		<div class="form-group">
			<table class="table table-bordered">
			<caption>관광지 후기 목록</caption>
				<tr>
					<td colspan="3"> 등록된 후기가 없습니다.</td>
				</tr>
			</table>
		</div>
		
		<!-- 관광지 후기 페이징 -->
		<div class="paginationCenter" align="center">
			${pageInfo.pagingHtml} <!-- 후기관련 페이징으로 변경해야함 -->
		</div>
		<!-- // 후기 페이징 -->
		<div align="right"> 
			<input type="button" class="btn btn-primary" value="후기목록 보러가기" >
		</div>
	</div>
	<!-- // 후기 리스트 -->
	</form>
	<!-- // 후기 관련 form -->
	
	<!-- 추천 캠핑/글램핑  -->
	<div class="container"> 
		<div class="marginPadding10">
			<label class="text-primary textFontSizeLarge"> 추천 캠핑/글램핑 </label>
		</div>
        <div id="carousel-example-generic" class="carousel slide">
        
            <!-- Indicators(이미지 하단의 동그란것->class="carousel-indicators") -->
            <ol class="carousel-indicators">
              <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
              <li data-target="#carousel-example-generic" data-slide-to="1"></li>
              <li data-target="#carousel-example-generic" data-slide-to="2"></li>
            </ol>
             <!-- Carousel items -->
             <div class="carousel-inner">
                <div class="item active">
                   <img src="${images}/1.jpg" style="height:400px; display: block; margin: 0px auto;" alt="First slide" >
                </div>
                <div class="item">
                   <img src="${images}/1.jpg" style="height:400px; display: block; margin: 0px auto;" alt="Second slide">               
                </div>
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
	<!-- // 추천 캠핑/글램핑  -->
	
	<!-- 버튼 -->
	<div class="marginPadding10" align="center">
		<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
	</div>
	<!-- // 버튼 -->
</div>  
</article>
</section>
<script>
	$('.carousel').carousel();
</script>
<%@ include file="../../common/bottom.jsp" %>  

<!-- kakao api start -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoKey}"></script>
<!-- kakao api end --> 