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
    
    //달력 얻어오기. (달력 여러개 적용시 class에 주기)
    $( ".datepicker" ).datepicker({
	    "dateFormat" : "yy-mm-dd"
	});
    
    //아이콘 있는 달력.
    $( "#endDate" ).datepicker({
        showOn: "button",
        buttonImage: "${images}/calendar.ico",
        buttonImageOnly: true,
        buttonText: "Select date",
        "dateFormat" : "yy-mm-dd"
    });
    
    //승민님이 원하시는 달력이랑 비슷해보임요.. (getDate 호출)
    var dateFormat = "yy-mm-dd",
    from = $( "#from" )
      .datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 3,
        showOn: "button",
        buttonImage: "${images}/calendar.ico",
        buttonImageOnly: true,
        buttonText: "Select date",
        "dateFormat" : "yy-mm-dd"
      })
      .on( "change", function() {
        to.datepicker( "option", "minDate", getDate( this ) );
      }),
    to = $( "#to" ).datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 3,
      showOn: "button",
      buttonImage: "${images}/calendar.ico",
      buttonImageOnly: true,
      buttonText: "Select date",
      "dateFormat" : "yy-mm-dd"
    })
    .on( "change", function() {
      from.datepicker( "option", "maxDate", getDate( this ) );
    });
    
});

//달력
function getDate( element ) {
    var date;
    try {
      date = $.datepicker.parseDate( dateFormat, element.value );
    } catch( error ) {
      date = null;
    }

    return date;
  }

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



</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">달력예제</h2></header>
	
	<form name="myForm" action="" method="post" enctype="multipart/form-data" class="form-horizontal">
	<table border="1" class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
		
		<tr>
			<td><label for="startDate"><span class="redFont"> * </span> 예약 가능 시작일자 </label> </td>
			<td>
				<input type="text" class="form-control datepicker" id="startDate" name="" value="" placeholder="입력해주세요.">
			</td>
			<td><label for="endDate"><span class="redFont"> * </span> 예약 가능 끝일자  </label> </td>
			<td>
				<input type="text" class="form-date-control60" id="endDate" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		
		<tr>
			<td><label for="from">From</label></td>
			<td>
				<input type="text" class="form-date-control60" id="from" name="from">
			</td>
			<td><label for="to">to</label></td>
			<td><input type="text" class="form-date-control60" id="to" name="to"></td>
		</tr>
		
		<!-- 충돌나는지 확인 여부때문에 .. 같이 둠. -->
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
			<td><span class="redFont"> * </span> 내용</td>
			<td colspan="3">
				<textarea rows="10" cols="3"  class="form-control summernote" name=""></textarea>
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
