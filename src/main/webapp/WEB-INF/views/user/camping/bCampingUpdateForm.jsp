<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../common/top.jsp" %>   

<style type="text/css">
	th{
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
	navActive('bCamping');
	
	$("#metaTitle").attr("content", "캠핑 수정");
	$("#metaDescription").attr("content", "캠핑 수정");
	$("#metaKeywords").attr("content", "#캠핑리스트, #글램핑리스트, #캠핑수정");
	
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

function addSearch(fullAddr) {
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
	      
	var roadAddressAddr = data.roadAddressEnglish.split(",");
	var autoJibunAddr = data.jibunAddressEnglish.split(",");
	
	//주소 값 넣기
	var addr3 = data.userSelectedType == 'R' ? data.bname1 +" " + data.roadname : data.bname1 +" " + data.bname;
	var addr4 = data.userSelectedType == 'R' ? roadAddressAddr[0] : autoJibunAddr[0];
	$('input[name="postcode"]').val(data.zonecode);
	$('input[name="address1"]').val(data.sido);
	$('input[name="address2"]').val(data.sigungu);
	$('input[name="address3"]').val(addr3); 
	$('input[name="address4"]').val(addr4);
	      
	$('#fullAddr').html(data.fullAddr);
	      
	//창 닫기.
	$('#myModal').modal('hide');
	      
	//지도 마크업 찍기.
	addSearch(data.fullAddr);
	
	});
}

//등록버튼 클릭시
function inputSave() {
	if (!confirm('수정하시겠습니까?')){
		return false;
	}
	
	return true;	
}

//리스트 버튼 클릭시
function goDetail(num,pageNumber) {
	location.href= "${contextPath}/bCampingDetail.do?num="+num+"&pageNumber="+pageNumber;
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
	<div class="marginPadding10">
		<input type="button" style="float: left" class="btn btn-default" value="돌아가기" onclick="goDetail(${camping.num},${pageNumber })">
	</div>	
	<header><h2 align="center" class="text-primary">캠핑장 수정</h2></header>
	
	<form:form name="myForm" commandName="camping" action="${contextPath}/bCampingUpdate.do" method="post" enctype="multipart/form-data" class="form-horizontal">
	<input type="hidden" name="pageNumber" value="${pageNumber}">
	<input type="hidden" name="num" value="${camping.num}">
	<input type="hidden" name="modid" value="${userid}">
	<table border="1" class="table table-bordered">
		<caption>
			<span class="redFont">* </span>표시는 필수 입력사항입니다.
		</caption>
		<tr>
			<th width="15%"><label for="name"><span class="redFont"> * </span> 캠핑장 이름 </label></th>
			<td width="85%">
				<input type="text" class="form-control" id="name" name="name" value="${camping.name }" placeholder="캠핑장의 정확한 상호명을 적어주세요.">
				<form:errors cssClass="errMessage" path="name"/>
			</td>
		</tr>
		<tr>
			<th><label for="camptype1"><span class="redFont"> * </span> 캠핑장 유형 </label></th>
			<td>
				<p><span class="redFont">해당되는 유형을 모두 선택해주세요.</span></p>
				<label for="camptype1">
				<input type="checkbox" id="camptype1" name="camptype" value="01" 
					<c:if test="${fn:contains(camping.camptype,'01')}"> checked</c:if>>&nbsp;일반캠핑장&nbsp;
				</label>
				<label for="camptype2">
				<input type="checkbox" id="camptype2" name="camptype" value="02" 
					<c:if test="${fn:contains(camping.camptype,'02')}"> checked</c:if>>&nbsp;자동차캠핑장&nbsp;
				</label>
				<label for="camptype3">
				<input type="checkbox" id="camptype3" name="camptype" value="03" 
					<c:if test="${fn:contains(camping.camptype,'03')}"> checked</c:if>>&nbsp;글램핑&nbsp;
				</label>
				<label for="camptype4">
				<input type="checkbox" id="camptype4" name="camptype" value="04" 
					<c:if test="${fn:contains(camping.camptype,'04')}"> checked</c:if>>&nbsp;카라반&nbsp;
				</label>
				<form:errors cssClass="errMessage" path="camptype"/>
			</td>
		</tr>
		<tr>
			<th><label for="themecode1"><span class="redFont"> * </span> 캠핑장 테마 </label></th>
			<td>
				<label for="themecode1">
				<input type="radio" id="themecode1" name="themecode" value="01"
					<c:if test="${camping.themecode eq '01'}"> checked</c:if>>&nbsp;숲/산&nbsp;
				</label>
				<label for="themecode2">
				<input type="radio" id="themecode2" name="themecode" value="02"
					<c:if test="${camping.themecode eq '02'}"> checked</c:if>>&nbsp;해변/바다&nbsp;
				</label>
				<label for="themecode3">
				<input type="radio" id="themecode3" name="themecode" value="03"
					<c:if test="${camping.themecode eq '03'}"> checked</c:if>>&nbsp;강/호수/계곡&nbsp;
				</label>
				<label for="themecode4">
				<input type="radio" id="themecode4" name="themecode" value="04"
					<c:if test="${camping.themecode eq '04'}"> checked</c:if>>&nbsp;도심&nbsp;
				</label>
				<label for="themecode5">
				<input type="radio" id="themecode5" name="themecode" value="05"
					<c:if test="${camping.themecode eq '05'}"> checked</c:if>>&nbsp;섬&nbsp;
				</label>
				<form:errors cssClass="errMessage" path="themecode"/>
			</td>
		</tr>
		<tr>
			<th><label for="summary"><span class="redFont"> * </span> 한줄 소개글 </label></th>
			<td>
				<input type="text" class="form-control" id="summary" name="summary" value="${camping.summary }" placeholder="목록 외부에 노출됩니다. ex) 숲 속 힐링캠프, 글램퍼스 양평점입니다.">
				<form:errors cssClass="errMessage" path="summary"/>
			</td>
		</tr>
		<tr>
			<th><label for="regkeywords_0"> 우리 캠핑장의 키워드(#) </label></th>
			<td>
				<p><span class="redFont"> 검색에 활용됩니다. 최대 5개까지만 골라주세요. </span></p>
				<c:forEach items="${keywordLists}" var="keywordList" varStatus="status">
					<label for="regkeywords_${status.index}" style="color: #337ab7;">
						&nbsp;
						<input type="checkbox" name="regkeyword" id="regkeywords_${status.index}" value="${keywordList.tag}"
							<c:if test="${fn:contains(camping.regkeyword,keywordList.tag) }">checked</c:if>> ${keywordList.tag}
					</label>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th><label for="options"> 캠핑장 시설 정보 </label></th>
			<td>
				<input type="text" class="form-control" id="options" name="options" value="${camping.options }" placeholder="캠핑장 시설 정보를 입력하세요.">
			</td>
		</tr>
		<tr>
			<th style="border-bottom: none;">
				<label for="searchZip"><span class="redFont"> * </span> 캠핑장 주소 </label>
			</th>
			<td colspan="3" style="border-bottom: none; border-right: none; border-left: none;">
				<input type="text" disabled="disabled" class="form-control40" name="postcode" id="postcodeView" value="${camping.postcode }" placeholder="우편번호 입력">
				<input type="hidden" id="postcode" name="postcode" value="${camping.postcode }">
				<input type="button" class="btn btn-primary" id="searchZip" value="우편번호찾기"  data-toggle="modal" data-target="#myModal">
			</td>
		</tr>
		<tr>
			<td rowspan="1" style="border-top: none; border-left: none; border-bottom: none;"></td>
			<td colspan="3" style="border-top: none; border-left: none; border-bottom: none;">
				<label style="padding-bottom: 3%;">
					<input type="text" class="form-control40" id="address1" name="address1" value="${camping.address1 }" placeholder="시" readonly="readonly">
					<form:errors cssClass="errMessage" path="address1"/>
					<input type="text" class="form-control40" id="address2" name="address2" value="${camping.address2 }" placeholder="구" readonly="readonly">
					<form:errors cssClass="errMessage" path="address2"/>
					<input type="text" class="form-control40" id="address3" name="address3" value="${camping.address3 }" placeholder="동" readonly="readonly">
					<form:errors cssClass="errMessage" path="address3"/>
					<input type="text" class="form-control40" id="address4" name="address4" value="${camping.address4 }" placeholder="상세주소 입력">
					<form:errors cssClass="errMessage" path="address4"/>
					
					<input type="hidden" class="form-control40" id="coordsMa" name="longitude" placeholder="좌표Ma" value="${camping.longitude }">
					<input type="hidden" class="form-control40" id="coordsLa" name="latitude" placeholder="좌표La" value="${camping.latitude }">
				</label>
				
				<span id="fullAddr" style="display: inline-block;"></span>
				<div id="map" style="width:100%;height:350px; "></div>
				
			</td>
		</tr>
		<tr>
			<th><label for="contact"><span class="redFont"> * </span> 캠핑장 연락처 </label></th>
			<td>
				<input type="text" class="form-control" id="contact" name="contact" value="${camping.contact }" placeholder="고객과 소통할 수 있는 연락처를 적어주세요.">
				<form:errors cssClass="errMessage" path="contact"/>
			</td>
		</tr>
		<tr>
			<th><label for="imgFile"><span class="redFont"> * </span> 대표 이미지 </label></th>
			<td>
				<div class="rounded">
					<img src="${fileImg}/${originImgUrl} " style="height:10%; width: 30%;">
				</div>
				<input type="file" id="imgFile" name="updateFile" value="${camping.imgurl}" accept=".jpg, .jpeg, .png, .gif">
				<input type="hidden" name="imgurl" value="${camping.imgurl}">
				<input type="hidden" name="originImgUrl" id="originImgUrl" value="${originImgUrl}">
				<form:errors cssClass="errMessage" path="updateFile"/>
			</td>
		</tr>
		<tr>
			<th><label for="contents">상세 소개글 </label></th>
			<td colspan="3">
				<textarea rows="10" cols="3" id="contents" class="form-control summernote" name="contents">${camping.contents }</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" class="btn btn-default" value="돌아가기" onclick="goDetail(${camping.num},${pageNumber })">	
				<input type="reset" class="btn btn-default" value="다시작성">
				<input type="submit" class="btn btn-primary" value="수정" onclick="return inputSave()">
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