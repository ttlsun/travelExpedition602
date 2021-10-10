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
	
  	//모달로 우편번호 띄우기.
  	$('#searchZip').click(function(){
  		addrKakao();
  	});

	//지도를 생성합니다
	map = mapViewInit('map');
	
});

function addSerach(fullAddr) {
	mapViewAddressPositionSearch(fullAddr, function(coords) {
		if (coords == null)
			return;
		
        // 결과값으로 받은 위치를 마커로 표시합니다
        marker = mapViewSetMarker(map, coords, marker);

        
        var coordsLa = coords.La;
        var coordsMa = coords.Ma;

        //console.log(coordsLa+","+coordsMa);
      	//좌표값 내려주기
        $('#coordsLa').val(coordsLa);
        $('#coordsMa').val(coordsMa);

        //이름
        var name = "지도 타이틀 이름";
        
        overlay = mapViewSetCustomOverlay(map, marker, name, fullAddr, overlay);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
	});
}

//커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}

function addrKakao() {
	
	//상세주소 텍스트 초기화
	$('#fullAddr').html("");
	
	mapViewAddressSearchPopupOpen('popup_type_kakaoAddr', function(data) {
		
		//주소 값 넣기.
		$('input[name="zip_code"]').val(data.zonecode);
		$('input[name="address1"]').val(data.sido);
		$('input[name="address2"]').val(data.sigungu);
		
		var roadAddressAddr = data.roadAddressEnglish.split(",");
		var autoJibunAddr = data.jibunAddressEnglish.split(",");
		
		//상세주소를 남기고 주소에 넣기.
		var addr3 = data.userSelectedType == 'R' ? data.bname1 + " "+ data.roadname+" " + roadAddressAddr[0] : data.bname1 + " " +data.bname +" " + autoJibunAddr[0];
		$('input[name="address3"]').val(addr3);
		
		// (이건 이슈가 있네요.. 몇개 들이 중간에 동이 안들감요..)
		//var addr3 = data.bname1 ;
		//var addr4 = data.userSelectedType == 'R' ? data.roadname+" " + roadAddressAddr[0] : data.bname +" " + autoJibunAddr[0];
		//$('input[name="address3"]').val(addr3); //북면
		//$('input[name="address4"]').val(addr4); //노씨터길 12
		
		
		// 확정인듯요.
		//var addr3 = data.userSelectedType == 'R' ? data.bname1 +" " + data.roadname : data.bname1 +" " + data.bname;
		//var addr4 = data.userSelectedType == 'R' ? roadAddressAddr[0] : autoJibunAddr[0];
		//$('input[name="address3"]').val(addr3); //북면 노씨터길
		//$('input[name="address4"]').val(addr4); //12
		
		
		$('#fullAddr').html(data.fullAddr);
		
		//창 닫기.
		$('#myModal').modal('hide');
		
		//지도 마크업 찍기.
		addSerach(data.fullAddr);
	});
}

// 이미지 파일 선택시 지도 말풍선 이미지 변경
function fileSelectChange(event) {
	var reader = new FileReader();
	reader.onload = function(event) {
		var img = document.querySelector("img#mapPositionIcon");
		if (img != undefined) {
			img.setAttribute("src", event.target.result);
		}
	};
	reader.readAsDataURL(event.target.files[0]);
}
</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">지도관련 샘플</h2></header>
	
	<form name="myForm" action="" method="post" class="form-horizontal">
	<table border="1" class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
		<tr>
			<td style="border-bottom: none;" width="10%">
				<label for="searchZip"><span class="redFont"> * </span> 주소</label>
			</td>
			<td colspan="3" style="border-bottom: none; border-right: none; border-left: none;">
				<input type="text" disabled="disabled" class="form-control40" name="zip_code" id="zipcodeView" placeholder="우편번호 입력">
				<input type="hidden" id="zipcode" name="zip_code">
				<input type="button" class="btn btn-primary" id="searchZip" value="우편번호찾기"  data-toggle="modal" data-target="#myModal">
			</td>
		</tr>
		<tr>
			<td rowspan="1" style="border-top: none; border-left: none; border-bottom: none;"></td>
			<td colspan="3" style="border-top: none; border-left: none; border-bottom: none;">
				<label style="padding-bottom: 3%;">
					<input type="text" class="form-control40" id="address1" name="address1" placeholder="시" readonly="readonly">
					<input type="text" class="form-control40" id="address2" name="address2" placeholder="구" readonly="readonly">
					<input type="text" class="form-control40" id="address3" name="address3" placeholder="동" readonly="readonly">
					<input type="text" class="form-control40" id="address4" name="address4" placeholder="상세주소 입력">
					
					<input type="text" class="form-control40" id="coordsMa" name="" placeholder="좌표Ma">
					<input type="text" class="form-control40" id="coordsLa" name="" placeholder="좌표La">
					
				</label>
				
				<span id="fullAddr" style="display: inline-block;"></span>
				<div id="map" style="width:100%;height:350px; "></div>
				
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

<!-- 우편번호 modal 시작 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel"> 우편번호 검색 </h4>
      </div>
      
      <div class="modal-body">
      
      	<!-- kakao api 노출영역 -->
		<div id="popup_type_kakaoAddr" style="position:relative; margint:20px; overflow:hidden;"></div>
		<!-- kakao api 노출영역 -->
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
      
    </div> <!-- 모달 콘텐츠 -->
  </div> <!-- 모달 다이얼로그 -->
</div> <!-- 모달 전체 윈도우 -->
<!-- //우편번호 modal 시작 -->

<%@ include file="../../common/bottom.jsp" %>   

<!-- kakao api start -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoKey}"></script>
<!-- kakao api end -->
