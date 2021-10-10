<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<!-- 지도관련 js -->
<!-- 지도 마커 css -->
<link href="${css}/mapview-1.0.0.css" rel="stylesheet">
<script src="${js}/mapview-1.0.0.js"></script>
<!-- //지도관련 js -->

<script type="text/javascript" >
var map;
var overlay;
var marker;

$(document).ready(function() {
	//메뉴 on 유지.
	navActive('camping');
	
	//메타태그 설정. (DB에 가져온 값 셋팅)
	var title = "야생화캠핑장"; //요런식으로 추출한값 가져오기. var title = "${bean.title}";
	$("#metaTitle").attr("content", title);
	$("#metaDescription").attr("content", "캠핑 상세");
	$("#metaKeywords").attr("content", "#키워드,#좋아요,#캠핑상세");
});

function addSearch(fullAddr, lat, lng) {
	
	var coords = new kakao.maps.LatLng(lat, lng);
	
	// 결과값으로 받은 위치를 마커로 표시합니다
    marker = mapViewSetMarker(map, coords, marker);
	
    var name = "야생화캠핑장" //캠핑장이름
	overlay = mapViewSetCustomOverlay(map, marker, name, fullAddr, overlay);

    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    map.setCenter(coords);
}

function fnTab(num) {
	if (num == 4) {
		if (map == null) {
			setTimeout(function() {
				//지도를 생성합니다
				map = mapViewInit('map');
				
				//주소 값 내려서 받기.
				var fullAddr = "경기 가평군 북면 노씨터길 12";
			    var coordsLa = "127.536039129141"; //위도
			    var coordsMa = "37.9501622932289"; //경도
			       
				addSearch(fullAddr, coordsMa, coordsLa);
			}, 300);
		}
	}
}

//커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}

</script>

<!-- 승민님이 만드신 화면단에 지도 이상하게 뜬거 수정한 예제.. -->

<section class="container">
<article>
<div>
	<header><h5 align="left" class="text-primary">캠핑장 상세 화면</h5></header>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="목록보기" onclick="goList()">
		<input type="button" class="btn btn-default" value="수정(사업자 전용)" onclick="goUpdate()">
		<input type="button" class="btn btn-default" value="삭제(사업자 전용)" onclick="goDelete()">
	</div>
	
	<!-- 캠핑장 타이틀 block -->
	<form name="campform" action="" method="post" class="form-horizontal">

	<table class="table table-bordered" style="border: none;">
		<tr>
			<td colspan="4" align="center" style="border: none;">
				<span class="text-primary" style="font-size: 30px; border-bottom: none;">
				캠핑명
				</span>	
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center" style="border: none;">
				<img src="${fileImg}/1.jpg" alt="" title="" width="60%">
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center" style="border: none; padding-bottom: 20px;">
				<span class="text-primary" style="font-size: 15px;">
				한줄소개
				</span>	
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center" style="border: none; padding-bottom: 20px;">
				<span class="text-primary" style="font-size: 15px;">
					<font color="red">!!!!!키워드태그추가!!!!!</font>
				</span>	
			</td>
		</tr>
		<tr>
			<td colspan="4" style="border: none; text-align:end;">
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
		</tr>
		<tr>
			<td colspan="2" align="left" style="border: none; text-align:left;">
				<div class="fs-4 mb-3">
             		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
 						<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
 						<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
				</svg>
					조회수
           		</div>
			</td>
			<td colspan="2" align="right" style="border: none; text-align:end;" width="30%">
				<button type="button" class="btn outline-secondary" >
					추천
			    	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up" viewBox="0 0 16 16">
			  		<path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"/>
					</svg>
					1 
			    </button>
			    <button type="button" class="btn outline-secondary" >
	           		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
					  <path d="m8 6.236-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z"/>
					</svg>
					찜 1
				</button>
			</td>
		</tr>
		<tr>
			<th width="15%">
				캠핑장 환경
			</th>
			<td width="35%">
				숲/산
			</td>
			<th width="15%">
				캠핑장 유형
			</th>
			<td width="35%">
				일반캠핑장
			</td>
		</tr>
		<tr>
			<th>
				주소
			</th>
			<td>
				<span class="text-primary" style="font-size: 15px;">
				<c:set var="fullAddr" value="경기 가평군 북면 노씨터길 12"/>
				${fullAddr }
				</span>	
			</td>
			<th>
				문의처
			</th>
			<td>
				<a href="tel:010-4000-4000" class="text-decoration-none">
                	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone-outbound" viewBox="0 0 16 16">
				  <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.568 17.568 0 0 0 4.168 6.608 17.569 17.569 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.678.678 0 0 0-.58-.122l-2.19.547a1.745 1.745 0 0 1-1.657-.459L5.482 8.062a1.745 1.745 0 0 1-.46-1.657l.548-2.19a.678.678 0 0 0-.122-.58L3.654 1.328zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511zM11 .5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-1 0V1.707l-4.146 4.147a.5.5 0 0 1-.708-.708L14.293 1H11.5a.5.5 0 0 1-.5-.5z"/>
				</svg>
              	</a>
              	&nbsp; 010-4000-4000
			</td>
		</tr>
	</table>
	</form>

	<!-- 캠핑장 상세 정보/객실 목록/후기/오시는 길/ 탭 -->
	<div class="marginPadding10">
		<ul class="nav nav-tabs">
			<li><a href="#tab1" data-toggle="tab">캠핑장 상세 정보</a></li>
			<li class="active"><a href="#tab2" data-toggle="tab">객실 목록</a></li>
		    <li><a href="#tab3" data-toggle="tab">캠핑장 후기(0)</a></li>
		    <li><a href="#tab4" data-toggle="tab" onClick="fnTab(4)">오시는 길</a></li>
		</ul>
		
		<div class="tab-content marginPadding10">
			
			<!-- 상세 정보 탭 -->
			<div class="tab-pane fade" id="tab1" style="text-align: left;">
			    <h3>캠핑장 상세 정보</h3>
			    <div>정보</div>
			</div>
			
			<!-- 객실 리스트 탭 -->
			<div class="tab-pane active fade in" id="tab2" style="text-align: left;">
		   		<h3>객실 리스트</h3>
		    	<span class="spanFlowRootP10"></span>
				
				<form name="roomform" action="" method="post">
					<div align="right">
						<input type="button" class="btn btn-primary" value="객실 등록하기(사업자 전용)" style="margin-bottom: 10px" onClick="goInsertRoom()">
					</div>
					
					일반캠핑장
					
						<table class="table table-bordered">
							<tr>
								<td rowspan="4" width="25%">
									<img src="${fileImg}/${room.imgurl}" alt="" title="" width="100%">
								</td>
								<td colspan="6" style="text-align: left;">
									[${rType}]&nbsp;${room.name }
								</td>
								<td rowspan="4" width="10%" align="center" style="vertical-align: middle;">
									<input type="button" value="상세보기" class="btn btn-primary" onClick="goRoomDetail()"><br><br>
									<input type="button" value="객실예약" class="btn btn-primary" onClick="goReservation()">	
								</td>
							</tr>
							<tr>
								<td colspan="6" style="text-align: left;">
									룸 한줄요약
								</td>
							</tr>
							<tr>
								<td width="12%">기준인원</td>
								<td width="5%">
									1
								</td>
								<td width="12%">최대인원</td>
								<td width="5%">
									2
								</td>
								<td width="10%">가격</td>
								<td>
									1000~2000
								</td>
							</tr>
							<tr>
								<td>주요시설</td>
								<td colspan="5">
									수영장
								</td>
							</tr>
						</table>
				</form>
			</div>
			
			<!-- 후기 탭-->
			<div class="tab-pane fade" id="tab3" style="text-align: left;">
		    	<h3>캠핑장 후기</h3>
		     	<form name="reviewform" action="" method="post" class="form-horizontal">
	
				<div class="marginPadding10">
					<div class="form-group">
						<table class="table table-bordered">
						<caption>캠핑/글램핑 후기 목록</caption>
							<tr>
								<td colspan="3"> 등록된 후기가 없습니다.</td>
							</tr>
						</table>
					</div>
		
					<!-- 후기 페이징 -->
					<div class="paginationCenter" align="center">
						${pageInfo.pagingHtml} <!-- 후기관련 페이징으로 변경해야함 -->
					</div>
					<!-- // 후기 페이징 -->
					
					<div align="right"> 
						<input type="button" class="btn btn-primary" value="후기목록 보러가기" >
					</div>
				</div>
				</form>
			</div>
			
			<!-- 오시는 길 탭 -->
		    <div class="tab-pane fade" id="tab4" style="text-align: left;">
		      	<h3> 오시는 길</h3>
				<span>1</span>
				<p>1</p>
				
				<div id="map" style="width:100%;height:350px; "></div>
			
			</div>
		</div>
		<hr>
	</div>
	
	<!-- 추천관광지  -->
	<div class="container"> 

	   	<div class="marginPadding10">
			<label class="text-primary textFontSizeLarge"> 추천관광지 </label>
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
	<!-- // 추천관광지  -->
	
	<!-- 버튼 -->
	<div class="marginPadding10" align="center">
		<input type="button" class="btn btn-primary" value="추천 관광지 더보기" onclick="goTourList()">
	</div>
	<!-- // 버튼 -->
</div>
</article>
</section>



<%@ include file="../../common/bottom.jsp" %>

<!-- kakao api start -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoKey}"></script>
<!-- kakao api end --> 