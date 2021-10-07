<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- registerForm.jsp -->
<!-- 관리자 : DB 직접 insert/ 그외 사용자 : 우편번호+주소X(개인회원), 성별(기업회원) 외 공통-->

<!-- WEB-INF/common/top.jsp -->
<!-- init.jsp 포함됨 -->
<%@ include file="../../../common/top.jsp"%>

<!-- 주소 관련 js -->
<script src="${js}/mapview-1.0.0.js"></script>
<script type="text/javascript">
	var use1 = "";
	var isIdCheck = false;
	var isIdChange = false;
	var use2 = "";
	var isEmailCheck = false;
	var isEmailChange = false;
	
	$(document).ready(function() {
		//메뉴 on 유지.
		navActive('member');

		//메타태그 설정.
		$("#metaTitle").attr("content", "회원가입");
		$("#metaDescription").attr("content", "회원가입");
		$("#metaKeywords").attr("content", "#여행자들602호 회원가입");

		//모달로 우편번호 띄우기.
		$('#searchPostcode').click(function() {
			addrKakao();
		});

		//회원 사용자 구분 select 박스 (change)
		$('#ucode').on('change', function() {
			var selectVal = $("#ucode option:selected").val();
			// customer : 회원 / business : 사업자
			// ucodeCustomer1 : 개인회원이면 colspan="3" 지우고 width="30%"
			// ucodeCustomer2 : 개인회원 show 사업자 hide
			// ucodeBusiness1 : 사업자 show 개인회원 hide
			if (selectVal == "customer") { // 개인회원
				$('#ucodeBusiness1').hide();
				$('#ucodeCustomer2').show();
				$('#ucodeCustomer2_2').show();
				
				$('#ucodeCustomer1').attr('colspan', ''); //css로 하면 테이블 모양 깨짐
				$('#ucodeCustomer1').css('width', '30%');
			} else { // 사업자
				$('#ucodeCustomer2_2').hide();
				$('#ucodeCustomer2').hide();
				$('#ucodeBusiness1').show();
				
				$('#ucodeCustomer1').css('width', '');
				$('#ucodeCustomer1').attr('colspan', '3'); //css로 하면 테이블 모양 깨짐
			} 
		});
		
		$('#id').keydown(function(){
			$('#idDupCheckResult').css('display', 'none');
			isIdChange = true;
		});

		$('#email').keydown(function(){
			$('#emailDupCheckResult').css('display', 'none');
			isEmailChange = true;
		});
	});
	
	function addrKakao() {
		//상세주소 텍스트 초기화
		$('#address1,#postcode').val("");

		mapViewAddressSearchPopupOpen('popup_type_kakaoAddr', function(data) {
			//주소 값 넣기.
			$('#postcode').val(data.zonecode);
			$('#address1').val(data.fullAddr);

			//창 닫기.
			$('#myModal').modal('hide');
		});
	}
	
	function idDupCheck(){
		isIdCheck = true;
		isIdChange = false;
		
		var id = $('#id').val();
		if(id == ""){
			alert("아이디를 입력한 다음 확인해주세요");
			$('#id').focus();
			return;
		}
		
		$.ajax({
			url : "idDupCheck.do",
			type : "post",
			data : id,
			dataType : "json",
			success : function(data){
				//alert("data.resultCode : "+data.resultCode);
				
				if(data.resultCode == "0"){
					/* console.log("아이디 없음");
					alert("사용할 수 있는 아이디입니다."); */
					$('#idDupCheckResult').html("<font color=green>사용 가능한 아이디입니다</font>");
					$('#idDupCheckResult').show();
					use1 = "possible";
				} else{
					/* console.log("아이디 있음");
					alert("중복된 아이디가 존재합니다."); */
					$('#idDupCheckResult').html("<font color=red>중복된 아이디입니다</font>");
					$('#idDupCheckResult').show();
					use1 = "impossible";
				}
			},
			error: function(request, status, error){
				//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				alert("아이디 중복확인 에러 발생");
			}
		}); //ajax
	}
	
	function emailDupCheck(){
		isEmailCheck = true;
		isEmailChange = false;
		
		var email = $('#email').val();
		if(email == ""){
			alert("이메일을 입력한 다음 확인해주세요");
			$('#email').focus();
			return;
		}
		
		$.ajax({
			url : "emailDupCheck.do",
			type : "post",
			data : email,
			dataType : "json",
			success : function(data){
				if(data.resultCode == "0"){
					/* console.log("이메일 없음");
					alert("사용할 수 있는 이메일입니다."); */
					$('#emailDupCheckResult').html("<font color=green>사용 가능한 이메일입니다</font>");
					$('#emailDupCheckResult').show();
					use2 = "possible";
				} else{
					/* console.log("이메일 있음");
					alert("중복된 이메일이 존재합니다."); */
					$('#emailDupCheckResult').html("<font color=red>중복된 이메일입니다</font>");
					$('#emailDupCheckResult').show();
					use2 = "impossible";
				}
			},
			error: function(request, status, error){
				//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				alert("이메일 중복확인 에러 발생");
			}
		}); //ajax
	}

	function input() {
		if(use1 == "impossible"){
			alert("이미 사용중인 아이디입니다");
			return false;
		} else if(use2 == "impossible"){
			alert("이미 사용중인 이메일입니다");
			return false;
		} else if(isIdCheck == false || isIdChange == true){
			alert("아이디 중복확인 해주세요");
			return false;
		} else if(isEmailCheck == false || isEmailCheck == true){
			alert("이메일 중복확인 해주세요");
			return false;
		} else if($("#ucode option:selected").val() == "customer"){
			// 사용자가 개인회원이면 gender 값이 있어야 함
			if($('#gender option:checked').val() == ""){
				alert("성별 체크해주세요");
				return false;
			}
		} else if($('#ucode option:selected').val() == "business"){
			// 사용자가 사업자면 주소 관련 값이 있어야 함
			if($('#postcode').val() == "" || $('#address1').val() == ""){
				alert("우편번호찾기를 진행해주세요");
				return false;
			}
		} else if($('pw').val() != $('rePw').val()){
			alert("비밀번호와 비밀번호 재확인이 다릅니다");
			return false;
		}
		
		if (!confirm('등록 하시겠습니까?')) {
			return false;
		}
	}
</script>

<section class="container">
	<article>
		<div>
			<header>
				<h2 align="center" class="text-primary">회원가입</h2>
			</header>
			<form:form commandName="users" name="myForm" action="usersReigster.do" method="post" class="form-horizontal">
				<table class="table table-bordered">
					<caption>
						<span class="redFont"> * </span> 필수 입력 사항
					</caption>
					<tr>
						<!-- 회원 구분 -->
						<td>
							<label for="ucode">
								<span class="redFont"> * </span> 회원구분
							</label>
						</td>
						<td colspan="3">
							<select name="ucode" class="form-control" id="ucode">
								<option value="customer">개인회원</option>
								<option value="business">사업자</option>
							</select>
							<form:errors cssClass="errMessage" path="ucode"/>
						</td>
					</tr>
					<tr>
						<!-- 이름 성별 -->
						<td width="20%">
							<label for="name">
								<span class="redFont"> * </span> 이름
							</label>
						</td>
						<td id="ucodeCustomer1" width="30%">
							<input type="text" class="form-control" id="name" name="name" size="30%" maxlength="40" placeholder="사업체 이름, 개인회원 실명(영어대소문자,한글,숫자,괄호가능)">
							<form:errors cssClass="errMessage" path="name"/>
						</td>
						
						<td id="ucodeCustomer2" width="20%" style="border-bottom: none; text-align: center;">
							<label for="gender1">
								<span class="redFont"> * </span> 성별
							</label>
						</td>
						<td id="ucodeCustomer2_2" style="border-bottom: none; text-align: center;">
							<label for="gender1">
								<input type="radio" id="gender1" name="gender" value="남성"> 남성
							</label>
							&nbsp;&nbsp;
							<label for="gender2">
								<input type="radio" id="gender2" name="gender" value="여성"> 여성
							</label>
						</td>
					</tr>
					<tr>
						<!-- 아이디 중복확인 -->
						<td width="20%">
							<label for="id">
								<span class="redFont"> * </span> 아이디
							</label>
						</td>
						<td colspan="3">
							<input type="text" class="form-control"	id="id" name="id" maxlength="20" placeholder="아이디 입력(영어소문자,숫자,-_가능)">
							<input type="button" class="btn btn-primary" id="idDuplicateCheck" value="중복확인" onClick="idDupCheck();">
							<span id="idDupCheckResult" style="display:none;">아이디 중복확인 결과</span>
							<form:errors cssClass="errMessage" path="id"/>
						</td>
					</tr>
					<tr>
						<td width="20%">
							<label for="pw">
								<span class="redFont"> * </span> 비번
							</label>
						</td>
						<td width="30%">
							<input type="password" class="form-control" id="pw" name="pw" maxlength="20">
							<form:errors cssClass="errMessage" path="pw"/>
						</td>
						<td width="20%">
							<label for="rePw">
								<span class="redFont"> * </span> 비번 재확인
							</label>
						</td>
						<td>
							<input type="password" class="form-control" id="rePw" maxlength="20">
						</td>
					</tr>
					<tr id="ucodeBusiness1" style="border-bottom: none; display: none;">
						<td style="border-bottom: none;">
							<label for="searchPostcode">
								<span class="redFont"> * </span> 사업장 주소
							</label>
						</td>
						<td style="border: none;" colspan="3">
							<input type="text" class="form-control40" id="postcode" name="postcode" readonly="readonly" placeholder="우편번호 입력">
							<input type="button" class="btn btn-primary" id="searchPostcode" value="우편번호찾기" data-toggle="modal" data-target="#myModal">
							<br>
							<input type="text" style="background-color: white;"	class="form-control" id="address1" name="address1" placeholder="사업장 주소" readonly="readonly">
							<input type="text" class="form-control" id="address2" name="address2" placeholder="상세주소 입력">
					</tr>
					<tr>
						<!-- 이메일 중복확인 -->
						<td>
							<label for="email">
								<span class="redFont"> * </span> 이메일
							</label>
						</td>
						<td colspan="3">
							<input type="text" class="form-control" id="email" name="email" maxlength="30" placeholder="이메일 입력">
							<input type="button" class="btn btn-primary" id="emailDuplicateCheck" value="중복확인" onClick="emailDupCheck();">
							<span id="emailDupCheckResult" style="display:none;">이메일 중복확인 결과</span>
							<form:errors cssClass="errMessage" path="email"/>
						</td>
					</tr>
					<tr>
						<td>
							<label for="contact">
								<span class="redFont"> * </span> 연락처
							</label>
						</td>
						<td>
							<input type="text" class="form-control" id="contact" name="contact" maxlength="30" placeholder="핸드폰 번호 입력(01000000000)">
							<form:errors cssClass="errMessage" path="contact"/>
						</td>
						<td>
							<label for="birth"> 사업자 사업시작일, 개인회원 생일</label>
						</td>
						<td>
							<input type="date" name="birth" min="2021-01-01">
						</td>
					</tr>
					<tr>
						<td colspan="4" align="center">
							<input type="submit" class="btn btn-primary" value="등록" onclick="return input()">
							<input type="reset" class="btn btn-default" value="다시작성">
							<input type="button" class="btn btn-primary" value="목록보기">
						</td>
					</tr>
				</table>
			</form:form>
		</div>
	</article>
</section>

<!-- 우편번호 modal 시작 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	 aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
					<span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">우편번호 검색</h4>
			</div>

			<div class="modal-body">
				<!-- kakao api 노출영역 -->
				<div id="popup_type_kakaoAddr" style="position: relative; margint: 20px; overflow: hidden;"></div>
				<!-- kakao api 노출영역 -->
			</div>
			
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
		<!-- 모달 콘텐츠 -->
	</div>
	<!-- 모달 다이얼로그 -->
</div>
<!-- 모달 전체 윈도우 -->

<%@ include file="../../../common/bottom.jsp"%>

<!-- kakao api start -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript"	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoKey}"></script>
<!-- kakao api end -->