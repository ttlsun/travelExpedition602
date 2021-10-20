<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/top.jsp" %>   

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
	navActive('bCamping');
	
	//메타태그 설정. (DB에 가져온 값 셋팅)
	$("#metaTitle").attr("content", "${tourbean.name} 관광지 상세");
	$("#metaDescription").attr("content", "${tourbean.summary}");
	$("#metaKeywords").attr("content", "${tourbean.regkeyword} ");
	
});

function addSearch(fullAddr, lat, lng) {
	
	var coords = new kakao.maps.LatLng(lat, lng);
	
	// 결과값으로 받은 위치를 마커로 표시합니다
    marker = mapViewSetMarker(map, coords, marker);

    var name = "${tourbean.name}" //관광지이름
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
				var fullAddr = "${tourbean.address1} ${tourbean.address2} ${tourbean.address3} ${tourbean.address4}";
			    var coordsLa = "${tourbean.latitude}"; 
			    var coordsMa = "${tourbean.longitude}"; 
			       
				addSearch(fullAddr, coordsMa, coordsLa);
			}, 300);
		}
	}
}
//커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}

//목록보기 버튼 클릭시
function goList(pageNumber) {
	location.href= "${contextPath}/bTourList.do?pageNumber="+pageNumber;
}

//수정(사업자 전용) 버튼 클릭시
function goUpdate(num,pageNumber) {
	location.href= "${contextPath}/bTourUpdate.do?num="+num+"&pageNumber="+pageNumber;
}

//삭제(사업자 전용) 버튼 클릭시
function goDelete(num,pageNumber) {
	location.href= "${contextPath}/bTourDelete.do?num="+num+"&pageNumber="+pageNumber;
}


//후기 등록페이지이동 버튼
function goCommunityRegister() {
	location.href= "${contextPath}/communityRegister.do?reviewnum=${tourbean.num}&reviewtype=02&type=2";
}


//공통으로 같이 태울 찜 likes 등록.
function likesRegisters() {
   var userId = "${userId}"; // 페이지 진입한 유저 아이디.
   var num = $('#num').val(); //id로 얻어온 자기 고유값 넣기.
   var acode = "1"; //게시글 구분코드(1:캠핑/2:관광지/3:커뮤니티)
   var userCode = "${userCode}"; //유저 구분코드
   
   if(userId == ""){
      alert("로그인후 이용해주세요.");
      return;
   }
   
   //사업자와 관리자는 찜콩하지마쇼
   if(userCode == "business" || userCode == "admin"){
      alert("사업자/관리자는 찜 하실 수 없습니다.");
      return;
   }
   
   $.ajax({
      url: "myLikesRegister.do",
      type: "POST",
      data: {
         num : num,
         userId : userId,
         acode : acode
      },
      dataType: "json",
      success: function(data) {
         if (data.resultCode != 'OK') {
            //alert(data.resultMsg);
            return;
         }
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
		<input type="button" style="float: left" class="btn btn-default" value="목록보기" onclick="goList(${pageNumber})">
		<input type="button" class="btn btn-default" value="수정(사업자 전용)" onclick="goUpdate(${tourbean.num},${pageNumber})">
		<input type="button" class="btn btn-default" value="삭제(사업자 전용)" onclick="goDelete(${tourbean.num},${pageNumber})">
	</div> 
	<!-- 상세페이지 form -->
	<form name="tourForm" action="tourDetail.do" method="post" class="form-horizontal">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	<input type="hidden" name="communityPageNumber" id="communityPageNumber" value="${communityPageInfo.pageNumber}">
	<input type="hidden" name="num" id="num" value="${tourbean.num}">
	<table>
		<tr>
			<td colspan="2" style="text-align:center; padding-bottom: 20px; border-bottom: 1px solid lightgrey;">
				<h2 class="text-primary">${tourbean.name }</h2>
				<h4 style="font-style: italic;">"${tourbean.summary }"</h4>
				<h4 style="color:purple; font-weight: normal;">${tourbean.regkeyword }</h4>
			</td>
		</tr>
		<tr>
			<td style="text-align:left; padding-top: 20px; padding-bottom: 20px;" class="col-xs-8 col-sm-8 col-md-8">
				<img src="${fileImg}/${tourbean.imgurl}" alt="" title="" width="100%">
			</td>
			<td style="border-left:none; padding-top:20px; text-align:right;" valign="top">
				<table class="table table-bordered" style="border-left:none; border-right:none;">
					<tr>
						<th style="border-top-color: red; border-left:none;">
							테마
						</th>
						<td style="border-top-color: black; border-right:none;">
							<c:choose>
								<c:when test="${tourbean.themecode eq '01'}">베스트</c:when>
								<c:when test="${tourbean.themecode eq '02'}">제주여행</c:when>
								<c:when test="${tourbean.themecode eq '03'}">내륙여행</c:when>
								<c:when test="${tourbean.themecode eq '04'}">섬여행</c:when>
						</c:choose>
							
						</td>
					</tr>
					<tr>
						<th style="border-left:none;">
							가격
						</th>
						<td style="border-right:none;">
							<fmt:formatNumber value="${tourbean.price}" pattern="###,###"/>
							&nbsp;원
						</td>
					</tr>
					<tr>
						<th style="border-left:none;">
							할인율
						</th>
						<td style="border-right:none;">
							${tourbean.discount }&nbsp;%
						</td>
					</tr>
					<tr>
						<th style="border-left:none; ">
							주소
						</th>
						<td style="border-right:none;">
							${tourbean.address1 }&nbsp;${tourbean.address2 }&nbsp;${tourbean.address3 }&nbsp;${tourbean.address4 }
						</td>
					</tr>
					<tr>
						<th style="border-left:none; ">
							연락처
						</th>
						<td style="border-right:none;">
							<a href="tel:${tourbean.contact }" class="text-decoration-none">
                				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone-outbound" viewBox="0 0 16 16">
								  <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.568 17.568 0 0 0 4.168 6.608 17.569 17.569 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.678.678 0 0 0-.58-.122l-2.19.547a1.745 1.745 0 0 1-1.657-.459L5.482 8.062a1.745 1.745 0 0 1-.46-1.657l.548-2.19a.678.678 0 0 0-.122-.58L3.654 1.328zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511zM11 .5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-1 0V1.707l-4.146 4.147a.5.5 0 0 1-.708-.708L14.293 1H11.5a.5.5 0 0 1-.5-.5z"/>
								</svg>
             			 	</a>
							&nbsp; ${tourbean.contact }
						</td>
					</tr>
					<tr>
						<th style="border-bottom-color: red; border-left:none; ">
							별등급
						</th>
						<td style="border-bottom-color: black; border-right:none;">
							<c:choose>
				<c:when test="${community.reviewtype ne '03' }">
						<fmt:parseNumber var="starranking" value="${startAvg}"/>
						<c:forEach var="i" begin="1" end="5">
							<c:choose>
								<c:when test="${i <= starranking}">
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
				</c:when>
				<c:otherwise>
					<td colspan="1" style="border: none;"></td>
				</c:otherwise>
			</c:choose>
						</td>
					</tr>
				</table>
				
				<button type="button" class="btn outline-secondary" style="cursor:no-drop;">
					추천
			        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="purple" class="bi bi-hand-thumbs-up" viewBox="0 0 16 16">
			  		<path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"/>
					</svg>
					 ${tourbean.recommend}
			    </button>
			    <button type="button" class="btn outline-secondary" style="cursor:no-drop;">
	                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="red" class="bi bi-suit-heart" viewBox="0 0 16 16">
					  <path d="m8 6.236-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z"/>
					</svg>
					찜 ${tourbean.steamed}
				</button>
			</td>
			
		</tr>
		
	</table>
	
	<div class="marginPadding10">
		<ul class="nav nav-tabs">
			<li class="active" style="width: 25%; text-align:center;"><a href="#tab1" data-toggle="tab">관광지 상세 정보</a></li>
			<li style="width: 25%; text-align:center;"><a href="#tab2" data-toggle="tab">주변관광지</a></li>
		    <li style="width: 25%; text-align:center;"><a href="#tab3" data-toggle="tab">관광지 후기(${tourbean.reviewcount })</a></li>
		    <li style="width: 25%; text-align:center;"><a href="#tab4" data-toggle="tab" onClick="fnTab(4)">오시는 길</a></li>
		</ul>
		
		<div>
		<div class="tab-content marginPadding10">
			
			<!-- 상세 정보 탭 -->
			<div class="tab-pane active fade in" id="tab1" style="text-align: left;">
			    <h3>관광지 상세 정보</h3>
			    ${tourbean.contents }
			    
			    <!-- 이미지가 없으면 보여주지 말고 , 이미지가 있을 경우 보여주세요. -->
			    <c:choose>
					<c:when test="${!empty imgList }">
					<div class="container"> 
						<div class="marginPadding10">
							<label class="text-primary textFontSizeLarge"> 관광지 상세 이미지들 </label>
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
					<!-- // 후기 사진  -->
					
					</c:when>
				</c:choose>
			    
			</div>
			
			<!-- 주변관광지 리스트 탭 -->
			<div class="tab-pane fade" id="tab2" style="text-align: left;">
		   		<h3>주변관광지</h3>
		    	<div class="marginPadding10">
						<table class="table table-bordered" style="margin-top: 3%;">
					<caption>레코드 총 갯수 : ${totalCount}</caption>
					<thead>
						<tr class="active">
							<th width="6%">번호</th>
							<th>관광지명</th>
							<th>주소</th>
							<th>한줄요약</th>
							<th width="14%">등록일</th>
						</tr>
					</thead>
				
					<tbody>
						<!-- list가 없을 경우 -->
						<c:if test="${empty lists}">
						<tr>
							<td colspan="5" align="center"> 해당 주변 관광지 레코드가 없습니다.</td>
						</tr>
						</c:if>
						
						<c:forEach var="list" items="${lists}">
						<tr>
							<td>${list.rownum}</td>
							<td>
								<a href="tourDetail.do?num=${list.num}&pageNumber=${pageInfo.pageNumber}">${list.name}</a>
							</td>
							<td>${list.postcode} &nbsp; ${tourbean.address1 }&nbsp;${tourbean.address2 }&nbsp;${tourbean.address3 }&nbsp;${tourbean.address4 } </td>
							<td>${list.summary}</td>
							<td>
								<fmt:parseDate var="dateFmt" value="${list.regdate}" pattern="yyyy-MM-dd"/>
								<fmt:formatDate var="registerDate" value="${dateFmt}" pattern="yyyy-MM-dd"/>
								${registerDate}
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
				
			</div>
				<!-- 후기 탭 :  사업자는 후기 보는 용도로만 사용(등록X) -->
				<div class="tab-pane fade" id="tab3" style="text-align: left;">
			    	<h3>관광지 후기</h3>
					<div class="marginPadding10">
						<table class="table table-bordered" style="margin-top: 3%;">
					<caption>레코드 총 갯수 : ${communityTotalCount}</caption>
					<thead>
						<tr class="active">
							<th width="6%">번호</th>
							<th>제목</th>
							<th>한줄요약</th>
							<th width="14%">등록일</th>
						</tr>
					</thead>
				
					<tbody>
						<!-- list가 없을 경우 -->
						<c:if test="${empty communityLists}">
						<tr>
							<td colspan="4" align="center"> 해당 후기 레코드가 없습니다.</td>
						</tr>
						</c:if>
						
						<c:forEach var="list" items="${communityLists}">
						<tr>
							<td>${list.rownum}</td>
							<td><a href="communityDetail.do?num=${list.num}&pageNumber=${communityPageInfo.pageNumber}&type=2">${list.title}</a></td> 
							<td>${list.summary}</td>
							<td>
								<fmt:parseDate var="dateFmt" value="${list.regdate}" pattern="yyyy-MM-dd"/>
								<fmt:formatDate var="registerDate" value="${dateFmt}" pattern="yyyy-MM-dd"/>
								${registerDate}
							</td> 
						</tr>
						</c:forEach>
					</tbody>
				
					</table>
			
					<!-- 페이징 -->
					<div class="paginationCenter" align="center">
						${communityPageInfo.pagingHtml}
					</div>
				</div>
			</div>
			
			<!-- 오시는 길 탭 -->
		    <div class="tab-pane fade" id="tab4" style="text-align: left;">
		      	<h3> 오시는 길</h3>
				<span>${tourbean.name } </span>
				<p>${fullAddr}</p>
					
				<div id="map" style="width:60%;height:350px; "></div>
			</div>
		</div>
		<hr>
	</div>
	</div>
	</form>
	
</div>  
</article>
</section>
<script>
	$('.carousel').carousel();
</script>
<%@ include file="../../../common/bottom.jsp" %>  

<!-- kakao api start -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoKey}"></script>
<!-- kakao api end --> 