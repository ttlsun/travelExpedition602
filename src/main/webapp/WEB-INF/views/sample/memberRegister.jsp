<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<!-- 주소 관련 js -->
<script src="${js}/mapview-1.0.0.js"></script>
<!-- //주소 관련 js -->

<script type="text/javascript" >

$(document).ready(function(){
	//메뉴 on 유지.
	navActive('member');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "회원가입");
	$("#metaDescription").attr("content", "회원가입");
	$("#metaKeywords").attr("content", "#여행자들602호 회원가입");
	
	//모달로 우편번호 띄우기.
  	$('#searchZip').click(function(){
  		addrKakao();
  	});
	
	//회원 사용자 구분 select 박스 (change)
	$('#memberType').on('change', function () {
		var selectVal = $("#memberType option:selected").val();
		//사업장이면 주소 입력창 보이게 처리. (01 : 회원 / 02: 사업장)
		if(selectVal == "02"){
			$('#memberTypeTr1, #memberTypeTr2, #memberTypeTr3').show();
		}else{
			$('#memberTypeTr1, #memberTypeTr2, #memberTypeTr3').hide();
		}
	});
});


function addrKakao() {
	
	//상세주소 텍스트 초기화
	$('#address1,#zipCode').val("");
	
	mapViewAddressSearchPopupOpen('popup_type_kakaoAddr', function(data) {
		
		//주소 값 넣기.
		$('#zipCode').val(data.zonecode);
		$('#address1').val(data.fullAddr);
		
		//창 닫기.
		$('#myModal').modal('hide');
		
	});
}

function inputSave() {
	if (!confirm('등록 하시겠습니까?')){
		return false;
	}
	
	return true;
	
}

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 회원가입 </h2></header>
	
	<form name="myForm" action="" method="post" class="form-horizontal">
	<table class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
		<tr>
			<td width="20%"><label for="id"><span class="redFont"> * </span>아이디 </label> </td>
			<td width="30%">
				<input type="text" class="form-control" id="id" name="id" value="" placeholder="입력해주세요.">
			</td>
			<td width="20%"><label for="name"><span class="redFont"> * </span> 이름</label> </td>
			<td>
				<input type="text" class="form-control" id="name" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="password"><span class="redFont"> * </span> 비번 </label> </td>
			<td>
				<input type="text" class="form-control" id="password" name="" value="" placeholder="입력해주세요.">
			</td>
			<td><label for="rePassword"><span class="redFont"> * </span> 비번 재확인 </label> </td>
			<td>
				<input type="text" class="form-control" id="rePassword" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="memberType"><span class="redFont"> * </span>회원구분</label> </td>
			<td colspan="3">
				<!-- 관리자는 DB에서 insert -->
				<select name="" class="form-control" id="memberType">
					<option value="01">일반회원</option>
					<option value="02">사업자 회원</option>
				</select>
			</td>
		</tr>
		<tr id="memberTypeTr1" style="border-bottom: none; display: none;">
			<td style="border-bottom: none;">
				<label for="searchZip"><span class="redFont"> * </span> 사업장 주소</label>
			</td>
			<td style="border: none;">
				<input type="text" class="form-control40" id="zipCode" name="" readonly="readonly" placeholder="우편번호 입력">
				<input type="button" class="btn btn-primary" id="searchZip" value="우편번호찾기"  data-toggle="modal" data-target="#myModal">
			</td>
			<td>
				<input type="text" style="background-color:white;" class="form-control" id="address1" name="" value="" placeholder="사업장 주소." readonly="readonly">
			</td>
			<td>
				<input type="text" class="form-control" id="address2" name="" value="" placeholder="상세주소 입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="phone"><span class="redFont"> * </span> 핸드폰번호 </label> </td>
			<td>
				<input type="text" class="form-control" id="phone" name="" value="" placeholder="입력해주세요.">
			</td>
			<td><label for="email"><span class="redFont"> * </span> 이메일 </label> </td>
			<td>
				<input type="text" class="form-control" id="email" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				<input type="submit" class="btn btn-primary" value="등록" onclick="return inputSave()">
				<input type="reset" class="btn btn-default" value="다시작성">
				<input type="button" class="btn btn-primary" value="목록보기">
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
   