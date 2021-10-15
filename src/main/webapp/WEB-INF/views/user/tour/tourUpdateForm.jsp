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
	navActive('camping');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관광지");
	$("#metaDescription").attr("content", "관광지 수정");
	$("#metaKeywords").attr("content", "#여행자들602호 관광지 등록,#관광지,#수정");
	
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
        
        //관광지 이름
        var name = $('#name').val();
        if(name == ""){
        	name = "관광지";
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
		$('input[name="postcode"]').val(data.zonecode);
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
	if (!confirm('수정 하시겠습니까? 관광지 리스트로 이동합니다.')){
		return false;
	}
	
	return true;	
}

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/tourList.do?pageNumber="+pageNumber;
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
	<header><h2 align="center" class="text-primary">관광지 수정 화면</h2></header>
	
	<form:form name="myForm" commandName="tour" action="${contextPath}/tourUpdate.do" method="post" enctype="multipart/form-data" class="form-horizontal">
	<input type="text" name="pageNumber" value="${pageNumber}">
	<input type="text" name="num" value="${tour.num}">
	<input type="text" name="modid" value="${userId}"> 
	<table border="1" class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
		<tr>
			<td width="20%">
				<label for="name"><span class="redFont"> * </span> 관광지 이름 </label>
			</td>
			<td colspan="3">
				<input type="text" class="form-control" id="name" name="name" value="${tour.name}" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for=themecode><span class="redFont"> * </span> 관광지 테마 </label> </td>
			<td colspan="3">
				<input type="radio" id="themecode" name="themecode" value="01"
					<c:if test="${tour.themecode eq '01'}"> checked</c:if>>&nbsp;베스트&nbsp;
				<input type="radio" id="themecode" name="themecode" value="02"
					<c:if test="${tour.themecode eq '02'}"> checked</c:if>>&nbsp;제주여행&nbsp;
				<input type="radio" id="themecode" name="themecode" value="03"
					<c:if test="${tour.themecode eq '03'}"> checked</c:if>>&nbsp;내륙여행&nbsp;
				<input type="radio" id="themecode" name="themecode" value="04"
					<c:if test="${tour.themecode eq '04'}"> checked</c:if>>&nbsp;섬여행&nbsp;
				<form:errors cssClass="errMessage" path="themecode"/>
			</td>
		</tr>
		<tr>
			<td><label for="discount"><span class="redFont"> * </span> 할인가</label> </td>
			<td>
				<input type="text" class="form-control" id="discount" name="discount" value="${tour.discount }" placeholder=" 할인율을 입력해주세요.">
			</td>
			<td><label for="price"><span class="redFont"> * </span> 가격 </label> </td>
			<td>
				<input type="text" class="form-control" id="price" name="price" value="${tour.price }" placeholder="가격을 입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="summary"> 한줄 소개글 <span class="redFont"> * </span></label></td>
			<td colspan="3">
				<input type="text" class="form-control" id="summary" name="summary" value="${tour.summary }" placeholder="목록 외부에 노출됩니다.">
			</td>
		</tr>
		
		<!-- 키워드(#) 코드와 문자열 연결하여 배열로 만들것 -->
		<tr>
			<td><label for="regkeywords_0"> 관광지 관련 키워드(#) </label></td>
			<td colspan="3">
				<p><span class="redFont"> 검색에 활용됩니다. 최대 5개까지만 골라주세요. </span></p>
				
				<c:forEach items="${keywordLists}" var="keywordList" varStatus="status">
					<label for="regkeywords_${status.index}" style="color: #337ab7;">
						&nbsp;
						<input type="checkbox" name="regkeyword" id="regkeywords_${status.index}" value="${keywordList.tag}"
							<c:if test="${fn:contains(tour.regkeyword,keywordList.tag)}"> checked</c:if>> ${keywordList.tag} 	
					</label>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td style="border-bottom: none;">
				<label for="searchZip"><span class="redFont"> * </span> 관광지 주소</label>
			</td>
			<td colspan="3" style="border-bottom: none; border-right: none; border-left: none;">
				<input type="text" disabled="disabled" class="form-control40" name="postcode" id="postcodeView" value="${tour.postcode }" placeholder="우편번호 입력">
				<input type="hidden" id="zipcode" name="zip_code">
				<input type="button" class="btn btn-primary" id="searchZip" value="우편번호찾기"  data-toggle="modal" data-target="#myModal">
			</td>
		</tr>
		<tr>
			<td rowspan="1" style="border-top: none; border-left: none; border-bottom: none;"></td>
			<td colspan="3" style="border-top: none; border-left: none; border-bottom: none;">
				<label style="padding-bottom: 3%;">
					<input type="text" class="form-control40" id="address1" name="address1" value="${tour.address1 }" placeholder="시" readonly="readonly">
					<form:errors cssClass="errMessage" path="address1"/>
					<input type="text" class="form-control40" id="address2" name="address2" value="${tour.address2 }" placeholder="구" readonly="readonly">
					<form:errors cssClass="errMessage" path="address2"/>
					<input type="text" class="form-control40" id="address3" name="address3" value="${tour.address3 }" placeholder="동" readonly="readonly">
					<form:errors cssClass="errMessage" path="address3"/>
					<input type="text" class="form-control40" id="address4" name="address4" value="${tour.address4 }" placeholder="상세주소 입력">
					<form:errors cssClass="errMessage" path="address4"/>
					
					<input type="text" class="form-control40" id="coordsMa" name="longitude" value="${tour.longitude}" placeholder="좌표Ma">
					<input type="text" class="form-control40" id="coordsLa" name="latitude" value="${tour.latitude}" placeholder="좌표La">
					
				</label>
				
				<span id="fullAddr" style="display: inline-block;"></span>
				<div id="map" style="width:100%;height:350px; "></div> 
				
			</td>
		</tr>
		<tr>
			<td width="20%">
				<label for="contact"><span class="redFont"> * </span> 관광지 연락처 </label>
			</td>
			<td colspan="3">
				<input type="text" class="form-control" id="contact" name="contact" value="${tour.contact }" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="imgFile">대표 타이틀 이미지 </label> </td>
			<td colspan="3">
				<div class="rounded">
					<img src="${fileImg}/${originImgUrl} " style="height:10%; width: 30%;">
				</div>
				<input type="file" id="imgFile" name="updateFile" value="" accept=".jpg, .jpeg, .png, .gif">
				<input type="hidden" name="imgurl" value="${tour.imgurl}">
				<input type="hidden" name="originImgUrl" id="originImgUrl" value="${originImgUrl}">
				<form:errors cssClass="errMessage" path="imgurl"/>
			</td>
		</tr>
		<tr>
			<td><label for="multipleImgFile">관광지<br>상세 이미지 </label> </td>
			<td colspan="3">
				<c:if test="${!empty imgList}">
				<div class="rounded">
					<table>
						<c:forEach var="listRow" items="${imgList}" varStatus="vsRow" step="5">
						<tr>
							<c:forEach var="listCell" items="${imgList}" varStatus="vsCell" begin="${vsRow.index}" end="${vsRow.count*5-1}">
							<td align="center" class="col-xs-12 col-sm-6 col-md-3" width="20%">
								<img src="${fileImg}/${listCell.imgname}" style="width:100%; margin: 0px auto;" alt="${listCell.imgname} 이미지" title="${listCell.imgname} 이미지" >
							</td>
							</c:forEach>
						</tr>
						</c:forEach>
					</table>
			  	</div>
				</c:if>
				<input type="file" multiple id="multipleImgFile" name="multipleUpdateFile" value="" accept=".jpg, .jpeg, .png, .gif">
			</td>
		</tr>
		<tr>
			<td><span class="redFont"> * </span> 내용</td>
			<td colspan="3">
				<textarea rows="10" cols="3"  class="form-control summernote" name="contents">${tour.contents }</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				<input type="submit" class="btn btn-primary" value="수정" onclick="return inputSave()">
				<input type="reset" class="btn btn-default" value="다시작성">
				<input type="button" class="btn btn-primary" value="돌아가기" onclick="goDetail(${tour.num},${pageNumber })">
			</td>
		</tr>
	</table>
	</form:form>
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

<%@ include file="../../../common/bottom.jsp" %>   


<!-- kakao api start -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoKey}"></script>
<!-- kakao api end -->