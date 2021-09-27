<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>

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
	
	$("#metaTitle").attr("content", "캠핑 객실 등록");
	$("#metaDescription").attr("content", "캠핑 객실 등록");
	$("#metaKeywords").attr("content", "#캠핑리스트, #글램핑리스트, #캠핑 객실 등록");
	
  	//summernote 선언
	$('.summernote').summernote({
	 	height: 200,   //set editable area's height
	 	placeholder : "설명 입력해주세요.", //placeholder
	  	codemirror: { // codemirror options
	   		theme: 'monokai'
	  	}
	});
	
	//summernote 저장시 사용
	var save = function() {
	  	var markup = $('.click2edit').summernote('code');
	  	$('.click2edit').summernote('destroy');
	};
  	
	//지도를 생성합니다
	map = mapViewInit('map');
	
	//주소 값 내려서 받기.
	var fullAddr = "경기 가평군 북면 노씨터길 12"; //테스트 주소.
    var coordsLa = "127.536039129141"; //좌표값
    var coordsMa = "37.9501622932289"; //좌표값
    
    addSerach(fullAddr, coordsMa, coordsLa);
	
});

function addSerach(fullAddr, lat, lng) {
	
	var coords = new kakao.maps.LatLng(lat, lng);
	
	// 결과값으로 받은 위치를 마커로 표시합니다
    marker = mapViewSetMarker(map, coords, marker);
	
    var name = "야생화캠핑장" //캠핑장이름
	overlay = mapViewSetCustomOverlay(map, marker, name, fullAddr, overlay);

    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    map.setCenter(coords);
}

//커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}


//등록버튼 클릭시
function inputSave() {
	if (!confirm('등록 하시겠습니까?')){
		return false;
	}
	
	return true;	
}

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/sampleCampingList";
}

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">캠핑/글램핑 객실 등록 화면</h2></header>
	
	<form name="myForm" action="" method="post" enctype="multipart/form-data" class="form-horizontal">
	<table border="1" class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
		<tr>
			<td width="20%">
				<label for="name"><span class="redFont"> * </span> 캠핑장 이름 </label>
			</td>
			<td> 야생화캠핑장 </td>
			<td><label for="roomName"><span class="redFont"> * </span> 객실 명칭 </label> </td>
			<td>
				<input type="text" class="form-control" id="roomName" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="roomSummary"><span class="redFont"> * </span> 객실 설명 한줄요약 </label> </td>
			<td>
				<input type="text" class="form-control" id="roomSummary" name="" value="" placeholder="입력해주세요.">
			</td>
			<td><label for="amenuty"><span class="redFont"> * </span> 부대시설,비품 </label> </td>
			<td>
				<input type="text" class="form-control" id="amenuty" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="propguests"><span class="redFont"> * </span> 기준인원 </label> </td>
			<td>
				<input type="text" class="form-control" id="propguests" name="" value="" placeholder="입력해주세요.">
			</td>
			<td><label for="maxguests"><span class="redFont"> * </span> 최대인원</label> </td>
			<td>
				<input type="text" class="form-control" id="maxguests" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="startDate"><span class="redFont"> * </span> 예약 가능 시작일자 </label> </td>
			<td>
				<input type="date" class="form-control" id="startDate" name="" value="" placeholder="입력해주세요.">
			</td>
			<td><label for="endDate"><span class="redFont"> * </span> 예약 가능 끝일자  </label> </td>
			<td>
				<input type="date" class="form-control" id="endDate" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="weekdayprice"><span class="redFont"> * </span> 주중 가격</label> </td>
			<td>
				<input type="text" class="form-control" id="weekdayprice" name="" value="" placeholder="입력해주세요.">
			</td>
			<td><label for="weekendprice"><span class="redFont"> * </span> 주말 가격</label> </td>
			<td>
				<input type="text" class="form-control" id="weekendprice" name="" value="" placeholder="입력해주세요.">
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
			<td><label for="imgFile"><span class="redFont"> * </span> 대표 타이틀 이미지 </label> </td>
			<td colspan="3">
				<input type="file" class="" id="imgFile" name="" value="" accept="image/*" onchange="fileSelectChange(event);">
				<input type="hidden" class="" id="imgUrl" name="" value="">
			</td>
		</tr>
		<tr>
			<td><span class="redFont"> * </span> 내용</td>
			<td colspan="3">
				<textarea rows="10" cols="3"  class="form-control summernote" name=""></textarea>
			</td>
		</tr>
		<tr>
			<td><label for="regKeyword">등록 키워드</label></td>
			<td colspan="3">
				<input type="text" class="form-control" id="regKeyword" name="" value="" placeholder="#키워드,#입력해주세요.">
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				<input type="submit" class="btn btn-primary" value="등록" onclick="return inputSave()">
				<input type="reset" class="btn btn-default" value="다시작성">
				<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
			</td>
		</tr>
	</table>
	</form>
</div>  
</article>
</section>

<%@ include file="../../common/bottom.jsp" %>   

<!-- kakao api start -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoKey}"></script>
<!-- kakao api end -->
