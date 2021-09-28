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
	
	$("#metaTitle").attr("content", "캠핑 등록");
	$("#metaDescription").attr("content", "캠핑 등록");
	$("#metaKeywords").attr("content", "#캠핑리스트, #글램핑리스트, #캠핑등록");
	
  	//모달로 우편번호 띄우기.
  	$('#searchZip').click(function(){
  		addrKakao();
  	});
  	
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
	
	//테마 샐랙트 박스 셋팅.
	selThemeInit();
});
//테마 샐랙트 박스 셋팅
function selThemeInit() {

	$("#theme").append(new Option("전체 테마", ""));
	
	$.each(selThemeArr, function (i, item) {
	    $('#theme').append($('<option>', {
	        value: selThemeArr[i],
	        text : selThemeArr[i]
	    }));
	});
	
}


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

        //캠핑장 이름
        var name = $('#name').val();
        if(name == ""){
        	name = "캠핑장";
        }
        
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
		$('input[name="address3"]').val(data.userSelectedType == 'R' ? data.roadname : data.bname);
		
		$('#fullAddr').html(data.fullAddr);
		
		//창 닫기.
		$('#myModal').modal('hide');
		
		//지도 마크업 찍기.
		addSerach(data.fullAddr);
	});
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
	<header><h2 align="center" class="text-primary">캠핑/글램핑 등록 화면</h2></header>
	
	<form name="myForm" action="" method="post" enctype="multipart/form-data" class="form-horizontal">
	<table border="1" class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
		<tr>
			<td width="15%">
				<label for="name"><span class="redFont"> * </span> 캠핑장 이름 </label>
			</td>
			<td>
				<input type="text" class="form-control" id="name" name="" value="" placeholder="입력해주세요.">
			</td>
			<td width="15%">
				<label for="summary"><span class="redFont"> * </span> 한줄 요약</label>
			</td>
			<td>
				<input type="text" class="form-control" id="summary" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="reviewDivision"><span class="redFont"> * </span> 캠핑 구분 </label> </td>
			<td>
				<select class="form-control" name="" id="" >
					<option value="01">일반야영장</option>
					<option value="02">자동차캠핑장</option>
					<option value="03">글램핑</option>
					<option value="04">카라반</option>
					<option value="05">이지캠핑</option>
				</select>
			</td>
			<td><label for="reviewDivision"><span class="redFont"> * </span> 테마별 </label> </td>
			<td>
				<select class="form-control" id="theme" name="" >
				</select>
			</td>
		</tr>
		<tr>
			<td style="border-bottom: none;">
				<label for="searchZip"><span class="redFont"> * </span> 캠핑장 주소</label>
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
					
					<input type="hidden" class="form-control40" id="coordsMa" name="" placeholder="좌표Ma">
					<input type="hidden" class="form-control40" id="coordsLa" name="" placeholder="좌표La">
					
				</label>
				
				<span id="fullAddr" style="display: inline-block;"></span>
				<div id="map" style="width:100%;height:350px; "></div>
				
			</td>
		</tr>
		<tr>
			<td>
				<label for="contact"><span class="redFont"> * </span> 캠핑장 연락처 </label>
			</td>
			<td>
				<input type="text" class="form-control" id="contact" name="contact" value="" placeholder="입력해주세요.">
			</td>
			<td><label for="amenuty"><span class="redFont"> * </span> 부대시설,비품 </label> </td>
			<td>
				<input type="text" class="form-control" id="amenuty" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="imgFile"><span class="redFont"> * </span> 대표 타이틀 이미지 </label> </td>
			<td colspan="3">
				<input type="file" name="imgFile" value="" accept=".jpg, .jpeg, .png, .gif">
			</td>
		</tr>
		<tr>
			<td><label for="multipleImgFile"><span class="redFont"> * </span> 근처 캠핑 이미지들(여러장 올리기) </label> </td>
			<td colspan="3">
				<input type="file" multiple name="multipleImgFile" value="" accept=".jpg, .jpeg, .png, .gif">
				<input type="hidden" class="" id="multipleImgFileNum" name="" value="">
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
