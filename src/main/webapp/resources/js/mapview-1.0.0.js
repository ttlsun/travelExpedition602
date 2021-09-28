/**
카카오 라이브러리 사용을 위해 jsp 소스 하단에 아래내용 추가

<!-- kakao api start -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoKey}"></script>
<!-- kakao api end -->
 */

/**
 * 주소를 받아 좌표를 리턴
 * @param geocode 주소-좌표 변환 객체를 생성합니다
 * @param fullAddress 검색할 전체 주소
 */
function mapViewAddressPositionSearch(fullAddress, callback) {
	// 주소-좌표 변환 객체를 생성
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색
	geocoder.addressSearch(fullAddress, function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			callback(coords);
		} else {
			callback(null);
		}
	});
}

function mapViewAddressSearchPopupOpen(elementId, callback) {
	new daum.Postcode({
		oncomplete: function(data) {
			var fullAddr = "";
			
			// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져오기.
			if (data.userSelectedType == 'R') { // 사용자가 도로명 주소를 선택했을 경우
				fullAddr = data.roadAddress; //도로명 fullAddr
				if (fullAddr == ""){
					fullAddr = data.autoJibunAddress.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
				}
			} else { // 사용자가 지번 주소를 선택했을 경우
				fullAddr = data.jibunAddress.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
			}

			data.fullAddr = fullAddr;
			
			//console.log(data);
			
			callback(data);
		},
		width : '100%',
		height : '65%'
	}).embed(document.getElementById(elementId));
}

function mapViewInit(elementId) {
	var container = document.getElementById(elementId);
	
    var option = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };
	
	//지도를 생성합니다
	return new kakao.maps.Map(container, option);
}

function mapViewAddMarker(map, coords) {
	return new kakao.maps.Marker({
        map: map,
        position: coords
    });
}

function mapViewSetMarker(map, coords, marker) {
	// 기존에 있던 마커 제거
	if (marker != null)
		marker.setMap(null);

	return new kakao.maps.Marker({
        map: map,
        position: coords
    });
}

function mapViewAddCustomOverlay(map, marker, titleName, fullAddress, contentText=mapViewCustomOverlayContentText(titleName, fullAddress)) {
	return new kakao.maps.CustomOverlay({
        content: contentText,
        map: map,
        position: marker.getPosition()
    });
}

function mapViewSetCustomOverlay(map, marker, titleName, fullAddress, overlay, contentText=mapViewCustomOverlayContentText(titleName, fullAddress)) {
	// 기존에 있던 말풍선 제거
	if (overlay != null)
		overlay.setMap(null);
		
	return new kakao.maps.CustomOverlay({
        content: contentText,
        map: map,
        position: marker.getPosition()
    });
}

function mapViewCustomOverlayContentText(titleName, fullAddress) {
	return '<div class="wrap">' + 
        '    <div class="info">' + 
        '        <div class="title">'+titleName+ 
        '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
        '        </div>' + 
        '        <div class="body">' + 
        '            <div class="img">' +
        '                <img src="resources/images/travelExpeditionIicon.JPG" id="mapPositionIcon"  width="73" height="70">' +
        '           </div>' + 
        '            <div class="desc">' + 
        '                <div class="ellipsis">'+fullAddress+'</div>' + 
       /*  '                <div><a href="https://map.kakao.com/link/map/'+name+','+coords.Ma+','+coords.La+'" target="_blank" class="link">길찾기</a></div>' +  */
        '                <div><a href="https://map.kakao.com/?q='+fullAddress+'" target="_blank" class="link">길찾기</a></div>' + 
        '            </div>' + 
        '        </div>' + 
        '    </div>' +    
        '</div>';
}